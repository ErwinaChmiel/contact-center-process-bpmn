-- =========================================================
-- 6. Dane przykładowe (SQL Server / T-SQL) – wersja portfolio BI
-- =========================================================
-- Ten plik pierwotnie zawierał „mikro” dane (5 klientów, 4 agentów, 9 calls),
-- co powoduje szkoleniowy wygląd trendów. Poniżej jest wersja dla SQL Server,
-- która:
--  1) (opcjonalnie) wstawia minimalne seed data, jeżeli tabele są puste
--  2) dopisuje klientów i agentów do targetu (np. 500 / 50)
--  3) dopisuje paczkę calls/cases/contacts (np. 600 / 450) – bez nadpisywania
--
-- Uwaga: skrypty używają CHECKSUM(NEWID()) & 2147483647 (bezpieczne losowanie),
-- żeby uniknąć NULL-i w CHOOSE().

SET NOCOUNT ON;

------------------------------------------------------------
-- 6.1 (Opcjonalnie) Minimalne seed data (jeśli tabele są puste)
------------------------------------------------------------

IF NOT EXISTS (SELECT 1 FROM dbo.customers)
BEGIN
  INSERT INTO dbo.customers (customer_id, [name], segment, region) VALUES
  (1, N'Klient A', N'B2C',       N'Mazowieckie'),
  (2, N'Klient B', N'B2C',       N'Śląskie'),
  (3, N'Klient C', N'SME',       N'Małopolskie'),
  (4, N'Klient D', N'B2C',       N'Mazowieckie'),
  (5, N'Klient E', N'Corporate', N'Wielkopolskie');
END;

IF NOT EXISTS (SELECT 1 FROM dbo.agents)
BEGIN
  INSERT INTO dbo.agents (agent_id, [name], team, seniority) VALUES
  (1, N'Anna Kowalska',    N'1st_line', N'mid'),
  (2, N'Jan Nowak',        N'1st_line', N'junior'),
  (3, N'Maria Wiśniewska', N'2nd_line', N'senior'),
  (4, N'Piotr Zieliński',  N'2nd_line', N'mid');
END;

------------------------------------------------------------
-- 6.2 Dosyp klientów do targetu (np. 500)
------------------------------------------------------------

DECLARE @target_customers int = 500;
DECLARE @current_customers int = (SELECT COUNT(*) FROM dbo.customers);
DECLARE @add_customers int = CASE WHEN @current_customers < @target_customers
                                  THEN @target_customers - @current_customers ELSE 0 END;

IF @add_customers > 0
BEGIN
  DECLARE @cust_identity bit =
    CASE WHEN COLUMNPROPERTY(OBJECT_ID('dbo.customers'), 'customer_id', 'IsIdentity') = 1 THEN 1 ELSE 0 END;

  DECLARE @base_customer_id int = ISNULL((SELECT MAX(customer_id) FROM dbo.customers), 0);

  IF OBJECT_ID('tempdb..#new_customers') IS NOT NULL DROP TABLE #new_customers;
  CREATE TABLE #new_customers (
    customer_id int NOT NULL,
    [name]      nvarchar(200) NOT NULL,
    [segment]   nvarchar(50)  NOT NULL,
    [region]    nvarchar(100) NOT NULL
  );

  ;WITH N AS (
    SELECT TOP (@add_customers) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS i
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b
  ),
  R AS (
    SELECT
      i,
      r1 = (CHECKSUM(NEWID()) & 2147483647),
      r2 = (CHECKSUM(NEWID()) & 2147483647)
    FROM N
  )
  INSERT INTO #new_customers (customer_id, [name], [segment], [region])
  SELECT
    @base_customer_id + i AS customer_id,
    CONCAT(N'Klient ', FORMAT(@base_customer_id + i, '00000')) AS [name],
    CASE
      WHEN (r1 % 100) < 70 THEN N'B2C'
      WHEN (r1 % 100) < 90 THEN N'SME'
      ELSE N'Corporate'
    END AS [segment],
    CHOOSE((r2 % 16) + 1,
      N'Dolnośląskie', N'Kujawsko-Pomorskie', N'Lubelskie', N'Lubuskie', N'Łódzkie', N'Małopolskie',
      N'Mazowieckie', N'Opolskie', N'Podkarpackie', N'Podlaskie', N'Pomorskie', N'Śląskie',
      N'Świętokrzyskie', N'Warmińsko-Mazurskie', N'Wielkopolskie', N'Zachodniopomorskie'
    ) AS [region]
  FROM R;

  IF @cust_identity = 1
  BEGIN
    INSERT INTO dbo.customers ([name], segment, region)
    SELECT [name], [segment], [region] FROM #new_customers;
  END
  ELSE
  BEGIN
    INSERT INTO dbo.customers (customer_id, [name], segment, region)
    SELECT customer_id, [name], [segment], [region] FROM #new_customers;
  END
END;

------------------------------------------------------------
-- 6.3 Dosyp agentów do targetu (np. 50)
------------------------------------------------------------

DECLARE @target_agents int = 50;
DECLARE @current_agents int = (SELECT COUNT(*) FROM dbo.agents);
DECLARE @add_agents int = CASE WHEN @current_agents < @target_agents
                               THEN @target_agents - @current_agents ELSE 0 END;

IF @add_agents > 0
BEGIN
  DECLARE @agent_identity bit =
    CASE WHEN COLUMNPROPERTY(OBJECT_ID('dbo.agents'), 'agent_id', 'IsIdentity') = 1 THEN 1 ELSE 0 END;

  DECLARE @base_agent_id int = ISNULL((SELECT MAX(agent_id) FROM dbo.agents), 0);

  IF OBJECT_ID('tempdb..#new_agents') IS NOT NULL DROP TABLE #new_agents;
  CREATE TABLE #new_agents (
    agent_id   int NOT NULL,
    [name]     nvarchar(200) NOT NULL,
    team       nvarchar(50)  NOT NULL,
    seniority  nvarchar(50)  NOT NULL
  );

  ;WITH N AS (
    SELECT TOP (@add_agents) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS i
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b
  ),
  R AS (
    SELECT
      i,
      r1 = (CHECKSUM(NEWID()) & 2147483647),
      r2 = (CHECKSUM(NEWID()) & 2147483647),
      r3 = (CHECKSUM(NEWID()) & 2147483647),
      r4 = (CHECKSUM(NEWID()) & 2147483647)
    FROM N
  )
  INSERT INTO #new_agents (agent_id, [name], team, seniority)
  SELECT
    @base_agent_id + i AS agent_id,
    CONCAT(
      CHOOSE((r1 % 10) + 1, N'Anna',N'Jan',N'Maria',N'Piotr',N'Katarzyna',N'Tomasz',N'Agnieszka',N'Paweł',N'Ewa',N'Marek'),
      N' ',
      CHOOSE((r2 % 10) + 1, N'Kowalska',N'Nowak',N'Wiśniewska',N'Zieliński',N'Wójcik',N'Kaczmarek',N'Mazur',N'Krawczyk',N'Piotrowski',N'Grabowski')
    ) AS [name],
    CASE WHEN (r3 % 100) < 65 THEN N'1st_line' ELSE N'2nd_line' END AS team,
    CASE
      WHEN (r4 % 100) < 45 THEN N'junior'
      WHEN (r4 % 100) < 85 THEN N'mid'
      ELSE N'senior'
    END AS seniority
  FROM R;

  IF @agent_identity = 1
  BEGIN
    INSERT INTO dbo.agents ([name], team, seniority)
    SELECT [name], team, seniority FROM #new_agents;
  END
  ELSE
  BEGIN
    INSERT INTO dbo.agents (agent_id, [name], team, seniority)
    SELECT agent_id, [name], team, seniority FROM #new_agents;
  END
END;

------------------------------------------------------------
-- 6.4 Dopisz paczkę CALLS / CASES / CONTACTS (np. +600 / +450)
--     Bez nadpisywania: bazuje na MAX(id)
------------------------------------------------------------

DECLARE @n_calls int = 600;
DECLARE @n_cases int = 450;

DECLARE @base_call_id    int = ISNULL((SELECT MAX(call_id)    FROM dbo.calls), 0);
DECLARE @base_case_id    int = ISNULL((SELECT MAX(case_id)    FROM dbo.cases), 0);
DECLARE @base_contact_id int = ISNULL((SELECT MAX(contact_id) FROM dbo.contacts), 0);

DECLARE @n_customers_now int = (SELECT COUNT(*) FROM dbo.customers);
DECLARE @n_agents_now    int = (SELECT COUNT(*) FROM dbo.agents);

IF @n_customers_now = 0 OR @n_agents_now = 0
BEGIN
  RAISERROR(N'Brak danych w dbo.customers lub dbo.agents. Najpierw uruchom sekcje 6.1–6.3.', 16, 1);
  RETURN;
END;

-- CALLS
;WITH
N AS (
  SELECT TOP (@n_calls) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS i
  FROM sys.all_objects a
  CROSS JOIN sys.all_objects b
),
R AS (
  SELECT
    i,
    r1 = (CHECKSUM(NEWID()) & 2147483647),
    r2 = (CHECKSUM(NEWID()) & 2147483647),
    r3 = (CHECKSUM(NEWID()) & 2147483647),
    r4 = (CHECKSUM(NEWID()) & 2147483647),
    r5 = (CHECKSUM(NEWID()) & 2147483647)
  FROM N
),
Src AS (
  SELECT
    call_id     = @base_call_id + i,
    customer_id = 1 + (r1 % @n_customers_now),
    r = (r2 % 10000),
    start_time =
      DATEADD(MINUTE,
        (r3 % (365*24*60)) + (r4 % (12*60)),
        CAST('2025-01-01T00:00:00' AS datetime2(0))
      ),
    ivr_topic =
      CHOOSE((r5 % 6) + 1, N'faktura', N'reklamacje', N'techniczne', N'konto', N'dostawa', N'platnosci'),
    channel =
      CASE WHEN (r4 % 100) < 85 THEN N'phone' ELSE N'chat' END
  FROM R
),
Shaped AS (
  SELECT
    call_id, customer_id, start_time, ivr_topic, channel,
    scenario =
      CASE
        WHEN r < 1200 THEN N'self_service'
        WHEN r < 2200 THEN N'abandoned'
        WHEN r < 3000 THEN N'callback_chosen'
        WHEN r < 4000 THEN N'callback_realized'
        ELSE N'answered'
      END
  FROM Src
),
FinalCalls AS (
  SELECT
    call_id,
    customer_id,
    agent_id =
      CASE WHEN scenario IN (N'answered', N'callback_realized')
           THEN 1 + ((CHECKSUM(NEWID()) & 2147483647) % @n_agents_now)
           ELSE NULL END,
    start_time,
    ivr_start_time =
      CASE WHEN scenario IN (N'answered', N'abandoned', N'callback_chosen', N'self_service')
           THEN DATEADD(SECOND, 2, start_time) ELSE NULL END,
    queue_start_time =
      CASE WHEN scenario IN (N'answered', N'abandoned', N'callback_chosen')
           THEN DATEADD(SECOND, 20 + ((CHECKSUM(NEWID()) & 2147483647) % 70), start_time) ELSE NULL END,
    answer_time =
      CASE WHEN scenario = N'answered'
           THEN DATEADD(SECOND, 20 + ((CHECKSUM(NEWID()) & 2147483647) % 70)
                              + ((CHECKSUM(NEWID()) & 2147483647) % 240), start_time)
           WHEN scenario = N'callback_realized'
           THEN DATEADD(SECOND, ((CHECKSUM(NEWID()) & 2147483647) % 15), start_time)
           ELSE NULL END,
    end_time =
      CASE
        WHEN scenario = N'self_service'
          THEN DATEADD(SECOND, 30 + ((CHECKSUM(NEWID()) & 2147483647) % 300), start_time)
        WHEN scenario = N'abandoned'
          THEN DATEADD(SECOND, 20 + ((CHECKSUM(NEWID()) & 2147483647) % 70) + 15 + ((CHECKSUM(NEWID()) & 2147483647) % 180), start_time)
        WHEN scenario = N'callback_chosen'
          THEN DATEADD(SECOND, 30 + ((CHECKSUM(NEWID()) & 2147483647) % 120), start_time)
        WHEN scenario = N'callback_realized'
          THEN DATEADD(SECOND, ((CHECKSUM(NEWID()) & 2147483647) % 15) + 60 + ((CHECKSUM(NEWID()) & 2147483647) % 600), start_time)
        ELSE
          DATEADD(SECOND, 20 + ((CHECKSUM(NEWID()) & 2147483647) % 70)
                         + ((CHECKSUM(NEWID()) & 2147483647) % 240)
                         + 120 + ((CHECKSUM(NEWID()) & 2147483647) % 720), start_time)
      END,
    direction = CASE WHEN scenario = N'callback_realized' THEN N'outbound' ELSE N'inbound' END,
    channel,
    ivr_topic,
    is_self_service       = CONVERT(bit, CASE WHEN scenario = N'self_service' THEN 1 ELSE 0 END),
    is_callback_chosen    = CONVERT(bit, CASE WHEN scenario = N'callback_chosen' THEN 1 ELSE 0 END),
    is_callback_realized  = CONVERT(bit, CASE WHEN scenario = N'callback_realized' THEN 1 ELSE 0 END),
    is_answered_by_agent  = CONVERT(bit, CASE WHEN scenario IN (N'answered', N'callback_realized') THEN 1 ELSE 0 END),
    is_abandoned_in_queue = CONVERT(bit, CASE WHEN scenario = N'abandoned' THEN 1 ELSE 0 END)
  FROM Shaped
)
INSERT INTO dbo.calls (
  call_id, customer_id, agent_id,
  start_time, ivr_start_time, queue_start_time, answer_time, end_time,
  direction, channel, ivr_topic,
  is_self_service, is_callback_chosen, is_callback_realized,
  is_answered_by_agent, is_abandoned_in_queue
)
SELECT
  call_id, customer_id, agent_id,
  start_time, ivr_start_time, queue_start_time, answer_time, end_time,
  direction, channel, ivr_topic,
  is_self_service, is_callback_chosen, is_callback_realized,
  is_answered_by_agent, is_abandoned_in_queue
FROM FinalCalls;

-- CASES
;WITH NewCalls AS (
  SELECT *
  FROM dbo.calls
  WHERE call_id > @base_call_id
),
Candidates AS (
  SELECT *
  FROM NewCalls
  WHERE is_answered_by_agent = 1 OR is_self_service = 1
),
Picked AS (
  SELECT TOP (@n_cases) *
  FROM Candidates
  ORDER BY NEWID()
),
Numbered AS (
  SELECT ROW_NUMBER() OVER (ORDER BY start_time, call_id) AS rn, *
  FROM Picked
),
CasesFinal AS (
  SELECT
    case_id       = @base_case_id + rn,
    customer_id,
    first_call_id = call_id,
    opened_at     = COALESCE(answer_time, ivr_start_time, start_time),
    status        = N'closed',

    case_category =
      CASE ivr_topic
        WHEN N'reklamacje' THEN N'reklamacja'
        WHEN N'faktura'    THEN N'faktura'
        WHEN N'techniczne' THEN N'techniczne'
        WHEN N'konto'      THEN N'konto'
        WHEN N'dostawa'    THEN N'dostawa'
        WHEN N'platnosci'  THEN N'platnosci'
        ELSE N'inne'
      END,

    case_subcategory =
      CASE ivr_topic
        WHEN N'reklamacje' THEN CHOOSE(((CHECKSUM(NEWID()) & 2147483647) % 4) + 1, N'reklamacja_zlozona',N'zwrot',N'uszkodzenie',N'brak_kompensaty')
        WHEN N'faktura'    THEN CHOOSE(((CHECKSUM(NEWID()) & 2147483647) % 4) + 1, N'saldo_info',N'faktura_niejasna',N'korekta',N'duplikat')
        WHEN N'techniczne' THEN CHOOSE(((CHECKSUM(NEWID()) & 2147483647) % 4) + 1, N'awaria_uslugi',N'brak_dostepu',N'bledy_aplikacji',N'konfiguracja')
        WHEN N'konto'      THEN CHOOSE(((CHECKSUM(NEWID()) & 2147483647) % 4) + 1, N'reset_hasla',N'zmiana_danych',N'blokada',N'uwierzytelnienie')
        WHEN N'dostawa'    THEN CHOOSE(((CHECKSUM(NEWID()) & 2147483647) % 4) + 1, N'opoznienie',N'adres',N'kurier',N'reklamacja_dostawy')
        WHEN N'platnosci'  THEN CHOOSE(((CHECKSUM(NEWID()) & 2147483647) % 4) + 1, N'odmowa',N'chargeback',N'raty',N'potwierdzenie')
        ELSE N'inne'
      END,

    priority =
      CASE
        WHEN ivr_topic IN (N'techniczne', N'reklamacje') AND ((CHECKSUM(NEWID()) & 2147483647) % 100) < 35 THEN N'high'
        WHEN ((CHECKSUM(NEWID()) & 2147483647) % 100) < 60 THEN N'medium'
        ELSE N'low'
      END,

    is_escalated_to_2nd_line =
      CONVERT(bit,
        CASE
          WHEN is_self_service = 0
           AND ivr_topic IN (N'techniczne', N'reklamacje')
           AND ((CHECKSUM(NEWID()) & 2147483647) % 100) < 25
          THEN 1 ELSE 0
        END
      ),

    sla_due_at =
      DATEADD(HOUR,
        CASE
          WHEN (
            CASE
              WHEN ivr_topic IN (N'techniczne', N'reklamacje') AND ((CHECKSUM(NEWID()) & 2147483647) % 100) < 35 THEN N'high'
              WHEN ((CHECKSUM(NEWID()) & 2147483647) % 100) < 60 THEN N'medium'
              ELSE N'low'
            END
          ) = N'low' THEN 48 ELSE 24 END,
        COALESCE(answer_time, ivr_start_time, start_time)
      ),

    closed_at =
      DATEADD(MINUTE,
        CASE
          WHEN ivr_topic IN (N'techniczne', N'reklamacje') AND ((CHECKSUM(NEWID()) & 2147483647) % 100) < 35 THEN 360
          WHEN ((CHECKSUM(NEWID()) & 2147483647) % 100) < 70 THEN 30
          ELSE 180
        END + ((CHECKSUM(NEWID()) & 2147483647) % (20*60)),
        COALESCE(answer_time, ivr_start_time, start_time)
      ),

    resolution_type =
      CASE
        WHEN is_self_service = 1 THEN N'self_service'
        WHEN ivr_topic IN (N'techniczne', N'reklamacje') AND ((CHECKSUM(NEWID()) & 2147483647) % 100) < 25 THEN N'after_escalation'
        ELSE N'FCR'
      END
  FROM Numbered
),
CasesWithSLA AS (
  SELECT *,
         resolved_in_sla = CONVERT(bit, CASE WHEN closed_at <= sla_due_at THEN 1 ELSE 0 END)
  FROM CasesFinal
)
INSERT INTO dbo.cases (
  case_id, customer_id, first_call_id,
  opened_at, closed_at, status,
  case_category, case_subcategory,
  priority, is_escalated_to_2nd_line,
  sla_due_at, resolved_in_sla,
  resolution_type
)
SELECT
  case_id, customer_id, first_call_id,
  opened_at, closed_at, status,
  case_category, case_subcategory,
  priority, is_escalated_to_2nd_line,
  sla_due_at, resolved_in_sla,
  resolution_type
FROM CasesWithSLA;

-- CONTACTS
;WITH NewCases AS (
  SELECT * FROM dbo.cases WHERE case_id > @base_case_id
),
AgentCases AS (
  SELECT
    nc.case_id,
    c.call_id,
    c.customer_id,
    c.agent_id,
    contact_time = COALESCE(c.answer_time, c.start_time),
    c.channel,
    c.direction,
    nc.resolution_type
  FROM NewCases nc
  JOIN dbo.calls c ON c.call_id = nc.first_call_id
  WHERE c.is_self_service = 0
),
NumberedContacts AS (
  SELECT ROW_NUMBER() OVER (ORDER BY contact_time, call_id) AS rn, *
  FROM AgentCases
)
INSERT INTO dbo.contacts (
  contact_id, case_id, call_id, customer_id, agent_id,
  contact_time, channel,
  is_first_contact, resolved_this_contact, is_inbound
)
SELECT
  @base_contact_id + rn AS contact_id,
  case_id, call_id, customer_id, agent_id,
  contact_time, channel,
  CONVERT(bit, 1) AS is_first_contact,
  CONVERT(bit, CASE WHEN resolution_type = N'FCR' THEN 1 ELSE 0 END) AS resolved_this_contact,
  CONVERT(bit, CASE WHEN direction = N'inbound' THEN 1 ELSE 0 END) AS is_inbound
FROM NumberedContacts;

------------------------------------------------------------
-- 6.5 Kontrola wolumenu
------------------------------------------------------------
SELECT 'customers' AS [table], COUNT(*) AS [rows] FROM dbo.customers
UNION ALL SELECT 'agents',   COUNT(*) FROM dbo.agents
UNION ALL SELECT 'calls',    COUNT(*) FROM dbo.calls
UNION ALL SELECT 'cases',    COUNT(*) FROM dbo.cases
UNION ALL SELECT 'contacts', COUNT(*) FROM dbo.contacts;

-- KONIEC DANYCH (SQL Server)


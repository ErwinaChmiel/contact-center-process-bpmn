
-- =========================================================
-- 1. Sprzątanie (opcjonalnie)
-- =========================================================
DROP TABLE IF EXISTS contacts;
DROP TABLE IF EXISTS cases;
DROP TABLE IF EXISTS calls;
DROP TABLE IF EXISTS agents;
DROP TABLE IF EXISTS customers;

-- =========================================================
-- 2. Tabele słownikowe: customers, agents
-- =========================================================
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    segment VARCHAR(50), -- np. B2C / SME / Corporate
    region VARCHAR(50) -- np. "Mazowieckie"
);

CREATE TABLE agents (
    agent_id INT PRIMARY KEY,
    name VARCHAR(100),
    team VARCHAR(50), -- 1st_line / 2nd_line
    seniority VARCHAR(50) -- junior / mid / senior
);

-- =========================================================
-- 3. Tabela calls – każde połączenie
-- =========================================================
CREATE TABLE calls (
    call_id INT PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    agent_id INT REFERENCES agents(agent_id),

    start_time TIMESTAMP NOT NULL,
    ivr_start_time TIMESTAMP,
    queue_start_time TIMESTAMP,
    answer_time TIMESTAMP,
    end_time TIMESTAMP,

    direction VARCHAR(20), -- inbound / outbound
    channel VARCHAR(20), -- phone / chat / email
    ivr_topic VARCHAR(50), -- faktura / reklamacje / techniczne

    is_self_service BOOLEAN DEFAULT FALSE,
    is_callback_chosen BOOLEAN DEFAULT FALSE,
    is_callback_realized BOOLEAN DEFAULT FALSE,
    is_answered_by_agent BOOLEAN DEFAULT FALSE,
    is_abandoned_in_queue BOOLEAN DEFAULT FALSE
);

-- =========================================================
-- 4. Tabela cases – zgłoszenia / sprawy
-- =========================================================
CREATE TABLE cases (
    case_id INT PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    first_call_id INT REFERENCES calls(call_id),

    opened_at TIMESTAMP NOT NULL,
    closed_at TIMESTAMP,
    status VARCHAR(20), -- open / in_progress / closed

    case_category VARCHAR(50), -- faktura / reklamacja / techniczne
    case_subcategory VARCHAR(50),
    priority VARCHAR(20), -- low / medium / high

    is_escalated_to_2nd_line BOOLEAN DEFAULT FALSE,
    sla_due_at TIMESTAMP,
    resolved_in_sla BOOLEAN,
    resolution_type VARCHAR(30) -- FCR / after_escalation / self_service / no_solution
);

-- =========================================================
-- 5. Tabela contacts – każdy kontakt konsultanta ze sprawą
-- =========================================================
CREATE TABLE contacts (
    contact_id INT PRIMARY KEY,
    case_id INT REFERENCES cases(case_id),
    call_id INT REFERENCES calls(call_id),
    customer_id INT REFERENCES customers(customer_id),
    agent_id INT REFERENCES agents(agent_id),

    contact_time TIMESTAMP NOT NULL,
    channel VARCHAR(20),

    is_first_contact BOOLEAN DEFAULT FALSE,
    resolved_this_contact BOOLEAN DEFAULT FALSE,
    is_inbound BOOLEAN DEFAULT TRUE
);

-- =========================================================
-- 6. Dane przykładowe
-- =========================================================

-- 6.1. Klienci
INSERT INTO customers (customer_id, name, segment, region) VALUES
(1, 'Klient A', 'B2C', 'Mazowieckie'),
(2, 'Klient B', 'B2C', 'Śląskie'),
(3, 'Klient C', 'SME', 'Małopolskie'),
(4, 'Klient D', 'B2C', 'Mazowieckie'),
(5, 'Klient E', 'Corporate', 'Wielkopolskie');

-- 6.2. Konsultanci
INSERT INTO agents (agent_id, name, team, seniority) VALUES
(1, 'Anna Kowalska', '1st_line', 'mid'),
(2, 'Jan Nowak', '1st_line', 'junior'),
(3, 'Maria Wiśniewska','2nd_line', 'senior'),
(4, 'Piotr Zieliński', '2nd_line', 'mid');

-- =========================================================
-- 6.3. Połączenia (CALLS)
-- Data przykładowa: 2025-01-10
-- =========================================================

-- 1) Klient A – prosta sprawa dot. faktury, załatwiona w IVR (self-service)
INSERT INTO calls VALUES (
  1, -- call_id
  1, -- customer_id
  NULL, -- agent_id
  '2025-01-10 09:00:00', -- start_time
  '2025-01-10 09:00:02', -- ivr_start_time
  NULL, -- queue_start_time
  NULL, -- answer_time
  '2025-01-10 09:02:00', -- end_time
  'inbound', -- direction
  'phone', -- channel
  'faktura', -- ivr_topic
  TRUE, -- is_self_service
  FALSE, -- is_callback_chosen
  FALSE, -- is_callback_realized
  FALSE, -- is_answered_by_agent
  FALSE -- is_abandoned_in_queue
);

-- 2) Klient B – reklamacja, rozwiązana od razu przez 1st line (FCR)
INSERT INTO calls VALUES (
  2,
  2,
  1, -- Anna (1st line)
  '2025-01-10 09:05:00',
  '2025-01-10 09:05:02',
  '2025-01-10 09:05:30',
  '2025-01-10 09:06:00',
  '2025-01-10 09:12:00',
  'inbound',
  'phone',
  'reklamacje',
  FALSE,
  FALSE,
  FALSE,
  TRUE,
  FALSE
);

-- 3) Klient C – problem techniczny, klient rozłącza się w kolejce (abandoned)
INSERT INTO calls VALUES (
  3,
  3,
  NULL,
  '2025-01-10 09:10:00',
  '2025-01-10 09:10:02',
  '2025-01-10 09:10:30',
  NULL,
  '2025-01-10 09:12:00',
  'inbound',
  'phone',
  'techniczne',
  FALSE,
  FALSE,
  FALSE,
  FALSE,
  TRUE -- is_abandoned_in_queue
);

-- 4) Klient B – trudniejsza reklamacja, później eskalowana do 2nd line
INSERT INTO calls VALUES (
  4,
  2,
  2, -- Jan (1st line)
  '2025-01-10 10:00:00',
  '2025-01-10 10:00:02',
  '2025-01-10 10:00:20',
  '2025-01-10 10:01:00',
  '2025-01-10 10:08:00',
  'inbound',
  'phone',
  'reklamacje',
  FALSE,
  FALSE,
  FALSE,
  TRUE,
  FALSE
);

-- 5) Klient D – wybiera callback (oddzwonienie), połączenie kończy się przed konsultantem
INSERT INTO calls VALUES (
  5,
  4,
  NULL,
  '2025-01-10 10:15:00',
  '2025-01-10 10:15:02',
  '2025-01-10 10:15:30',
  NULL,
  '2025-01-10 10:16:00',
  'inbound',
  'phone',
  'faktura',
  FALSE,
  TRUE, -- is_callback_chosen
  FALSE, -- is_callback_realized (jeszcze nie)
  FALSE,
  FALSE
);

-- 6) Klient D – oddzwonienie (callback) zrealizowane, sprawa rozwiązana
INSERT INTO calls VALUES (
  6,
  4,
  1, -- Anna (1st line)
  '2025-01-10 10:30:00',
  NULL,
  NULL,
  '2025-01-10 10:30:10',
  '2025-01-10 10:35:00',
  'outbound',
  'phone',
  'faktura',
  FALSE,
  FALSE,
  TRUE, -- is_callback_realized
  TRUE, -- is_answered_by_agent
  FALSE
);

-- 7) Klient E – problem techniczny, wymaga 2nd line (eskalacja)
INSERT INTO calls VALUES (
  7,
  5,
  2, -- Jan
  '2025-01-10 11:00:00',
  '2025-01-10 11:00:02',
  '2025-01-10 11:00:20',
  '2025-01-10 11:01:00',
  '2025-01-10 11:07:00',
  'inbound',
  'phone',
  'techniczne',
  FALSE,
  FALSE,
  FALSE,
  TRUE,
  FALSE
);

-- 8) Klient E – oddzwonienie od 2nd line z decyzją
INSERT INTO calls VALUES (
  8,
  5,
  3, -- Maria (2nd line)
  '2025-01-10 13:00:00',
  NULL,
  NULL,
  '2025-01-10 13:00:10',
  '2025-01-10 13:05:00',
  'outbound',
  'phone',
  'techniczne',
  FALSE,
  FALSE,
  FALSE,
  TRUE,
  FALSE
);

-- 9) Klient B – follow-up po eskalacji do 2nd line
INSERT INTO calls VALUES (
  9,
  2,
  3, -- Maria (2nd line)
  '2025-01-11 09:00:00',
  NULL,
  NULL,
  '2025-01-11 09:00:10',
  '2025-01-11 09:05:00',
  'outbound',
  'phone',
  'reklamacje',
  FALSE,
  FALSE,
  FALSE,
  TRUE,
  FALSE
);

-- =========================================================
-- 6.4. Sprawy (CASES)
-- =========================================================

-- Case 1 – Klient B, reklamacja rozwiązana przy pierwszym kontakcie (FCR)
INSERT INTO cases VALUES (
  1,
  2, -- customer_id (Klient B)
  2, -- first_call_id
  '2025-01-10 09:06:00', -- opened_at (start rozmowy)
  '2025-01-10 09:12:00', -- closed_at
  'closed', -- status
  'reklamacja', -- case_category
  'faktura_niejasna', -- case_subcategory
  'medium', -- priority
  FALSE, -- is_escalated_to_2nd_line
  '2025-01-11 09:06:00', -- sla_due_at (24h)
  TRUE, -- resolved_in_sla
  'FCR' -- resolution_type
);

-- Case 2 – Klient B, trudniejsza reklamacja, eskalowana do 2nd line
INSERT INTO cases VALUES (
  2,
  2,
  4,
  '2025-01-10 10:01:00',
  '2025-01-11 09:05:00',
  'closed',
  'reklamacja',
  'reklamacja_zlozona',
  'high',
  TRUE, -- is_escalated_to_2nd_line
  '2025-01-11 10:01:00', -- SLA 24h
  TRUE, -- resolved_in_sla
  'after_escalation'
);

-- Case 3 – Klient D, sprawa dot. faktury, rozwiązana podczas callbacku
INSERT INTO cases VALUES (
  3,
  4,
  6,
  '2025-01-10 10:30:10',
  '2025-01-10 10:35:00',
  'closed',
  'faktura',
  'saldo_rozliczenie',
  'low',
  FALSE,
  '2025-01-11 10:30:10',
  TRUE,
  'FCR'
);

-- Case 4 – Klient E, problem techniczny, eskalacja + 2nd line
INSERT INTO cases VALUES (
  4,
  5,
  7,
  '2025-01-10 11:01:00',
  '2025-01-10 13:05:00',
  'closed',
  'techniczne',
  'awaria_uslugi',
  'high',
  TRUE,
  '2025-01-11 11:01:00',
  TRUE,
  'after_escalation'
);

-- Case 5 – Klient A, sprawa rozwiązana w IVR (self-service),
-- dla przykładu również rejestrowana jako sprawa
INSERT INTO cases VALUES (
  5,
  1,
  1,
  '2025-01-10 09:00:02',
  '2025-01-10 09:02:00',
  'closed',
  'faktura',
  'saldo_info',
  'low',
  FALSE,
  '2025-01-11 09:00:02',
  TRUE,
  'self_service'
);

-- =========================================================
-- 6.5. Kontakty (CONTACTS)
-- =========================================================

-- Case 1 – jeden kontakt, FCR
INSERT INTO contacts VALUES (
  1,
  1, -- case_id
  2, -- call_id
  2, -- customer_id (Klient B)
  1, -- agent_id (Anna)
  '2025-01-10 09:06:00',
  'phone',
  TRUE, -- is_first_contact
  TRUE, -- resolved_this_contact
  TRUE -- is_inbound
);

-- Case 2 – pierwszy kontakt (1st line), jeszcze bez rozwiązania
INSERT INTO contacts VALUES (
  2,
  2,
  4,
  2,
  2, -- Jan
  '2025-01-10 10:01:00',
  'phone',
  TRUE, -- first_contact
  FALSE, -- resolved_this_contact
  TRUE
);

-- Case 2 – drugi kontakt (2nd line), sprawa zamknięta
INSERT INTO contacts VALUES (
  3,
  2,
  9,
  2,
  3, -- Maria
  '2025-01-11 09:00:10',
  'phone',
  FALSE,
  TRUE,
  FALSE -- outbound
);

-- Case 3 – callback do Klienta D, FCR
INSERT INTO contacts VALUES (
  4,
  3,
  6,
  4,
  1, -- Anna
  '2025-01-10 10:30:10',
  'phone',
  TRUE,
  TRUE,
  FALSE -- outbound (callback)
);

-- Case 4 – kontakt 1st line (nie rozwiązuje)
INSERT INTO contacts VALUES (
  5,
  4,
  7,
  5,
  2, -- Jan
  '2025-01-10 11:01:00',
  'phone',
  TRUE,
  FALSE,
  TRUE
);

-- Case 4 – kontakt 2nd line z decyzją
INSERT INTO contacts VALUES (
  6,
  4,
  8,
  5,
  3, -- Maria
  '2025-01-10 13:00:10',
  'phone',
  FALSE,
  TRUE,
  FALSE
);

-- Case 5 – samoobsługa w IVR, bez kontaktu z konsultantem (dla przykładu brak w contacts)

-- KONIEC DANYCH

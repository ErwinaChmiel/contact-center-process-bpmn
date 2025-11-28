-- =========================================================
-- 6. Dane przykladowe
-- =========================================================

-- 6.1. Klienci
INSERT INTO customers (customer_id, name, segment, region) VALUES
(1, 'Klient A', 'B2C', 'Mazowieckie'),
(2, 'Klient B', 'B2C', '?l?skie'),
(3, 'Klient C', 'SME', 'Ma?opolskie'),
(4, 'Klient D', 'B2C', 'Mazowieckie'),
(5, 'Klient E', 'Corporate', 'Wielkopolskie');

-- 6.2. Konsultanci
INSERT INTO agents (agent_id, name, team, seniority) VALUES
(1, 'Anna Kowalska',   '1st_line', 'mid'),
(2, 'Jan Nowak',       '1st_line', 'junior'),
(3, 'Maria Wi?niewska','2nd_line', 'senior'),
(4, 'Piotr Zieli?ski', '2nd_line', 'mid');

-- =========================================================
-- 6.3. Po??czenia (CALLS)
-- Data przyk?adowa: 2025-01-10
-- =========================================================

-- 1) Klient A – prosta sprawa dot. faktury, zalatwiona w IVR (self-service)
INSERT INTO calls VALUES (
  1,         -- call_id
  1,         -- customer_id
  NULL,      -- agent_id
  '2025-01-10 09:00:00', -- start_time
  '2025-01-10 09:00:02', -- ivr_start_time
  NULL,                  -- queue_start_time
  NULL,                  -- answer_time
  '2025-01-10 09:02:00', -- end_time
  'inbound',             -- direction
  'phone',               -- channel
  'faktura',             -- ivr_topic
  1,                     -- is_self_service
  0,                     -- is_callback_chosen
  0,                     -- is_callback_realized
  0,                     -- is_answered_by_agent
  0                      -- is_abandoned_in_queue
);

-- 2) Klient B – reklamacja, rozwiazana od razu przez 1st line (FCR)
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
  0,
  0,
  0,
  1,
  0
);

-- 3) Klient C – problem techniczny, klient rozlacza sie w kolejce (abandoned)
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
  0,
  0,
  0,
  0,
  1           -- is_abandoned_in_queue
);

-- 4) Klient B – trudniejsza reklamacja, pozniej eskalowana do 2nd line
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
  0,
  0,
  0,
  1,
  0
);

-- 5) Klient D – wybiera callback (oddzwonienie), polaczenie konczy sie przed konsultantem
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
  0,
  1,   -- is_callback_chosen
  0,   -- is_callback_realized (jeszcze nie)
  0,
  0
);

-- 6) Klient D – oddzwonienie (callback) zrealizowane, sprawa rozwiazana
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
  0,
  0,
  1,   -- is_callback_realized
  1,   -- is_answered_by_agent
  0
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
  0,
  0,
  0,
  1,
  0
);

-- 8) Klient E – oddzwonienie od 2nd line z decyzja
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
  0,
  0,
  0,
  1,
  0
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
  0,
  0,
  0,
  1,
  0
);

-- =========================================================
-- 6.4. Sprawy (CASES)
-- =========================================================

-- Case 1 – Klient B, reklamacja rozwiazana przy pierwszym kontakcie (FCR)
INSERT INTO cases VALUES (
  1,
  2,               -- customer_id (Klient B)
  2,               -- first_call_id
  '2025-01-10 09:06:00',   -- opened_at (start rozmowy)
  '2025-01-10 09:12:00',   -- closed_at
  'closed',                -- status
  'reklamacja',            -- case_category
  'faktura_niejasna',      -- case_subcategory
  'medium',                -- priority
  0,                       -- is_escalated_to_2nd_line
  '2025-01-11 09:06:00',   -- sla_due_at (24h)
  1,                       -- resolved_in_sla
  'FCR'                    -- resolution_type
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
  1,                      -- is_escalated_to_2nd_line
  '2025-01-11 10:01:00',  -- SLA 24h
  1,                      -- resolved_in_sla
  'after_escalation'
);

-- Case 3 – Klient D, sprawa dot. faktury, rozwiazana podczas callbacku
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
  0,
  '2025-01-11 10:30:10',
  1,
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
  1,
  '2025-01-11 11:01:00',
  1,
  'after_escalation'
);

-- Case 5 – Klient A, sprawa rozwiazana w IVR (self-service),
--           dla przykladu rowniez rejestrowana jako sprawa
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
  0,
  '2025-01-11 09:00:02',
  1,
  'self_service'
);

-- =========================================================
-- 6.5. Kontakty (CONTACTS)
-- =========================================================

-- Case 1 – jeden kontakt, FCR
INSERT INTO contacts VALUES (
  1,
  1,    -- case_id
  2,    -- call_id
  2,    -- customer_id (Klient B)
  1,    -- agent_id (Anna)
  '2025-01-10 09:06:00',
  'phone',
  1,   -- is_first_contact
  1,   -- resolved_this_contact
  1    -- is_inbound
);

-- Case 2 – pierwszy kontakt (1st line), jeszcze bez rozwiazania
INSERT INTO contacts VALUES (
  2,
  2,
  4,
  2,
  2,     -- Jan
  '2025-01-10 10:01:00',
  'phone',
  1,   -- first_contact
  0,   -- resolved_this_contact
  1
);

-- Case 2 – drugi kontakt (2nd line), sprawa zamknieta
INSERT INTO contacts VALUES (
  3,
  2,
  9,
  2,
  3,     -- Maria
  '2025-01-11 09:00:10',
  'phone',
  0,
  1,
  0   -- outbound
);

-- Case 3 – callback do Klienta D, FCR
INSERT INTO contacts VALUES (
  4,
  3,
  6,
  4,
  1,      -- Anna
  '2025-01-10 10:30:10',
  'phone',
  1,
  1,
  0   -- outbound (callback)
);

-- Case 4 – kontakt 1st line (nie rozwiazuje)
INSERT INTO contacts VALUES (
  5,
  4,
  7,
  5,
  2,      -- Jan
  '2025-01-10 11:01:00',
  'phone',
  1,
  0,
  1
);

-- Case 4 – kontakt 2nd line z decyzja
INSERT INTO contacts VALUES (
  6,
  4,
  8,
  5,
  3,      -- Maria
  '2025-01-10 13:00:10',
  'phone',
  0,
  1,
  0
);

-- Case 5 – samoobsauga w IVR, bez kontaktu z konsultantem (dla przykladu brak w contacts)

-- KONIEC DANYCH


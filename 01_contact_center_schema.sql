
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
    customer_id   INT PRIMARY KEY,
    name          VARCHAR(100),
    segment       VARCHAR(50),   -- np. B2C / SME / Corporate
    region        VARCHAR(50)    -- np. "Mazowieckie"
);

CREATE TABLE agents (
    agent_id   INT PRIMARY KEY,
    name       VARCHAR(100),
    team       VARCHAR(50),      -- 1st_line / 2nd_line
    seniority  VARCHAR(50)       -- junior / mid / senior
);

-- =========================================================
-- 3. Tabela calls – każde połączenie
-- =========================================================
CREATE TABLE calls (
    call_id               INT PRIMARY KEY,
    customer_id           INT FOREIGN KEY REFERENCES customers(customer_id),
    agent_id              INT FOREIGN KEY REFERENCES agents(agent_id),

    start_time            DATETIME2 NOT NULL,
    ivr_start_time        DATETIME2,
    queue_start_time      DATETIME2,
    answer_time           DATETIME2,
    end_time              DATETIME2,

    direction             VARCHAR(20),  -- inbound / outbound
    channel               VARCHAR(20),  -- phone / chat / email
    ivr_topic             VARCHAR(50),  -- faktura / reklamacje / techniczne

    is_self_service       BIT DEFAULT 0,
    is_callback_chosen    BIT DEFAULT 0,
    is_callback_realized  BIT DEFAULT 0,
    is_answered_by_agent  BIT DEFAULT 0,
    is_abandoned_in_queue BIT DEFAULT 0
);

-- =========================================================
-- 4. Tabela cases – zgłoszenia / sprawy
-- =========================================================
CREATE TABLE cases (
    case_id               INT PRIMARY KEY,
    customer_id           INT FOREIGN KEY REFERENCES customers(customer_id),
    first_call_id         INT FOREIGN KEY REFERENCES calls(call_id),

    opened_at             DATETIME2 NOT NULL,
    closed_at             DATETIME2,
    status                VARCHAR(20),   -- open / in_progress / closed

    case_category         VARCHAR(50),   -- faktura / reklamacja / techniczne
    case_subcategory      VARCHAR(50),
    priority              VARCHAR(20),   -- low / medium / high

    is_escalated_to_2nd_line BIT DEFAULT 0,
    sla_due_at            DATETIME2,
    resolved_in_sla       BIT,
    resolution_type       VARCHAR(30)    -- FCR / after_escalation / self_service / no_solution
);

-- =========================================================
-- 5. Tabela contacts – każdy kontakt konsultanta ze sprawą
-- =========================================================
CREATE TABLE contacts (
    contact_id        INT PRIMARY KEY,
    case_id           INT FOREIGN KEY REFERENCES cases(case_id),
    call_id           INT FOREIGN KEY REFERENCES calls(call_id),
    customer_id       INT FOREIGN KEY REFERENCES customers(customer_id),
    agent_id          INT FOREIGN KEY REFERENCES agents(agent_id),

    contact_time      DATETIME2 NOT NULL,
    channel           VARCHAR(20),

    is_first_contact      BIT DEFAULT 0,
    resolved_this_contact BIT DEFAULT 0,
    is_inbound            BIT DEFAULT 1
);
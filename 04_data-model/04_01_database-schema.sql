/*
================================================================================
Contact Center Process Optimization — SQL Server schema
Wersja enterprise-ready: spójna z BPMN, callbackami, SLA, KPI i Power BI.
================================================================================
*/

SET NOCOUNT ON;
GO

/* -----------------------------------------------------------------------------
1. Cleanup — kolejność zgodna z zależnościami FK
----------------------------------------------------------------------------- */
DROP TABLE IF EXISTS dbo.sla_events;
DROP TABLE IF EXISTS dbo.callbacks;
DROP TABLE IF EXISTS dbo.contacts;
DROP TABLE IF EXISTS dbo.cases;
DROP TABLE IF EXISTS dbo.calls;
DROP TABLE IF EXISTS dbo.agents;
DROP TABLE IF EXISTS dbo.customers;
GO

/* -----------------------------------------------------------------------------
2. Master data
----------------------------------------------------------------------------- */
CREATE TABLE dbo.customers (
    customer_id     INT             NOT NULL,
    customer_name   NVARCHAR(150)   NOT NULL,
    segment         NVARCHAR(30)    NOT NULL,
    region          NVARCHAR(80)    NOT NULL,
    created_at      DATETIME2(0)    NOT NULL CONSTRAINT DF_customers_created_at DEFAULT SYSUTCDATETIME(),
    is_active       BIT             NOT NULL CONSTRAINT DF_customers_is_active DEFAULT 1,

    CONSTRAINT PK_customers PRIMARY KEY (customer_id),
    CONSTRAINT CK_customers_segment CHECK (segment IN (N'B2C', N'SME', N'Corporate'))
);
GO

CREATE TABLE dbo.agents (
    agent_id        INT             NOT NULL,
    agent_name      NVARCHAR(150)   NOT NULL,
    team            NVARCHAR(30)    NOT NULL,
    seniority       NVARCHAR(30)    NOT NULL,
    location        NVARCHAR(80)    NOT NULL,
    is_active       BIT             NOT NULL CONSTRAINT DF_agents_is_active DEFAULT 1,

    CONSTRAINT PK_agents PRIMARY KEY (agent_id),
    CONSTRAINT CK_agents_team CHECK (team IN (N'1st_line', N'2nd_line', N'back_office')),
    CONSTRAINT CK_agents_seniority CHECK (seniority IN (N'junior', N'mid', N'senior', N'expert'))
);
GO

/* -----------------------------------------------------------------------------
3. Operational facts
----------------------------------------------------------------------------- */
CREATE TABLE dbo.calls (
    call_id                 INT             NOT NULL,
    customer_id             INT             NOT NULL,
    agent_id                INT             NULL,
    start_time              DATETIME2(0)    NOT NULL,
    ivr_start_time          DATETIME2(0)    NULL,
    queue_start_time        DATETIME2(0)    NULL,
    answer_time             DATETIME2(0)    NULL,
    end_time                DATETIME2(0)    NOT NULL,
    direction               NVARCHAR(20)    NOT NULL,
    channel                 NVARCHAR(20)    NOT NULL,
    ivr_topic               NVARCHAR(50)    NULL,
    call_outcome            NVARCHAR(40)    NOT NULL,
    is_self_service         BIT             NOT NULL CONSTRAINT DF_calls_self_service DEFAULT 0,
    is_callback_chosen      BIT             NOT NULL CONSTRAINT DF_calls_callback_chosen DEFAULT 0,
    is_callback_realized    BIT             NOT NULL CONSTRAINT DF_calls_callback_realized DEFAULT 0,
    is_answered_by_agent    BIT             NOT NULL CONSTRAINT DF_calls_answered DEFAULT 0,
    is_abandoned_in_queue   BIT             NOT NULL CONSTRAINT DF_calls_abandoned DEFAULT 0,

    CONSTRAINT PK_calls PRIMARY KEY (call_id),
    CONSTRAINT FK_calls_customers FOREIGN KEY (customer_id) REFERENCES dbo.customers(customer_id),
    CONSTRAINT FK_calls_agents FOREIGN KEY (agent_id) REFERENCES dbo.agents(agent_id),
    CONSTRAINT CK_calls_direction CHECK (direction IN (N'inbound', N'outbound')),
    CONSTRAINT CK_calls_channel CHECK (channel IN (N'phone', N'chat', N'email')),
    CONSTRAINT CK_calls_outcome CHECK (call_outcome IN (N'answered', N'abandoned', N'self_service', N'callback_requested', N'callback_completed')),
    CONSTRAINT CK_calls_time_order CHECK (end_time >= start_time),
    CONSTRAINT CK_calls_answer_after_queue CHECK (answer_time IS NULL OR queue_start_time IS NULL OR answer_time >= queue_start_time),
    CONSTRAINT CK_calls_ivr_after_start CHECK (ivr_start_time IS NULL OR ivr_start_time >= start_time)
);
GO

CREATE TABLE dbo.cases (
    case_id                     INT             NOT NULL,
    customer_id                 INT             NOT NULL,
    first_call_id               INT             NOT NULL,
    opened_at                   DATETIME2(0)    NOT NULL,
    closed_at                   DATETIME2(0)    NULL,
    status                      NVARCHAR(30)    NOT NULL,
    case_category               NVARCHAR(50)    NOT NULL,
    case_subcategory            NVARCHAR(80)    NULL,
    priority                    NVARCHAR(20)    NOT NULL,
    is_escalated_to_2nd_line    BIT             NOT NULL CONSTRAINT DF_cases_escalated DEFAULT 0,
    escalation_reason           NVARCHAR(150)   NULL,
    sla_due_at                  DATETIME2(0)    NOT NULL,
    resolved_in_sla             BIT             NULL,
    resolution_type             NVARCHAR(40)    NULL,

    CONSTRAINT PK_cases PRIMARY KEY (case_id),
    CONSTRAINT FK_cases_customers FOREIGN KEY (customer_id) REFERENCES dbo.customers(customer_id),
    CONSTRAINT FK_cases_calls_first_call FOREIGN KEY (first_call_id) REFERENCES dbo.calls(call_id),
    CONSTRAINT CK_cases_status CHECK (status IN (N'open', N'in_progress', N'escalated', N'closed')),
    CONSTRAINT CK_cases_priority CHECK (priority IN (N'low', N'medium', N'high', N'critical')),
    CONSTRAINT CK_cases_resolution CHECK (resolution_type IS NULL OR resolution_type IN (N'FCR', N'after_escalation', N'self_service', N'no_solution')),
    CONSTRAINT CK_cases_time_order CHECK (closed_at IS NULL OR closed_at >= opened_at),
    CONSTRAINT CK_cases_sla_after_open CHECK (sla_due_at >= opened_at)
);
GO

CREATE TABLE dbo.contacts (
    contact_id              INT             NOT NULL,
    case_id                 INT             NOT NULL,
    call_id                 INT             NOT NULL,
    customer_id             INT             NOT NULL,
    agent_id                INT             NULL,
    contact_time            DATETIME2(0)    NOT NULL,
    channel                 NVARCHAR(20)    NOT NULL,
    contact_type            NVARCHAR(40)    NOT NULL,
    is_first_contact        BIT             NOT NULL CONSTRAINT DF_contacts_first DEFAULT 0,
    resolved_this_contact   BIT             NOT NULL CONSTRAINT DF_contacts_resolved DEFAULT 0,
    is_inbound              BIT             NOT NULL CONSTRAINT DF_contacts_inbound DEFAULT 1,

    CONSTRAINT PK_contacts PRIMARY KEY (contact_id),
    CONSTRAINT FK_contacts_cases FOREIGN KEY (case_id) REFERENCES dbo.cases(case_id),
    CONSTRAINT FK_contacts_calls FOREIGN KEY (call_id) REFERENCES dbo.calls(call_id),
    CONSTRAINT FK_contacts_customers FOREIGN KEY (customer_id) REFERENCES dbo.customers(customer_id),
    CONSTRAINT FK_contacts_agents FOREIGN KEY (agent_id) REFERENCES dbo.agents(agent_id),
    CONSTRAINT CK_contacts_channel CHECK (channel IN (N'phone', N'chat', N'email')),
    CONSTRAINT CK_contacts_type CHECK (contact_type IN (N'inbound_call', N'outbound_callback', N'backoffice_update'))
);
GO

CREATE TABLE dbo.callbacks (
    callback_id             INT             NOT NULL,
    source_call_id          INT             NOT NULL,
    realized_call_id        INT             NULL,
    customer_id             INT             NOT NULL,
    requested_at            DATETIME2(0)    NOT NULL,
    scheduled_at            DATETIME2(0)    NOT NULL,
    realized_at             DATETIME2(0)    NULL,
    status                  NVARCHAR(30)    NOT NULL,
    failure_reason          NVARCHAR(150)   NULL,
    agent_id                INT             NULL,
    phone_masked            NVARCHAR(30)    NOT NULL,

    CONSTRAINT PK_callbacks PRIMARY KEY (callback_id),
    CONSTRAINT FK_callbacks_source_call FOREIGN KEY (source_call_id) REFERENCES dbo.calls(call_id),
    CONSTRAINT FK_callbacks_realized_call FOREIGN KEY (realized_call_id) REFERENCES dbo.calls(call_id),
    CONSTRAINT FK_callbacks_customers FOREIGN KEY (customer_id) REFERENCES dbo.customers(customer_id),
    CONSTRAINT FK_callbacks_agents FOREIGN KEY (agent_id) REFERENCES dbo.agents(agent_id),
    CONSTRAINT CK_callbacks_status CHECK (status IN (N'requested', N'scheduled', N'completed', N'cancelled', N'failed', N'overdue')),
    CONSTRAINT CK_callbacks_schedule CHECK (scheduled_at >= requested_at),
    CONSTRAINT CK_callbacks_realized CHECK (realized_at IS NULL OR realized_at >= requested_at)
);
GO

CREATE TABLE dbo.sla_events (
    sla_event_id            INT             NOT NULL,
    case_id                 INT             NOT NULL,
    event_type              NVARCHAR(40)    NOT NULL,
    event_time              DATETIME2(0)    NOT NULL,
    old_status              NVARCHAR(30)    NULL,
    new_status              NVARCHAR(30)    NULL,
    breached_flag           BIT             NOT NULL CONSTRAINT DF_sla_events_breached DEFAULT 0,
    event_comment           NVARCHAR(250)   NULL,

    CONSTRAINT PK_sla_events PRIMARY KEY (sla_event_id),
    CONSTRAINT FK_sla_events_cases FOREIGN KEY (case_id) REFERENCES dbo.cases(case_id),
    CONSTRAINT CK_sla_events_type CHECK (event_type IN (N'created', N'warning', N'escalated', N'resolved', N'breached'))
);
GO

/* -----------------------------------------------------------------------------
4. Reporting indexes
----------------------------------------------------------------------------- */
CREATE INDEX IX_calls_customer_id ON dbo.calls(customer_id);
CREATE INDEX IX_calls_agent_id ON dbo.calls(agent_id);
CREATE INDEX IX_calls_start_time ON dbo.calls(start_time);
CREATE INDEX IX_calls_direction_channel ON dbo.calls(direction, channel);
CREATE INDEX IX_calls_outcome ON dbo.calls(call_outcome);

CREATE INDEX IX_cases_customer_id ON dbo.cases(customer_id);
CREATE INDEX IX_cases_first_call_id ON dbo.cases(first_call_id);
CREATE INDEX IX_cases_opened_at ON dbo.cases(opened_at);
CREATE INDEX IX_cases_closed_at ON dbo.cases(closed_at);
CREATE INDEX IX_cases_status_priority ON dbo.cases(status, priority);
CREATE INDEX IX_cases_resolved_sla ON dbo.cases(resolved_in_sla);
CREATE INDEX IX_cases_escalated ON dbo.cases(is_escalated_to_2nd_line);

CREATE INDEX IX_contacts_case_id ON dbo.contacts(case_id);
CREATE INDEX IX_contacts_call_id ON dbo.contacts(call_id);
CREATE INDEX IX_contacts_customer_id ON dbo.contacts(customer_id);
CREATE INDEX IX_contacts_agent_id ON dbo.contacts(agent_id);
CREATE INDEX IX_contacts_time ON dbo.contacts(contact_time);

CREATE INDEX IX_callbacks_source_call_id ON dbo.callbacks(source_call_id);
CREATE INDEX IX_callbacks_realized_call_id ON dbo.callbacks(realized_call_id);
CREATE INDEX IX_callbacks_customer_id ON dbo.callbacks(customer_id);
CREATE INDEX IX_callbacks_status ON dbo.callbacks(status);
CREATE INDEX IX_callbacks_scheduled_at ON dbo.callbacks(scheduled_at);

CREATE INDEX IX_sla_events_case_id ON dbo.sla_events(case_id);
CREATE INDEX IX_sla_events_type_time ON dbo.sla_events(event_type, event_time);
GO

/*
================================================================================
Contact Center Process Optimization — KPI queries
SQL Server / T-SQL. Queries aligned with the enterprise-ready schema.
================================================================================
*/

SET NOCOUNT ON;
GO

/* -----------------------------------------------------------------------------
0. Volume checks
----------------------------------------------------------------------------- */
SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM dbo.customers
UNION ALL SELECT 'agents', COUNT(*) FROM dbo.agents
UNION ALL SELECT 'calls', COUNT(*) FROM dbo.calls
UNION ALL SELECT 'cases', COUNT(*) FROM dbo.cases
UNION ALL SELECT 'contacts', COUNT(*) FROM dbo.contacts
UNION ALL SELECT 'callbacks', COUNT(*) FROM dbo.callbacks
UNION ALL SELECT 'sla_events', COUNT(*) FROM dbo.sla_events;
GO

/* -----------------------------------------------------------------------------
1. ASA — Average Speed of Answer
----------------------------------------------------------------------------- */
SELECT
    AVG(CAST(DATEDIFF(SECOND, queue_start_time, answer_time) AS DECIMAL(10, 2))) AS asa_seconds
FROM dbo.calls
WHERE direction = N'inbound'
  AND is_answered_by_agent = 1
  AND queue_start_time IS NOT NULL
  AND answer_time IS NOT NULL;
GO

/* -----------------------------------------------------------------------------
2. AHT — Average Handle Time
----------------------------------------------------------------------------- */
SELECT
    AVG(CAST(DATEDIFF(SECOND, answer_time, end_time) AS DECIMAL(10, 2))) AS aht_seconds
FROM dbo.calls
WHERE is_answered_by_agent = 1
  AND answer_time IS NOT NULL
  AND end_time IS NOT NULL;
GO

/* -----------------------------------------------------------------------------
3. Abandonment Rate
----------------------------------------------------------------------------- */
WITH inbound_calls AS (
    SELECT *
    FROM dbo.calls
    WHERE direction = N'inbound'
)
SELECT
    COUNT(*) AS total_inbound_calls,
    SUM(CASE WHEN is_abandoned_in_queue = 1 THEN 1 ELSE 0 END) AS abandoned_calls,
    CAST(1.0 * SUM(CASE WHEN is_abandoned_in_queue = 1 THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0) AS DECIMAL(10, 4)) AS abandonment_rate
FROM inbound_calls;
GO

/* -----------------------------------------------------------------------------
4. Self-service Rate
----------------------------------------------------------------------------- */
WITH inbound_calls AS (
    SELECT *
    FROM dbo.calls
    WHERE direction = N'inbound'
)
SELECT
    COUNT(*) AS total_inbound_calls,
    SUM(CASE WHEN is_self_service = 1 THEN 1 ELSE 0 END) AS self_service_calls,
    CAST(1.0 * SUM(CASE WHEN is_self_service = 1 THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0) AS DECIMAL(10, 4)) AS self_service_rate
FROM inbound_calls;
GO

/* -----------------------------------------------------------------------------
5. Callback Rate and Callback Realization Rate
----------------------------------------------------------------------------- */
WITH queued_calls AS (
    SELECT *
    FROM dbo.calls
    WHERE direction = N'inbound'
      AND queue_start_time IS NOT NULL
), callback_summary AS (
    SELECT
        COUNT(*) AS total_callbacks,
        SUM(CASE WHEN status = N'completed' THEN 1 ELSE 0 END) AS completed_callbacks,
        AVG(CASE WHEN status = N'completed' THEN CAST(DATEDIFF(MINUTE, requested_at, realized_at) AS DECIMAL(10, 2)) END) AS avg_callback_delay_minutes
    FROM dbo.callbacks
)
SELECT
    (SELECT COUNT(*) FROM queued_calls) AS total_queued_calls,
    (SELECT COUNT(*) FROM dbo.callbacks) AS callback_requests,
    CAST(1.0 * (SELECT COUNT(*) FROM dbo.callbacks) / NULLIF((SELECT COUNT(*) FROM queued_calls), 0) AS DECIMAL(10, 4)) AS callback_rate,
    completed_callbacks,
    CAST(1.0 * completed_callbacks / NULLIF(total_callbacks, 0) AS DECIMAL(10, 4)) AS callback_realization_rate,
    avg_callback_delay_minutes
FROM callback_summary;
GO

/* -----------------------------------------------------------------------------
6. FCR — First Contact Resolution
----------------------------------------------------------------------------- */
SELECT
    COUNT(*) AS closed_cases,
    SUM(CASE WHEN resolution_type = N'FCR' THEN 1 ELSE 0 END) AS fcr_cases,
    CAST(1.0 * SUM(CASE WHEN resolution_type = N'FCR' THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0) AS DECIMAL(10, 4)) AS fcr_rate
FROM dbo.cases
WHERE status = N'closed';
GO

/* -----------------------------------------------------------------------------
7. SLA Rate and SLA breaches
----------------------------------------------------------------------------- */
SELECT
    COUNT(*) AS closed_cases,
    SUM(CASE WHEN resolved_in_sla = 1 THEN 1 ELSE 0 END) AS cases_in_sla,
    SUM(CASE WHEN resolved_in_sla = 0 THEN 1 ELSE 0 END) AS cases_after_sla,
    CAST(1.0 * SUM(CASE WHEN resolved_in_sla = 1 THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0) AS DECIMAL(10, 4)) AS sla_rate
FROM dbo.cases
WHERE status = N'closed';
GO

/* -----------------------------------------------------------------------------
8. Escalation Rate
----------------------------------------------------------------------------- */
SELECT
    COUNT(*) AS total_cases,
    SUM(CASE WHEN is_escalated_to_2nd_line = 1 THEN 1 ELSE 0 END) AS escalated_cases,
    CAST(1.0 * SUM(CASE WHEN is_escalated_to_2nd_line = 1 THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0) AS DECIMAL(10, 4)) AS escalation_rate
FROM dbo.cases;
GO

/* -----------------------------------------------------------------------------
9. Hourly load — queue, ASA, abandonment
----------------------------------------------------------------------------- */
SELECT
    DATEPART(HOUR, start_time) AS call_hour,
    COUNT(*) AS total_calls,
    SUM(CASE WHEN is_answered_by_agent = 1 THEN 1 ELSE 0 END) AS answered_calls,
    SUM(CASE WHEN is_abandoned_in_queue = 1 THEN 1 ELSE 0 END) AS abandoned_calls,
    AVG(CASE WHEN queue_start_time IS NOT NULL AND answer_time IS NOT NULL THEN DATEDIFF(SECOND, queue_start_time, answer_time) END) AS asa_seconds
FROM dbo.calls
WHERE direction = N'inbound'
GROUP BY DATEPART(HOUR, start_time)
ORDER BY call_hour;
GO

/* -----------------------------------------------------------------------------
10. Agent performance — AHT, FCR, contact volume
----------------------------------------------------------------------------- */
SELECT
    a.agent_id,
    a.agent_name,
    a.team,
    COUNT(DISTINCT c.call_id) AS handled_calls,
    AVG(CASE WHEN c.answer_time IS NOT NULL THEN DATEDIFF(SECOND, c.answer_time, c.end_time) END) AS aht_seconds,
    COUNT(DISTINCT ca.case_id) AS handled_cases,
    CAST(1.0 * SUM(CASE WHEN ca.resolution_type = N'FCR' THEN 1 ELSE 0 END) / NULLIF(COUNT(ca.case_id), 0) AS DECIMAL(10, 4)) AS fcr_rate
FROM dbo.agents a
LEFT JOIN dbo.calls c
    ON c.agent_id = a.agent_id
LEFT JOIN dbo.contacts ct
    ON ct.agent_id = a.agent_id
LEFT JOIN dbo.cases ca
    ON ca.case_id = ct.case_id
GROUP BY a.agent_id, a.agent_name, a.team
ORDER BY handled_calls DESC;
GO

/* -----------------------------------------------------------------------------
11. Category analysis — FCR, SLA, escalation
----------------------------------------------------------------------------- */
SELECT
    case_category,
    COUNT(*) AS total_cases,
    CAST(1.0 * SUM(CASE WHEN resolution_type = N'FCR' THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0) AS DECIMAL(10, 4)) AS fcr_rate,
    CAST(1.0 * SUM(CASE WHEN resolved_in_sla = 1 THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0) AS DECIMAL(10, 4)) AS sla_rate,
    CAST(1.0 * SUM(CASE WHEN is_escalated_to_2nd_line = 1 THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0) AS DECIMAL(10, 4)) AS escalation_rate
FROM dbo.cases
GROUP BY case_category
ORDER BY total_cases DESC;
GO

/* -----------------------------------------------------------------------------
12. Operational exceptions — for dashboard alert page
----------------------------------------------------------------------------- */
SELECT
    N'CASE_AFTER_SLA' AS exception_type,
    CAST(case_id AS NVARCHAR(50)) AS object_id,
    opened_at AS detected_at,
    CONCAT(N'Case category: ', case_category, N', priority: ', priority) AS description
FROM dbo.cases
WHERE status = N'closed'
  AND resolved_in_sla = 0

UNION ALL

SELECT
    N'CALLBACK_NOT_COMPLETED' AS exception_type,
    CAST(callback_id AS NVARCHAR(50)) AS object_id,
    scheduled_at AS detected_at,
    CONCAT(N'Callback status: ', status, N', reason: ', COALESCE(failure_reason, N'n/a')) AS description
FROM dbo.callbacks
WHERE status IN (N'failed', N'overdue')

ORDER BY detected_at DESC;
GO

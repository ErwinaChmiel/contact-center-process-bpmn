--SELECT * FROM customers;
--SELECT * FROM agents;
--SELECT * FROM calls;
--SELECT * FROM cases;
--SELECT * FROM contacts;

--SELECT COUNT(*) AS calls_cnt      FROM calls;
--SELECT COUNT(*) AS cases_cnt      FROM cases;
--SELECT COUNT(*) AS contacts_cnt   FROM contacts;

-- ASA – Average Speed of Answer (średni czas oczekiwania)
SELECT 
    AVG(DATEDIFF(SECOND, queue_start_time, answer_time)) AS ASA_seconds
FROM calls
WHERE 
    direction = 'inbound'
    AND is_answered_by_agent = 1
    AND queue_start_time IS NOT NULL
    AND answer_time IS NOT NULL;

-- AHT – Average Handle Time (średni czas obsługi)
SELECT 
    AVG(DATEDIFF(SECOND, answer_time, end_time)) AS AHT_seconds
FROM calls
WHERE 
    is_answered_by_agent = 1
    AND answer_time IS NOT NULL
    AND end_time IS NOT NULL;

--Abandonment rate – % porzuconych połączeń
WITH inbound_calls AS (
    SELECT *
    FROM calls
    WHERE direction = 'inbound'
)
SELECT 
    COUNT(*)                                      AS total_inbound,
    SUM(CASE WHEN is_abandoned_in_queue = 1 THEN 1 ELSE 0 END) AS abandoned_in_queue,
    1.0 * SUM(CASE WHEN is_abandoned_in_queue = 1 THEN 1 ELSE 0 END)
/ NULLIF(COUNT(*),0)                             AS abandonment_rate
FROM inbound_calls;

--Self-service rate – % połączeń załatwionych w IVR
WITH inbound_calls AS (
    SELECT *
    FROM calls
    WHERE direction = 'inbound'
)
SELECT
    COUNT(*) AS total_inbound,
    SUM(CASE WHEN is_self_service = 1 THEN 1 ELSE 0 END) AS self_service_cnt,
    1.0 * SUM(CASE WHEN is_self_service = 1 THEN 1 ELSE 0 END)
/ NULLIF(COUNT(*),0) AS self_service_rate
FROM inbound_calls;

--Callback rate
WITH queued_calls AS (
    SELECT *
    FROM calls
    WHERE queue_start_time IS NOT NULL
)
SELECT
    COUNT(*) AS total_queued,
    SUM(CASE WHEN is_callback_chosen = 1 THEN 1 ELSE 0 END) AS callback_chosen,
    1.0 * SUM(CASE WHEN is_callback_chosen = 1 THEN 1 ELSE 0 END)
/ NULLIF(COUNT(*),0) AS callback_rate
FROM queued_calls;

--FCR – First Contact Resolution (po sprawach)
SELECT
    COUNT(*) AS closed_cases,
    SUM(CASE WHEN resolution_type = 'FCR' THEN 1 ELSE 0 END) AS fcr_cases,
    1.0 * SUM(CASE WHEN resolution_type = 'FCR' THEN 1 ELSE 0 END)
/ NULLIF(COUNT(*),0) AS fcr_rate
FROM cases
WHERE status = 'closed';

--SLA – % spraw zamkniętych w czasie
SELECT
    COUNT(*) AS closed_cases,
    SUM(CASE WHEN resolved_in_sla = 1 THEN 1 ELSE 0 END) AS in_sla_cases,
    1.0 * SUM(CASE WHEN resolved_in_sla = 1 THEN 1 ELSE 0 END)
/ NULLIF(COUNT(*),0) AS sla_rate
FROM cases
WHERE status = 'closed';

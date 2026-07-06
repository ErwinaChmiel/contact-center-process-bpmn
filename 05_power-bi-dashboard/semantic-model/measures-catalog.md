# Measures Catalog — Contact Center Power BI

| Measure | Folder | Business meaning | Source |
|---|---|---|---|
| `Total Calls` | Calls | Liczba wszystkich połączeń | `calls` |
| `Inbound Calls` | Calls | Liczba połączeń przychodzących | `calls.direction` |
| `ASA Seconds` | Calls | Średni czas oczekiwania na odpowiedź | `calls.queue_start_time`, `calls.answer_time` |
| `AHT Seconds` | Calls | Średni czas obsługi | `calls.answer_time`, `calls.end_time` |
| `Abandonment Rate` | Calls | Odsetek porzuceń | `calls.is_abandoned_in_queue` |
| `Self-service Rate` | Calls | Udział self-service | `calls.is_self_service` |
| `FCR Rate` | Cases | First Contact Resolution | `cases.resolution_type` |
| `SLA Rate` | Cases | Odsetek spraw w SLA | `cases.resolved_in_sla` |
| `Escalation Rate` | Cases | Udział eskalacji | `cases.is_escalated_to_2nd_line` |
| `Callback Realization Rate` | Callback | Skuteczność callbacków | `callbacks.status` |
| `Callback Delay Minutes` | Callback | Średnie opóźnienie realizacji callbacku | `callbacks.requested_at`, `callbacks.realized_at` |
| `Operational Exceptions` | Alerts | Liczba wyjątków operacyjnych | `cases`, `callbacks` |
| `Executive Health Score` | Alerts | Syntetyczna ocena kondycji procesu | SLA, callback, ASA, abandonment |

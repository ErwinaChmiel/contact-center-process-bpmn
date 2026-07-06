# Power BI Semantic Model — relacje i założenia

## Cel

Dokument opisuje rekomendowany model semantyczny dla dashboardu Power BI. Dzięki temu plik PBIX nie jest jedynym miejscem, w którym ukryta jest logika raportowa.

---

## Relacje rekomendowane w Power BI

| Tabela źródłowa | Kolumna | Tabela docelowa | Kolumna | Kardynalność | Kierunek filtrowania |
|---|---|---|---|---:|---|
| `customers` | `customer_id` | `calls` | `customer_id` | 1:* | Single |
| `customers` | `customer_id` | `cases` | `customer_id` | 1:* | Single |
| `customers` | `customer_id` | `callbacks` | `customer_id` | 1:* | Single |
| `agents` | `agent_id` | `calls` | `agent_id` | 1:* | Single |
| `agents` | `agent_id` | `contacts` | `agent_id` | 1:* | Single |
| `calls` | `call_id` | `cases` | `first_call_id` | 1:* | Single |
| `calls` | `call_id` | `contacts` | `call_id` | 1:* | Single |
| `calls` | `call_id` | `callbacks` | `source_call_id` | 1:* | Single |
| `cases` | `case_id` | `contacts` | `case_id` | 1:* | Single |
| `cases` | `case_id` | `sla_events` | `case_id` | 1:* | Single |
| `Date` | `Date` | `calls` | `start_time_date` | 1:* | Single |
| `Date` | `Date` | `cases` | `opened_at_date` | 1:* | Single |
| `Date` | `Date` | `callbacks` | `requested_at_date` | 1:* | Single |

---

## Rekomendacje modelowania

1. Utwórz osobną tabelę kalendarza `Date` i oznacz ją jako Date table.
2. W tabelach faktów dodaj kolumny dat bez czasu, np. `start_time_date`, `opened_at_date`, `requested_at_date`.
3. Dla relacji alternatywnych, np. `callbacks.realized_call_id → calls.call_id`, użyj relacji nieaktywnej i aktywuj ją w miarach przez `USERELATIONSHIP`, jeśli będzie potrzebna.
4. Kierunek filtrowania ustaw jako `Single`, aby uniknąć niekontrolowanych ścieżek filtracji.
5. Miary trzymaj w osobnej tabeli `Measures` albo w folderach display folders.
6. Kolumny techniczne, flagi pomocnicze i identyfikatory ukryj w widoku raportowym, jeżeli nie są potrzebne użytkownikowi biznesowemu.

---

## Warstwa biznesowa nazw

| Nazwa techniczna | Nazwa biznesowa w raporcie |
|---|---|
| `calls` | Połączenia |
| `cases` | Sprawy |
| `contacts` | Kontakty |
| `callbacks` | Callbacki |
| `sla_events` | Zdarzenia SLA |
| `agents` | Konsultanci |
| `customers` | Klienci |

---

## Minimalna lista stron raportu

1. Executive Overview
2. Call Flow & Queue Performance
3. SLA & Case Management
4. Callback Performance
5. Agent Performance
6. Operational Exceptions
7. Contact Category Analysis

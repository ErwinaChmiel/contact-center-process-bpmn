# Model danych i KPI

## 1. Diagram modelu danych

Model jest zbudowany w układzie zbliżonym do **star schema** – tabele faktów (`calls`, `cases`, `contacts`) połączone z wymiarami (`customers`, `agents`, `dimDate`) oraz techniczną tabelą miar (`measures_all`).

Poniżej diagram w formacie **Mermaid** (GitHub wyświetli go jako grafikę):

```mermaid
erDiagram
    CUSTOMERS ||--o{ CALLS    : has
    CUSTOMERS ||--o{ CASES    : owns
    CUSTOMERS ||--o{ CONTACTS : "is party of"

    AGENTS   ||--o{ CALLS     : handles
    AGENTS   ||--o{ CONTACTS  : handles

    CALLS    ||--o{ CASES     : "creates (first_call_id)"
    CASES    ||--o{ CONTACTS  : "is handled in"

    DIMDATE  ||--o{ CALLS     : "call dates"
    DIMDATE  ||--o{ CASES     : "opened / closed"

    CUSTOMERS {
      int     customer_id PK
      string  name
      string  segment
      string  region
    }

    AGENTS {
      int     agent_id PK
      string  name
      string  team
      string  seniority
    }

    CALLS {
      int     call_id PK
      int     customer_id FK
      int     agent_id FK
      datetime start_time
      datetime ivr_start_time
      datetime queue_start_time
      datetime answer_time
      datetime end_time
      string  direction
      string  channel
      string  ivr_topic
      bool    is_self_service
      bool    is_callback_chosen
      bool    is_callback_realized
      bool    is_answered_by_agent
      bool    is_abandoned_in_queue
    }

    CASES {
      int     case_id PK
      int     customer_id FK
      int     first_call_id FK
      datetime opened_at
      datetime closed_at
      string  status
      string  case_category
      string  case_subcategory
      string  priority
      bool    is_escalated_to_2nd_line
      datetime sla_due_at
      bool    resolved_in_sla
      string  resolution_type
    }

    CONTACTS {
      int     contact_id PK
      int     case_id FK
      int     call_id FK
      int     customer_id FK
      int     agent_id FK
      datetime contact_time
      string  channel
      bool    is_first_contact
      bool    resolved_this_contact
      bool    is_inbound
    }

    DIMDATE {
      date    Date PK
      int     Year
      int     Month
      int     Day
      string  YearMonth
      int     Hour
    }

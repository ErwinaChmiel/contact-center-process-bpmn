# Model danych i KPI

## Diagram modelu danych

Model danych został zaprojektowany w układzie zbliżonym do **gwiazdy** (star schema).  
Poniżej prosty schemat relacji pomiędzy tabelami:

```text
                 ┌───────────────┐
                 │  dimCustomers │
                 │  customers    │
                 └───────┬───────┘
                         │ customer_id
                         │
                 ┌───────▼───────┐
                 │   factCalls   │
                 │    calls      │
                 └──┬────┬───────┘
            call_id │    │ agent_id
                    │    │
         first_call_id    │
           ┌──────────────▼──────────────┐
           │          dimAgents          │
           │           agents            │
           └─────────────────────────────┘

                 ┌───────────────┐
                 │   factCases   │
                 │    cases      │
                 └──┬────────────┘
          case_id   │
                    │ case_id
             ┌──────▼───────┐
             │ factContacts │
             │  contacts    │
             └──────────────┘

                 ┌───────────────┐
                 │   dimDate     │
                 │  (Calendar)   │
                 └────┬────┬─────┘
                      │    │
        Date ↔ start_time  │
             (calls)       │
                      Date ↔ opened_at / closed_at
                           (cases)

| Tabela         | Rola w modelu | Ziarnistość (grain)                                         | Klucz główny  | Główne klucze obce / relacje                                                                                                         |
| -------------- | ------------- | ----------------------------------------------------------- | ------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| `calls`        | fact          | 1 wiersz = 1 połączenie (inbound / outbound, IVR / agent)   | `call_id`     | `customer_id` → `customers.customer_id`  • `agent_id` → `agents.agent_id` (jeśli odebrane)  • daty → `dimDate[Date]` (start_time)    |
| `cases`        | fact          | 1 wiersz = 1 sprawa / zgłoszenie                            | `case_id`     | `customer_id` → `customers.customer_id`  • `first_call_id` → `calls.call_id`  • daty → `dimDate[Date]` (opened_at / closed_at)       |
| `contacts`     | fact          | 1 wiersz = 1 kontakt konsultanta w ramach sprawy            | `contact_id`  | `case_id` → `cases.case_id` • `call_id` → `calls.call_id` • `customer_id` → `customers.customer_id` • `agent_id` → `agents.agent_id` |
| `agents`       | dimension     | 1 wiersz = 1 konsultant                                     | `agent_id`    | Relacje z faktami: `calls.agent_id`, `contacts.agent_id`                                                                             |
| `customers`    | dimension     | 1 wiersz = 1 klient                                         | `customer_id` | Relacje z faktami: `calls.customer_id`, `cases.customer_id`, `contacts.customer_id`                                                  |
| `dimDate`      | dimension     | 1 wiersz = 1 dzień (z dodatkowymi atrybutami kalendarza)    | `Date`        | Łączona z polami daty w faktach (np. `calls.start_time`, `cases.opened_at`, `cases.closed_at`)                                       |
| `measures_all` | helper        | Tabela techniczna – tylko miary DAX, brak danych fizycznych | –             | Służy do trzymania wszystkich miar KPI w jednym miejscu (ASA, AHT, FCR, SLA, Abandonment, Self-service, Callback itd.)               |


## Model danych

Projekt obejmuje prosty model danych wspierający analizę procesu Contact Center:

- **Tabela `customers`** – klienci (segment, region).
- **Tabela `agents`** – konsultanci (zespół, seniority).
- **Tabela `calls`** – każde połączenie telefoniczne:
  - czasy: start, IVR, kolejka, odebranie, zakończenie,
  - temat z IVR (faktura / reklamacje / techniczne),
  - flagi: self-service, callback, porzucone połączenie, połączenie odebrane przez konsultanta.
- **Tabela `cases`** – zgłoszenia / sprawy:
  - kategoria, priorytet,
  - informacja o eskalacji do 2nd line,
  - SLA (termin i informacja, czy dotrzymane),
  - typ rozwiązania: FCR / after_escalation / self_service / no_solution.
- **Tabela `contacts`** – kontakty z konsultantem w ramach sprawy:
  - który konsultant rozmawiał z klientem,
  - pierwszy kontakt czy kolejny,
  - czy sprawa została rozwiązana w danym kontakcie.

Dzięki takiej strukturze można powiązać:
- pojedyncze połączenia z IVR i kolejki,
- sprawy (cases) i ich status,
- kontakty z konsultantami (contacts),
- konsultantów i klientów.

## Kluczowe KPI

- **ASA (Average Speed of Answer)** – średni czas oczekiwania na połączenie:
  - liczony na podstawie `queue_start_time` i `answer_time` w tabeli `calls`.

- **AHT (Average Handle Time)** – średni czas obsługi:
  - liczony jako różnica między `answer_time` a `end_time` w `calls`.

- **Abandonment rate** – odsetek porzuconych połączeń:
  - połączenia z `is_abandoned_in_queue = 1` vs wszystkie `inbound`.

- **Self-service rate** – odsetek spraw załatwionych w IVR:
  - połączenia z `is_self_service = 1`.

- **Callback rate** – odsetek klientów wybierających oddzwonienie:
  - połączenia z `is_callback_chosen = 1` wśród połączeń, które trafiły do kolejki.

- **FCR (First Contact Resolution)** – odsetek spraw rozwiązanych przy pierwszym kontakcie:
  - sprawy (`cases`) z `resolution_type = 'FCR'`,
  - alternatywnie: sprawy, dla których jest tylko jeden kontakt w `contacts` i `resolved_this_contact = 1`.

- **SLA** – odsetek spraw zamkniętych w wymaganym czasie:
  - sprawy z `resolved_in_sla = 1` wśród zamkniętych (`status = 'closed'`).
 


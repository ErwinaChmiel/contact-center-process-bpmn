# Model danych i KPI

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

Te KPI mogą być później prezentowane na dashboardzie w Power BI (np. kafelki z KPI + wykresy w czasie).

    

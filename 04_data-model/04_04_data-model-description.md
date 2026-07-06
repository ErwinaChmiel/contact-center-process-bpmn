# Opis modelu danych — Contact Center

## Cel dokumentu

Dokument opisuje założenia modelu danych przygotowanego na potrzeby analizy procesu Contact Center oraz raportowania KPI w Power BI. Model danych jest warstwą pośrednią między procesem BPMN, integracjami systemowymi, skryptami SQL i dashboardem operacyjnym.

---

## Zakres modelu

Model obejmuje dane potrzebne do analizy operacyjnej Contact Center:

- wolumen i przebieg połączeń,
- kolejki i czas oczekiwania,
- self-service w IVR,
- callbacki,
- zgłoszenia i sprawy klienta,
- kontakty konsultantów z klientami,
- eskalacje do 2nd line,
- zdarzenia SLA,
- dane konsultantów i klientów,
- KPI operacyjne dla Power BI.

---

## Główne encje modelu

| Encja | Typ | Opis |
|---|---|---|
| `customers` | Master data | Dane klientów, segment i region |
| `agents` | Master data | Dane konsultantów, zespół, seniority i lokalizacja |
| `calls` | Fact / operational event | Dane połączeń przychodzących i wychodzących |
| `cases` | Fact / business object | Dane zgłoszeń i spraw klientów |
| `contacts` | Fact / interaction | Historia kontaktów powiązanych ze sprawami |
| `callbacks` | Fact / operational object | Rejestr callbacków, statusów i terminowości realizacji |
| `sla_events` | Fact / event log | Zdarzenia SLA: utworzenie, ostrzeżenie, eskalacja, przekroczenie, zamknięcie |

---

## Relacje logiczne

| Relacja | Kardynalność | Uzasadnienie |
|---|---:|---|
| `customers` → `calls` | 1:N | Klient może mieć wiele połączeń |
| `customers` → `cases` | 1:N | Klient może mieć wiele spraw |
| `customers` → `callbacks` | 1:N | Klient może zamówić wiele callbacków |
| `agents` → `calls` | 1:N | Konsultant może obsłużyć wiele połączeń |
| `agents` → `contacts` | 1:N | Konsultant może obsłużyć wiele kontaktów |
| `calls` → `cases` | 1:N | Połączenie może rozpocząć sprawę |
| `cases` → `contacts` | 1:N | Sprawa może mieć wiele kontaktów |
| `calls` → `callbacks` | 1:N | Połączenie w kolejce może wygenerować callback |
| `callbacks` → `calls` | 0:1 | Callback może mieć powiązane zrealizowane połączenie wychodzące |
| `cases` → `sla_events` | 1:N | Sprawa może mieć wiele zdarzeń SLA |

---

## Powiązanie danych z KPI

| KPI | Źródło danych | Przykładowa logika |
|---|---|---|
| ASA | `calls` | `answer_time - queue_start_time` dla odebranych połączeń inbound |
| AHT | `calls`, `contacts` | `end_time - answer_time` dla kontaktów obsłużonych przez konsultanta |
| FCR | `cases`, `contacts` | udział spraw z `resolution_type = 'FCR'` |
| SLA Rate | `cases`, `sla_events` | udział spraw zamkniętych w terminie SLA |
| Cases Past SLA | `cases`, `sla_events` | liczba spraw z `resolved_in_sla = 0` albo eventem `breached` |
| Abandonment Rate | `calls` | udział połączeń inbound z `is_abandoned_in_queue = 1` |
| Self-service Rate | `calls` | udział połączeń inbound z `is_self_service = 1` |
| Callback Rate | `callbacks`, `calls` | udział kolejkowanych połączeń, które wygenerowały callback |
| Callback Realization Rate | `callbacks` | udział callbacków ze statusem `completed` |
| Callback Delay | `callbacks` | `realized_at - requested_at` dla zrealizowanych callbacków |
| Escalation Rate | `cases` | udział spraw z `is_escalated_to_2nd_line = 1` |

---

## Kluczowe założenia jakości danych

| ID | Założenie |
|---|---|
| DQ.01 | Dane w repozytorium są syntetyczne i nie zawierają danych produkcyjnych |
| DQ.02 | Identyfikatory klientów, spraw, połączeń i callbacków są stabilne w obrębie modelu |
| DQ.03 | Daty w tabelach operacyjnych muszą zachowywać kolejność procesu |
| DQ.04 | Statusy i kategorie są walidowane przez ograniczenia `CHECK` |
| DQ.05 | Dane raportowe muszą umożliwiać odtworzenie KPI z poziomu SQL |
| DQ.06 | Pola telefoniczne są maskowane i nie przechowują pełnych numerów klientów |

---

## Dlaczego dodano `callbacks` i `sla_events`?

W procesie TO-BE callback i SLA są kluczowymi mechanizmami kontroli operacyjnej. Dlatego nie powinny istnieć wyłącznie jako flagi w tabelach `calls` i `cases`.

Osobna tabela `callbacks` umożliwia analizę:

- liczby zamówionych callbacków,
- terminowości oddzwonień,
- statusów callbacków,
- opóźnień,
- niezrealizowanych prób kontaktu.

Osobna tabela `sla_events` umożliwia analizę:

- historii statusów sprawy,
- momentów eskalacji,
- zdarzeń przekroczenia SLA,
- audytowalności procesu,
- alertów operacyjnych w dashboardzie.

---

## Podsumowanie

Model danych wspiera pełną ścieżkę analityczną: problem biznesowy → proces BPMN → wymagania → dane → KPI → dashboard Power BI. Wersja enterprise-ready zwiększa spójność projektu poprzez dodanie jawnych tabel callbacków i SLA, walidacji danych, indeksów raportowych oraz opisu relacji i założeń jakościowych.

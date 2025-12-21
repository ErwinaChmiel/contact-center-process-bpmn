# Optymalizacja procesu obsługi połączeń w Contact Center (BPMN + SQL + Power BI)

Projekt własny pokazujący podejście analityczki biznesowo-danowej do procesu w dziale Contact Center.  
Projekt przedstawia kompletny cykl analityczny — od modelowania procesów biznesowych (BPMN AS-IS i TO-BE), przez zaprojektowanie i zasilenie relacyjnej bazy danych SQL, aż po budowę zaawansowanego, wielostronicowego dashboardu operacyjnego w Power BI.

---

## Cel projektu

Celem projektu jest zaprezentowanie pełnego procesu pracy analityczki biznesowej:

- modelowanie procesów biznesowych (BPMN 2.0),
- zaprojektowanie modelu danych pod analizę operacyjną,
- tworzenie i ładowanie danych w relacyjnej bazie SQL,
- budowa semantycznego modelu danych i miar DAX w Power BI,
- przygotowanie profesjonalnych dashboardów dla Contact Center,
- analiza KPI: FCR, SLA, AHT, ASA, abandonment, callback, self-service.

Projekt może służyć jako:

- element portfolio rekrutacyjnego,
- wzorzec raportowania operacyjnego dla Contact Center,
- kompletne case study analityczne.

---

## Architektura rozwiązania

- **BPMN 2.0** – model procesów AS-IS i TO-BE,
- **SQL** – baza danych + dane przykładowe,
- **Power BI** – model danych i KPI (DAX),
- **Dashboard** – 4 strony analityczne + strona alertów.

---

## Zakres projektu

### 1. Model procesu (BPMN 2.0 – Camunda Web Modeler)

Proces obsługi połączeń przychodzących w Contact Center został zamodelowany w dwóch wariantach:

- **AS-IS** – stan obecny:
  - obsługa połączeń przychodzących,
  - IVR z rozbiciem na tematy (faktury, reklamacje, techniczne),
  - obsługa przez konsultanta 1st line oraz 2nd line,
  - SLA i eskalacje w back-office.

- **TO-BE** – proces docelowy z usprawnieniami:
  - **self-service** w IVR dla prostych spraw dotyczących faktur,
  - **callback** (oddzwonienia) zamiast długiego oczekiwania w kolejce,
  - dodatkowy krok **tagowania powodu kontaktu i wyniku rozmowy w systemie** (pod analitykę i KPI),
  - skrócony SLA dzięki lepszemu routingu i odciążeniu konsultantów.

---

### 2. Model danych + przykładowe dane (SQL)

Zaprojektowany został prosty, ale realistyczny model danych pod analitykę Contact Center:

- **Tabele główne:**
  - `calls` – połączenia (IVR, kolejka, konsultant, self-service, callback),
  - `cases` – zgłoszenia / sprawy,
  - `contacts` – kontakty z konsultantem w ramach spraw,
  - `agents` – konsultanci,
  - `customers` – klienci.

- Dane przykładowe odzwierciedlają różne scenariusze:
  - self-service w IVR,
  - FCR na 1st linii,
  - eskalacja do 2nd linii,
  - porzucone połączenia w kolejce,
  - callback (wybór oddzwonienia i jego realizacja).

---

### 3. Dashboard w Power BI

W katalogu `powerbi/` znajduje się plik:

- `ContactCenter.pbix` – dashboard zbudowany na bazie modelu danych z katalogu `sql/`.

Dashboard prezentuje m.in.:

---

### 3.1. Strona 1 — Executive KPI Overview

KPI główne:

- łączna liczba połączeń przychodzących,  
- odebrane połączenia,  
- wskaźnik porzuceń (Abandonment Rate),  
- poziom SLA,  
- First Contact Resolution Rate (FCR),  
- Self-service Rate (IVR).

Dodatkowa analityka:

- obciążenie godzinowe (Inbound by Hour),
- rozkład tematów IVR,
- kategorie zgłoszeń,
- trendy ASA (Average Speed of Answer) i AHT (Average Handle Time).

---

### 3.2. Strona 2 — Call Flow / SLA / FCR / Callback Analysis

Sekcje:

#### Call Flow Funnel  
Przepływ klienta przez proces:  
**Inbound → IVR → Queue → Answered → Self-Service → Callback**

#### SLA Analysis  
- SLA Rate,  
- SLA Trend,  
- Escalation Rate (donut chart).

#### FCR Analysis  
- FCR KPI,  
- trend FCR,  
- FCR wg kategorii spraw (case category).

#### Callback Analysis  
- callback funnel (selected → realized → resolved),  
- średnie opóźnienie callbacku.

---

### 3.3. Strona 3 — Operational Analytics

Najważniejsze wskaźniki operacyjne:

- średni czas oczekiwania w kolejce (Queue Time),  
- wskaźnik porzuceń (Abandonment Rate),  
- liczba połączeń przekazanych do kolejki (Queued Calls).

Wizualizacje:

- **ASA Trend** (Average Speed of Answer),  
- **AHT Trend** (Average Handle Time),  
- **Inbound Calls by Hour** (obciążenie contact center w ciągu dnia).

---

### 3.4. Strona 4 — Segmentation & Agents Analysis

Sekcje:

#### Agent Team Performance  
- FCR dla zespołów (np. 1st line vs 2nd line),  
- AHT dla zespołów.

#### Individual Agent Performance  
- liczba obsłużonych połączeń per agent,  
- AHT per agent,  
- FCR per agent.

#### Customer Segment Analysis  
- wolumen połączeń według segmentu (np. B2C / SME / Corporate),  
- FCR wg segmentu.

#### Agent Trends  
- FCR Trend per agent (trend jakości obsługi w czasie).

---

### 3.5. Strona 5 — Alerts & Exceptions

Strona operacyjna dla managerów i liderów Contact Center, prezentująca wyjątki i obszary wymagające reakcji:

- sprawy po SLA (przekroczony termin realizacji),
- nierozwiązane callbacki (wybrany, ale nie zrealizowany),
- połączenia porzucone powyżej ustalonego progu czasu oczekiwania,
- konsultanci z podwyższonym AHT,
- lista wyjątków w formie tabeli (cases, callbacks, agents).

---

## KPI & DAX

Model danych zawiera zestaw profesjonalnych miar, m.in.:

### KPI połączeń

- **Total Inbound Calls** – łączna liczba połączeń przychodzących,  
- **Answered Calls** – liczba połączeń obsłużonych przez konsultanta,  
- **ASA (Average Speed of Answer)** – średni czas oczekiwania na połączenie,  
- **AHT (Average Handle Time)** – średni czas obsługi połączenia,  
- **Abandonment Rate** – odsetek połączeń porzuconych przez klientów,  
- **Queue Time (avg / p95)** – średni i 95. percentyl czasu oczekiwania w kolejce.

### KPI jakości obsługi

- **FCR Rate (First Contact Resolution)** – odsetek spraw rozwiązanych przy pierwszym kontakcie,  
- **Escalation Rate** – odsetek spraw eskalowanych na 2nd line,  
- **SLA Rate** – odsetek spraw zrealizowanych w wymaganym czasie (zgodnie z SLA).

### Automatyzacja i callback

- **Self-service Rate** – odsetek spraw załatwionych w IVR,  
- **Callback Selected** – liczba przypadków, gdzie klient wybrał oddzwonienie,  
- **Callback Realized** – liczba zrealizowanych oddzwonień,  
- **Callback FCR** – sprawy rozwiązane w ramach callbacku,  
- **Callback Delay** – średni czas oczekiwania na realizację callbacku.

(Szczegółowa logika znajduje się w miarach DAX w pliku `ContactCenter.pbix`.)

---

## Wnioski biznesowe

Dashboard umożliwia m.in.:

- identyfikację godzin największego obciążenia (planowanie grafików, SLA),  
- analizę kluczowych przyczyn kontaktu (IVR topics, case categories),  
- wykrywanie problemów operacyjnych (kolejki, porzucenia, długie czasy obsługi),  
- ocenę jakości obsługi (FCR, SLA) w czasie i w podziale na zespoły / agentów,  
- ocenę skuteczności samoobsługi i callbacków,  
- monitorowanie wyjątków (sprawy po SLA, niezrealizowane callbacki, słabsza efektywność części agentów).

Projekt odzwierciedla rzeczywiste potrzeby zarządzania Contact Center z perspektywy zarówno operacyjnej, jak i jakościowej.

---

## Struktura repozytorium

- `bpmn/`  
  Diagramy procesu AS-IS i TO-BE (BPMN + PNG):
  - `CC_Obsluga_Polaczenia_AS_IS.bpmn` – proces obecny (AS-IS),
  - `CC_Obsluga_Polaczenia_TO_BE.bpmn` – proces docelowy (TO-BE),
  - `CC_Obsluga_Polaczenia_AS_IS.png` – zrzut diagramu AS-IS,
  - `CC_Obsluga_Polaczenia_TO_BE.png` – zrzut diagramu TO-BE.

- `sql/`  
  Skrypty SQL:
  - `01_contact_center_schema.sql` – schemat bazy (tabele i relacje),
  - `02_contact_center_sample_data.sql` – dane przykładowe dla procesu Contact Center.

- `docs/`  
  Dokumentacja:
  - `opis_procesu_AS_IS.md` – opis procesu AS-IS (stan obecny, problemy),
  - `opis_procesu_TO_BE.md` – opis procesu TO-BE (usprawnienia: self-service, callback, SLA itd.),
  - `kpi_i_model_danych.md` – opis modelu danych oraz kluczowych KPI.

- `powerbi/`  
  - `ContactCenter.pbix` – raport Power BI bazujący na modelu danych z katalogu `sql/`.

- `README.md` – podsumowanie projektu, instrukcja uruchomienia i kontekst biznesowy.

---

## Jak uruchomić projekt

1. Utwórz bazę danych (np. lokalny MS SQL / Azure SQL / inny silnik zgodny z T-SQL).
2. Uruchom skrypty z katalogu `sql/`:
   - `01_contact_center_schema.sql` – utworzy tabele,
   - `02_contact_center_sample_data.sql` – wstawi dane przykładowe.
3. Otwórz Power BI Desktop i połącz się z utworzoną bazą danych.
4. Załaduj tabele: `calls`, `cases`, `contacts`, `agents`, `customers`.
5. Otwórz plik `powerbi/ContactCenter.pbix` – dashboard automatycznie odświeży model i KPI na podstawie bazy.

---

## Przykładowe KPI oparte na tym modelu

- **ASA (Average Speed of Answer)** – średni czas oczekiwania na połączenie.  
- **AHT (Average Handle Time)** – średni czas obsługi połączenia.  
- **FCR (First Contact Resolution)** – odsetek spraw rozwiązanych przy pierwszym kontakcie.  
- **Abandonment rate** – odsetek porzuconych połączeń (rozłączenie w IVR / kolejce).  
- **Self-service rate** – odsetek spraw załatwionych w IVR.  
- **Callback rate** – odsetek klientów wybierających oddzwonienie.  
- **SLA** – odsetek spraw zamkniętych w wymaganym czasie (zgodnie z terminem SLA).

---

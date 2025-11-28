# Optymalizacja procesu obsługi połączeń w Contact Center (BPMN + SQL)

Projekt własny pokazujący podejście analityczki biznesowo-danowej do procesu w dziale Contact Center.

## Zakres projektu

### 1. Model procesu (BPMN 2.0 – Camunda Web Modeler)

Proces obsługi połączeń przychodzących w Contact Center, zmapowany w wersji:

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

### 2. Model danych + przykładowe dane (SQL)

Projekt i implementacja prostego modelu danych pod analitykę Contact Center:

- Tabele:
  - `calls` – połączenia (IVR, kolejka, konsultant, self-service, callback),
  - `cases` – zgłoszenia / sprawy,
  - `contacts` – kontakty z konsultantem w ramach spraw,
  - `agents`, `customers` – słowniki.

- Dane przykładowe odzwierciedlają różne scenariusze:
  - self-service w IVR,
  - FCR na 1st linii,
  - eskalacja do 2nd linii,
  - porzucone połączenia w kolejce,
  - callback (wybór oddzwonienia i jego realizacja).

### 3. (Planowane) Dashboardy w Power BI

Na bazie przygotowanego modelu danych planuję zbudować dashboard w Power BI, prezentujący m.in.:

- obciążenie infolinii w czasie (wolumen połączeń),
- kluczowe KPI (ASA, AHT, FCR, SLA, self-service, callback),
- porównanie AS-IS vs TO-BE pod kątem jakości obsługi.

Docelowo w repo pojawi się:

- plik `.pbix` z dashboardem,
- zrzuty ekranów w katalogu `docs/` lub `bi/`.

## Struktura repozytorium

- `bpmn/`  
  Diagramy procesu AS-IS i TO-BE (BPMN + PNG):
  - `CC_Obsluga_Polaczenia_AS_IS.bpmn` – proces obecny (AS-IS),
  - `CC_Obsluga_Polaczenia_TO_BE.bpmn` – proces docelowy (TO-BE),
  - `*.png` – zrzuty diagramów.

- `sql/`  
  Skrypty SQL:
  - `01_contact_center_schema.sql` – schemat bazy (tabele i relacje),
  - `02_contact_center_sample_data.sql` – dane przykładowe,
  - `03_contact_center_kpi_queries.sql` (opcjonalnie) – przykładowe zapytania KPI.

- `docs/`  
  Dokumentacja:
  - `opis_procesu_AS_IS.md` – opis procesu AS-IS,
  - `opis_procesu_TO_BE.md` – opis procesu TO-BE,
  - `kpi_i_model_danych.md` – opis modelu danych i kluczowych KPI.

- `README.md` – podsumowanie projektu.

## Jak uruchomić SQL

1. Utwórz bazę danych (np. na Azure SQL / lokalnym MS SQL / innym silniku zgodnym z T-SQL).
2. Uruchom skrypt z katalogu `sql/`:
   - `01_contact_center_schema.sql` – utworzy tabele,
   - `02_contact_center_sample_data.sql` – wstawi dane przykładowe.
3. Na tej bazie możesz:
   - liczyć KPI procesu (ASA, AHT, FCR, SLA, self-service, callback),
   - budować dashboard w narzędziu BI (np. Power BI, Looker Studio).

## Przykładowe KPI oparte na tym modelu

- **ASA (Average Speed of Answer)** – średni czas oczekiwania na połączenie.
- **AHT (Average Handle Time)** – średni czas obsługi połączenia.
- **FCR (First Contact Resolution)** – odsetek spraw rozwiązanych przy pierwszym kontakcie.
- **Abandonment rate** – odsetek porzuconych połączeń (rozłączenie w IVR / kolejce).
- **Self-service rate** – odsetek spraw załatwionych w IVR.
- **Callback rate** – odsetek klientów wybierających oddzwonienie.
- **SLA** – odsetek spraw zamkniętych w wymaganym czasie (zgodnie z terminem SLA).

## Pliki w repozytorium

### BPMN

- `bpmn/CC_Obsluga_Polaczenia_AS_IS.bpmn` – proces obecny (AS-IS).
- `bpmn/CC_Obsluga_Polaczenia_TO_BE.bpmn` – proces docelowy z usprawnieniami (TO-BE).
- `bpmn/CC_Obsluga_Polaczenia_AS_IS.png` – zrzut diagramu AS-IS.
- `bpmn/CC_Obsluga_Polaczenia_TO_BE.png` – zrzut diagramu TO-BE.

### SQL

- `sql/01_contact_center_schema.sql` – schemat bazy (tabele i relacje).
- `sql/02_contact_center_sample_data.sql` – dane przykładowe dla procesu Contact Center.
- `sql/03_contact_center_kpi_queries.sql` – przykładowe zapytania SQL liczące KPI (ASA, AHT, FCR, SLA, self-service, callback) – jeśli taki plik dodasz.

### Dokumentacja

- `docs/opis_procesu_AS_IS.md` – opis procesu AS-IS (stan obecny, problemy).
- `docs/opis_procesu_TO_BE.md` – opis procesu TO-BE (usprawnienia: self-service, callback, SLA itd.).
- `docs/kpi_i_model_danych.md` – opis modelu danych oraz kluczowych KPI.

### Pozostałe

- `README.md` – podsumowanie projektu, instrukcja uruchomienia i kontekst biznesowy.


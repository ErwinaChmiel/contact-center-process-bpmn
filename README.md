# Optymalizacja procesu obsługi połączeń w Contact Center (BPMN + SQL)

Projekt własny pokazujący podejście analityczki biznesowo-danowej
do procesu w dziale Contact Center.

## Zakres projektu

- Model procesu **AS-IS** i **TO-BE** w notacji **BPMN 2.0** (Camunda Web Modeler):
  - obsługa połączeń przychodzących,
  - IVR z rozbiciem na tematy (faktury, reklamacje, techniczne),
  - obsługa przez konsultanta 1st line oraz 2nd line,
  - SLA i eskalacje w back-office.
- Usprawnienia w TO-BE:
  - **self-service** w IVR dla prostych spraw dotyczących faktur,
  - **callback** (oddzwonienia) zamiast wiszenia w kolejce,
  - dodatkowy krok **tagowania powodu kontaktu i wyniku rozmowy** w systemie (pod analitykę).
- Model danych + przykładowe dane w SQL:
  - tabele `calls`, `cases`, `contacts`, `agents`, `customers`,
  - dane przykładowe odzwierciedlające różne scenariusze:
    - self-service w IVR,
    - FCR na 1st linii,
    - eskalacja do 2nd linii,
    - porzucone połączenia w kolejce,
    - callback.
   
## Struktura repozytorium
- `bpmn/` - diagramy procesu AS-IS i TO-BE (BPMN + PNG).
- `sql/` - skrypt tworzący bazę i dane przykładowe.
- `docs/` - opisy procesów oraz KPI i model danych.
- `README.md` - podsumowanie projektu.

## Jak uruchomić SQL

1. Utwórz bazę danych (np. na Azure SQL / lokalnym MS SQL / Postgres).
2. Uruchom skrypt z katalogu `sql/`:
   - utworzy tabele,
   - wstawi dane przykładowe.
3. Na tej bazie możesz:
   - liczyć KPI procesu (ASA, AHT, FCR, SLA, self-service, callback),
   - budować dashboard w narzędziu BI (np. Power BI, Looker Studio).

## Przykładowe KPI oparte na tym modelu

- **ASA (Average Speed of Answer)** – średni czas oczekiwania na połączenie.
- **AHT (Average Handle Time)** – średni czas obsługi połączenia.
- **FCR (First Contact Resolution)** – odsetek spraw rozwiązanych przy pierwszym kontakcie.
- **Abandonment rate** – odsetek porzuconych połączeń.
- **Self-service rate** – odsetek spraw załatwionych w IVR.
- **Callback rate** – odsetek klientów wybierających oddzwonienie.
- **SLA** – odsetek spraw zamkniętych w wymaganym czasie.


## Pliki

- `CC_Obsluga_Polaczenia_AS_IS.bpmn` – proces obecny (AS-IS).
- `CC_Obsluga_Polaczenia_TO_BE.bpmn` – proces docelowy z usprawnieniami.
- `*.png` – zrzuty diagramów.
- `sql/contact_center_schema_and_sample_data.sql` – schemat bazy i dane przykładowe.


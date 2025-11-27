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

## Pliki

- `CC_Obsluga_Polaczenia_AS_IS.bpmn` – proces obecny (AS-IS).
- `CC_Obsluga_Polaczenia_TO_BE.bpmn` – proces docelowy z usprawnieniami.
- `*.png` – zrzuty diagramów.
- `sql/contact_center_schema_and_sample_data.sql` – schemat bazy i dane przykładowe.


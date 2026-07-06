# BPMN Modeling Decisions — AS-IS / TO-BE

## Cel dokumentu

Dokument opisuje decyzje modelowania BPMN dla procesu Contact Center. Jego zadaniem jest pokazanie, że diagram BPMN nie jest wyłącznie wizualizacją, ale kontrolowanym modelem procesu zgodnym z wymaganiami, danymi i KPI.

---

## Poziomy modelowania

| Poziom | Zakres | Cel |
|---|---|---|
| L0 | Kontekst procesu Contact Center | Szybkie zrozumienie procesu przez interesariuszy biznesowych |
| L1 | Główny przepływ AS-IS / TO-BE | Analiza głównych kroków, decyzji i odpowiedzialności |
| L2 | Subprocessy: self-service, callback, eskalacja, SLA | Szczegółowa analiza miejsc krytycznych i automatyzacji |

---

## Lane'y i odpowiedzialności

| Lane / Pool | Rola w procesie |
|---|---|
| Klient | Inicjuje kontakt i podejmuje decyzję: oczekiwanie, self-service, callback |
| IVR | Identyfikuje temat sprawy, proponuje self-service i callback |
| Contact Center 1st Line | Obsługuje standardowe zgłoszenia, taguje przyczynę kontaktu, zamyka FCR |
| 2nd Line / Back Office | Obsługuje sprawy złożone i eskalowane |
| CRM / Case Management | Przechowuje historię klienta, sprawy i statusy |
| Reporting / Power BI | Konsumuje dane operacyjne do KPI i alertów |

---

## Decyzje dotyczące gatewayów

| Obszar | Typ gatewaya | Uzasadnienie |
|---|---|---|
| Self-service w IVR | Exclusive Gateway | Klient albo rozwiązuje sprawę w IVR, albo przechodzi dalej |
| Callback | Exclusive Gateway | Klient wybiera callback albo pozostaje w kolejce |
| Eskalacja | Exclusive Gateway | Sprawa jest rozwiązana na 1st line albo przekazana do 2nd line |
| SLA | Event-based / Timer | Przekroczenie SLA jest zdarzeniem zależnym od czasu |

---

## Zdarzenia timerowe

Timer events powinny zostać użyte dla:

- czasu oczekiwania w kolejce,
- możliwości zaproponowania callbacku po przekroczeniu progu oczekiwania,
- monitorowania terminu realizacji callbacku,
- monitorowania SLA sprawy,
- alertowania spraw zagrożonych przekroczeniem SLA.

---

## Obiekty danych i data stores

| BPMN element | Powiązanie z modelem danych |
|---|---|
| Dane połączenia | `calls` |
| Dane callbacku | `callbacks` |
| Dane sprawy | `cases` |
| Historia kontaktu | `contacts` |
| Zdarzenia SLA | `sla_events` |
| Dane konsultanta | `agents` |
| Dane klienta | `customers` |

---

## Message flows

Message flows powinny pokazywać komunikację między:

- Klientem i IVR,
- IVR i Contact Center,
- Contact Center i CRM,
- Contact Center i 2nd Line,
- CRM / SQL i Power BI,
- mechanizmem callbacku i klientem.

---

## Reguły jakości modelu BPMN

1. Każdy gateway powinien mieć nazwane warunki wyjścia.
2. Każdy timer powinien mieć opis progu czasowego lub biznesowego.
3. Każdy subprocess powinien mieć jasno wskazany start i koniec.
4. Data objects powinny odpowiadać tabelom albo zdarzeniom w modelu danych.
5. Modele `.bpmn` powinny być trzymane w repozytorium jako pliki źródłowe, nie tylko jako obrazy PNG.
6. PNG jest tylko podglądem dla osób nietechnicznych; źródłem prawdy jest plik `.bpmn`.

---

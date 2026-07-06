# User Stories — Contact Center

## Cel dokumentu

Dokument zawiera User Stories dla projektu optymalizacji procesu obsługi połączeń w Contact Center. User Stories opisują potrzeby użytkowników i interesariuszy w formacie:

> Jako [rola] chcę [potrzeba / funkcjonalność], aby [wartość biznesowa].

Każda User Story zawiera identyfikator, rolę użytkownika, wartość biznesową, priorytet, powiązane wymagania, powiązane KPI oraz kryteria akceptacji.

---

## Epic 1 — Obsługa połączeń przychodzących

### US.01 — Rejestracja połączeń przychodzących

**Jako** lider zespołu  
**chcę**, aby system rejestrował każde połączenie przychodzące  
**aby** możliwe było monitorowanie wolumenu, kolejek, ASA i porzuceń połączeń.

| Atrybut | Wartość |
|---|---|
| Priorytet | Wysoki |
| Wartość biznesowa | Pełna widoczność wolumenu połączeń i obciążenia Contact Center |
| Powiązane wymagania | WF.01, WF.07, WF.08 |
| Powiązane KPI | ASA, AHT, Abandonment Rate, Call Volume |
| Kryteria akceptacji | AC.04.01–AC.04.07 |

### US.02 — Historia kontaktów klienta

**Jako** konsultant Contact Center  
**chcę** widzieć historię kontaktów klienta  
**aby** szybciej rozwiązywać zgłoszenia i ograniczyć konieczność ponownego zadawania tych samych pytań.

| Atrybut | Wartość |
|---|---|
| Priorytet | Wysoki |
| Wartość biznesowa | Skrócenie czasu obsługi i poprawa jakości kontaktu |
| Powiązane wymagania | WF.02, WF.03, WF.07 |
| Powiązane KPI | AHT, FCR |
| Kryteria akceptacji | AC.01.01–AC.01.05 |

### US.03 — Kategoryzacja przyczyny kontaktu

**Jako** konsultant Contact Center  
**chcę** oznaczyć przyczynę kontaktu klienta  
**aby** dane mogły być wykorzystane do analizy KPI i optymalizacji procesu.

| Atrybut | Wartość |
|---|---|
| Priorytet | Wysoki |
| Wartość biznesowa | Lepsza analiza powodów kontaktu i identyfikacja potencjału automatyzacji |
| Powiązane wymagania | WF.03, WF.07 |
| Powiązane KPI | FCR, Contact Category Analysis, Self-service Rate |
| Kryteria akceptacji | AC.03.01–AC.03.05 |

---

## Epic 2 — Callback

### US.04 — Rejestracja callbacku

**Jako** klient  
**chcę** mieć możliwość zamówienia oddzwonienia  
**aby** nie musieć oczekiwać w kolejce.

| Atrybut | Wartość |
|---|---|
| Priorytet | Wysoki |
| Wartość biznesowa | Redukcja porzuconych połączeń i poprawa doświadczenia klienta |
| Powiązane wymagania | WF.04, WF.05 |
| Powiązane KPI | Callback Rate, Abandonment Rate |
| Kryteria akceptacji | AC.02.01–AC.02.06 |

### US.05 — Monitorowanie realizacji callbacku

**Jako** lider zespołu  
**chcę** monitorować realizację callbacków  
**aby** kontrolować terminowość oddzwonień i identyfikować niezrealizowane zgłoszenia.

| Atrybut | Wartość |
|---|---|
| Priorytet | Średni |
| Wartość biznesowa | Kontrola jakości obsługi i terminowości oddzwonień |
| Powiązane wymagania | WF.05, WF.07 |
| Powiązane KPI | Callback Realization Rate, Callback Delay, Overdue Callbacks |
| Kryteria akceptacji | AC.02.03–AC.02.05 |

### US.06 — Raportowanie callbacków

**Jako** menedżer Contact Center  
**chcę** analizować skuteczność callbacków  
**aby** ocenić, czy mechanizm oddzwonień ogranicza porzucone połączenia.

| Atrybut | Wartość |
|---|---|
| Priorytet | Średni |
| Wartość biznesowa | Ocena skuteczności mechanizmu callback |
| Powiązane wymagania | WF.05, WF.07, WF.08 |
| Powiązane KPI | Callback Rate, Callback Realization Rate, Abandonment Rate |
| Kryteria akceptacji | AC.02.04–AC.02.05, AC.04.01–AC.04.07 |

---

## Epic 3 — SLA i eskalacje

### US.07 — Monitorowanie SLA

**Jako** lider zespołu  
**chcę** monitorować SLA dla spraw klientów  
**aby** szybko identyfikować zgłoszenia zagrożone przekroczeniem terminu.

| Atrybut | Wartość |
|---|---|
| Priorytet | Wysoki |
| Wartość biznesowa | Identyfikacja spraw zagrożonych SLA i priorytetyzacja pracy |
| Powiązane wymagania | WF.07, WF.08 |
| Powiązane KPI | SLA Rate, Cases Past SLA, SLA Breach Count |
| Kryteria akceptacji | AC.04.01–AC.04.07 |

### US.08 — Obsługa eskalacji do 2nd line

**Jako** konsultant Contact Center  
**chcę** przekazać sprawę do 2nd line  
**aby** bardziej złożone zgłoszenia zostały obsłużone przez właściwy zespół.

| Atrybut | Wartość |
|---|---|
| Priorytet | Wysoki |
| Wartość biznesowa | Poprawa obsługi spraw złożonych i ograniczenie ryzyka przekroczenia SLA |
| Powiązane wymagania | WF.06, WF.07 |
| Powiązane KPI | Escalation Rate, SLA Rate, FCR |
| Kryteria akceptacji | AC.05.01–AC.05.06 |

### US.09 — Raport spraw po SLA

**Jako** lider zespołu  
**chcę** widzieć listę spraw po SLA  
**aby** szybko reagować na opóźnienia i priorytetyzować obsługę.

| Atrybut | Wartość |
|---|---|
| Priorytet | Średni |
| Wartość biznesowa | Szybsza reakcja liderów zespołu |
| Powiązane wymagania | WF.07, WF.08 |
| Powiązane KPI | Cases Past SLA, SLA Rate, SLA Breach Count |
| Kryteria akceptacji | AC.04.01–AC.04.07 |

---

## Epic 4 — Raportowanie KPI

### US.10 — Dashboard FCR

**Jako** menedżer Contact Center  
**chcę** monitorować FCR  
**aby** oceniać skuteczność rozwiązywania spraw przy pierwszym kontakcie.

| Atrybut | Wartość |
|---|---|
| Priorytet | Wysoki |
| Wartość biznesowa | Monitorowanie skuteczności pierwszego kontaktu |
| Powiązane wymagania | WF.07, WF.08 |
| Powiązane KPI | FCR |
| Kryteria akceptacji | AC.04.01–AC.04.07 |

### US.11 — Dashboard AHT i ASA

**Jako** lider zespołu  
**chcę** analizować AHT i ASA  
**aby** kontrolować czas obsługi oraz czas oczekiwania klientów.

| Atrybut | Wartość |
|---|---|
| Priorytet | Średni |
| Wartość biznesowa | Kontrola czasu obsługi i oczekiwania |
| Powiązane wymagania | WF.01, WF.07, WF.08 |
| Powiązane KPI | AHT, ASA |
| Kryteria akceptacji | AC.04.01–AC.04.07 |

### US.12 — Dashboard porzuceń połączeń

**Jako** lider zespołu  
**chcę** analizować porzucone połączenia  
**aby** identyfikować godziny przeciążenia Contact Center.

| Atrybut | Wartość |
|---|---|
| Priorytet | Średni |
| Wartość biznesowa | Identyfikacja godzin przeciążenia Contact Center |
| Powiązane wymagania | WF.01, WF.07, WF.08 |
| Powiązane KPI | Abandonment Rate, Call Volume |
| Kryteria akceptacji | AC.04.01–AC.04.07 |

### US.13 — Dashboard alertów operacyjnych

**Jako** lider zespołu  
**chcę** widzieć alerty operacyjne  
**aby** szybko reagować na sprawy po SLA, niezrealizowane callbacki i konsultantów z podwyższonym AHT.

| Atrybut | Wartość |
|---|---|
| Priorytet | Średni |
| Wartość biznesowa | Szybka identyfikacja wyjątków wymagających reakcji |
| Powiązane wymagania | WF.07, WF.08, WN.03 |
| Powiązane KPI | SLA Rate, Callback Realization Rate, AHT, Operational Exceptions |
| Kryteria akceptacji | AC.04.01–AC.04.07 |

---

## Macierz User Story → wymagania → KPI

| User Story | Powiązane wymagania | Powiązane KPI |
|---|---|---|
| US.01 | WF.01, WF.07, WF.08 | ASA, AHT, Abandonment Rate, Call Volume |
| US.02 | WF.02, WF.03, WF.07 | AHT, FCR |
| US.03 | WF.03, WF.07 | FCR, Contact Category Analysis, Self-service Rate |
| US.04 | WF.04, WF.05 | Callback Rate, Abandonment Rate |
| US.05 | WF.05, WF.07 | Callback Realization Rate, Callback Delay |
| US.06 | WF.05, WF.07, WF.08 | Callback Rate, Callback Realization Rate, Abandonment Rate |
| US.07 | WF.07, WF.08 | SLA Rate, Cases Past SLA |
| US.08 | WF.06, WF.07 | Escalation Rate, SLA Rate, FCR |
| US.09 | WF.07, WF.08 | Cases Past SLA, SLA Rate |
| US.10 | WF.07, WF.08 | FCR |
| US.11 | WF.01, WF.07, WF.08 | AHT, ASA |
| US.12 | WF.01, WF.07, WF.08 | Abandonment Rate |
| US.13 | WF.07, WF.08, WN.03 | SLA Rate, Callback Realization Rate, AHT |

---

## Podsumowanie

User Stories pokazują powiązanie pomiędzy rolami użytkowników, wymaganiami, wartością biznesową, KPI, procesem TO-BE, modelem danych i dashboardem Power BI. Dokument jest przygotowany w formacie wspierającym dalsze mapowanie do backlogu, kryteriów akceptacji, API, SQL i raportowania.

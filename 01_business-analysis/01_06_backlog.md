# Backlog produktu — Contact Center

## Cel dokumentu

Dokument przedstawia backlog produktu dla projektu optymalizacji procesu obsługi połączeń w Contact Center.

Backlog został przygotowany na podstawie analizy problemów biznesowych, procesu AS-IS, procesu TO-BE, wymagań funkcjonalnych oraz potrzeb związanych z raportowaniem KPI.

---

## Założenia backlogu

| ID | Założenie |
|---|---|
| ZB.01 | Backlog ma charakter analityczny i portfolio |
| ZB.02 | User Stories zostały pogrupowane w epiki odpowiadające głównym obszarom procesu |
| ZB.03 | Priorytet określono na podstawie wartości biznesowej i wpływu na KPI |
| ZB.04 | Backlog obejmuje proces, dane, callback, SLA, eskalacje i raportowanie |
| ZB.05 | Backlog nie obejmuje pełnej implementacji aplikacji produkcyjnej |

---

## Statusy backlogu

| Status | Znaczenie |
|---|---|
| New | Element został zidentyfikowany |
| Ready for Analysis | Element gotowy do doprecyzowania analitycznego |
| Ready for Development | Element gotowy do przekazania zespołowi technicznemu |
| In Progress | Element w realizacji |
| Done | Element zakończony |
| Out of Scope | Element poza zakresem projektu |

---

## Skala priorytetów

| Priorytet | Znaczenie |
|---|---|
| Wysoki | Element krytyczny dla procesu TO-BE lub kluczowych KPI |
| Średni | Element istotny, ale możliwy do realizacji w kolejnej iteracji |
| Niski | Element wspierający lub opcjonalny |

---

# Epic 1 — Obsługa połączeń

## Cel epiku

Usprawnienie podstawowego procesu obsługi połączeń przychodzących, w tym rejestracji połączeń, identyfikacji klienta i klasyfikacji przyczyny kontaktu.

| ID | User Story | Priorytet | Wartość biznesowa | Powiązane KPI | Status |
|---|---|---|---|---|---|
| US.01 | Rejestracja połączeń przychodzących | Wysoki | Pełna widoczność wolumenu połączeń | ASA, Abandonment Rate | Ready for Analysis |
| US.02 | Historia kontaktów klienta | Wysoki | Skrócenie czasu obsługi i poprawa jakości kontaktu | AHT, FCR | Ready for Analysis |
| US.03 | Kategoryzacja przyczyny kontaktu | Wysoki | Lepsza analiza powodów kontaktu i optymalizacja procesu | FCR, Contact Category Analysis | Ready for Analysis |

---

# Epic 2 — Callback

## Cel epiku

Zmniejszenie liczby porzuconych połączeń poprzez umożliwienie klientowi wyboru oddzwonienia zamiast oczekiwania w kolejce.

| ID | User Story | Priorytet | Wartość biznesowa | Powiązane KPI | Status |
|---|---|---|---|---|---|
| US.04 | Rejestracja callbacku | Wysoki | Redukcja liczby porzuconych połączeń | Callback Rate, Abandonment Rate | Ready for Analysis |
| US.05 | Monitorowanie realizacji callbacku | Średni | Kontrola jakości obsługi i terminowości oddzwonień | Callback Realization Rate | Ready for Analysis |
| US.06 | Raportowanie callbacków | Średni | Ocena skuteczności mechanizmu callback | Callback Rate, Callback Delay | Ready for Analysis |

---

# Epic 3 — SLA i eskalacje

## Cel epiku

Zapewnienie lepszej kontroli realizacji SLA oraz obsługi spraw wymagających przekazania do 2nd line lub back-office.

| ID | User Story | Priorytet | Wartość biznesowa | Powiązane KPI | Status |
|---|---|---|---|---|---|
| US.07 | Monitorowanie SLA | Wysoki | Identyfikacja spraw zagrożonych przekroczeniem terminu | SLA Rate, Cases Past SLA | Ready for Analysis |
| US.08 | Obsługa eskalacji do 2nd line | Wysoki | Poprawa obsługi spraw złożonych | Escalation Rate, SLA | Ready for Analysis |
| US.09 | Raport spraw po SLA | Średni | Szybsza reakcja liderów zespołu | Cases Past SLA | Ready for Analysis |

---

# Epic 4 — Raportowanie KPI

## Cel epiku

Udostępnienie warstwy raportowej umożliwiającej monitorowanie efektywności Contact Center, jakości obsługi oraz wyjątków operacyjnych.

| ID | User Story | Priorytet | Wartość biznesowa | Powiązane KPI | Status |
|---|---|---|---|---|---|
| US.10 | Dashboard FCR | Wysoki | Monitorowanie skuteczności pierwszego kontaktu | FCR | Ready for Analysis |
| US.11 | Dashboard AHT i ASA | Średni | Kontrola czasu obsługi i oczekiwania | AHT, ASA | Ready for Analysis |
| US.12 | Dashboard porzuceń połączeń | Średni | Identyfikacja godzin przeciążenia Contact Center | Abandonment Rate | Ready for Analysis |
| US.13 | Dashboard alertów operacyjnych | Średni | Szybka identyfikacja wyjątków wymagających reakcji | SLA, Callback, AHT | Ready for Analysis |

---

## Macierz backlogu: problem biznesowy → epic

| Problem biznesowy | Epic | Uzasadnienie |
|---|---|---|
| PB.01 — Wysoki czas oczekiwania klienta | Epic 1, Epic 4 | Rejestracja danych i analiza ASA/AHT umożliwiają identyfikację przeciążeń |
| PB.02 — Wysoki poziom porzuconych połączeń | Epic 2, Epic 4 | Callback i raportowanie porzuceń wspierają ograniczenie problemu |
| PB.03 — Ograniczona samoobsługa klienta | Epic 1, Epic 4 | Kategoryzacja kontaktów pozwala wskazać sprawy możliwe do self-service |
| PB.04 — Niewystarczająca kontrola SLA | Epic 3, Epic 4 | Monitoring SLA i alerty umożliwiają szybką reakcję |
| PB.05 — Ograniczona analiza przyczyn kontaktu | Epic 1, Epic 4 | Tagowanie i dashboardy pozwalają analizować powody kontaktu |

---

## MVP

Zakres MVP obejmuje elementy konieczne do pokazania wartości biznesowej procesu TO-BE.

| ID | Element MVP | Uzasadnienie |
|---|---|---|
| MVP.01 | Rejestracja połączeń przychodzących | Podstawa do analizy wolumenu i KPI |
| MVP.02 | Historia kontaktów klienta | Wsparcie konsultanta i skrócenie czasu obsługi |
| MVP.03 | Kategoryzacja przyczyny kontaktu | Dane niezbędne do analizy powodów kontaktu |
| MVP.04 | Rejestracja callbacku | Ograniczenie porzuceń połączeń |
| MVP.05 | Monitorowanie SLA | Kontrola terminowości obsługi |
| MVP.06 | Dashboard KPI | Prezentacja efektów procesu TO-BE |

---

## Definition of Ready

User Story może zostać uznana za gotową do realizacji, jeżeli:

| Warunek | Opis |
|---|---|
| Opis wartości biznesowej | User Story opisuje wartość dla użytkownika lub organizacji |
| Kryteria akceptacji | User Story posiada mierzalne kryteria akceptacji |
| Powiązanie z wymaganiami | User Story jest powiązana z wymaganiem biznesowym lub funkcjonalnym |
| Powiązanie z KPI | Wpływ User Story na KPI jest możliwy do określenia |
| Brak krytycznych niejasności | Zakres jest zrozumiały dla biznesu i zespołu technicznego |

---

## Definition of Done

User Story może zostać uznana za zakończoną, jeżeli:

| Warunek | Opis |
|---|---|
| Spełnione kryteria akceptacji | Wszystkie przypisane kryteria są spełnione |
| Dane dostępne w modelu | Dane mogą zostać wykorzystane w SQL / Power BI |
| Zgodność z procesem TO-BE | Funkcjonalność wspiera docelowy proces |
| Możliwość raportowania | Efekt funkcjonalności może być mierzony przez KPI |
| Brak błędów krytycznych | Funkcjonalność nie blokuje procesu obsługi |


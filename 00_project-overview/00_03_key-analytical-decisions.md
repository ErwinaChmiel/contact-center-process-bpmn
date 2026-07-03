# Kluczowe decyzje analityczne

## Cel dokumentu

Dokument opisuje najważniejsze decyzje analityczne podjęte podczas przygotowania projektu Contact Center.

Celem nie jest przedstawienie gotowych odpowiedzi rekrutacyjnych, ale pokazanie logiki pracy analitycznej: w jaki sposób zidentyfikowano wymagania, dobrano KPI, zaprojektowano proces TO-BE, określono źródła danych oraz opisano integracje systemowe.

Dokument uzupełnia główne artefakty projektu:

- analizę problemu biznesowego,
- analizę interesariuszy,
- wymagania,
- User Stories,
- kryteria akceptacji,
- BPMN AS-IS / TO-BE,
- architekturę,
- integracje,
- API,
- model danych SQL,
- dashboard Power BI.

---

## 1. Identyfikacja wymagań

Wymagania zostały wyprowadzone z analizy procesu AS-IS, problemów operacyjnych oraz potrzeb interesariuszy.

Punktem wyjścia nie była technologia ani dashboard, ale problemy biznesowe występujące w procesie obsługi połączeń przychodzących.

W analizie uwzględniono m.in.:

- długi czas oczekiwania klientów,
- porzucone połączenia,
- ograniczony zakres samoobsługi w IVR,
- brak callbacku jako alternatywy dla oczekiwania w kolejce,
- ograniczoną kontrolę SLA,
- brak spójnego tagowania przyczyn kontaktu,
- potrzebę raportowania KPI.

Na tej podstawie wymagania zostały podzielone na:

- wymagania biznesowe,
- wymagania funkcjonalne,
- wymagania niefunkcjonalne.

Takie podejście pozwoliło zachować śledzenie zależności pomiędzy problemem biznesowym, wymaganiem, User Story, KPI i rozwiązaniem.

---

## 2. Dobór KPI

KPI zostały dobrane tak, aby mierzyć najważniejsze problemy zidentyfikowane w procesie AS-IS oraz efekty proponowanych zmian w procesie TO-BE.

Nie były traktowane jako osobna warstwa raportowa, ale jako sposób oceny skuteczności procesu.

| Problem / potrzeba | KPI | Uzasadnienie |
|---|---|---|
| Długi czas oczekiwania klienta | ASA | Mierzy średni czas oczekiwania na odpowiedź konsultanta |
| Długi czas obsługi | AHT | Pozwala analizować czas potrzebny na obsługę połączenia |
| Porzucone połączenia | Abandonment Rate | Pokazuje skalę klientów rezygnujących z oczekiwania |
| Skuteczność pierwszego kontaktu | FCR | Mierzy, czy sprawa została rozwiązana bez ponownego kontaktu |
| Terminowość obsługi | SLA Rate | Pozwala monitorować realizację spraw w wymaganym czasie |
| Skuteczność callbacków | Callback Realization Rate | Pokazuje, czy zaplanowane oddzwonienia są realizowane |
| Automatyzacja prostych spraw | Self-service Rate | Mierzy udział spraw obsłużonych w IVR bez konsultanta |
| Eskalacje | Escalation Rate | Pokazuje udział spraw wymagających przekazania do 2nd line |

Dzięki takiemu doborowi KPI dashboard pokazuje nie tylko wolumen danych, ale również jakość i efektywność procesu.

---

## 3. Różnica pomiędzy AS-IS i TO-BE

Model AS-IS został przygotowany w celu opisania aktualnego przebiegu procesu oraz wskazania miejsc, w których pojawiają się problemy operacyjne.

W procesie AS-IS klient przechodzi przez IVR, trafia do kolejki, a następnie do konsultanta 1st line. Bardziej złożone sprawy są eskalowane do 2nd line lub back-office. W obecnym procesie występują jednak problemy związane z długim czasem oczekiwania, porzuconymi połączeniami, brakiem callbacku i ograniczoną samoobsługą.

Model TO-BE został przygotowany jako odpowiedź na te problemy.

Najważniejsze usprawnienia w TO-BE:

| Obszar | AS-IS | TO-BE |
|---|---|---|
| Oczekiwanie w kolejce | Klient czeka na połączenie z konsultantem | Klient może wybrać callback |
| Proste sprawy | Wymagają kontaktu z konsultantem | Część spraw obsługiwana jest przez self-service w IVR |
| Dane o kontakcie | Ograniczone lub niespójne tagowanie | Konsultant taguje powód kontaktu i wynik rozmowy |
| SLA | Ograniczona kontrola i opóźniona reakcja | SLA monitorowane przez dane i dashboard |
| Eskalacje | Przekazywane do 2nd line / back-office | Eskalacje są rejestrowane i widoczne w KPI |
| Raportowanie | Ograniczona widoczność procesu | Dashboard prezentuje KPI i wyjątki operacyjne |

Proces TO-BE został więc zaprojektowany nie tylko jako zmiana przebiegu procesu, ale również jako podstawa do lepszego raportowania i zarządzania operacyjnego.

---

## 4. Źródła danych do KPI

Dane potrzebne do KPI pochodzą z kilku obszarów procesu.

W projekcie założono, że źródłem danych są komponenty takie jak IVR, system Contact Center, CRM, Back Office / 2nd Line oraz warstwa SQL wykorzystywana do raportowania.

| KPI | Źródło danych | Przykładowe tabele / obszary |
|---|---|---|
| ASA | Dane o połączeniach | calls |
| AHT | Dane o połączeniach i kontaktach | calls, contacts |
| FCR | Dane o sprawach i kontaktach | cases, contacts |
| SLA | Dane o zgłoszeniach i terminach | cases, sla_events |
| Abandonment Rate | Dane o połączeniach porzuconych | calls |
| Callback Rate | Dane o callbackach | callbacks |
| Callback Realization Rate | Statusy callbacków | callbacks |
| Self-service Rate | Dane z IVR / Contact Center | calls |
| Escalation Rate | Dane o eskalacjach | cases, contacts |

Takie podejście pokazuje, że dashboard KPI jest końcowym efektem przepływu danych przez proces i systemy, a nie niezależnym raportem oderwanym od źródeł danych.

---

## 5. Integracja Contact Center z CRM

Integracja Contact Center z CRM została opisana jako jeden z kluczowych elementów rozwiązania, ponieważ konsultant potrzebuje dostępu do danych klienta oraz historii wcześniejszych kontaktów.

Celem integracji jest:

- identyfikacja klienta,
- pobranie danych klienta,
- pobranie historii kontaktów,
- aktualizacja historii kontaktu po zakończeniu rozmowy,
- zapewnienie danych do raportowania KPI.

Przykładowy przepływ:

```text
Contact Center → CRM
Zapytanie o dane klienta

CRM → Contact Center
Zwrot danych klienta i historii kontaktów

Contact Center → CRM
Zapis informacji o nowym kontakcie
```

Zakres danych obejmuje m.in.:

| Dane | Cel |
|---|---|
| customerId | Identyfikacja klienta |
| customerSegment | Analiza segmentacyjna |
| customerStatus | Kontekst obsługi |
| openCases | Widoczność aktywnych spraw |
| interactionHistory | Historia kontaktów dla konsultanta |
| contactCategory | Dane do KPI i analizy przyczyn kontaktu |
| ticketStatus | Monitorowanie statusu sprawy |

Taka integracja wspiera zarówno obsługę klienta w czasie rozmowy, jak i późniejsze raportowanie operacyjne.

---

## 6. Endpoint callbacku

Endpoint callbacku został opisany jako przykładowa operacja REST API wspierająca proces TO-BE.

Jego celem jest zarejestrowanie zgłoszenia oddzwonienia dla klienta, który nie chce oczekiwać w kolejce.

Przykładowa operacja:

```http
POST /api/v1/callbacks
```

Przykładowy request:

```json
{
  "customerId": 1001,
  "phoneNumber": "+48123456789",
  "preferredTime": "2026-07-01T14:30:00Z",
  "reason": "INVOICE"
}
```

Przykładowa odpowiedź:

```json
{
  "callbackId": 501,
  "customerId": 1001,
  "status": "SCHEDULED",
  "createdAt": "2026-07-01T12:15:00Z"
}
```

Reguły biznesowe dla endpointu:

| ID | Reguła |
|---|---|
| BR.CB.01 | Callback może zostać utworzony tylko dla istniejącego klienta |
| BR.CB.02 | Numer telefonu jest wymagany |
| BR.CB.03 | Nowy callback otrzymuje status SCHEDULED |
| BR.CB.04 | Aktywny callback powinien być widoczny w danych raportowych |
| BR.CB.05 | Niezrealizowany callback powinien być oznaczony jako wyjątek operacyjny |

Endpoint callbacku pokazuje, w jaki sposób wymaganie biznesowe dotyczące ograniczenia oczekiwania w kolejce może zostać przełożone na operację systemową.

---

## 7. Kryteria akceptacji dla callbacku

Kryteria akceptacji dla callbacku zostały przygotowane tak, aby były zrozumiałe zarówno dla biznesu, jak i zespołu technicznego.

Celem callbacku jest ograniczenie liczby porzuconych połączeń oraz poprawa doświadczenia klienta.

Kryteria akceptacji:

| ID | Kryterium |
|---|---|
| AC.CB.01 | Klient może wybrać callback w IVR |
| AC.CB.02 | System zapisuje numer telefonu klienta |
| AC.CB.03 | Callback otrzymuje status „Zaplanowany” |
| AC.CB.04 | Callback jest widoczny w danych raportowych |
| AC.CB.05 | Niezrealizowany callback jest oznaczony jako wyjątek operacyjny |
| AC.CB.06 | Callback nie może zostać utworzony bez numeru telefonu |
| AC.CB.07 | Status callbacku może zostać wykorzystany do wyliczenia Callback Realization Rate |

Przykładowy scenariusz akceptacyjny:

```gherkin
Given klient oczekuje w kolejce
When klient wybiera opcję callbacku w IVR
Then system zapisuje zgłoszenie callbacku
And callback otrzymuje status "Zaplanowany"
And callback jest widoczny w raporcie operacyjnym
```

---

## 8. Postępowanie przy niepełnych danych o callbackach

Niepełne dane o callbackach wpływają bezpośrednio na jakość KPI, zwłaszcza Callback Rate, Callback Realization Rate oraz widok alertów operacyjnych.

W przypadku braków danych należałoby najpierw określić, jakiego typu dane są niepełne:

| Brakujące dane | Potencjalny wpływ |
|---|---|
| Brak statusu callbacku | Nie można określić, czy callback został zrealizowany |
| Brak numeru telefonu | Callback nie powinien zostać utworzony |
| Brak daty utworzenia | Trudna analiza terminowości |
| Brak daty realizacji | Nie można policzyć opóźnienia callbacku |
| Brak powodu kontaktu | Trudna analiza źródeł zgłoszeń |
| Brak customerId | Utrudnione powiązanie callbacku z klientem |

Rekomendowane działania:

1. Zidentyfikować zakres braków danych.
2. Sprawdzić, czy problem powstaje w IVR, Contact Center, CRM czy warstwie SQL.
3. Wprowadzić reguły jakości danych dla callbacków.
4. Zdefiniować statusy obowiązkowe, np. SCHEDULED, COMPLETED, CANCELLED, MISSED.
5. Oznaczać rekordy niepełne jako wyjątki danych.
6. Nie usuwać rekordów niepełnych bez analizy przyczyny.
7. W dashboardzie pokazać metrykę jakości danych dla callbacków.
8. Ustalić, czy KPI powinny wykluczać rekordy niepełne, czy prezentować je jako osobną kategorię.

Przykładowe reguły jakości danych:

| ID | Reguła |
|---|---|
| DQ.CB.01 | Każdy callback musi mieć unikalny callbackId |
| DQ.CB.02 | Każdy callback musi mieć status |
| DQ.CB.03 | Callback bez numeru telefonu powinien zostać oznaczony jako błąd walidacji |
| DQ.CB.04 | Data realizacji nie może być wcześniejsza niż data utworzenia |
| DQ.CB.05 | Callback ze statusem COMPLETED powinien mieć datę realizacji |
| DQ.CB.06 | Callback bez customerId powinien być oznaczony jako callback niezidentyfikowany |

Takie podejście pozwala nie tylko poprawić jakość raportowania, ale również znaleźć przyczynę problemu w procesie lub integracji.

---

## Podsumowanie

Kluczowe decyzje analityczne w projekcie opierały się na zasadzie:

```text
Problem biznesowy → wymagania → proces → dane → integracje → KPI → dashboard
```

Dzięki temu każdy element projektu ma uzasadnienie:

- wymagania wynikają z problemów biznesowych,
- User Stories wynikają z potrzeb interesariuszy,
- proces TO-BE odpowiada na problemy AS-IS,
- integracje pokazują przepływ danych między systemami,
- API opisuje wybrane operacje systemowe,
- model SQL umożliwia wyliczenie KPI,
- dashboard Power BI wspiera decyzje operacyjne.

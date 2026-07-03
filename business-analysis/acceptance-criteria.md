# Kryteria akceptacji

## Cel dokumentu

Dokument opisuje kryteria akceptacji dla kluczowych User Stories z projektu optymalizacji procesu Contact Center.

Kryteria akceptacji określają warunki, które muszą zostać spełnione, aby dana funkcjonalność mogła zostać uznana za zrealizowaną z perspektywy biznesowej i systemowej.

---

## Standard zapisu

Kryteria akceptacji zostały opisane w formie:

- warunków biznesowych,
- oczekiwanego zachowania systemu,
- kryteriów jakościowych,
- powiązania z wymaganiami funkcjonalnymi,
- powiązania z KPI.

---

# AC.01 — Historia kontaktów klienta

## Powiązana User Story

**US.01 — Historia kontaktów klienta**

Jako konsultant Contact Center  
chcę widzieć historię kontaktów klienta  
aby szybciej rozwiązywać zgłoszenia i ograniczyć konieczność ponownego zadawania tych samych pytań.

## Powiązane wymagania

| ID | Wymaganie |
|---|---|
| WF.02 | Identyfikacja klienta |
| WF.03 | Rejestracja przyczyny kontaktu |
| WF.07 | Dane do raportowania KPI |

## Kryteria akceptacji

| ID | Kryterium akceptacji | Typ |
|---|---|---|
| AC.01.01 | System prezentuje historię kontaktów klienta z ostatnich 12 miesięcy | Funkcjonalne |
| AC.01.02 | Historia kontaktów jest sortowana od najnowszych do najstarszych | Funkcjonalne |
| AC.01.03 | Konsultant widzi datę kontaktu, kategorię sprawy, kanał kontaktu i status zgłoszenia | Funkcjonalne |
| AC.01.04 | Czas odpowiedzi dla pobrania historii kontaktów nie przekracza 2 sekund | Niefunkcjonalne |
| AC.01.05 | Jeżeli klient nie ma historii kontaktów, system wyświetla komunikat „Brak wcześniejszych kontaktów” | Funkcjonalne |

## Scenariusz akceptacyjny

```gherkin
Given konsultant obsługuje połączenie klienta
And klient został poprawnie zidentyfikowany
When konsultant otwiera historię kontaktów
Then system wyświetla kontakty klienta z ostatnich 12 miesięcy
And kontakty są posortowane od najnowszych do najstarszych
And czas odpowiedzi nie przekracza 2 sekund
```

---

# AC.02 — Callback

## Powiązana User Story

**US.02 — Callback**

Jako klient  
chcę mieć możliwość zamówienia oddzwonienia  
aby nie musieć oczekiwać w kolejce.

## Powiązane wymagania

| ID | Wymaganie |
|---|---|
| WF.04 | Obsługa callbacku |
| WF.05 | Status callbacku |
| WB.01 | Zmniejszenie liczby porzuconych połączeń |
| WB.02 | Skrócenie średniego czasu oczekiwania klienta |

## Kryteria akceptacji

| ID | Kryterium akceptacji | Typ |
|---|---|---|
| AC.02.01 | Klient może wybrać callback w IVR | Funkcjonalne |
| AC.02.02 | System zapisuje numer telefonu klienta | Funkcjonalne |
| AC.02.03 | Nowy callback otrzymuje status „Zaplanowany” | Funkcjonalne |
| AC.02.04 | Callback jest widoczny w danych raportowych | Funkcjonalne |
| AC.02.05 | Niezrealizowany callback jest oznaczany jako wyjątek operacyjny | Funkcjonalne |
| AC.02.06 | Callback nie może zostać utworzony bez numeru telefonu | Walidacyjne |

## Scenariusz akceptacyjny

```gherkin
Given klient oczekuje w kolejce
When klient wybiera opcję callbacku w IVR
Then system zapisuje zgłoszenie callbacku
And callback otrzymuje status "Zaplanowany"
And callback jest widoczny w raporcie operacyjnym
```

---

# AC.03 — Tagowanie przyczyny kontaktu

## Powiązana User Story

**US.03 — Tagowanie przyczyny kontaktu**

Jako konsultant  
chcę oznaczyć przyczynę kontaktu klienta  
aby dane mogły być wykorzystane do analizy KPI i optymalizacji procesu.

## Powiązane wymagania

| ID | Wymaganie |
|---|---|
| WF.03 | Rejestracja przyczyny kontaktu |
| WF.07 | Dane do raportowania KPI |
| WB.04 | Poprawa jakości danych o przyczynach kontaktu |

## Kryteria akceptacji

| ID | Kryterium akceptacji | Typ |
|---|---|---|
| AC.03.01 | Wybór kategorii kontaktu jest obowiązkowy przed zamknięciem zgłoszenia | Funkcjonalne |
| AC.03.02 | Lista kategorii kontaktu jest zdefiniowana centralnie | Funkcjonalne |
| AC.03.03 | System umożliwia wybór kategorii, np. faktura, reklamacja, techniczne, inne | Funkcjonalne |
| AC.03.04 | Zmiana kategorii kontaktu jest logowana | Audytowe |
| AC.03.05 | Dane o kategorii kontaktu są dostępne w modelu raportowym | Raportowe |

## Scenariusz akceptacyjny

```gherkin
Given konsultant obsługuje zgłoszenie klienta
When konsultant próbuje zamknąć zgłoszenie bez wskazania kategorii kontaktu
Then system blokuje zamknięcie zgłoszenia
And wyświetla komunikat o konieczności wyboru kategorii
```

---

# AC.04 — Monitorowanie KPI

## Powiązana User Story

**US.04 — Monitorowanie KPI**

Jako lider zespołu  
chcę monitorować KPI operacyjne  
aby szybko identyfikować problemy w procesie obsługi.

## Powiązane wymagania

| ID | Wymaganie |
|---|---|
| WF.07 | Dane do raportowania KPI |
| WF.08 | Analiza KPI |
| WB.05 | Monitorowanie KPI operacyjnych w dashboardzie Power BI |

## Kryteria akceptacji

| ID | Kryterium akceptacji | Typ |
|---|---|---|
| AC.04.01 | Dashboard prezentuje SLA | Raportowe |
| AC.04.02 | Dashboard prezentuje FCR | Raportowe |
| AC.04.03 | Dashboard prezentuje AHT | Raportowe |
| AC.04.04 | Dashboard prezentuje ASA | Raportowe |
| AC.04.05 | Dashboard prezentuje Abandonment Rate | Raportowe |
| AC.04.06 | Dane można filtrować po okresie, zespole i konsultancie | Funkcjonalne |
| AC.04.07 | KPI są liczone na podstawie danych z modelu SQL | Techniczne |

## Scenariusz akceptacyjny

```gherkin
Given lider zespołu otwiera dashboard Contact Center
When wybiera zakres dat i zespół
Then system prezentuje KPI dla wybranego zakresu
And dashboard pokazuje SLA, FCR, AHT, ASA oraz Abandonment Rate
```

---

# AC.05 — Eskalacja do 2nd line

## Powiązana User Story

**US.05 — Eskalacja do 2nd line**

Jako konsultant  
chcę przekazać sprawę do 2nd line  
aby bardziej złożone zgłoszenia zostały obsłużone przez właściwy zespół.

## Powiązane wymagania

| ID | Wymaganie |
|---|---|
| WF.06 | Eskalacja do 2nd line |
| WF.07 | Dane do raportowania KPI |
| WF.08 | Analiza KPI |

## Kryteria akceptacji

| ID | Kryterium akceptacji | Typ |
|---|---|---|
| AC.05.01 | Konsultant może oznaczyć sprawę jako eskalowaną | Funkcjonalne |
| AC.05.02 | System zapisuje datę i czas eskalacji | Funkcjonalne |
| AC.05.03 | System zapisuje powód eskalacji | Funkcjonalne |
| AC.05.04 | Sprawa otrzymuje status „Eskalowana” | Funkcjonalne |
| AC.05.05 | Eskalacje są widoczne w dashboardzie operacyjnym | Raportowe |
| AC.05.06 | Eskalowana sprawa jest uwzględniana w analizie SLA | Raportowe |

## Scenariusz akceptacyjny

```gherkin
Given konsultant obsługuje zgłoszenie klienta
And zgłoszenie wymaga wsparcia 2nd line
When konsultant oznacza sprawę jako eskalowaną
Then system zapisuje status "Eskalowana"
And zapisuje powód eskalacji
And sprawa jest widoczna w raporcie eskalacji
```

---

## Macierz User Story → Kryteria akceptacji

| User Story | Kryteria akceptacji |
|---|---|
| US.01 — Historia kontaktów klienta | AC.01.01 - AC.01.05 |
| US.02 — Callback | AC.02.01 - AC.02.06 |
| US.03 — Tagowanie przyczyny kontaktu | AC.03.01 - AC.03.05 |
| US.04 — Monitorowanie KPI | AC.04.01 - AC.04.07 |
| US.05 — Eskalacja do 2nd line | AC.05.01 - AC.05.06 |

---

## Macierz wymagań → Kryteria akceptacji

| Wymaganie | Powiązane kryteria akceptacji |
|---|---|
| WF.02 | AC.01.01, AC.01.03 |
| WF.03 | AC.03.01, AC.03.02, AC.03.03, AC.03.05 |
| WF.04 | AC.02.01, AC.02.02, AC.02.03 |
| WF.05 | AC.02.03, AC.02.04, AC.02.05 |
| WF.06 | AC.05.01, AC.05.02, AC.05.03, AC.05.04 |
| WF.07 | AC.03.05, AC.04.07, AC.05.05 |
| WF.08 | AC.04.01 - AC.04.07, AC.05.06 |

---

## Definicja ukończenia

Funkcjonalność może zostać uznana za ukończoną, jeżeli:

| Warunek | Opis |
|---|---|
| Spełnienie kryteriów akceptacji | Wszystkie kryteria przypisane do User Story zostały spełnione |
| Poprawność danych | Dane są dostępne w modelu raportowym |
| Spójność procesu | Funkcjonalność jest zgodna z procesem TO-BE |
| Możliwość raportowania | Dane mogą być wykorzystane w dashboardzie Power BI |
| Brak błędów krytycznych | Funkcjonalność nie powoduje błędów blokujących proces |



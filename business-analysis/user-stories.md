cat > business-analysis/user-stories.md <<'EOF'
# User Stories

## Epic: Obsługa połączeń przychodzących

### US-01 — Historia kontaktów klienta

Jako konsultant Contact Center  
chcę widzieć historię kontaktów klienta  
aby szybciej rozwiązywać zgłoszenia i ograniczyć konieczność ponownego zadawania tych samych pytań.

#### Kryteria akceptacji

- system prezentuje historię kontaktów klienta z ostatnich 12 miesięcy,
- historia jest sortowana od najnowszych kontaktów,
- konsultant widzi kategorię sprawy, datę kontaktu i status zgłoszenia,
- czas odpowiedzi nie przekracza 2 sekund.

---

### US-02 — Callback

Jako klient  
chcę mieć możliwość zamówienia oddzwonienia  
aby nie musieć oczekiwać w kolejce.

#### Kryteria akceptacji

- klient może wybrać callback w IVR,
- system zapisuje numer telefonu klienta,
- system nadaje callbackowi status "Zaplanowany",
- callback jest widoczny w raporcie operacyjnym,
- niezrealizowany callback jest oznaczony jako wyjątek.

---

### US-03 — Tagowanie przyczyny kontaktu

Jako konsultant  
chcę oznaczyć przyczynę kontaktu klienta  
aby dane mogły być wykorzystane do analizy KPI i optymalizacji procesu.

#### Kryteria akceptacji

- wybór kategorii kontaktu jest obowiązkowy,
- lista kategorii jest zdefiniowana centralnie,
- zmiana kategorii jest logowana,
- dane są dostępne w modelu raportowym.

---

### US-04 — Monitorowanie KPI

Jako lider zespołu  
chcę monitorować KPI operacyjne  
aby szybko identyfikować problemy w procesie obsługi.

#### Kryteria akceptacji

- dashboard prezentuje SLA,
- dashboard prezentuje FCR,
- dashboard prezentuje AHT,
- dashboard prezentuje ASA,
- dashboard prezentuje Abandonment Rate,
- dane można filtrować po dacie, zespole i konsultancie.

---

### US-05 — Eskalacja do 2nd line

Jako konsultant  
chcę przekazać sprawę do 2nd line  
aby bardziej złożone zgłoszenia zostały obsłużone przez właściwy zespół.

#### Kryteria akceptacji

- konsultant może oznaczyć sprawę jako eskalowaną,
- system zapisuje datę i powód eskalacji,
- sprawa otrzymuje status "Eskalowana",
- eskalacje są widoczne w dashboardzie.
EOF

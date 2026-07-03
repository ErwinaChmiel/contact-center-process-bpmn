# Analiza interesariuszy — Contact Center

## Cel dokumentu

Celem dokumentu jest identyfikacja kluczowych interesariuszy procesu obsługi połączeń w Contact Center oraz określenie ich celów, potrzeb, problemów i oczekiwań wobec procesu TO-BE.

Dokument wspiera analizę wymagań, definiowanie User Stories, kryteriów akceptacji oraz KPI wykorzystywanych w dashboardzie Power BI.

---

## Zakres analizy

Analiza obejmuje interesariuszy biorących udział w procesie:

- obsługi połączeń przychodzących,
- obsługi IVR i self-service,
- obsługi callbacków,
- rejestracji i kategoryzacji kontaktów,
- monitorowania SLA,
- eskalacji do 2nd line lub back-office,
- raportowania KPI.

---

## Interesariusze procesu

| ID | Interesariusz | Rola w procesie |
|---|---|---|
| ST.01 | Klient | Inicjuje kontakt z Contact Center i oczekuje rozwiązania sprawy |
| ST.02 | Konsultant Contact Center | Obsługuje połączenia, rejestruje kontakt i klasyfikuje sprawę |
| ST.03 | Lider zespołu | Monitoruje efektywność konsultantów i reaguje na problemy operacyjne |
| ST.04 | Menedżer Contact Center | Odpowiada za jakość obsługi, koszty i realizację KPI |
| ST.05 | Back Office / 2nd Line | Obsługuje sprawy złożone i eskalowane |
| ST.06 | Analityk BI / Raportowy | Przygotowuje model danych, KPI i dashboard |
| ST.07 | Zespół IT / Integracyjny | Odpowiada za integracje systemowe i dostępność danych |

---

# ST.01 — Klient

## Cele

- uzyskanie szybkiej odpowiedzi na zgłoszenie,
- krótki czas oczekiwania na połączenie,
- możliwość skorzystania z samoobsługi lub callbacku,
- otrzymanie informacji o statusie sprawy.

## Problemy w procesie AS-IS

- długi czas oczekiwania w kolejce,
- konieczność ponownego kontaktu w tej samej sprawie,
- brak możliwości prostego sprawdzenia statusu sprawy,
- ograniczona samoobsługa w IVR.

## Oczekiwania wobec procesu TO-BE

| Oczekiwanie | Wartość biznesowa |
|---|---|
| Krótszy czas oczekiwania | Wyższa satysfakcja klienta |
| Callback | Mniejsza frustracja związana z kolejką |
| Self-service | Szybsza obsługa prostych spraw |
| Status sprawy | Większa przejrzystość obsługi |

---

# ST.02 — Konsultant Contact Center

## Cele

- szybki dostęp do danych klienta,
- dostęp do historii kontaktów,
- możliwość poprawnego oznaczenia przyczyny kontaktu,
- sprawne przekazanie sprawy do 2nd line lub back-office.

## Problemy w procesie AS-IS

- brak pełnego kontekstu klienta,
- konieczność pracy w kilku systemach,
- ręczne oznaczanie statusów,
- duże obciążenie w godzinach szczytu.

## Oczekiwania wobec procesu TO-BE

| Oczekiwanie | Wartość biznesowa |
|---|---|
| Historia kontaktów klienta | Krótszy czas obsługi |
| Centralna kategoryzacja kontaktu | Lepsza jakość danych |
| Prosty proces eskalacji | Sprawniejsza obsługa spraw złożonych |
| Mniej powtarzalnych spraw | Lepsze wykorzystanie czasu konsultanta |

---

# ST.03 — Lider zespołu

## Cele

- monitorowanie efektywności zespołu,
- kontrola realizacji SLA,
- szybka identyfikacja problemów operacyjnych,
- analiza jakości obsługi.

## Kluczowe KPI

| KPI | Znaczenie |
|---|---|
| FCR | Skuteczność rozwiązania sprawy przy pierwszym kontakcie |
| SLA | Terminowość realizacji spraw |
| AHT | Średni czas obsługi połączenia |
| ASA | Średni czas oczekiwania na odpowiedź |
| Abandonment Rate | Odsetek porzuconych połączeń |
| Callback Realization Rate | Skuteczność realizacji callbacków |

## Oczekiwania wobec procesu TO-BE

| Oczekiwanie | Wartość biznesowa |
|---|---|
| Dashboard KPI | Szybsza reakcja na problemy |
| Widok alertów | Identyfikacja wyjątków operacyjnych |
| Analiza per konsultant | Lepsze zarządzanie zespołem |
| Analiza trendów | Wsparcie planowania pracy |

---

# ST.04 — Menedżer Contact Center

## Cele

- poprawa jakości obsługi klienta,
- optymalizacja kosztów operacyjnych,
- zwiększenie skuteczności samoobsługi,
- podejmowanie decyzji na podstawie danych.

## Kluczowe KPI

| KPI | Znaczenie |
|---|---|
| Service Level | Ogólna jakość dostępności obsługi |
| First Contact Resolution | Skuteczność rozwiązania sprawy |
| Cost per Contact | Koszt obsługi pojedynczego kontaktu |
| Abandonment Rate | Utracone kontakty klientów |
| Cases Past SLA | Liczba spraw przekroczonych po terminie |

## Oczekiwania wobec procesu TO-BE

| Oczekiwanie | Wartość biznesowa |
|---|---|
| Raportowanie zarządcze | Decyzje oparte na danych |
| Identyfikacja godzin szczytu | Lepsze planowanie zasobów |
| Analiza self-service | Optymalizacja kosztów |
| Analiza efektywności zespołów | Poprawa jakości obsługi |

---

# ST.05 — Back Office / 2nd Line

## Cele

- obsługa spraw złożonych,
- przejmowanie eskalacji od konsultantów,
- zamykanie spraw wymagających dodatkowej analizy.

## Problemy w procesie AS-IS

- brak pełnego kontekstu przekazywanej sprawy,
- niepełne dane dotyczące powodu eskalacji,
- opóźniona informacja o sprawach po SLA.

## Oczekiwania wobec procesu TO-BE

| Oczekiwanie | Wartość biznesowa |
|---|---|
| Powód eskalacji | Szybsza obsługa sprawy |
| Historia kontaktów | Lepsze zrozumienie kontekstu |
| Status SLA | Priorytetyzacja spraw |
| Raport eskalacji | Monitorowanie obciążenia 2nd line |

---

# ST.06 — Analityk BI / Raportowy

## Cele

- przygotowanie modelu danych,
- zdefiniowanie KPI,
- zapewnienie spójności danych raportowych,
- przygotowanie dashboardu Power BI.

## Potrzeby

| Potrzeba | Uzasadnienie |
|---|---|
| Spójne źródła danych | Poprawne wyliczanie KPI |
| Jednoznaczne definicje KPI | Uniknięcie różnych interpretacji wskaźników |
| Dane historyczne | Analiza trendów |
| Dane o callbackach i SLA | Raportowanie wyjątków operacyjnych |

---

# ST.07 — Zespół IT / Integracyjny

## Cele

- zapewnienie dostępności danych,
- utrzymanie integracji między systemami,
- wsparcie warstwy API,
- zapewnienie bezpieczeństwa komunikacji.

## Potrzeby

| Potrzeba | Uzasadnienie |
|---|---|
| Jasne wymagania integracyjne | Poprawna implementacja przepływu danych |
| Specyfikacja API | Spójność komunikacji pomiędzy systemami |
| Reguły walidacji danych | Ograniczenie błędów integracyjnych |
| Wymagania niefunkcjonalne | Zapewnienie wydajności, bezpieczeństwa i dostępności |

---

## Macierz interesariusz → potrzeba → artefakt

| Interesariusz | Główna potrzeba | Artefakt projektowy |
|---|---|---|
| Klient | Szybka obsługa sprawy | Proces TO-BE, callback, self-service |
| Konsultant | Pełna informacja o kliencie | Historia kontaktów, CRM, User Stories |
| Lider zespołu | Kontrola KPI | Dashboard Power BI, alerty operacyjne |
| Menedżer | Raportowanie i optymalizacja | Executive KPI Overview |
| Back Office / 2nd Line | Obsługa spraw eskalowanych | Proces eskalacji, statusy spraw |
| Analityk BI | Spójne dane i KPI | Model SQL, definicje KPI, Power BI |
| IT | Jasne integracje | Specyfikacja API, analiza integracji |

---

## Macierz wpływ / zainteresowanie

| Interesariusz | Wpływ | Zainteresowanie | Strategia komunikacji |
|---|---|---|---|
| Menedżer Contact Center | Wysoki | Wysokie | Regularne podsumowania KPI i decyzji |
| Lider zespołu | Wysoki | Wysokie | Warsztaty operacyjne i walidacja dashboardu |
| Konsultant | Średni | Wysokie | Zbieranie potrzeb i testowanie procesu TO-BE |
| Klient | Niski | Wysokie | Analiza potrzeb poprzez proces i KPI |
| Back Office / 2nd Line | Średni | Średnie | Uzgodnienia dotyczące eskalacji |
| Analityk BI | Średni | Wysokie | Uzgodnienie definicji KPI i modelu danych |
| IT | Wysoki | Średnie | Uzgodnienie API, integracji i wymagań niefunkcjonalnych |

---

## Podsumowanie

Analiza interesariuszy wskazuje, że proces TO-BE powinien odpowiadać jednocześnie na potrzeby klientów, konsultantów, liderów zespołów, menedżerów oraz zespołów technicznych.

Najważniejsze potrzeby interesariuszy dotyczą:

- skrócenia czasu oczekiwania,
- poprawy dostępu do historii klienta,
- zwiększenia self-service,
- monitorowania SLA,
- raportowania KPI,
- poprawy jakości danych,
- lepszej obsługi eskalacji.

EOF

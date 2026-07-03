# Inżynieria wymagań — Contact Center

## Cel dokumentu

Celem dokumentu jest uporządkowanie zidentyfikowanych problemów biznesowych, wymagań biznesowych, funkcjonalnych i niefunkcjonalnych dla procesu obsługi połączeń w Contact Center.

Dokument pokazuje powiązanie pomiędzy problemami operacyjnymi, wymaganiami, procesem TO-BE, danymi oraz KPI wykorzystywanymi w dashboardzie Power BI.

---

## Kontekst biznesowy

Proces Contact Center obejmuje obsługę połączeń przychodzących dotyczących:

- faktur,
- reklamacji,
- spraw technicznych,
- zgłoszeń wymagających eskalacji do 2nd line lub back-office,
- spraw możliwych do obsługi przez self-service lub callback.

Analiza procesu AS-IS wykazała problemy wpływające na jakość obsługi klienta oraz efektywność operacyjną zespołu Contact Center.

---

## Zidentyfikowane problemy biznesowe

| ID | Problem biznesowy | Wpływ na proces |
|---|---|---|
| PB.01 | Wysoki poziom porzuconych połączeń w godzinach największego obciążenia | Spadek jakości obsługi i niższa satysfakcja klientów |
| PB.02 | Długi średni czas oczekiwania klienta na połączenie z konsultantem | Wzrost liczby porzuceń i większe obciążenie infolinii |
| PB.03 | Ograniczony zakres samoobsługi w IVR dla prostych spraw | Konsultanci obsługują powtarzalne, niskowartościowe zgłoszenia |
| PB.04 | Brak spójnego tagowania przyczyn kontaktu klienta | Utrudniona analiza powodów kontaktu i identyfikacja problemów |
| PB.05 | Ograniczona możliwość bieżącego monitorowania SLA, FCR, AHT i callbacków | Brak szybkiej reakcji na problemy operacyjne |

---

## Wymagania biznesowe

| ID | Wymaganie biznesowe | Powiązany problem | Oczekiwana wartość biznesowa |
|---|---|---|---|
| WB.01 | Zmniejszenie liczby porzuconych połączeń | PB.01 | Poprawa dostępności obsługi i satysfakcji klientów |
| WB.02 | Skrócenie średniego czasu oczekiwania klienta | PB.02 | Szybsza obsługa klientów i lepsze SLA |
| WB.03 | Zwiększenie udziału spraw obsługiwanych przez self-service | PB.03 | Odciążenie konsultantów i redukcja kosztów operacyjnych |
| WB.04 | Poprawa jakości danych o przyczynach kontaktu | PB.04 | Lepsza analiza problemów i optymalizacja procesu |
| WB.05 | Zapewnienie monitorowania KPI operacyjnych w dashboardzie Power BI | PB.05 | Podejmowanie decyzji na podstawie danych |

---

## Wymagania funkcjonalne

| ID | Wymaganie funkcjonalne | Opis | Priorytet |
|---|---|---|---|
| WF.01 | Rejestracja połączeń przychodzących | System powinien rejestrować każde połączenie przychodzące wraz z datą, godziną, kolejką i statusem obsługi | Wysoki |
| WF.02 | Identyfikacja klienta | System powinien umożliwiać identyfikację klienta na podstawie danych z IVR lub CRM | Wysoki |
| WF.03 | Rejestracja przyczyny kontaktu | System powinien umożliwiać zapis przyczyny kontaktu klienta zgodnie ze zdefiniowaną listą kategorii | Wysoki |
| WF.04 | Obsługa callbacku | System powinien umożliwiać zarejestrowanie callbacku wybranego przez klienta | Wysoki |
| WF.05 | Status callbacku | System powinien umożliwiać zapis i aktualizację statusu callbacku | Średni |
| WF.06 | Eskalacja do 2nd line | System powinien rejestrować informację o eskalacji sprawy do 2nd line | Wysoki |
| WF.07 | Dane do raportowania KPI | System powinien udostępniać dane wymagane do raportowania KPI | Wysoki |
| WF.08 | Analiza KPI | System powinien umożliwiać analizę SLA, FCR, AHT, ASA i porzuceń połączeń | Wysoki |

---

## Wymagania niefunkcjonalne

| ID | Wymaganie niefunkcjonalne | Opis | Kryterium akceptacji |
|---|---|---|---|
| WN.01 | Wydajność | Czas odpowiedzi systemu dla podstawowych operacji nie powinien przekraczać 2 sekund | 95% zapytań obsługiwanych poniżej 2 sekund |
| WN.02 | Dostępność | Dostępność systemu powinna wynosić minimum 99,5% | System dostępny w godzinach pracy Contact Center |
| WN.03 | Audytowalność | Wszystkie operacje użytkowników powinny być logowane | Logi zawierają użytkownika, czas operacji i typ akcji |
| WN.04 | Bezpieczeństwo | Komunikacja między komponentami powinna być szyfrowana | Komunikacja realizowana przez HTTPS |
| WN.05 | Skalowalność | Rozwiązanie powinno umożliwiać obsługę minimum 10 000 połączeń dziennie | System obsługuje zakładany wolumen danych |

---

## Macierz powiązań: problem → wymaganie

| Problem biznesowy | Wymaganie biznesowe | Wymagania funkcjonalne |
|---|---|---|
| PB.01 | WB.01 | WF.01, WF.04, WF.05 |
| PB.02 | WB.02 | WF.01, WF.04, WF.08 |
| PB.03 | WB.03 | WF.03, WF.04 |
| PB.04 | WB.04 | WF.03, WF.07 |
| PB.05 | WB.05 | WF.07, WF.08 |

---

## Macierz wymagań → KPI

| Wymaganie | Powiązane KPI | Uzasadnienie |
|---|---|---|
| WF.01 | ASA, AHT, Abandonment Rate | Rejestracja połączeń umożliwia analizę czasu oczekiwania, obsługi i porzuceń |
| WF.02 | AHT, FCR | Identyfikacja klienta i historia kontaktów mogą skrócić obsługę oraz poprawić FCR |
| WF.03 | FCR, Contact Category Analysis, Self-service Rate | Kategoryzacja kontaktów pozwala analizować powody zgłoszeń i potencjał automatyzacji |
| WF.04 | Callback Rate, Abandonment Rate | Callback może ograniczyć liczbę porzuconych połączeń |
| WF.05 | Callback Realization Rate | Status callbacku pozwala monitorować skuteczność oddzwonień |
| WF.06 | Escalation Rate, SLA, FCR | Eskalacje wpływają na terminowość obsługi i skuteczność pierwszego kontaktu |
| WF.07 | Wszystkie KPI | Dane raportowe są podstawą dashboardu operacyjnego |
| WF.08 | SLA, FCR, AHT, ASA, Abandonment Rate | Analiza KPI pozwala monitorować efektywność procesu |

---

## Źródła wymagań

| Źródło | Zakres informacji | Efekt analizy |
|---|---|---|
| Analiza procesu AS-IS | Obecny przebieg obsługi połączeń | Identyfikacja wąskich gardeł i problemów operacyjnych |
| Analiza KPI | FCR, SLA, AHT, ASA, porzucone połączenia, callbacki | Określenie mierników sukcesu procesu TO-BE |
| Analiza problemów operacyjnych | Kolejki, porzucenia, eskalacje, callbacki | Zdefiniowanie wymagań biznesowych |
| Mapowanie przepływu danych | IVR, Contact Center, CRM, SQL, Power BI | Określenie danych wymaganych do raportowania |
| Identyfikacja potrzeb interesariuszy | Klient, konsultant, lider zespołu, manager | Zdefiniowanie User Stories i kryteriów akceptacji |
| Projektowanie procesu TO-BE | Self-service, callback, lepsze tagowanie, raportowanie | Określenie docelowych usprawnień procesu |

---

## Założenia projektowe

| ID | Założenie |
|---|---|
| Z.01 | Dane wykorzystywane w projekcie są danymi przykładowymi |
| Z.02 | Model procesu został przygotowany w notacji BPMN 2.0 |
| Z.03 | Model danych został zaprojektowany pod potrzeby analityki operacyjnej |
| Z.04 | Dashboard Power BI korzysta z przygotowanego modelu SQL |
| Z.05 | Specyfikacja wymagań ma charakter analityczny i portfolio |

---

## Zakres poza projektem

| ID | Element poza zakresem | Uzasadnienie |
|---|---|---|
| OOS.01 | Pełna implementacja aplikacji Contact Center | Projekt koncentruje się na analizie procesu, danych i KPI |
| OOS.02 | Produkcyjna integracja z CRM | Integracja została opisana koncepcyjnie |
| OOS.03 | Produkcyjna integracja z IVR | Proces IVR został odwzorowany na poziomie analitycznym |
| OOS.04 | Mechanizm rzeczywistego kolejkowania połączeń | Projekt skupia się na danych i raportowaniu |

---

## Podsumowanie

Wymagania zostały zdefiniowane na podstawie problemów biznesowych, analizy procesu AS-IS, potrzeb interesariuszy oraz oczekiwanych KPI.

Dokument pokazuje pełną ścieżkę analityczną:

- problem biznesowy,
- wymaganie biznesowe,
- wymaganie funkcjonalne,
- wymaganie niefunkcjonalne,
- KPI,
- zakres danych,
- założenia i ograniczenia projektu.

# Podejście analityczne i struktura dokumentacji

Projekt został rozbudowany o dwa główne obszary dokumentacji:

- `business-analysis/`
- `architecture/`

Celem takiego podziału było pokazanie pełniejszego procesu pracy analitycznej — od identyfikacji problemu biznesowego i potrzeb interesariuszy, przez wymagania i backlog, aż po analizę integracji, architekturę logiczną i specyfikację API.

Dzięki temu projekt nie ogranicza się wyłącznie do modelowania BPMN, SQL i dashboardu Power BI, ale pokazuje również sposób przejścia od problemu biznesowego do rozwiązania systemowo-danowego.

---

## Folder `business-analysis/`

Folder `business-analysis/` zawiera dokumenty opisujące warstwę biznesową projektu.

Dokumentacja w tym obszarze została przygotowana po to, aby uporządkować:

- problem biznesowy,
- potrzeby interesariuszy,
- wymagania biznesowe,
- wymagania funkcjonalne,
- wymagania niefunkcjonalne,
- User Stories,
- backlog produktu,
- kryteria akceptacji,
- powiązanie wymagań z KPI.

Taki podział odzwierciedla typowy sposób pracy analitycznej, w którym punktem wyjścia nie jest od razu rozwiązanie techniczne, ale zrozumienie problemu, kontekstu biznesowego oraz potrzeb użytkowników.

---

## Dlaczego rozpoczęto od analizy problemu biznesowego?

Pierwszym krokiem było opisanie problemu biznesowego, ponieważ przed zaprojektowaniem procesu TO-BE, modelu danych lub dashboardu konieczne było określenie, jaki problem ma zostać rozwiązany.

W projekcie zidentyfikowano m.in.:

- wysoki czas oczekiwania klienta,
- porzucone połączenia,
- ograniczoną samoobsługę,
- niewystarczającą kontrolę SLA,
- ograniczoną analizę przyczyn kontaktu.

Te problemy wpływają bezpośrednio na jakość obsługi klienta, efektywność konsultantów oraz możliwość zarządzania procesem na podstawie danych.

Dlatego dokument `business-problem.md` pełni rolę punktu startowego dla dalszej analizy.

---

## Dlaczego przygotowano analizę interesariuszy?

Po określeniu problemu biznesowego kolejnym krokiem było wskazanie interesariuszy procesu.

W projekcie wyróżniono m.in.:

- klienta,
- konsultanta Contact Center,
- lidera zespołu,
- menedżera Contact Center,
- Back Office / 2nd Line,
- analityka BI,
- zespół IT.

Każda z tych grup ma inne potrzeby i oczekiwania wobec procesu. Klient oczekuje szybkiej obsługi, konsultant potrzebuje dostępu do historii kontaktów, lider zespołu potrzebuje kontroli KPI, a menedżer oczekuje raportowania wspierającego decyzje operacyjne.

Analiza interesariuszy pozwoliła powiązać potrzeby poszczególnych ról z wymaganiami, User Stories oraz dashboardem KPI.

---

## Dlaczego wymagania zostały podzielone na biznesowe, funkcjonalne i niefunkcjonalne?

Wymagania zostały podzielone na kilka poziomów, aby oddzielić cel biznesowy od sposobu jego realizacji.

Wymagania biznesowe opisują oczekiwaną wartość, np.:

- zmniejszenie liczby porzuconych połączeń,
- skrócenie czasu oczekiwania,
- zwiększenie udziału self-service,
- poprawę monitorowania KPI.

Wymagania funkcjonalne opisują, co system lub rozwiązanie powinno umożliwiać, np.:

- rejestrację połączeń,
- identyfikację klienta,
- obsługę callbacku,
- rejestrację eskalacji,
- dostarczenie danych do raportowania.

Wymagania niefunkcjonalne opisują oczekiwaną jakość rozwiązania, np.:

- czas odpowiedzi,
- dostępność,
- audytowalność,
- bezpieczeństwo,
- skalowalność.

Taki podział ułatwia przejście od potrzeby biznesowej do konkretnej funkcjonalności oraz pozwala zachować śledzenie zależności pomiędzy problemem, wymaganiem i KPI.

---

## Dlaczego przygotowano User Stories?

User Stories zostały przygotowane, aby opisać wymagania z perspektywy użytkowników procesu.

Zamiast opisywać funkcjonalności wyłącznie technicznie, zastosowano strukturę:

```text
Jako [rola]
chcę [potrzeba]
aby [wartość biznesowa]

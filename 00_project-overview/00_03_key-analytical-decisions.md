# Warsztaty analityczne i pozyskiwanie wymagań

## Cel dokumentu

Dokument opisuje podejście do pozyskiwania wymagań dla projektu optymalizacji procesu Contact Center.

Celem dokumentu jest pokazanie, w jaki sposób zidentyfikowano problemy biznesowe, potrzeby interesariuszy, wymagania, User Stories, kryteria akceptacji oraz dane niezbędne do raportowania KPI.

Dokument uzupełnia:

- analizę problemu biznesowego,
- analizę interesariuszy,
- wymagania,
- User Stories,
- kryteria akceptacji,
- proces BPMN AS-IS / TO-BE,
- analizę integracji,
- specyfikację API,
- model danych SQL,
- dashboard Power BI.

---

## Założenie warsztatowe

Na potrzeby projektu przyjęto warsztatowe podejście do pozyskiwania wymagań.

Wymagania nie były definiowane od razu jako lista funkcji systemowych. Najpierw analizowano:

- jak obecnie przebiega proces,
- kto uczestniczy w procesie,
- gdzie pojawiają się problemy,
- jakie są skutki biznesowe tych problemów,
- jakie dane są dostępne,
- jakie KPI powinny mierzyć skuteczność procesu,
- jak powinien wyglądać proces docelowy TO-BE.

Dopiero na tej podstawie zidentyfikowano wymagania biznesowe, funkcjonalne, niefunkcjonalne, User Stories i kryteria akceptacji.

---

## Uczestnicy warsztatów

W projekcie uwzględniono perspektywę następujących interesariuszy:

| Rola | Perspektywa |
|---|---|
| Klient | Czas oczekiwania, łatwość kontaktu, możliwość callbacku i self-service |
| Konsultant Contact Center | Obsługa połączeń, historia klienta, kategoryzacja kontaktu |
| Lider zespołu | KPI, SLA, kolejki, obciążenie konsultantów, wyjątki operacyjne |
| Menedżer Contact Center | Jakość obsługi, koszty, efektywność procesu, raportowanie zarządcze |
| Back Office / 2nd Line | Eskalacje, statusy spraw, terminy SLA |
| Analityk BI | Dane, KPI, model SQL, dashboard Power BI |
| Zespół IT / integracyjny | Integracje, API, dostępność danych, wymagania niefunkcjonalne |

---

# 1. Warsztat otwierający — zrozumienie problemu biznesowego

## Cel warsztatu

Celem pierwszego warsztatu było zrozumienie, dlaczego proces wymaga usprawnienia i jakie problemy są najbardziej odczuwalne dla organizacji.

## Pytania zadawane podczas warsztatu

### Pytania o proces

- Jak obecnie wygląda obsługa połączenia od momentu wejścia klienta do IVR?
- Jakie są główne ścieżki klienta w procesie?
- W których miejscach klient może zrezygnować z kontaktu?
- Kiedy połączenie trafia do konsultanta 1st line?
- Kiedy sprawa jest przekazywana do 2nd line lub back-office?
- Czy proces wygląda tak samo dla faktur, reklamacji i problemów technicznych?
- Które kroki procesu są wykonywane manualnie?
- Które kroki procesu powodują największe opóźnienia?

### Pytania o problemy biznesowe

- Co jest obecnie największym problemem w obsłudze połączeń?
- Czy największym problemem jest czas oczekiwania, porzucone połączenia, SLA czy jakość danych?
- W jakich godzinach występuje największe przeciążenie infolinii?
- Jak często klienci kontaktują się ponownie w tej samej sprawie?
- Jakie typy spraw najczęściej wymagają eskalacji?
- Czy proste sprawy trafiają do konsultantów mimo możliwości automatyzacji?
- Jakie konsekwencje biznesowe mają porzucone połączenia?
- Jakie konsekwencje ma brak pełnej informacji o przyczynie kontaktu?

### Rezultat warsztatu

Na podstawie warsztatu zidentyfikowano główne problemy biznesowe:

- długi czas oczekiwania klienta,
- wysoki poziom porzuconych połączeń,
- ograniczony zakres self-service,
- niewystarczającą kontrolę SLA,
- brak spójnego tagowania przyczyn kontaktu,
- ograniczoną widoczność KPI.

---

# 2. Warsztat z interesariuszami — potrzeby użytkowników

## Cel warsztatu

Celem warsztatu było określenie potrzeb różnych grup uczestniczących w procesie Contact Center.

Każda rola ma inną perspektywę, dlatego wymagania nie powinny być definiowane wyłącznie z poziomu raportowania lub systemu.

---

## Pytania do konsultantów Contact Center

- Jakie informacje są potrzebne przed rozpoczęciem rozmowy z klientem?
- Czy konsultant widzi historię kontaktów klienta?
- Jak długo trwa odnalezienie informacji o kliencie?
- Czy konsultant pracuje w jednym systemie, czy w kilku?
- Jak oznaczana jest przyczyna kontaktu?
- Czy lista kategorii kontaktu jest jednoznaczna?
- Czy zdarza się zamknięcie sprawy bez wskazania przyczyny kontaktu?
- Kiedy konsultant decyduje o eskalacji do 2nd line?
- Jakie informacje powinny zostać przekazane przy eskalacji?
- Co najbardziej wydłuża obsługę rozmowy?

## Pytania do liderów zespołów

- Jakie KPI są monitorowane codziennie?
- Które KPI są najważniejsze dla oceny jakości obsługi?
- Czy lider ma widok spraw po SLA?
- Czy lider widzi niezrealizowane callbacki?
- Czy można analizować wskaźniki per konsultant lub zespół?
- Jak szybko lider dowiaduje się o problemach operacyjnych?
- Czy dashboard powinien pokazywać alerty i wyjątki?
- Jakie filtry są potrzebne w raporcie?
- Jakie decyzje operacyjne są podejmowane na podstawie KPI?

## Pytania do menedżera Contact Center

- Jakie są główne cele biznesowe procesu Contact Center?
- Jakie KPI są raportowane na poziomie zarządczym?
- Czy obecne raportowanie wspiera podejmowanie decyzji?
- Jakie informacje są potrzebne do planowania obsady?
- Czy self-service może zmniejszyć koszt obsługi?
- Czy callback może ograniczyć porzucone połączenia?
- Jak mierzyć efektywność procesu TO-BE?
- Jakie informacje powinny być widoczne w widoku executive dashboard?

## Pytania do Back Office / 2nd Line

- Jakie sprawy trafiają do 2nd line?
- Jakie informacje są potrzebne do obsługi sprawy eskalowanej?
- Czy powód eskalacji jest jednoznacznie zapisywany?
- Czy sprawy eskalowane mają osobny status?
- Jak monitorowany jest SLA dla spraw eskalowanych?
- Czy są widoczne sprawy po terminie?
- Co powoduje opóźnienia w obsłudze eskalacji?

## Pytania do zespołu IT / integracyjnego

- Jakie systemy uczestniczą w procesie?
- Czy dane klienta pochodzą z CRM?
- Czy Contact Center ma dostęp do historii kontaktów klienta?
- Jakie dane przekazuje IVR?
- Czy dane są dostępne przez API, eksport, pliki czy bazę danych?
- Jak identyfikowany jest klient pomiędzy systemami?
- Czy istnieje wspólny customerId?
- Jakie są ograniczenia integracyjne?
- Jak obsługiwane są błędy integracji?
- Czy wymagane jest logowanie operacji użytkowników?
- Jakie są wymagania dotyczące czasu odpowiedzi?

---

# 3. Warsztat AS-IS — analiza obecnego procesu

## Cel warsztatu

Celem warsztatu AS-IS było szczegółowe opisanie obecnego przebiegu procesu oraz identyfikacja miejsc, w których występują problemy operacyjne.

## Pytania zadawane podczas analizy AS-IS

- Od czego zaczyna się proces?
- Jakie decyzje podejmuje klient w IVR?
- Jak połączenie jest kierowane do kolejki?
- Kiedy połączenie jest uznawane za porzucone?
- Jak konsultant identyfikuje klienta?
- Jak konsultant rejestruje kontakt?
- Jak wygląda eskalacja do 2nd line?
- Czy status sprawy jest aktualizowany automatycznie czy ręcznie?
- Gdzie w procesie pojawia się opóźnienie?
- Które kroki procesu nie dostarczają danych do raportowania?
- Jakie dane są obecnie dostępne?
- Jakich danych brakuje do wyliczenia KPI?

## Rezultat warsztatu AS-IS

Wynikiem warsztatu było przygotowanie procesu AS-IS oraz wskazanie głównych problemów:

- długi czas oczekiwania w kolejce,
- brak callbacku,
- ograniczony self-service,
- niespójne tagowanie przyczyn kontaktu,
- ograniczona widoczność spraw po SLA,
- ograniczone dane potrzebne do KPI.

---

# 4. Warsztat TO-BE — projektowanie procesu docelowego

## Cel warsztatu

Celem warsztatu TO-BE było zaprojektowanie usprawnień procesu, które odpowiadają na problemy zidentyfikowane w AS-IS.

## Pytania zadawane podczas projektowania TO-BE

### Self-service

- Które sprawy mogą zostać obsłużone bez konsultanta?
- Czy sprawy dotyczące faktur mogą być obsługiwane w IVR?
- Jak rozpoznać, że sprawa nadaje się do self-service?
- Jak mierzyć skuteczność self-service?
- Czy self-service powinien kończyć proces bez tworzenia zgłoszenia do konsultanta?

### Callback

- W którym momencie klient powinien otrzymać możliwość callbacku?
- Jakie dane są potrzebne do utworzenia callbacku?
- Czy numer telefonu powinien być wymagany?
- Jaki status powinien otrzymać nowy callback?
- Jak oznaczać callback niezrealizowany?
- Jak monitorować skuteczność callbacków?
- Czy callback powinien wpływać na Abandonment Rate?

### Tagowanie kontaktu

- Jakie kategorie kontaktu powinny być dostępne?
- Czy wybór kategorii powinien być obowiązkowy?
- Czy konsultant może zmienić kategorię po zapisaniu?
- Czy zmiana kategorii powinna być logowana?
- Jak wykorzystać kategorie kontaktu w KPI?

### SLA i eskalacje

- Kiedy sprawa powinna zostać eskalowana?
- Jakie statusy powinny mieć sprawy eskalowane?
- Jak monitorować sprawy zagrożone przekroczeniem SLA?
- Czy sprawy po SLA powinny być widoczne w osobnym widoku alertów?
- Czy eskalacja powinna obniżać FCR?

## Rezultat warsztatu TO-BE

Na podstawie warsztatu zaprojektowano usprawnienia:

- self-service w IVR,
- callback,
- obowiązkowe tagowanie przyczyny kontaktu,
- rejestrację eskalacji,
- monitoring SLA,
- dane pod KPI i dashboard Power BI.

---

# 5. Warsztat KPI i raportowania

## Cel warsztatu

Celem warsztatu było ustalenie, jakie KPI powinny być mierzone oraz jakie decyzje biznesowe mają wspierać.

## Pytania dotyczące KPI

- Jakie wskaźniki najlepiej opisują efektywność Contact Center?
- Czy KPI mierzą problem biznesowy, czy tylko wolumen pracy?
- Jak mierzyć czas oczekiwania klienta?
- Jak mierzyć czas obsługi konsultanta?
- Jak mierzyć skuteczność pierwszego kontaktu?
- Jak mierzyć porzucone połączenia?
- Jak mierzyć terminowość realizacji spraw?
- Jak mierzyć skuteczność callbacków?
- Jak mierzyć udział self-service?
- Jak mierzyć eskalacje?
- Które KPI powinny być widoczne dla lidera zespołu?
- Które KPI powinny być widoczne dla menedżera?

## Pytania dotyczące dashboardu

- Jakie widoki są potrzebne na poziomie operacyjnym?
- Jakie widoki są potrzebne na poziomie zarządczym?
- Czy raport powinien mieć widok alertów?
- Jakie filtry są niezbędne?
- Czy potrzebna jest analiza per konsultant?
- Czy potrzebna jest analiza per zespół?
- Czy potrzebna jest analiza według kategorii spraw?
- Czy dashboard powinien pokazywać trendy?
- Czy dashboard powinien pokazywać wyjątki, np. sprawy po SLA?

## Rezultat warsztatu KPI

Na podstawie warsztatu wybrano KPI:

| KPI | Cel |
|---|---|
| ASA | Pomiar czasu oczekiwania |
| AHT | Pomiar czasu obsługi |
| FCR | Pomiar skuteczności pierwszego kontaktu |
| SLA Rate | Pomiar terminowości obsługi |
| Abandonment Rate | Pomiar porzuconych połączeń |
| Callback Rate | Pomiar wykorzystania callbacków |
| Callback Realization Rate | Pomiar realizacji callbacków |
| Self-service Rate | Pomiar automatyzacji prostych spraw |
| Escalation Rate | Pomiar spraw przekazywanych do 2nd line |

---

# 6. Warsztat danych i jakości danych

## Cel warsztatu

Celem warsztatu było określenie, jakie dane są wymagane do wyliczenia KPI oraz jakie reguły jakości danych powinny zostać zastosowane.

## Pytania dotyczące danych

- Jakie dane są potrzebne do wyliczenia ASA?
- Jakie dane są potrzebne do wyliczenia AHT?
- Jakie dane są potrzebne do wyliczenia FCR?
- Jakie dane są potrzebne do wyliczenia SLA?
- Jakie dane są potrzebne do monitorowania callbacków?
- Jakie dane są potrzebne do monitorowania self-service?
- Czy każda sprawa ma unikalny identyfikator?
- Czy każde połączenie ma unikalny identyfikator?
- Czy każdy callback ma status?
- Czy każdy kontakt ma kategorię?
- Czy każda eskalacja ma powód?
- Czy dane z IVR można powiązać z danymi z CRM?
- Czy dane z Contact Center można powiązać z danymi SQL?
- Czy są braki w danych historycznych?

## Pytania dotyczące jakości danych

- Które pola powinny być obowiązkowe?
- Jak obsługiwać brak customerId?
- Jak obsługiwać brak numeru telefonu dla callbacku?
- Jak obsługiwać brak statusu callbacku?
- Jak oznaczać kontakty bez kategorii?
- Czy rekordy niepełne powinny być wykluczane z KPI?
- Czy rekordy niepełne powinny być pokazywane jako osobna kategoria jakości danych?
- Jak monitorować jakość danych w dashboardzie?

## Rezultat warsztatu danych

Na podstawie warsztatu określono:

- tabele modelu SQL,
- relacje między danymi,
- pola wymagane do KPI,
- reguły jakości danych,
- sposób obsługi danych niepełnych,
- źródła danych dla dashboardu Power BI.

---

# 7. Warsztat integracji i API

## Cel warsztatu

Celem warsztatu było określenie, jakie komponenty systemowe uczestniczą w procesie oraz jakie integracje są potrzebne do obsługi procesu TO-BE.

## Pytania dotyczące integracji

- Jakie dane przekazuje IVR do Contact Center?
- Jak Contact Center identyfikuje klienta?
- Jak Contact Center pobiera dane klienta z CRM?
- Jak zapisywana jest historia kontaktu?
- Jak zapisywany jest callback?
- Jak aktualizowany jest status zgłoszenia?
- Jak dane trafiają do SQL?
- Jak Power BI pobiera dane?
- Czy integracje są synchroniczne czy asynchroniczne?
- Jak obsługiwane są błędy integracyjne?
- Co dzieje się, gdy CRM nie odpowiada?
- Co dzieje się, gdy zapis do SQL się nie powiedzie?

## Pytania dotyczące API

- Jakie endpointy są potrzebne do obsługi procesu TO-BE?
- Jak powinien wyglądać request dla callbacku?
- Jak powinien wyglądać response?
- Jakie statusy HTTP powinny być obsługiwane?
- Jakie błędy biznesowe mogą wystąpić?
- Czy endpoint powinien walidować numer telefonu?
- Czy endpoint powinien sprawdzać istnienie klienta?
- Czy można utworzyć drugi aktywny callback dla tej samej sprawy?
- Czy status zgłoszenia powinien mieć słownik wartości?

## Rezultat warsztatu integracyjnego

Na podstawie warsztatu opisano:

- architekturę logiczną,
- integracje między systemami,
- przykładowe endpointy REST API,
- reguły biznesowe dla API,
- standard odpowiedzi błędów,
- specyfikację OpenAPI.

---

# 8. Przykładowe decyzje podjęte na podstawie warsztatów

| Obszar | Decyzja | Uzasadnienie |
|---|---|---|
| Self-service | Proste sprawy fakturowe mogą kończyć się w IVR | Ograniczenie obciążenia konsultantów |
| Callback | Klient może wybrać oddzwonienie zamiast oczekiwania | Redukcja porzuconych połączeń |
| Tagowanie | Kategoria kontaktu jest obowiązkowa | Poprawa jakości danych i raportowania |
| SLA | Sprawy po terminie są widoczne jako alert | Szybsza reakcja lidera zespołu |
| Eskalacje | Eskalacje mają status i powód | Lepsza analiza pracy 2nd line |
| KPI | Wybrano ASA, AHT, FCR, SLA, Abandonment Rate, Callback Rate | KPI mierzą kluczowe problemy biznesowe |
| SQL | Dane procesowe są mapowane do relacyjnego modelu | Umożliwienie raportowania Power BI |
| API | Callback, klient, historia kontaktów, status zgłoszenia i KPI mają opisane endpointy | Pokazanie przepływu danych i operacji systemowych |

---

## Podsumowanie

Warsztaty analityczne pozwoliły przejść od ogólnego problemu biznesowego do konkretnych wymagań, procesu TO-BE, operacji API, modelu danych i dashboardu KPI.

Najważniejszą zasadą było powiązanie każdego elementu rozwiązania z realną potrzebą procesu:

```text
Problem → pytanie warsztatowe → wymaganie → User Story → kryterium akceptacji → dane → KPI → dashboard
```

Dzięki temu projekt pokazuje nie tylko końcowy efekt w Power BI, ale również sposób dochodzenia do rozwiązania analitycznego i systemowego.


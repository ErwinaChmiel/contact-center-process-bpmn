# Run Instructions — Contact Center Process Optimization

## Cel dokumentu

Ten dokument opisuje, jak uruchomić i przejrzeć najważniejsze elementy projektu **Contact Center Process Optimization — BPMN + SQL + Power BI**.

Instrukcja obejmuje:

- przegląd struktury projektu,
- podgląd modeli BPMN AS-IS i TO-BE,
- uruchomienie skryptów SQL,
- załadowanie danych przykładowych,
- uruchomienie zapytań KPI,
- otwarcie dashboardu Power BI,
- przegląd specyfikacji REST API i OpenAPI,
- najczęstsze problemy oraz sposoby ich rozwiązania.

Projekt ma charakter portfolio i case study, dlatego wybrane elementy można przeglądać niezależnie, bez konieczności uruchamiania pełnego środowiska produkcyjnego.

---

## Wymagania wstępne

Do pełnego przejrzenia projektu przydatne będą:

- GitHub lub lokalny klient Git,
- edytor tekstu, np. Visual Studio Code,
- Camunda Modeler lub inne narzędzie do podglądu BPMN,
- lokalna baza danych zgodna z SQL / T-SQL, np. MS SQL Server lub Azure SQL,
- SQL Server Management Studio, Azure Data Studio lub inne narzędzie SQL,
- Power BI Desktop,
- opcjonalnie Swagger Editor lub inne narzędzie do podglądu OpenAPI.

---

## 1. Pobranie projektu

Repozytorium można pobrać lokalnie za pomocą Git:

```bash
git clone https://github.com/ErwinaChmiel/contact-center-process-bpmn.git
```

Następnie przejdź do katalogu projektu:

```bash
cd contact-center-process-bpmn
```

Alternatywnie można pobrać repozytorium jako plik ZIP bezpośrednio z GitHuba:

```text
Code → Download ZIP
```

Po pobraniu projektu warto sprawdzić, czy struktura folderów odpowiada poniższemu układowi:

```text
contact-center-process-bpmn/
├── 00_project-overview/
├── 01_business-analysis/
├── 02_process-analysis/
├── 03_solution-architecture/
├── 04_data-model/
├── 05_power-bi-dashboard/
├── 06_documentation/
└── README.md
```

---

## 2. Rekomendowana kolejność przeglądania projektu

Projekt został ułożony zgodnie z logiką pracy analitycznej — od problemu biznesowego do dashboardu KPI.

Rekomendowana kolejność:

1. `README.md` — ogólny opis projektu.
2. `00_project-overview/` — kontekst, zakres i sposób czytania projektu.
3. `01_business-analysis/` — problem biznesowy, interesariusze, wymagania, User Stories i backlog.
4. `02_process-analysis/` — procesy BPMN AS-IS i TO-BE.
5. `03_solution-architecture/` — architektura logiczna, integracje, REST API i OpenAPI.
6. `04_data-model/` — model danych SQL, dane przykładowe i zapytania KPI.
7. `05_power-bi-dashboard/` — dashboard Power BI i wnioski biznesowe.
8. `06_documentation/` — podejście analityczne, słownik, macierz śladowania i instrukcje uruchomienia.

Pełna ścieżka analizy wygląda następująco:

```text
Problem biznesowy
        ↓
Wymagania
        ↓
Proces AS-IS / TO-BE
        ↓
Architektura i integracje
        ↓
OpenAPI
        ↓
Model danych SQL
        ↓
Zapytania KPI
        ↓
Dashboard Power BI
        ↓
Wnioski biznesowe
```

---

## 3. Podgląd modeli BPMN

Modele BPMN znajdują się w folderze:

```text
02_process-analysis/
```

Pliki BPMN:

```text
02_process-analysis/02_01_bpmn-as-is.bpmn
02_process-analysis/02_03_bpmn-to-be.bpmn
```

Pliki PNG z podglądem:

```text
02_process-analysis/02_02_bpmn-as-is.png
02_process-analysis/02_04_bpmn-to-be.png
```

### Jak otworzyć diagram BPMN?

1. Otwórz Camunda Modeler lub inne narzędzie obsługujące BPMN 2.0.
2. Wczytaj plik:

```text
02_process-analysis/02_01_bpmn-as-is.bpmn
```

3. Przejrzyj proces AS-IS, czyli aktualny sposób obsługi połączeń.
4. Następnie otwórz plik:

```text
02_process-analysis/02_03_bpmn-to-be.bpmn
```

5. Porównaj proces AS-IS z procesem TO-BE.

### Na co zwrócić uwagę w procesie AS-IS?

Proces AS-IS pokazuje aktualny sposób obsługi połączeń przychodzących, w którym występują m.in.:

- oczekiwanie klienta w kolejce,
- ograniczony self-service w IVR,
- brak callbacku jako alternatywy dla oczekiwania,
- eskalacje do 2nd line,
- ryzyko przekroczenia SLA,
- ograniczona informacja o przyczynach kontaktów.

### Na co zwrócić uwagę w procesie TO-BE?

Proces TO-BE pokazuje usprawniony proces docelowy, który obejmuje:

- self-service w IVR dla prostych spraw,
- callback zamiast oczekiwania w kolejce,
- tagowanie powodu kontaktu i wyniku rozmowy,
- lepsze monitorowanie SLA,
- uporządkowaną eskalację do 2nd line,
- dane przygotowane pod raportowanie KPI.

---

## 4. Uruchomienie bazy danych SQL

Skrypty SQL znajdują się w folderze:

```text
04_data-model/
```

Najważniejsze pliki:

```text
04_data-model/04_01_database-schema.sql
04_data-model/04_02_sample-data.sql
04_data-model/04_03_kpi-queries.sql
04_data-model/04_04_data-model-description.md
```

### Krok 1 — utwórz bazę danych

Utwórz lokalną bazę danych, np. w MS SQL Server lub Azure SQL.

Przykładowa nazwa bazy:

```sql
ContactCenterAnalytics
```

Przykładowe polecenie SQL:

```sql
CREATE DATABASE ContactCenterAnalytics;
GO
```

Następnie przełącz się na utworzoną bazę:

```sql
USE ContactCenterAnalytics;
GO
```

---

### Krok 2 — uruchom schemat bazy

Uruchom skrypt:

```text
04_data-model/04_01_database-schema.sql
```

Ten skrypt tworzy strukturę tabel potrzebnych do analizy procesu Contact Center.

Model danych obejmuje między innymi obszary:

- `calls` — połączenia przychodzące,
- `cases` — zgłoszenia / sprawy,
- `contacts` — kontakty klienta z Contact Center,
- `agents` — konsultanci,
- `customers` — klienci,
- `callbacks` — oddzwonienia,
- `sla_events` — zdarzenia SLA.

Po wykonaniu skryptu sprawdź, czy tabele zostały utworzone poprawnie.

Przykładowe sprawdzenie:

```sql
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';
```

---

### Krok 3 — załaduj dane przykładowe

Następnie uruchom skrypt:

```text
04_data-model/04_02_sample-data.sql
```

Dane przykładowe obejmują scenariusze biznesowe takie jak:

- self-service w IVR,
- sprawa rozwiązana przy pierwszym kontakcie,
- eskalacja do 2nd line,
- porzucone połączenie,
- callback,
- sprawa po SLA.

Po załadowaniu danych możesz sprawdzić przykładową liczbę rekordów w tabelach:

```sql
SELECT COUNT(*) AS calls_count FROM calls;
SELECT COUNT(*) AS cases_count FROM cases;
SELECT COUNT(*) AS contacts_count FROM contacts;
SELECT COUNT(*) AS agents_count FROM agents;
SELECT COUNT(*) AS customers_count FROM customers;
```

Jeśli w modelu znajdują się dodatkowe tabele, np. `callbacks` lub `sla_events`, sprawdź je analogicznie:

```sql
SELECT COUNT(*) AS callbacks_count FROM callbacks;
SELECT COUNT(*) AS sla_events_count FROM sla_events;
```

---

### Krok 4 — uruchom zapytania KPI

Po utworzeniu schematu i załadowaniu danych uruchom skrypt:

```text
04_data-model/04_03_kpi-queries.sql
```

Zapytania KPI służą do wyliczenia wskaźników takich jak:

- ASA — Average Speed of Answer,
- AHT — Average Handle Time,
- FCR — First Contact Resolution,
- SLA Rate,
- Abandonment Rate,
- Self-service Rate,
- Callback Rate,
- Callback Realization Rate,
- Escalation Rate.

Wyniki zapytań można wykorzystać do walidacji danych oraz do porównania z dashboardem Power BI.

---

## 5. Otwarcie dashboardu Power BI

Dashboard znajduje się w folderze:

```text
05_power-bi-dashboard/
```

Najważniejsze pliki:

```text
05_power-bi-dashboard/05_01_contact-center-kpis-dashboard.pbix
05_power-bi-dashboard/05_02_dashboard-overview.png
05_power-bi-dashboard/05_03_dashboard-data-model.png
05_power-bi-dashboard/05_04_dashboard-business-insights.md
```

### Jak otworzyć dashboard?

1. Otwórz Power BI Desktop.
2. Otwórz plik:

```text
05_power-bi-dashboard/05_01_contact-center-kpis-dashboard.pbix
```

3. Sprawdź źródło danych.
4. Jeśli połączenie wskazuje na inną bazę lub inny serwer, zaktualizuj ustawienia źródła danych.
5. Połącz raport z lokalną bazą danych.
6. Odśwież dane.
7. Przejrzyj strony dashboardu.

### Co pokazuje dashboard?

Dashboard prezentuje między innymi:

- Executive KPI Overview,
- Call Flow Analysis,
- SLA Analysis,
- FCR Analysis,
- Callback Analysis,
- Operational Analytics,
- Segmentation & Agents Analysis,
- Alerts & Exceptions.

Dashboard wspiera analizę:

- obciążenia infolinii,
- efektywności konsultantów,
- poziomu SLA,
- poziomu FCR,
- porzuconych połączeń,
- callbacków,
- self-service,
- eskalacji do 2nd line.

---

## 6. Podgląd dashboardu bez Power BI

Jeśli nie chcesz otwierać pliku `.pbix`, możesz przejrzeć zrzuty ekranu dashboardu.

Podgląd dashboardu:

```text
05_power-bi-dashboard/05_02_dashboard-overview.png
```

Podgląd modelu danych dashboardu:

```text
05_power-bi-dashboard/05_03_dashboard-data-model.png
```

Wnioski biznesowe z dashboardu znajdują się w pliku:

```text
05_power-bi-dashboard/05_04_dashboard-business-insights.md
```

---

## 7. Podgląd specyfikacji REST API i OpenAPI

Dokumentacja architektury i integracji znajduje się w folderze:

```text
03_solution-architecture/
```

Najważniejsze pliki:

```text
03_solution-architecture/03_01_architecture.md
03_solution-architecture/03_02_integrations.md
03_solution-architecture/03_03_api-specification.md
03_solution-architecture/03_04_openapi.yaml
```

Plik:

```text
03_solution-architecture/03_04_openapi.yaml
```

zawiera przykładową specyfikację OpenAPI 3.0 dla wybranych endpointów.

Przykładowe endpointy:

```text
POST /api/v1/callbacks
GET /api/v1/customers/{customerId}
GET /api/v1/customers/{customerId}/contacts
PUT /api/v1/tickets/{ticketId}/status
GET /api/v1/kpi/contact-center
```

### Jak podejrzeć OpenAPI?

1. Otwórz Swagger Editor lub inne narzędzie obsługujące OpenAPI.
2. Wgraj plik:

```text
03_solution-architecture/03_04_openapi.yaml
```

3. Sprawdź endpointy, requesty, response’y i schematy danych.
4. Zweryfikuj, jak API wspiera proces TO-BE.

---

## 8. Przegląd dokumentacji analitycznej

Dokumentacja analityczna znajduje się w folderach:

```text
00_project-overview/
01_business-analysis/
06_documentation/
```

### Project overview

```text
00_project-overview/00_01_project-context.md
00_project-overview/00_02_how-to-read-this-project.md
00_project-overview/00_03_scope-and-assumptions.md
00_project-overview/00_04_requirements-workshops.md
```

### Business analysis

```text
01_business-analysis/01_01_business-problem.md
01_business-analysis/01_02_stakeholder-analysis.md
01_business-analysis/01_03_requirements.md
01_business-analysis/01_04_user-stories.md
01_business-analysis/01_05_acceptance-criteria.md
01_business-analysis/01_06_backlog.md
```

### Documentation

```text
06_documentation/06_01_analytical-approach.md
06_documentation/06_02_glossary.md
06_documentation/06_03_traceability-matrix.md
06_documentation/06_04_run-instructions.md
```

Szczególnie warto sprawdzić:

- `06_01_analytical-approach.md` — opis podejścia analitycznego,
- `06_02_glossary.md` — słownik pojęć,
- `06_03_traceability-matrix.md` — powiązanie problemów, wymagań, User Stories, procesu, danych i KPI,
- `06_04_run-instructions.md` — instrukcja uruchomienia projektu.

---

## 9. Oczekiwany rezultat po uruchomieniu

Po przejściu przez projekt użytkownik powinien móc:

- zrozumieć problem biznesowy Contact Center,
- porównać proces AS-IS i TO-BE,
- prześledzić wymagania oraz User Stories,
- zrozumieć logikę architektury rozwiązania,
- sprawdzić przykładową specyfikację REST API / OpenAPI,
- uruchomić model danych SQL,
- załadować dane przykładowe,
- wyliczyć kluczowe KPI,
- otworzyć dashboard Power BI,
- przeanalizować wnioski biznesowe z danych.

---

## 10. Najczęstsze problemy i rozwiązania

### Problem: brak połączenia Power BI z bazą danych

Możliwe przyczyny:

- inna nazwa serwera,
- inna nazwa bazy danych,
- brak dostępu do lokalnej instancji SQL,
- nieprawidłowy tryb uwierzytelniania.

Rozwiązanie:

- sprawdź nazwę serwera,
- sprawdź nazwę bazy danych,
- sprawdź konfigurację źródła danych w Power BI,
- zaktualizuj połączenie w Power BI Desktop,
- odśwież dane.

---

### Problem: brak danych w dashboardzie

Możliwe przyczyny:

- nie uruchomiono skryptu tworzącego strukturę bazy,
- nie załadowano danych przykładowych,
- Power BI wskazuje na pustą lub inną bazę danych.

Rozwiązanie:

1. Uruchom:

```text
04_data-model/04_01_database-schema.sql
```

2. Następnie uruchom:

```text
04_data-model/04_02_sample-data.sql
```

3. Odśwież dane w Power BI.

---

### Problem: zapytania KPI zwracają błąd

Możliwe przyczyny:

- brak tabel,
- brak danych,
- zmienione nazwy kolumn,
- nieuruchomiony skrypt schematu.

Rozwiązanie:

- sprawdź, czy tabele zostały utworzone,
- sprawdź, czy dane przykładowe zostały załadowane,
- sprawdź, czy nazwy tabel i kolumn są zgodne ze schematem bazy,
- uruchom zapytanie diagnostyczne:

```sql
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';
```

---

### Problem: OpenAPI nie otwiera się w Swagger Editor

Możliwe przyczyny:

- niepoprawne wcięcia YAML,
- nieprawidłowe rozszerzenie pliku,
- brak wymaganej pierwszej linii specyfikacji.

Rozwiązanie:

- upewnij się, że plik ma rozszerzenie `.yaml`,
- sprawdź, czy pierwsza linia to:

```yaml
openapi: 3.0.3
```

- sprawdź wcięcia,
- ponownie wklej plik do Swagger Editor.

---

### Problem: diagram BPMN nie otwiera się

Możliwe przyczyny:

- plik został pobrany niepoprawnie,
- narzędzie nie obsługuje BPMN 2.0,
- plik został otwarty jako zwykły tekst.

Rozwiązanie:

- otwórz plik w Camunda Modeler,
- upewnij się, że plik ma rozszerzenie `.bpmn`,
- jeśli model nie otwiera się poprawnie, skorzystaj z podglądu PNG.

---

## 11. Charakter projektu

Projekt ma charakter portfolio i case study.

Nie jest to pełna implementacja produkcyjna systemu Contact Center. Projekt pokazuje sposób pracy analitycznej i projektowej obejmujący:

- analizę biznesową,
- analizę procesową,
- modelowanie BPMN,
- projektowanie architektury logicznej,
- dokumentację API,
- specyfikację OpenAPI,
- modelowanie danych,
- SQL,
- KPI,
- Power BI.

---

## 12. Podsumowanie

Projekt można uruchamiać warstwowo:

```text
BPMN → SQL → KPI queries → Power BI
```

Pełna wartość projektu widoczna jest jednak wtedy, gdy przejdzie się całą ścieżkę:

```text
Problem biznesowy → wymagania → proces AS-IS / TO-BE → architektura → API → dane → KPI → dashboard
```

Takie podejście pokazuje, w jaki sposób analiza biznesowa, analiza systemowa i analiza danych łączą się w jednym kompletnym case study.
```



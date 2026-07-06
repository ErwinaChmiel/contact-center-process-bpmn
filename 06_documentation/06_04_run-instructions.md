# Run Instructions — Contact Center Process Optimization

## Cel dokumentu

Ten dokument opisuje, jak uruchomić i przejrzeć najważniejsze elementy projektu **Contact Center Process Optimization — BPMN + SQL + Power BI**.

Projekt ma charakter portfolio / case study, dlatego wybrane elementy można przeglądać niezależnie, bez konieczności uruchamiania pełnego środowiska produkcyjnego.

---

## Wymagania wstępne

Do pełnego przejrzenia projektu przydatne będą:

- Git lub dostęp do GitHuba,
- Visual Studio Code lub inny edytor tekstu,
- Camunda Modeler lub inne narzędzie do podglądu BPMN 2.0,
- MS SQL Server / Azure SQL albo inne środowisko zgodne z użytym SQL,
- SQL Server Management Studio, Azure Data Studio lub inne narzędzie SQL,
- Power BI Desktop,
- Swagger Editor, Redocly lub inne narzędzie do podglądu OpenAPI.

---

## 1. Pobranie projektu

```bash
git clone https://github.com/ErwinaChmiel/contact-center-process.git
cd contact-center-process
```

Alternatywnie można pobrać repozytorium jako ZIP przez GitHub:

```text
Code → Download ZIP
```

---

## 2. Rekomendowana kolejność przeglądania

1. `README.md` — ogólny opis projektu.
2. `00_project-overview/` — kontekst, zakres i sposób czytania projektu.
3. `01_business-analysis/` — problem biznesowy, interesariusze, wymagania, User Stories i backlog.
4. `02_process-analysis/` — procesy BPMN AS-IS i TO-BE.
5. `03_solution-architecture/` — architektura logiczna, integracje, REST API i OpenAPI.
6. `04_data-model/` — model danych SQL, dane przykładowe i zapytania KPI.
7. `05_power-bi-dashboard/` — dashboard Power BI, screenshoty, DAX i model semantyczny.
8. `06_documentation/` — podejście analityczne, słownik, traceability matrix, instrukcje i data governance.

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

Jak otworzyć diagram BPMN:

1. Otwórz Camunda Modeler albo inne narzędzie obsługujące BPMN 2.0.
2. Wczytaj `02_01_bpmn-as-is.bpmn`.
3. Następnie wczytaj `02_03_bpmn-to-be.bpmn`.
4. Porównaj proces AS-IS z procesem TO-BE.

---

## 4. Uruchomienie bazy danych SQL

Skrypty SQL znajdują się w folderze:

```text
04_data-model/
```

Najważniejsze pliki:

```text
04_01_database-schema.sql
04_02_sample-data.sql
04_03_kpi-queries.sql
04_04_data-model-description.md
```

Rekomendowana kolejność:

```sql
-- 1. Utwórz bazę
CREATE DATABASE ContactCenterAnalytics;
GO

-- 2. Przełącz się na bazę
USE ContactCenterAnalytics;
GO
```

Następnie uruchom kolejno:

1. `04_data-model/04_01_database-schema.sql` — tworzy tabele i relacje.
2. `04_data-model/04_02_sample-data.sql` — ładuje dane syntetyczne.
3. `04_data-model/04_03_kpi-queries.sql` — uruchamia zapytania KPI.

Model powinien obejmować m.in. tabele:

```text
customers
agents
calls
cases
contacts
callbacks
sla_events
```

---

## 5. Podgląd REST API i OpenAPI

Dokumentacja API znajduje się w folderze:

```text
03_solution-architecture/
```

Pliki:

```text
03_03_api-specification.md
03_04_openapi.yaml
03_05_api-governance-notes.md
```

Jak sprawdzić OpenAPI:

1. Otwórz Swagger Editor albo inne narzędzie obsługujące OpenAPI 3.0.
2. Wczytaj plik `03_solution-architecture/03_04_openapi.yaml`.
3. Sprawdź endpointy dla `customers`, `contacts`, `cases`, `callbacks`, `sla-events` i KPI.

Kluczowa zasada nazewnicza: dokumentacja API używa nazwy `case`, nie `ticket`, aby zachować spójność z modelem SQL.

---

## 6. Otwarcie dashboardu Power BI

Plik Power BI znajduje się tutaj:

```text
05_power-bi-dashboard/05_01_contact-center-kpis-dashboard.pbix
```

Podglądy stron dashboardu:

```text
05_02_dashboard-overview.png
05_03_call-flow-sla-fcr-callback.png
05_04_operational-analytics.png
05_05_segments-and-agents-analysis.png
05_06_alerts-and-exceptions.png
```

Dokumentacja dashboardu:

```text
05_07_dashboard-kpi-pages.md
05_08_dashboard-business-insights.md
```

Miary DAX:

```text
05_power-bi-dashboard/dax/
```

Model semantyczny:

```text
05_power-bi-dashboard/semantic-model/
```

---

## 7. Traceability i governance

Dodatkowa dokumentacja znajduje się w folderze:

```text
06_documentation/
```

Najważniejsze pliki:

```text
06_01_analytical-approach.md
06_02_glossary.md
06_03_traceability-matrix.md
06_04_run-instructions.md
06_05_security-and-data-governance.md
```

Szczególnie warto sprawdzić:

- `06_03_traceability-matrix.md` — powiązanie problemów, wymagań, BPMN, API, SQL, KPI i Power BI,
- `06_05_security-and-data-governance.md` — założenia dotyczące danych syntetycznych, RODO/GDPR, maskowania i retencji.

---

## 8. Najczęstsze problemy

| Problem | Możliwa przyczyna | Rozwiązanie |
|---|---|---|
| BPMN nie otwiera się w modelerze | Otwierany jest plik ZIP lub stara kopia | Użyj plików `.bpmn`: `02_01_bpmn-as-is.bpmn`, `02_03_bpmn-to-be.bpmn` |
| Link w README nie działa | Nazwa pliku nie zgadza się ze strukturą repo | Sprawdź aktualne nazwy w drzewie repozytorium |
| Power BI nie odświeża danych | Brak lokalnej bazy lub inna ścieżka połączenia | Załaduj dane SQL lokalnie i zaktualizuj źródło w Power BI |
| OpenAPI nie parsuje się | Wklejono Markdown zamiast YAML | Wczytaj `03_04_openapi.yaml` |
| API mówi o `ticket` | Stara wersja dokumentacji | Użyj wersji z nazwą `case` zgodną z SQL |

---

## 9. Charakter danych

Dane w projekcie są syntetyczne i przygotowane wyłącznie na potrzeby portfolio. Repozytorium nie powinno zawierać danych produkcyjnych ani danych osobowych klientów.

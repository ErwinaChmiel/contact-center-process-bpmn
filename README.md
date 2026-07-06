# Contact Center Process Optimization — BPMN + SQL + Power BI

> Portfolio project showing a full business, process, system, data and BI analysis case study for a Contact Center process.

![Business Analysis](https://img.shields.io/badge/Business%20Analysis-Requirements-blue)
![BPMN](https://img.shields.io/badge/BPMN-AS--IS%20%7C%20TO--BE-green)
![SQL](https://img.shields.io/badge/SQL-Data%20Model-orange)
![API](https://img.shields.io/badge/API-OpenAPI%203.0-lightgrey)
![Power BI](https://img.shields.io/badge/Power%20BI-KPI%20Dashboard-yellow)
![Portfolio](https://img.shields.io/badge/Portfolio-Business%20%7C%20BI%20Analyst-purple)

---

## O projekcie

Projekt przedstawia kompletne case study optymalizacji procesu obsługi połączeń przychodzących w Contact Center.

Celem projektu jest pokazanie pełnego toku pracy analitycznej — od identyfikacji problemu biznesowego, przez analizę wymagań i modelowanie procesu BPMN AS-IS / TO-BE, aż po zaprojektowanie architektury logicznej, integracji, specyfikacji API, modelu danych SQL oraz dashboardu KPI w Power BI.

Projekt został przygotowany jako portfolio analityczki biznesowo-systemowej i BI, pokazujące pracę na styku:

- biznesu,
- procesów,
- systemów,
- danych,
- SQL,
- REST API,
- OpenAPI,
- raportowania KPI,
- Power BI.

---

## Cel projektu

Celem projektu jest zaprezentowanie, w jaki sposób można przejść od problemów operacyjnych w Contact Center do uporządkowanego rozwiązania analityczno-systemowego.

Projekt obejmuje:

- analizę problemu biznesowego,
- analizę interesariuszy,
- inżynierię wymagań,
- User Stories i kryteria akceptacji,
- backlog produktu,
- modelowanie procesu BPMN AS-IS i TO-BE,
- opis architektury logicznej rozwiązania,
- analizę integracji między systemami,
- przykładową specyfikację REST API,
- plik OpenAPI zgodny ze standardem OpenAPI 3.0,
- projekt relacyjnego modelu danych SQL,
- dane przykładowe,
- zapytania SQL dla KPI,
- dashboard operacyjny w Power BI,
- analizę KPI: FCR, SLA, AHT, ASA, Abandonment Rate, Callback Rate, Self-service Rate.

---

## Zakres biznesowy

Projekt dotyczy procesu obsługi połączeń przychodzących w Contact Center.

W analizie uwzględniono:

- obsługę połączeń przez IVR,
- klasyfikację tematu kontaktu,
- obsługę przez konsultanta 1st line,
- eskalację do 2nd line / back-office,
- samoobsługę w IVR,
- callback jako alternatywę dla oczekiwania w kolejce,
- monitorowanie SLA,
- oznaczanie przyczyny kontaktu i wyniku rozmowy,
- przygotowanie danych pod raportowanie KPI.

---

## Główne problemy biznesowe

W procesie AS-IS zidentyfikowano następujące problemy:

- długi czas oczekiwania klientów na połączenie,
- wysoki poziom porzuconych połączeń,
- ograniczony zakres samoobsługi w IVR,
- brak callbacku jako alternatywy dla oczekiwania w kolejce,
- niewystarczającą kontrolę SLA,
- ograniczoną analizę przyczyn kontaktu,
- brak pełnej widoczności KPI operacyjnych,
- utrudnione monitorowanie efektywności konsultantów,
- brak spójnego modelu danych do raportowania.

Proces TO-BE odpowiada na te problemy poprzez:

- self-service w IVR dla prostych spraw,
- callback dla klientów oczekujących w kolejce,
- tagowanie przyczyn kontaktu i wyniku rozmowy,
- lepsze monitorowanie SLA,
- sprawniejszą eskalację do 2nd line,
- przygotowanie danych do raportowania KPI,
- uporządkowany model danych SQL,
- dashboard Power BI dla liderów i menedżerów.

---

## Pytania biznesowe, na które odpowiada projekt

Dashboard i dokumentacja analityczna odpowiadają m.in. na pytania:

- W których godzinach Contact Center ma największe obciążenie?
- Jaki jest poziom FCR i SLA dla całego procesu oraz poszczególnych zespołów?
- Które typy spraw najczęściej wymagają eskalacji do 2nd line?
- Ilu klientów korzysta z self-service w IVR?
- Ilu klientów wybiera callback zamiast oczekiwania w kolejce?
- Czy callbacki są realizowane terminowo?
- Którzy konsultanci mają podwyższony AHT lub niższy FCR?
- Ile spraw przekroczyło SLA?
- Jakie kategorie kontaktu generują największe obciążenie?
- Jakie usprawnienia mogą zmniejszyć liczbę porzuconych połączeń?

---

## Logika projektu

Projekt został uporządkowany zgodnie z naturalną kolejnością pracy analitycznej:

```text
Problem biznesowy
        ↓
Interesariusze i potrzeby
        ↓
Wymagania biznesowe, funkcjonalne i niefunkcjonalne
        ↓
User Stories i kryteria akceptacji
        ↓
Backlog produktu
        ↓
Proces AS-IS i TO-BE w BPMN
        ↓
Architektura logiczna rozwiązania
        ↓
Integracje i REST API
        ↓
Specyfikacja OpenAPI
        ↓
Model danych SQL
        ↓
Dane przykładowe
        ↓
Zapytania KPI
        ↓
Dashboard Power BI
        ↓
Wnioski biznesowe i rekomendacje
```

Dzięki temu repozytorium pokazuje nie tylko końcowy dashboard, ale cały proces dochodzenia do rozwiązania.

---

## Struktura repozytorium

Projekt został podzielony na ponumerowane foldery, aby pokazać kolejność pracy analitycznej.

```text
contact-center-process-bpmn/
│
├── 00_project-overview/
│   ├── 00_01_project-context.md
│   ├── 00_02_how-to-read-this-project.md
│   ├── 00_03_scope-and-assumptions.md
│   └── 00_04_requirements-workshops.md
│
├── 01_business-analysis/
│   ├── 01_01_business-problem.md
│   ├── 01_02_stakeholder-analysis.md
│   ├── 01_03_requirements.md
│   ├── 01_04_user-stories.md
│   ├── 01_05_acceptance-criteria.md
│   └── 01_06_backlog.md
│
├── 02_process-analysis/
│   ├── 02_01_bpmn-as-is.bpmn
│   ├── 02_02_bpmn-as-is.png
│   ├── 02_03_bpmn-to-be.bpmn
│   ├── 02_04_bpmn-to-be.png
│   ├── 02_05_as-is-process-description.md
│   └── 02_06_to-be-process-description.md
│
├── 03_solution-architecture/
│   ├── 03_01_architecture.md
│   ├── 03_02_integrations.md
│   ├── 03_03_api-specification.md
│   └── 03_04_openapi.yaml
│
├── 04_data-model/
│   ├── 04_01_database-schema.sql
│   ├── 04_02_sample-data.sql
│   ├── 04_03_kpi-queries.sql
│   └── 04_04_data-model-description.md
│
├── 05_power-bi-dashboard/
│   ├── 05_01_contact-center-kpis-dashboard.pbix
│   ├── 05_02_dashboard-overview.png
│   ├── 05_03_dashboard-data-model.png
│   └── 05_04_dashboard-business-insights.md
│
├── 06_documentation/
│   ├── 06_01_analytical-approach.md
│   ├── 06_02_glossary.md
│   ├── 06_03_traceability-matrix.md
│   └── 06_04_run-instructions.md
│
└── README.md
```

---

## Jak czytać projekt?

Projekt został ułożony tak, aby pokazać pełną ścieżkę pracy analitycznej — od problemu biznesowego do dashboardu KPI.

Rekomendowana kolejność czytania:

1. Zacznij od `README.md`, aby zrozumieć cel projektu, zakres i strukturę repozytorium.

2. Przejdź do `00_project-overview/`, aby poznać kontekst projektu, założenia oraz sposób czytania repozytorium.

3. Następnie otwórz `01_business-analysis/`, gdzie znajdują się:
   - problem biznesowy,
   - interesariusze,
   - wymagania,
   - User Stories,
   - kryteria akceptacji,
   - backlog produktu.

4. Przejdź do `02_process-analysis/`, aby porównać proces:
   - AS-IS — stan obecny,
   - TO-BE — proces docelowy po usprawnieniach.

5. Sprawdź `03_solution-architecture/`, aby zobaczyć:
   - architekturę logiczną rozwiązania,
   - integracje między systemami,
   - przykładową specyfikację REST API,
   - plik OpenAPI `03_04_openapi.yaml`.

6. Przejdź do `04_data-model/`, aby zobaczyć:
   - schemat bazy danych,
   - dane przykładowe,
   - zapytania SQL liczące KPI,
   - opis modelu danych.

7. Otwórz `05_power-bi-dashboard/`, aby zobaczyć:
   - plik Power BI,
   - podgląd dashboardu,
   - opis wniosków biznesowych.

8. Na końcu sprawdź `06_documentation/`, gdzie znajdują się:
   - podejście analityczne,
   - słownik pojęć,
   - macierz śladowania wymagań,
   - instrukcje uruchomienia projektu.

W ten sposób można prześledzić pełny tok analizy:

```text
Problem biznesowy → wymagania → proces BPMN → architektura → API → SQL → KPI → Power BI
```

---

## Najważniejsze artefakty

| Obszar | Plik |
|---|---|
| Kontekst projektu | `00_project-overview/00_01_project-context.md` |
| Instrukcja czytania projektu | `00_project-overview/00_02_how-to-read-this-project.md` |
| Zakres i założenia | `00_project-overview/00_03_scope-and-assumptions.md` |
| Warsztaty wymagań | `00_project-overview/00_04_requirements-workshops.md` |
| Problem biznesowy | `01_business-analysis/01_01_business-problem.md` |
| Analiza interesariuszy | `01_business-analysis/01_02_stakeholder-analysis.md` |
| Wymagania | `01_business-analysis/01_03_requirements.md` |
| User Stories | `01_business-analysis/01_04_user-stories.md` |
| Kryteria akceptacji | `01_business-analysis/01_05_acceptance-criteria.md` |
| Backlog | `01_business-analysis/01_06_backlog.md` |
| Proces AS-IS BPMN | `02_process-analysis/02_01_bpmn-as-is.bpmn` |
| Proces TO-BE BPMN | `02_process-analysis/02_03_bpmn-to-be.bpmn` |
| Podgląd AS-IS | `02_process-analysis/02_02_bpmn-as-is.png` |
| Podgląd TO-BE | `02_process-analysis/02_04_bpmn-to-be.png` |
| Opis procesu AS-IS | `02_process-analysis/02_05_as-is-process-description.md` |
| Opis procesu TO-BE | `02_process-analysis/02_06_to-be-process-description.md` |
| Architektura logiczna | `03_solution-architecture/03_01_architecture.md` |
| Integracje | `03_solution-architecture/03_02_integrations.md` |
| REST API | `03_solution-architecture/03_03_api-specification.md` |
| OpenAPI | `03_solution-architecture/03_04_openapi.yaml` |
| Model danych SQL | `04_data-model/04_01_database-schema.sql` |
| Dane przykładowe | `04_data-model/04_02_sample-data.sql` |
| Zapytania KPI | `04_data-model/04_03_kpi-queries.sql` |
| Opis modelu danych | `04_data-model/04_04_data-model-description.md` |
| Dashboard Power BI | `05_power-bi-dashboard/05_01_contact-center-kpis-dashboard.pbix` |
| Podgląd dashboardu | `05_power-bi-dashboard/05_02_dashboard-overview.png` |
| Wnioski biznesowe z dashboardu | `05_power-bi-dashboard/05_04_dashboard-business-insights.md` |
| Macierz śladowania | `06_documentation/06_03_traceability-matrix.md` |

---

## 01. Business Analysis

Folder `01_business-analysis/` zawiera dokumenty opisujące warstwę biznesową projektu.

Zawartość:

- `01_01_business-problem.md` — analiza problemu biznesowego,
- `01_02_stakeholder-analysis.md` — analiza interesariuszy,
- `01_03_requirements.md` — wymagania biznesowe, funkcjonalne i niefunkcjonalne,
- `01_04_user-stories.md` — User Stories,
- `01_05_acceptance-criteria.md` — kryteria akceptacji,
- `01_06_backlog.md` — backlog produktu.

Ta część pokazuje, dlaczego projekt jest potrzebny, jakie problemy rozwiązuje i jakie wymagania wynikają z procesu Contact Center.

---

## 02. Process Analysis — BPMN AS-IS / TO-BE

Folder `02_process-analysis/` zawiera modele procesu w notacji BPMN 2.0.

Proces został zamodelowany w dwóch wariantach:

### AS-IS

Stan obecny procesu:

- klient dzwoni na infolinię,
- połączenie trafia do IVR,
- klient wybiera temat sprawy,
- połączenie jest kierowane do konsultanta 1st line,
- trudniejsze sprawy są eskalowane do 2nd line / back-office,
- występują kolejki, porzucone połączenia i ograniczone dane o przyczynach kontaktu.

### TO-BE

Proces docelowy po usprawnieniach:

- self-service w IVR dla prostych spraw,
- callback zamiast oczekiwania w kolejce,
- tagowanie powodu kontaktu i wyniku rozmowy,
- lepsze monitorowanie SLA,
- sprawniejsza eskalacja do 2nd line,
- dane przygotowane pod KPI i raportowanie.

### Podgląd procesu AS-IS

02_process-analysis/02_02_bpmn-as-is.png

02_process-analysis/02_02_bpmn-as-is.png

### Podgląd procesu TO-BE

02_process-analysis/02_04_bpmn-to-be.png

02_process-analysis/02_04_bpmn-to-be.png

---

## 03. Solution Architecture

Folder `03_solution-architecture/` opisuje warstwę systemową projektu.

Zawartość:

- `03_01_architecture.md` — architektura logiczna rozwiązania,
- `03_02_integrations.md` — analiza integracji i przepływu danych,
- `03_03_api-specification.md` — przykładowa specyfikacja REST API,
- `03_04_openapi.yaml` — przykładowa specyfikacja OpenAPI 3.0.

Ta część pokazuje, jak proces biznesowy może zostać przełożony na komponenty systemowe, dane i integracje.

Uwzględnione komponenty:

- IVR,
- Contact Center,
- CRM,
- Back Office / 2nd Line,
- SQL Database,
- REST API Layer,
- Power BI.

---

## 04. Data Model — SQL

Folder `04_data-model/` zawiera model danych oraz skrypty SQL.

Model danych został zaprojektowany tak, aby umożliwić analizę operacyjną Contact Center oraz wyliczenie KPI.

Główne obszary danych:

- `calls` — połączenia przychodzące,
- `cases` — zgłoszenia / sprawy,
- `contacts` — kontakty z konsultantem,
- `agents` — konsultanci,
- `customers` — klienci,
- `callbacks` — oddzwonienia,
- `sla_events` — zdarzenia SLA.

Dane przykładowe odzwierciedlają scenariusze biznesowe, takie jak:

- self-service w IVR,
- FCR na 1st line,
- eskalacja do 2nd line,
- porzucone połączenie,
- callback,
- sprawy po SLA.

---

## 05. Power BI Dashboard

Folder `05_power-bi-dashboard/` zawiera raport Power BI oraz opis wniosków biznesowych.

Dashboard prezentuje m.in.:

- Executive KPI Overview,
- Call Flow / SLA / FCR / Callback Analysis,
- Operational Analytics,
- Segmentation & Agents Analysis,
- Alerts & Exceptions.

Dashboard został przygotowany jako narzędzie wspierające pracę liderów i menedżerów Contact Center.

### Podgląd dashboardu

05_power-bi-dashboard/05_02_dashboard-overview.png

05_power-bi-dashboard/05_02_dashboard-overview.png

---

## KPI analizowane w projekcie

| KPI | Znaczenie |
|---|---|
| ASA | Average Speed of Answer — średni czas oczekiwania na odpowiedź |
| AHT | Average Handle Time — średni czas obsługi połączenia |
| FCR | First Contact Resolution — odsetek spraw rozwiązanych przy pierwszym kontakcie |
| SLA Rate | Odsetek spraw obsłużonych w wymaganym czasie |
| Abandonment Rate | Odsetek połączeń porzuconych przez klientów |
| Self-service Rate | Odsetek spraw obsłużonych automatycznie w IVR |
| Callback Rate | Odsetek klientów wybierających callback |
| Callback Realization Rate | Odsetek zrealizowanych callbacków |
| Escalation Rate | Odsetek spraw przekazanych do 2nd line |

---

## Przykładowe decyzje wspierane przez dashboard

| Obserwacja | Możliwa decyzja |
|---|---|
| Wysokie ASA w określonych godzinach | Zmiana grafików lub zwiększenie obsady |
| Wysoki Abandonment Rate | Promowanie callbacku lub analiza kolejek |
| Niski FCR | Analiza jakości obsługi i powodów eskalacji |
| Wysoki AHT | Analiza kategorii spraw i potrzeb szkoleniowych |
| Sprawy po SLA | Priorytetyzacja zaległych zgłoszeń |
| Niski Self-service Rate | Rozbudowa IVR lub automatyzacji |
| Niezrealizowane callbacki | Monitoring procesu oddzwonień |

---

## Jak uruchomić projekt

1. Utwórz lokalną bazę danych, np. w MS SQL Server lub Azure SQL.

2. Uruchom skrypt tworzący strukturę bazy:

```text
04_data-model/04_01_database-schema.sql
```

3. Załaduj dane przykładowe:

```text
04_data-model/04_02_sample-data.sql
```

4. Opcjonalnie uruchom zapytania KPI:

```text
04_data-model/04_03_kpi-queries.sql
```

5. Otwórz Power BI Desktop.

6. Połącz raport z lokalną bazą danych.

7. Otwórz plik:

```text
05_power-bi-dashboard/05_01_contact-center-kpis-dashboard.pbix
```

8. Odśwież dane w Power BI.

---

## Narzędzia i technologie

- BPMN 2.0,
- Camunda Web Modeler,
- SQL / T-SQL,
- Power BI,
- REST API,
- OpenAPI 3.0,
- Markdown,
- GitHub.

---

## Charakter projektu

Projekt ma charakter portfolio i case study.

Nie przedstawia pełnej implementacji produkcyjnej systemu Contact Center, ale pokazuje sposób pracy analitycznej obejmujący:

- analizę biznesową,
- analizę procesową,
- analizę systemową,
- analizę danych,
- projektowanie KPI,
- SQL,
- REST API,
- OpenAPI,
- Power BI.

---

## Najważniejsza wartość projektu

Projekt pokazuje pełne przejście:

```text
Problem biznesowy → wymagania → proces TO-BE → architektura → API → dane SQL → KPI → dashboard Power BI
```

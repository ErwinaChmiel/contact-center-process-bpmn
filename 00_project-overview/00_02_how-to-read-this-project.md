# Jak czytać ten projekt

## Cel dokumentu

Dokument wyjaśnia rekomendowaną kolejność czytania projektu oraz logikę podziału repozytorium na foldery.

Projekt został uporządkowany tak, aby pokazać pełną ścieżkę pracy analitycznej — od problemu biznesowego do dashboardu KPI.

---

## Rekomendowana kolejność czytania

### 1. Kontekst projektu

Folder:

```text
00_project-overview/
```

Cel:

- zrozumienie, czego dotyczy projekt,
- poznanie zakresu biznesowego,
- zrozumienie, jak czytać repozytorium.

---

### 2. Analiza biznesowa

Folder:

```text
01_business-analysis/
```

Cel:

- zrozumienie problemu biznesowego,
- identyfikacja interesariuszy,
- analiza wymagań,
- opis User Stories,
- zdefiniowanie kryteriów akceptacji,
- uporządkowanie zakresu w backlogu.

Rekomendowana kolejność plików:

---

### 3. Analiza procesu

Folder:

```text
02_process-analysis/
```

Cel:

- zrozumienie procesu AS-IS,
- identyfikacja problemów w obecnym przebiegu,
- analiza procesu TO-BE,
- pokazanie usprawnień takich jak self-service, callback i lepsze tagowanie.

---

### 4. Architektura rozwiązania

Folder:

```text
03_solution-architecture/
```

Cel:

- pokazanie komponentów rozwiązania,
- opis przepływu danych,
- analiza integracji,
- przykładowa specyfikacja REST API.

Rekomendowana kolejność plików:

```text
03_01_architecture.md
03_02_integrations.md
03_03_api-specification.md
```

---

### 5. Model danych

Folder:

```text
04_data-model/
```

Cel:

- pokazanie, jakie dane są potrzebne do analizy procesu,
- opis struktury bazy SQL,
- przygotowanie danych przykładowych,
- umożliwienie wyliczenia KPI.

---

### 6. Dashboard Power BI

Folder:

```text
05_power-bi-dashboard/
```

Cel:

- pokazanie warstwy raportowej,
- analiza KPI,
- prezentacja wniosków biznesowych,
- monitorowanie wyjątków operacyjnych.

---

### 7. Dokumentacja uzupełniająca

Folder:

```text
06_documentation/
```

Cel:

- opis podejścia analitycznego,
- uzasadnienie struktury projektu,
- instrukcje pomocnicze,
- dodatkowe wyjaśnienia.

---

## Logika projektu

Projekt został przygotowany zgodnie z następującą kolejnością:

```text
Problem biznesowy
        ↓
Interesariusze
        ↓
Wymagania
        ↓
User Stories
        ↓
Kryteria akceptacji
        ↓
Backlog
        ↓
BPMN AS-IS / TO-BE
        ↓
Architektura
        ↓
Integracje i API
        ↓
Model danych SQL
        ↓
Dashboard Power BI
        ↓
Wnioski biznesowe
```

---

## Dlaczego taka kolejność?

Taka kolejność pokazuje, że projekt nie zaczyna się od technologii, ale od problemu biznesowego.

Dopiero po zrozumieniu problemów, interesariuszy i wymagań zaprojektowano proces TO-BE, architekturę, model danych oraz dashboard KPI.

Dzięki temu repozytorium pokazuje pełną logikę pracy analityka biznesowo-systemowego i BI.



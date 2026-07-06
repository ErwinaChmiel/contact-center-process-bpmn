# Analytical Approach — Contact Center Process Optimization

## Cel dokumentu

Ten dokument opisuje podejście analityczne zastosowane w projekcie optymalizacji procesu obsługi połączeń przychodzących w Contact Center.

Celem dokumentu jest pokazanie, w jaki sposób projekt został przeprowadzony od identyfikacji problemu biznesowego, przez analizę wymagań i modelowanie procesu, aż po przygotowanie modelu danych, KPI oraz dashboardu Power BI.

Projekt został przygotowany jako kompletne case study analityczne, pokazujące sposób pracy Business Analyst / Business-System Analyst / BI Analyst.

---

## Założenie analityczne

Punktem wyjścia projektu była potrzeba poprawy efektywności obsługi połączeń przychodzących w Contact Center.

W procesie AS-IS zidentyfikowano problemy operacyjne, takie jak:

- długi czas oczekiwania klientów na połączenie,
- wysoki poziom porzuconych połączeń,
- ograniczony zakres samoobsługi w IVR,
- brak callbacku jako alternatywy dla oczekiwania w kolejce,
- niewystarczające monitorowanie SLA,
- ograniczona analiza przyczyn kontaktu,
- brak pełnej widoczności KPI operacyjnych,
- brak spójnego modelu danych pod raportowanie.

Na tej podstawie przyjęto, że projekt powinien pokazać nie tylko sam docelowy proces TO-BE, ale również pełną ścieżkę analityczną prowadzącą do rozwiązania.

---

## Etapy pracy analitycznej

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

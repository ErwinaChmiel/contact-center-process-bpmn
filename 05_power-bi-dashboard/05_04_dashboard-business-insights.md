# Podejście analityczne

## Cel dokumentu

Dokument opisuje sposób pracy analitycznej zastosowany w projekcie Contact Center.

Celem było pokazanie, w jaki sposób można przejść od problemu biznesowego do rozwiązania procesowego, systemowego, danych i raportowania KPI.

---

## Główna zasada projektu

Projekt został przygotowany zgodnie z zasadą:

```text
Najpierw problem biznesowy, potem rozwiązanie.
```

Oznacza to, że projekt nie zaczyna się od technologii, dashboardu ani modelu danych.

Punktem wyjścia jest zrozumienie:

- jakie problemy występują w procesie,
- kogo dotyczą,
- jakie mają konsekwencje biznesowe,
- jakie wymagania z nich wynikają,
- jak można je zmierzyć przez KPI.

---

## Etapy pracy analitycznej

| Etap | Opis | Artefakty |
|---|---|---|
| 1 | Identyfikacja problemu biznesowego | business-problem.md |
| 2 | Analiza interesariuszy | stakeholder-analysis.md |
| 3 | Inżynieria wymagań | requirements.md |
| 4 | Opis potrzeb użytkowników | user-stories.md |
| 5 | Doprecyzowanie warunków akceptacji | acceptance-criteria.md |
| 6 | Uporządkowanie zakresu | backlog.md |
| 7 | Modelowanie procesu | BPMN AS-IS i TO-BE |
| 8 | Projektowanie rozwiązania | architecture.md |
| 9 | Analiza integracji | integrations.md |
| 10 | Opis API | api-specification.md |
| 11 | Modelowanie danych | SQL |
| 12 | Raportowanie | Power BI |

---

## Dlaczego zastosowano takie podejście?

Takie podejście pozwala zachować spójność pomiędzy problemem biznesowym a końcowym dashboardem.

Każdy kolejny element projektu wynika z poprzedniego:

- wymagania wynikają z problemów,
- User Stories wynikają z potrzeb interesariuszy,
- kryteria akceptacji doprecyzowują User Stories,
- backlog porządkuje zakres,
- proces TO-BE odpowiada na problemy AS-IS,
- architektura pokazuje komponenty rozwiązania,
- integracje pokazują przepływ danych,
- model SQL umożliwia wyliczenie KPI,
- Power BI prezentuje efekty procesu.

---

## Rola analizy biznesowej

Analiza biznesowa w projekcie odpowiada na pytania:

- jaki problem rozwiązujemy,
- kto jest interesariuszem,
- jakie są potrzeby użytkowników,
- jakie wymagania należy spełnić,
- jak mierzyć efekt zmiany,
- które funkcjonalności są najważniejsze.

---

## Rola analizy systemowej

Analiza systemowa w projekcie odpowiada na pytania:

- jakie komponenty biorą udział w rozwiązaniu,
- jakie dane przepływają między systemami,
- jakie integracje są potrzebne,
- jakie endpointy API mogą wspierać proces,
- jakie wymagania niefunkcjonalne należy uwzględnić.

---

## Rola analizy danych

Analiza danych w projekcie odpowiada na pytania:

- jakie dane są potrzebne do KPI,
- jakie tabele powinien mieć model SQL,
- jakie relacje są potrzebne,
- jakie dane przykładowe odwzorowują proces,
- jak przekształcić dane operacyjne w dashboard.

---

## Rola Power BI

Power BI jest końcową warstwą projektu.

Jego celem jest pokazanie, czy zmiany zaprojektowane w procesie TO-BE mogą być mierzone i monitorowane.

Dashboard pozwala analizować:

- czas oczekiwania,
- czas obsługi,
- skuteczność pierwszego kontaktu,
- SLA,
- porzucone połączenia,
- callbacki,
- self-service,
- efektywność konsultantów.

---

## Podsumowanie

Projekt pokazuje pełną ścieżkę pracy analitycznej:

```text
Problem → Wymagania → Proces → Architektura → Dane → KPI → Dashboard
```

Dzięki temu case study prezentuje nie tylko umiejętność przygotowania raportu, ale również sposób myślenia analitycznego potrzebny w pracy analityka biznesowego, biznesowo-systemowego i BI.



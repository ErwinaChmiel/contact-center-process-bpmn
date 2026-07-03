# Opis modelu danych — Contact Center

## Cel dokumentu

Dokument opisuje założenia modelu danych przygotowanego na potrzeby analizy procesu Contact Center oraz raportowania KPI w Power BI.

Model danych stanowi warstwę pośrednią pomiędzy procesem biznesowym BPMN a dashboardem raportowym.

---

## Dlaczego przygotowano model danych?

Proces BPMN pokazuje przebieg obsługi klienta, ale sam diagram nie pozwala mierzyć efektywności procesu.

Aby możliwe było monitorowanie KPI, konieczne było zaprojektowanie struktury danych obejmującej:

- połączenia,
- zgłoszenia,
- kontakty,
- klientów,
- konsultantów,
- callbacki,
- SLA,
- eskalacje.

Model danych pozwala przekształcić proces biznesowy w mierzalne wskaźniki operacyjne.

---

## Główne encje modelu

| Encja | Opis |
|---|---|
| customers | Dane klientów i segmenty |
| calls | Dane połączeń przychodzących |
| cases | Dane zgłoszeń i spraw |
| contacts | Historia kontaktów z klientem |
| agents | Dane konsultantów i zespołów |
| callbacks | Dane dotyczące oddzwonień |
| sla_events | Dane dotyczące realizacji SLA |

---

## Rola poszczególnych tabel

### customers

Tabela przechowuje dane klientów, które umożliwiają analizę kontaktów według segmentów, statusu klienta lub typu klienta.

Przykładowe zastosowania:

- analiza liczby kontaktów według segmentu,
- analiza FCR według typu klienta,
- identyfikacja klientów z wieloma zgłoszeniami.

---

### calls

Tabela przechowuje informacje o połączeniach przychodzących.

Przykładowe zastosowania:

- analiza wolumenu połączeń,
- wyliczenie ASA,
- wyliczenie AHT,
- analiza porzuconych połączeń,
- identyfikacja godzin największego obciążenia.

---

### cases

Tabela przechowuje informacje o zgłoszeniach klientów.

Przykładowe zastosowania:

- analiza statusów spraw,
- monitorowanie SLA,
- identyfikacja spraw po terminie,
- analiza eskalacji.

---

### contacts

Tabela opisuje kontakty pomiędzy klientem a konsultantem.

Przykładowe zastosowania:

- analiza historii kontaktów,
- ocena FCR,
- analiza kategorii kontaktu,
- powiązanie kontaktów z konsultantami.

---

### agents

Tabela przechowuje dane konsultantów i zespołów.

Przykładowe zastosowania:

- analiza efektywności konsultantów,
- porównanie zespołów,
- analiza AHT i FCR per agent.

---

### callbacks

Tabela przechowuje dane dotyczące callbacków.

Przykładowe zastosowania:

- analiza liczby wybranych callbacków,
- monitorowanie realizacji oddzwonień,
- identyfikacja niezrealizowanych callbacków,
- wyliczenie Callback Realization Rate.

---

## Powiązanie danych z KPI

| KPI | Źródło danych | Cel |
|---|---|---|
| ASA | calls | Pomiar średniego czasu oczekiwania na odpowiedź |
| AHT | calls, contacts | Pomiar średniego czasu obsługi |
| FCR | cases, contacts | Ocena rozwiązania sprawy przy pierwszym kontakcie |
| SLA | cases, sla_events | Monitorowanie terminowości obsługi |
| Abandonment Rate | calls | Analiza porzuconych połączeń |
| Callback Rate | callbacks, calls | Ocena wykorzystania callbacków |
| Callback Realization Rate | callbacks | Ocena skuteczności realizacji callbacków |
| Self-service Rate | calls | Ocena udziału spraw obsłużonych automatycznie |

---

## Założenia modelu danych

| ID | Założenie |
|---|---|
| DM.01 | Model danych ma charakter analityczny |
| DM.02 | Dane wykorzystane w projekcie są danymi przykładowymi |
| DM.03 | Model został zaprojektowany pod raportowanie KPI |
| DM.04 | Relacje między tabelami odzwierciedlają proces Contact Center |
| DM.05 | Model danych nie jest pełnym modelem produkcyjnego systemu Contact Center |

---

## Dlaczego model jest relacyjny?

Model relacyjny został wybrany, ponieważ dane Contact Center mają naturalną strukturę relacyjną.

Przykładowo:

- klient może mieć wiele połączeń,
- klient może mieć wiele zgłoszeń,
- zgłoszenie może mieć wiele kontaktów,
- konsultant może obsłużyć wiele kontaktów,
- sprawa może mieć zdarzenia SLA.

Taka struktura ułatwia analizę danych, przygotowanie zapytań SQL oraz budowę modelu semantycznego w Power BI.

---

## Podsumowanie

Model danych umożliwia przejście od procesu biznesowego do mierzalnej analityki operacyjnej.

Dzięki niemu możliwe jest:

- wyliczenie KPI,
- przygotowanie dashboardu Power BI,
- analiza skuteczności procesu TO-BE,
- identyfikacja problemów operacyjnych,
- monitorowanie wyjątków takich jak sprawy po SLA czy niezrealizowane callbacki.



# Security and Data Governance — Contact Center

## Cel dokumentu

Dokument opisuje zasady bezpieczeństwa, prywatności i governance dla projektu Contact Center Process Optimization. Projekt jest portfolio case study, ale został opisany zgodnie z praktykami oczekiwanymi w środowisku enterprise.

---

## Klasyfikacja danych

| Klasa danych | Przykłady | Ryzyko | Zasada postępowania |
|---|---|---|---|
| Dane osobowe / PII | imię i nazwisko klienta, numer telefonu | Wysokie | Minimalizacja, maskowanie, ograniczenie dostępu |
| Dane operacyjne | status sprawy, czas połączenia, kolejka | Średnie | Dostęp według roli, audyt zmian |
| Dane KPI | ASA, AHT, FCR, SLA, callback rate | Niskie/średnie | Agregacja, brak danych identyfikujących klienta |
| Dane techniczne | correlation id, trace id, logi API | Średnie | Retencja, monitoring, brak danych wrażliwych w logach |

---

## Dane syntetyczne

Dane w repozytorium są danymi syntetycznymi. Nie powinny zawierać:

- realnych numerów telefonów,
- realnych adresów e-mail,
- realnych identyfikatorów klientów,
- nagrań rozmów,
- danych finansowych klientów,
- danych pochodzących z produkcyjnego CRM.

W tabeli `callbacks` numer telefonu jest przechowywany wyłącznie w formie zamaskowanej, np. `+48 *** *** 1234`.

---

## Role i dostęp

| Rola | Dostęp |
|---|---|
| Konsultant 1st Line | Historia klienta, aktywne sprawy, możliwość zamknięcia standardowej sprawy |
| Konsultant 2nd Line | Sprawy eskalowane, historia zgłoszenia, komentarze techniczne |
| Lider zespołu | KPI zespołu, alerty SLA, callbacki, obciążenie godzinowe |
| Manager Contact Center | Agregaty KPI, trendy, efektywność zespołów |
| BI Analyst | Model semantyczny, dane raportowe, brak pełnych danych PII |
| Administrator | Konfiguracja, audyt, zarządzanie uprawnieniami |

---

## RBAC dla dashboardu

Rekomendowane ograniczenia w Power BI:

- konsultant widzi tylko własne dane operacyjne,
- lider widzi dane swojego zespołu,
- manager widzi agregaty wszystkich zespołów,
- analityk BI pracuje na danych zanonimizowanych lub pseudonimizowanych,
- dane klienta w dashboardzie powinny być domyślnie ukryte.

---

## Audytowalność

Audyt powinien obejmować:

- zmianę statusu sprawy,
- eskalację do 2nd line,
- utworzenie callbacku,
- zmianę statusu callbacku,
- przekroczenie SLA,
- ręczną zmianę kategorii kontaktu,
- eksport danych raportowych.

W modelu analitycznym audyt SLA jest reprezentowany przez tabelę `sla_events`. W systemie produkcyjnym analogiczny mechanizm powinien istnieć również dla callbacków i zmian statusów spraw.

---

## Retencja danych

| Typ danych | Rekomendowana retencja |
|---|---:|
| Szczegóły kontaktów klienta | 12–24 miesiące, zgodnie z polityką firmy |
| Dane KPI zagregowane | 3–5 lat |
| Logi techniczne API | 90–180 dni |
| Dane audytowe zmian statusów | 2–5 lat, zależnie od regulacji |
| Dane syntetyczne w repozytorium | Bez ograniczeń, o ile nie zawierają danych realnych |

---

## GDPR / RODO — zasady projektowe

1. Minimalizacja danych — zbieramy tylko dane potrzebne do obsługi procesu i KPI.
2. Privacy by design — dashboard powinien używać agregatów, a nie pełnych danych klienta.
3. Maskowanie — numery telefonów i inne identyfikatory są maskowane.
4. Ograniczenie celu — dane operacyjne są wykorzystywane do obsługi klienta, SLA i raportowania.
5. Audyt — krytyczne zmiany statusów są możliwe do odtworzenia.
6. Retencja — dane nie powinny być przechowywane bezterminowo bez uzasadnienia.

---

## Ryzyka i mitigacje

| Ryzyko | Mitigacja |
|---|---|
| Ujawnienie danych klienta w repo publicznym | Używanie danych syntetycznych i maskowanie PII |
| Nieuprawniony dostęp do dashboardu | RBAC / RLS w Power BI |
| Błędne KPI przez niespójne statusy | Ograniczenia `CHECK`, słowniki statusów, testy jakości danych |
| Brak audytu eskalacji i SLA | Event log w `sla_events` |
| Duplikacja callbacków | `Idempotency-Key` w API |
| Trudność w śledzeniu błędów integracji | `X-Correlation-Id` i `traceId` w API |

---

## Podsumowanie

Dokument pokazuje, że projekt uwzględnia nie tylko proces i dane, ale również bezpieczeństwo, prywatność, audytowalność i governance. To jeden z elementów, które odróżniają projekt portfolio od projektu wyglądającego jak praca w dużej organizacji.

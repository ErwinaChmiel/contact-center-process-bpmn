# Specyfikacja REST API — Contact Center

## Cel dokumentu

Dokument opisuje koncepcyjną specyfikację REST API dla rozwiązania wspierającego proces obsługi połączeń w Contact Center.

Specyfikacja obejmuje endpointy wykorzystywane do:

- obsługi callbacków,
- pobierania danych klienta,
- pobierania historii kontaktów,
- aktualizacji statusu zgłoszenia,
- udostępniania danych KPI dla warstwy raportowej.

Dokument ma charakter analityczny i pokazuje sposób opisu integracji systemowych z perspektywy analityka biznesowo-systemowego.

---

## Zakres API

| Obszar | Opis |
|---|---|
| Callback | Utworzenie i monitorowanie zgłoszeń oddzwonienia |
| Customer | Pobieranie danych klienta |
| Contact History | Pobieranie historii kontaktów klienta |
| Ticket | Aktualizacja statusu zgłoszenia |
| KPI | Udostępnianie danych operacyjnych do raportowania |

---

## Założenia ogólne

| ID | Założenie |
|---|---|
| A.01 | API wykorzystuje styl architektoniczny REST |
| A.02 | Dane są przesyłane w formacie JSON |
| A.03 | Komunikacja odbywa się przez HTTPS |
| A.04 | Identyfikatory zasobów przekazywane są w ścieżce endpointu |
| A.05 | Filtrowanie danych odbywa się przez query parameters |
| A.06 | Daty przekazywane są w formacie ISO 8601 |
| A.07 | Specyfikacja ma charakter koncepcyjny i portfolio |

---

## Standard odpowiedzi błędów

```json
{
  "errorCode": "CUSTOMER_NOT_FOUND",
  "message": "Customer with given identifier was not found.",
  "timestamp": "2026-07-01T12:15:00Z"
}
```

---

## Standardowe kody odpowiedzi

| Kod HTTP | Znaczenie | Przykład użycia |
|---|---|---|
| 200 OK | Żądanie zakończone sukcesem | Pobranie danych klienta |
| 201 Created | Zasób został utworzony | Utworzenie callbacku |
| 400 Bad Request | Niepoprawne dane wejściowe | Błędny format numeru telefonu |
| 401 Unauthorized | Brak autoryzacji | Brak tokenu dostępu |
| 403 Forbidden | Brak uprawnień | Użytkownik bez dostępu do zasobu |
| 404 Not Found | Nie znaleziono zasobu | Brak klienta lub zgłoszenia |
| 409 Conflict | Konflikt biznesowy | Callback już istnieje |
| 500 Internal Server Error | Błąd techniczny systemu | Nieobsłużony wyjątek aplikacji |

---

# API.01 — Utworzenie callbacku

## Endpoint

```http
POST /api/v1/callbacks
```

## Cel biznesowy

Endpoint umożliwia utworzenie zgłoszenia callbacku dla klienta, który nie chce oczekiwać w kolejce na połączenie z konsultantem.

## Powiązane wymagania

| ID | Wymaganie |
|---|---|
| WB.01 | Zmniejszenie liczby porzuconych połączeń |
| WB.02 | Skrócenie średniego czasu oczekiwania klienta |
| WF.04 | Obsługa callbacku |
| WF.05 | Status callbacku |

## Request body

```json
{
  "customerId": 1001,
  "phoneNumber": "+48123456789",
  "preferredTime": "2026-07-01T14:30:00Z",
  "reason": "INVOICE"
}
```

## Opis pól requestu

| Pole | Typ | Wymagane | Opis |
|---|---|---|---|
| customerId | integer | Tak | Identyfikator klienta |
| phoneNumber | string | Tak | Numer telefonu do oddzwonienia |
| preferredTime | datetime | Nie | Preferowany termin callbacku |
| reason | string | Tak | Powód kontaktu klienta |

## Response — 201 Created

```json
{
  "callbackId": 501,
  "customerId": 1001,
  "status": "SCHEDULED",
  "createdAt": "2026-07-01T12:15:00Z"
}
```

## Reguły biznesowe

| ID | Reguła |
|---|---|
| BRULE.01 | Callback może zostać utworzony tylko dla istniejącego klienta |
| BRULE.02 | Numer telefonu musi mieć poprawny format |
| BRULE.03 | Status nowego callbacku ustawiany jest jako SCHEDULED |
| BRULE.04 | Dla tego samego klienta nie powinien istnieć aktywny callback o tym samym powodzie kontaktu |

## Możliwe kody odpowiedzi

| Kod | Opis |
|---|---|
| 201 | Callback został utworzony |
| 400 | Niepoprawne dane wejściowe |
| 404 | Nie znaleziono klienta |
| 409 | Aktywny callback już istnieje |
| 500 | Błąd wewnętrzny systemu |

---

# API.02 — Pobranie danych klienta

## Endpoint

```http
GET /api/v1/customers/{customerId}
```

## Cel biznesowy

Endpoint zwraca podstawowe dane klienta potrzebne konsultantowi podczas obsługi połączenia.

## Parametry ścieżki

| Parametr | Typ | Wymagane | Opis |
|---|---|---|---|
| customerId | integer | Tak | Identyfikator klienta |

## Response — 200 OK

```json
{
  "customerId": 1001,
  "segment": "SME",
  "status": "ACTIVE",
  "openCases": 2,
  "lastContactDate": "2026-06-25"
}
```

## Możliwe kody odpowiedzi

| Kod | Opis |
|---|---|
| 200 | Dane klienta zostały zwrócone |
| 404 | Nie znaleziono klienta |
| 500 | Błąd wewnętrzny systemu |

---

# API.03 — Pobranie historii kontaktów klienta

## Endpoint

```http
GET /api/v1/customers/{customerId}/contacts
```

## Cel biznesowy

Endpoint zwraca historię kontaktów klienta z Contact Center. Dane wspierają konsultanta w szybkim rozpoznaniu kontekstu sprawy.

## Query parameters

| Parametr | Typ | Wymagane | Opis |
|---|---|---|---|
| dateFrom | date | Nie | Data początkowa zakresu |
| dateTo | date | Nie | Data końcowa zakresu |
| category | string | Nie | Kategoria kontaktu |
| status | string | Nie | Status sprawy |

## Przykładowe wywołanie

```http
GET /api/v1/customers/1001/contacts?dateFrom=2026-06-01&dateTo=2026-06-30
```

## Response — 200 OK

```json
[
  {
    "contactId": 9001,
    "contactDate": "2026-06-20",
    "category": "INVOICE",
    "channel": "PHONE",
    "status": "CLOSED"
  },
  {
    "contactId": 9002,
    "contactDate": "2026-06-25",
    "category": "COMPLAINT",
    "channel": "PHONE",
    "status": "OPEN"
  }
]
```

## Reguły biznesowe

| ID | Reguła |
|---|---|
| BRULE.05 | Domyślnie zwracana jest historia z ostatnich 12 miesięcy |
| BRULE.06 | Kontakty sortowane są malejąco po dacie kontaktu |
| BRULE.07 | Historia kontaktów dostępna jest wyłącznie dla istniejącego klienta |

---

# API.04 — Aktualizacja statusu zgłoszenia

## Endpoint

```http
PUT /api/v1/tickets/{ticketId}/status
```

## Cel biznesowy

Endpoint umożliwia aktualizację statusu zgłoszenia, np. oznaczenie sprawy jako eskalowanej do 2nd line.

## Request body

```json
{
  "status": "ESCALATED",
  "reason": "REQUIRES_SECOND_LINE_SUPPORT"
}
```

## Response — 200 OK

```json
{
  "ticketId": 3001,
  "status": "ESCALATED",
  "updatedAt": "2026-07-01T13:00:00Z"
}
```

## Dozwolone statusy zgłoszenia

| Status | Opis |
|---|---|
| OPEN | Zgłoszenie otwarte |
| IN_PROGRESS | Zgłoszenie w trakcie obsługi |
| ESCALATED | Zgłoszenie przekazane do 2nd line |
| CLOSED | Zgłoszenie zamknięte |
| CANCELLED | Zgłoszenie anulowane |

---

# API.05 — Pobranie KPI Contact Center

## Endpoint

```http
GET /api/v1/kpi/contact-center
```

## Cel biznesowy

Endpoint udostępnia zagregowane KPI operacyjne wykorzystywane w dashboardzie Power BI.

## Query parameters

| Parametr | Typ | Wymagane | Opis |
|---|---|---|---|
| dateFrom | date | Tak | Data początkowa zakresu analizy |
| dateTo | date | Tak | Data końcowa zakresu analizy |
| teamId | integer | Nie | Identyfikator zespołu |
| agentId | integer | Nie | Identyfikator konsultanta |

## Przykładowe wywołanie

```http
GET /api/v1/kpi/contact-center?dateFrom=2026-06-01&dateTo=2026-06-30&teamId=10
```

## Response — 200 OK

```json
{
  "period": {
    "dateFrom": "2026-06-01",
    "dateTo": "2026-06-30"
  },
  "filters": {
    "teamId": 10,
    "agentId": null
  },
  "metrics": {
    "slaRate": 0.92,
    "fcrRate": 0.74,
    "averageHandleTime": 420,
    "averageSpeedOfAnswer": 35,
    "abandonmentRate": 0.08,
    "callbackRealizationRate": 0.87,
    "selfServiceRate": 0.31
  }
}
```

## Opis metryk

| Metryka | Opis |
|---|---|
| slaRate | Odsetek spraw obsłużonych w ramach SLA |
| fcrRate | Odsetek spraw rozwiązanych przy pierwszym kontakcie |
| averageHandleTime | Średni czas obsługi połączenia w sekundach |
| averageSpeedOfAnswer | Średni czas oczekiwania na odpowiedź w sekundach |
| abandonmentRate | Odsetek porzuconych połączeń |
| callbackRealizationRate | Odsetek zrealizowanych callbacków |
| selfServiceRate | Odsetek spraw obsłużonych przez samoobsługę |

---

## Macierz endpointów i wymagań

| Endpoint | Obszar | Powiązane wymagania |
|---|---|---|
| POST /api/v1/callbacks | Callback | WB.01, WB.02, WF.04, WF.05 |
| GET /api/v1/customers/{customerId} | Customer | WF.02 |
| GET /api/v1/customers/{customerId}/contacts | Contact History | WF.02, WF.03 |
| PUT /api/v1/tickets/{ticketId}/status | Ticket | WF.06, WF.07 |
| GET /api/v1/kpi/contact-center | KPI Reporting | WB.05, WF.07, WF.08 |

---

## Uwagi analityczne

Specyfikacja API została przygotowana w celu pokazania sposobu opisu integracji systemowej na poziomie analitycznym.

Dokument nie stanowi kompletnej dokumentacji developerskiej, ale zawiera elementy typowe dla pracy analityka biznesowo-systemowego:

- cel biznesowy endpointu,
- powiązanie z wymaganiami,
- strukturę request/response,
- opis pól,
- reguły biznesowe,
- kody odpowiedzi,
- parametry filtrowania,
- macierz powiązań endpointów z wymaganiami.


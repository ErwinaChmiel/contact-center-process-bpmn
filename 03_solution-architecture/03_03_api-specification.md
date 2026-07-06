# Specyfikacja REST API — Contact Center

## Cel dokumentu

Dokument opisuje koncepcyjną specyfikację REST API dla rozwiązania wspierającego proces obsługi połączeń w Contact Center.

Specyfikacja obejmuje endpointy wykorzystywane do:

- obsługi callbacków,
- pobierania danych klienta,
- pobierania historii kontaktów,
- aktualizacji statusu sprawy (`case`),
- udostępniania danych KPI dla warstwy raportowej.

Dokument ma charakter analityczny i pokazuje sposób opisu integracji systemowych z perspektywy analityka biznesowo-systemowego.

---

## Zakres API

| Obszar | Opis |
|---|---|
| Callback | Utworzenie i monitorowanie zgłoszeń oddzwonienia |
| Customer | Pobieranie danych klienta |
| Contact History | Pobieranie historii kontaktów klienta |
| Case | Aktualizacja statusu sprawy / zgłoszenia |
| SLA Events | Rejestracja i odczyt zdarzeń SLA |
| KPI | Udostępnianie danych operacyjnych do raportowania |

---

## Założenia ogólne

| ID | Założenie |
|---|---|
| A.01 | API wykorzystuje styl architektoniczny REST |
| A.02 | Dane są przesyłane w formacie JSON |
| A.03 | Komunikacja odbywa się przez HTTPS |
| A.04 | Identyfikatory zasobów są spójne z modelem SQL: `customerId`, `callId`, `caseId`, `callbackId` |
| A.05 | Filtrowanie danych odbywa się przez query parameters |
| A.06 | Daty przekazywane są w formacie ISO 8601 |
| A.07 | API wykorzystuje `X-Correlation-Id` do śledzenia żądań |
| A.08 | Operacje tworzące zasoby mogą wykorzystywać `Idempotency-Key` |
| A.09 | Specyfikacja ma charakter koncepcyjny i portfolio |

---

## Security i nagłówki techniczne

| Element | Opis |
|---|---|
| Authorization | `Bearer <JWT>` |
| X-Correlation-Id | Identyfikator żądania wspierający monitoring i troubleshooting |
| Idempotency-Key | Klucz idempotencji dla operacji tworzących callback |
| Content-Type | `application/json` |

---

## Standard odpowiedzi błędów

```json
{
  "errorCode": "CUSTOMER_NOT_FOUND",
  "message": "Customer with given identifier was not found.",
  "traceId": "8e3f7f9a-6d4d-4b33-9e3a-7b8f9d1a2f11",
  "timestamp": "2026-07-01T12:15:00Z"
}
```

---

## Standardowe kody odpowiedzi

| Kod HTTP | Znaczenie | Przykład użycia |
|---|---|---|
| 200 OK | Żądanie zakończone sukcesem | Pobranie danych klienta |
| 201 Created | Zasób został utworzony | Utworzenie callbacku |
| 400 Bad Request | Niepoprawne dane wejściowe | Błędny format daty lub statusu |
| 401 Unauthorized | Brak autoryzacji | Brak tokenu dostępu |
| 403 Forbidden | Brak uprawnień | Użytkownik bez dostępu do zasobu |
| 404 Not Found | Nie znaleziono zasobu | Brak klienta, sprawy lub callbacku |
| 409 Conflict | Konflikt biznesowy | Callback już istnieje |
| 422 Unprocessable Entity | Dane poprawne technicznie, ale naruszają reguły biznesowe | Callback zaplanowany w przeszłości |
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
  "sourceCallId": 5001,
  "customerId": 1001,
  "scheduledAt": "2026-07-01T14:30:00Z",
  "phoneMasked": "+48***56789"
}
```

## Opis pól requestu

| Pole | Typ | Wymagane | Opis |
|---|---|---|---|
| sourceCallId | integer | Tak | Identyfikator połączenia źródłowego |
| customerId | integer | Tak | Identyfikator klienta |
| scheduledAt | datetime | Tak | Planowany termin callbacku |
| phoneMasked | string | Tak | Zamaskowany numer telefonu do oddzwonienia |

## Response — 201 Created

```json
{
  "callbackId": 501,
  "customerId": 1001,
  "status": "scheduled",
  "createdAt": "2026-07-01T12:15:00Z"
}
```

## Reguły biznesowe

| ID | Reguła |
|---|---|
| BRULE.01 | Callback może zostać utworzony tylko dla istniejącego klienta |
| BRULE.02 | `sourceCallId` musi wskazywać istniejące połączenie |
| BRULE.03 | Status nowego callbacku ustawiany jest jako `scheduled` |
| BRULE.04 | Planowany czas callbacku nie może być wcześniejszy niż moment utworzenia zgłoszenia |
| BRULE.05 | Dla tego samego klienta nie powinien istnieć aktywny callback dotyczący tej samej sprawy |

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
  "status": "active",
  "openCases": 2,
  "lastContactDate": "2026-06-25"
}
```

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
| limit | integer | Nie | Liczba rekordów na stronie |
| offset | integer | Nie | Przesunięcie stronicowania |

## Przykładowe wywołanie

```http
GET /api/v1/customers/1001/contacts?dateFrom=2026-06-01&dateTo=2026-06-30&limit=50&offset=0
```

## Response — 200 OK

```json
{
  "customerId": 1001,
  "items": [
    {
      "contactId": 9001,
      "contactDate": "2026-06-20",
      "category": "invoice",
      "channel": "phone",
      "status": "closed"
    },
    {
      "contactId": 9002,
      "contactDate": "2026-06-25",
      "category": "complaint",
      "channel": "phone",
      "status": "open"
    }
  ],
  "pagination": {
    "limit": 50,
    "offset": 0,
    "total": 2
  }
}
```

---

# API.04 — Aktualizacja statusu sprawy

## Endpoint

```http
PUT /api/v1/cases/{caseId}/status
```

## Cel biznesowy

Endpoint umożliwia aktualizację statusu sprawy, np. oznaczenie sprawy jako eskalowanej do 2nd line.

## Request body

```json
{
  "status": "escalated",
  "escalationReason": "Requires 2nd line support"
}
```

## Response — 200 OK

```json
{
  "caseId": 3001,
  "status": "escalated",
  "updatedAt": "2026-07-01T13:00:00Z"
}
```

## Dozwolone statusy sprawy

| Status | Opis |
|---|---|
| open | Sprawa otwarta |
| in_progress | Sprawa w trakcie obsługi |
| escalated | Sprawa przekazana do 2nd line |
| closed | Sprawa zamknięta |

---

# API.05 — Pobranie zdarzeń SLA dla sprawy

## Endpoint

```http
GET /api/v1/cases/{caseId}/sla-events
```

## Cel biznesowy

Endpoint zwraca zdarzenia SLA dla konkretnej sprawy. Dane wspierają audyt procesu, analizę przekroczeń SLA oraz dashboard operacyjny.

## Response — 200 OK

```json
{
  "caseId": 3001,
  "items": [
    {
      "slaEventId": 70001,
      "eventType": "sla_started",
      "eventTime": "2026-07-01T12:10:00Z",
      "breachedFlag": false
    },
    {
      "slaEventId": 70002,
      "eventType": "sla_breached",
      "eventTime": "2026-07-01T18:10:00Z",
      "breachedFlag": true
    }
  ]
}
```

---

# API.06 — Pobranie KPI Contact Center

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
| channel | string | Nie | Kanał kontaktu: `phone`, `chat`, `email` |

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
    "agentId": null,
    "channel": null
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

---

## Macierz endpointów i wymagań

| Endpoint | Obszar | Powiązane wymagania |
|---|---|---|
| `POST /api/v1/callbacks` | Callback | WB.01, WB.02, WF.04, WF.05 |
| `GET /api/v1/customers/{customerId}` | Customer | WF.02 |
| `GET /api/v1/customers/{customerId}/contacts` | Contact History | WF.02, WF.03 |
| `PUT /api/v1/cases/{caseId}/status` | Case | WF.06, WF.07 |
| `GET /api/v1/cases/{caseId}/sla-events` | SLA Events | WF.07 |
| `GET /api/v1/kpi/contact-center` | KPI Reporting | WB.05, WF.07, WF.08 |

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
- macierz powiązań endpointów z wymaganiami,
- spójność nazw z modelem danych SQL (`cases`, `callbacks`, `sla_events`).

# Opis procesu TO-BE

Proces TO-BE pokazuje docelowy sposób obsługi połączeń po wprowadzeniu usprawnień.

## Kluczowe usprawnienia

- **Self-service w IVR** dla prostych spraw dotyczących faktur:
  - klient może sprawdzić saldo / status faktury bez rozmowy z konsultantem,
  - część spraw kończy się już w IVR (osobny end event w BPMN).

- **Callback (oddzwonienia)**:
  - klient może wybrać oddzwonienie zamiast czekać w kolejce,
  - system zapisuje żądanie callbacku,
  - oddzielny proces outbound realizuje oddzwonienia.

- **Lepsze zarządzanie zgłoszeniami**:
  - wyraźne rozdzielenie ról 1st line / 2nd line,
  - SLA z przypomnieniem (timer + task „Przypomnienie nierozwiązanej sprawy”).

- **Tagowanie danych pod analitykę**:
  - dodatkowy krok „Konsultant taguje powód kontaktu i wynik rozmowy w systemie”,
  - dane zapisują się w strukturze, którą odzwierciedla model SQL (`calls`, `cases`, `contacts`).

## Oczekiwane efekty

- Większy udział self-service (mniej prostych pytań u konsultantów).
- Lepsze doświadczenie klienta dzięki callbackowi.
- Lepsza jakość danych → możliwość liczenia KPI (FCR, SLA, self-service, callback).
- Potencjalne skrócenie SLA dzięki mniejszemu obciążeniu 2nd line.


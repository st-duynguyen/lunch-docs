# Contract

## 1. Quy ước

Base `/api`, JSON `camelCase`. Lỗi: HTTP 4xx + `{code, message}`. Mỗi endpoint một file, mỗi file có bảng
**Fields** và dòng `Fixture:` trỏ JSON mẫu; `status.sh` so khóa trong fixture với bảng Fields.
Danh sách endpoint, request / response, curl mẫu: `endpoints.md`.

## 2. Enum

```text
Order.status:  PLACED | CANCELLED
Error.code:    VALIDATION_ERROR | NOT_FOUND
```

## 3. Danh sách

Toàn bộ endpoint ở `contract/endpoints.md` §1.

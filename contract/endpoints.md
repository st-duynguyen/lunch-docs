# Endpoints ↔ fixtures

Base local `http://localhost:8001/api`. Lỗi: HTTP 4xx + `{code, message}` (`contract/README.md` §1).
Mỗi mục có dòng `Fixture:` (đường dẫn tính từ `contract/`); `status.sh` so khóa trong fixture với bảng Fields của mục đó.

## 1. Danh sách

| Method | Path | Request | Response | Fixture |
|---|---|---|---|---|
| GET | `/api/menus` | — | `200 {items: Menu[]}` | `menus.json` |
| POST | `/api/orders` | body `{menuId, quantity, note?}` | `201 Order` · `422 VALIDATION_ERROR` | `order.json` |
| GET | `/api/orders/{id}` | — | `200 Order` · `404 NOT_FOUND` | `order.json` |

## 2. GET /api/menus

Menu trong ngày.

Fixture: fixtures/menus.json

| Field | Kiểu | Ghi chú |
|---|---|---|
| items | Menu[] | id, name, price (VND) |

## 3. POST /api/orders

Request `{menuId, quantity, note?}`; `quantity` 1–5; `note` string tối đa 300 ký tự. Sai dữ liệu → `422 VALIDATION_ERROR`.

Fixture: fixtures/order.json

| Field | Kiểu | Ghi chú |
|---|---|---|
| id | string | |
| menuId | string | |
| quantity | int | 1–5 |
| note | string | Không bắt buộc; tối đa 300 ký tự; không gửi → `""` (C002) |
| status | Order.status | |
| createdAt | string | ISO-8601 +07:00 |

## 4. GET /api/orders/{id}

Xem lại một đơn đã đặt. Không có `id` → `404 NOT_FOUND`.

Fixture: fixtures/order.json

| Field | Kiểu | Ghi chú |
|---|---|---|
| id | string | |
| menuId | string | |
| quantity | int | 1–5 |
| note | string | Không bắt buộc; tối đa 300 ký tự; không gửi → `""` (C002) |
| status | Order.status | |
| createdAt | string | ISO-8601 +07:00 |

## 5. curl mẫu

```bash
curl -s localhost:8001/api/menus
curl -s -X POST localhost:8001/api/orders -H 'Content-Type: application/json' -d '{"menuId":"m1","quantity":1,"note":"ít cay"}'
curl -s localhost:8001/api/orders/o_001
```

## 6. Thứ tự smoke (khớp `scope.md` §2)

1. `GET /api/menus` → có Cơm gà, Bún chả.
2. `POST /api/orders` → `201`, ghi lại `id`.
3. `GET /api/orders/{id}` → đúng đơn vừa đặt (UC-01).

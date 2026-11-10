# Lượt chạy: order · local · 2026-11-06

Người chạy: QC · Bản: lunch-api `main`, lunch-web `main`, lunch-docs `main` (C001)
Cách chạy: theo `features/order.md` §4, mở http://localhost:8002/?api=real

| ID | Kết quả | Bằng chứng |
|---|---|---|
| TC-order-001 | PASS | Màn hình có 2 món; `curl /api/menus` → 2 phần tử |
| TC-order-002 | PASS | Thấy 注文しました; `curl /api/orders/o_001` → status PLACED |
| TC-order-003 | PASS | `curl POST quantity=5` → 201 |
| TC-order-004 | PASS | `curl POST quantity=6` → 422 VALIDATION_ERROR |
| TC-order-005 | PASS | `curl POST menuId=zzz` → 422 VALIDATION_ERROR |
| TC-order-006 | PASS | `curl /api/orders/o_001` → 200 |
| TC-order-007 | PASS | `curl /api/orders/o_999` → 404 NOT_FOUND |

Tổng: 7/7 PASS, mọi case P1 PASS.

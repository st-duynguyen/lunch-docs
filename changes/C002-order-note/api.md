# C002 — api

## 1. Baseline

`POST /api/orders` nhận `{menuId, quantity}` (`contract/endpoints.md` §3).

## 2. Delta

`POST /api/orders` nhận thêm `note`; `Order` trả thêm `note` (`contract/endpoints.md` §3, §4 — lead BE cập nhật).

## 3. Việc

- [ ] T1 Nhận, kiểm tra và trả `note` trong đơn, contract test

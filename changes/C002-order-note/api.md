# C002 — api

## 1. Baseline

`POST /api/orders` nhận `{menuId, quantity}` (`design/api.md` §3).

## 2. Delta

Nhận thêm `note` tùy chọn, lưu và trả trong `Order` theo `contract/endpoints.md` §3, §4.

## 3. Việc

- [ ] T1 API nhận, kiểm độ dài, lưu và trả `note`; contract test

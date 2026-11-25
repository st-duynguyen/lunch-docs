# C002 — api

## 1. Baseline

`POST /api/orders` nhận `{menuId, quantity}`; Order không có `note`.

## 2. Delta

Thêm field `note` (string, không bắt buộc, tối đa 300 ký tự) vào request `POST /api/orders` và Order trả về
(`contract/endpoints.md` §3, §4). Quá 300 ký tự hoặc không phải string → `422 VALIDATION_ERROR`.
Không gửi `note` → lưu `""`.

## 3. Việc

- [ ] T1 API nhận, kiểm, lưu, trả `note`; contract test đọc `contract/fixtures/order.json`

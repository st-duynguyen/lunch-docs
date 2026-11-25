# Test case: order

Feature `features/order.md`. Cách viết: `qc/README.md` §2.

| ID | Chức năng con | Loại | P | Các bước | Kỳ vọng | Nguồn |
|---|---|---|---|---|---|---|
| TC-order-001 | xem-menu | Bình thường | P1 | Mở trang | Thấy 2 món: Cơm gà, Bún chả | contract/endpoints.md §2 |
| TC-order-002 | dat-mon | Bình thường | P1 | Đặt Cơm gà, số lượng 1 | 201, status PLACED, thấy Order placed | contract/endpoints.md §3 |
| TC-order-003 | dat-mon | Biên | P2 | Đặt Cơm gà, số lượng 5 | 201 | contract/endpoints.md §3 |
| TC-order-004 | dat-mon | Lỗi | P1 | Đặt Cơm gà, số lượng 6 | 422 VALIDATION_ERROR | contract/endpoints.md §3 |
| TC-order-005 | dat-mon | Lỗi | P2 | Đặt món có menuId không tồn tại | 422 VALIDATION_ERROR | contract/endpoints.md §3 |
| TC-order-006 | xem-don | Bình thường | P2 | GET đơn vừa đặt | 200, cùng id, cùng menuId | contract/endpoints.md §4 |
| TC-order-007 | xem-don | Lỗi | P2 | GET /api/orders/o_999 | 404 NOT_FOUND | contract/endpoints.md §4 |
| TC-order-008 | dat-mon | Bình thường | P1 | Đặt Cơm gà, số lượng 1, ô **Note** gõ `ít cay, không hành` | 201, `note` trả về đúng `ít cay, không hành`; thấy Order placed | contract/endpoints.md §3 |
| TC-order-009 | dat-mon | Bình thường | P2 | Đặt món, để trống ghi chú (API: không gửi `note`) | 201, `note` là `""` | contract/endpoints.md §3 |
| TC-order-010 | dat-mon | Biên | P1 | Đặt món, ghi chú đúng 300 ký tự | 201, `note` đủ 300 ký tự | contract/endpoints.md §3 |
| TC-order-011 | dat-mon | Lỗi | P1 | API: POST ghi chú 301 ký tự | 422 VALIDATION_ERROR | contract/endpoints.md §3 |
| TC-order-012 | dat-mon | Lỗi | P2 | API: POST `note` là số (`5`) | 422 VALIDATION_ERROR | contract/endpoints.md §3 |
| TC-order-013 | dat-mon | Biên | P2 | Màn hình: gõ / dán 301 ký tự vào ô **Note** | ⚠ Chưa chốt; mặc định: ô dừng ở 300 ký tự, không thông báo | open-questions.md #3 |
| TC-order-014 | dat-mon | Biên | P2 | Ghi chú 300 emoji (vd 🌶) | ⚠ Chưa chốt cách đếm; mặc định: 201 (mỗi emoji tính 1 ký tự) | open-questions.md #4 |
| TC-order-015 | xem-don | Bình thường | P2 | GET đơn vừa đặt có ghi chú | 200, `note` giống lúc đặt | contract/endpoints.md §4 |

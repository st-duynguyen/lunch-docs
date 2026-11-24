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

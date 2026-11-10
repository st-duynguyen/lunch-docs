# Design: lunch-api

Mô tả hệ thống **đang chạy**. Endpoint, request, response: `contract/endpoints.md` §1. Luật khi sửa code: `rules/api.md`.

## 1. Cấu trúc

| File | Việc |
|---|---|
| `app.py` | Nhận request HTTP, gọi `orders.py`, trả JSON (thư viện chuẩn Python, cổng 8001) |
| `orders.py` | Nghiệp vụ: kiểm dữ liệu, tạo đơn, lấy đơn |

## 2. Dữ liệu

- Lưu trong bộ nhớ của server: tắt server là mất, chưa có database.
- Menu: cố định trong code (Cơm gà, Bún chả).
- Đơn hàng gồm: `id`, `menuId`, `quantity`, `status`, `createdAt`. Mã đơn tăng dần `o_001`, `o_002`…

## 3. Luồng đặt món

1. `app.py` nhận `POST /api/orders`, đọc body JSON.
2. `orders.py` kiểm `menuId` có trong menu, `quantity` từ 1 đến 5; sai thì báo lỗi.
3. Tạo mã đơn, gắn trạng thái `PLACED` và thời gian, lưu vào bộ nhớ.
4. Trả đơn vừa tạo; `GET /api/orders/{id}` đọc lại từ bộ nhớ.

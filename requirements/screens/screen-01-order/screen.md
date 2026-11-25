# Screen 01 — Đặt món (Order)

UC: UC-01 · Features: `features/order.md`

### Overview

**Mục đích:** Nhân viên chọn món trong menu hôm nay, chọn số lượng và đặt cơm trưa trước 11:00.
**Truy cập:** Mọi nhân viên trong team, không cần đăng nhập.
**Trên màn hình có:**
- Đầu trang: logo, tên app `Team Lunch`, ngày hôm nay
- Ô chọn món (tên món + giá)
- Ô số lượng có nút `−` / `+`
- Nút `Place order`
- Thông báo kết quả (thành công / lỗi)

**User làm được:**
- Xem menu hôm nay
- Chọn một món, số lượng từ 1 đến 5
- Đặt món, thấy kết quả ngay

**Giới hạn:** Mỗi lần đặt một món. Không sửa, không hủy đơn đã đặt trên màn này.

### Component: Order form

| Element | Mô tả |
|---|---|
| Ô chọn món | Danh sách món lấy từ menu hôm nay; hiện tên món và giá |
| Ô số lượng | Mặc định 1; nút `−` / `+` tăng giảm trong khoảng 1–5 |
| Nút `Place order` | Gửi đơn |
| Thông báo thành công | Hộp xanh: `Order placed` |
| Thông báo lỗi | Hộp đỏ: `Could not place order: <lý do>` |

### Behavior theo condition

| Condition | UI | Feedback |
|---|---|---|
| Mở màn | Tải menu, chọn sẵn món đầu tiên, số lượng 1 | — |
| Bấm `−` khi số lượng là 1 | Số lượng giữ 1 | — |
| Bấm `+` khi số lượng là 5 | Số lượng giữ 5 | — |
| Bấm `Place order`, dữ liệu hợp lệ | Gửi đơn | Hộp xanh `Order placed` |
| Bấm `Place order`, số lượng ngoài 1–5 (gõ tay) | Không đặt được | Hộp đỏ `Could not place order: quantity must be 1–5` |
| Bấm `Place order` lần nữa | Ẩn thông báo cũ, hiện thông báo mới | — |

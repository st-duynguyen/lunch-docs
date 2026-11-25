# Screen 01 — Đặt món (Order)

UC: UC-01 · Features: `features/order.md`

### Overview

**Mục đích:** Nhân viên chọn món trong menu hôm nay, chọn số lượng và đặt cơm trưa trước 11:00.
**Truy cập:** Mọi nhân viên trong team, không cần đăng nhập.
**Trên màn hình có:**
- Đầu trang: logo, tên app `Team Lunch`, ngày hôm nay
- Ô chọn món (tên món + giá)
- Ô số lượng có nút `−` / `+`
- Ô ghi chú (vd: ít cay, không hành)
- Nút `Place order`
- Thông báo kết quả (thành công / lỗi)

**User làm được:**
- Xem menu hôm nay
- Chọn một món, số lượng từ 1 đến 5
- Ghi chú cho món (không bắt buộc), tối đa 300 ký tự
- Đặt món, thấy kết quả ngay

**Giới hạn:** Mỗi lần đặt một món. Không sửa, không hủy đơn đã đặt trên màn này.

### Component: Order form

| Element | Mô tả |
|---|---|
| Ô chọn món | Danh sách món lấy từ menu hôm nay; hiện tên món và giá |
| Ô số lượng | Mặc định 1; nút `−` / `+` tăng giảm trong khoảng 1–5 |
| Ô ghi chú | Nhập tự do, tối đa 300 ký tự (theo khách, #6); để trống được (chưa chốt). Nhãn ô: `Note` — nhãn chờ tech lead đưa vào Handles |
| Nút `Place order` | Gửi đơn (kèm ghi chú nếu có) |
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
| Gõ ghi chú quá 300 ký tự | Chặn nhập thêm hay báo lỗi: chưa chốt | Nội dung thông báo: chưa chốt |
| Bấm `Place order` có ghi chú | Gửi đơn kèm ghi chú | Hộp xanh `Order placed` |

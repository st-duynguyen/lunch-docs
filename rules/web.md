# Rules: lunch-web

- Không tự đặt nhãn nút / ô nhập: lấy từ bảng Handles trong `features/`, gom ở `src/i18n/en.js`.
- Đếm độ dài chuỗi bằng `[...s].length`, không `s.length` (xem `traps.md`).
- Gọi API qua `src/api.js`. API trả lỗi `{code, message}` thì hiện `msg-error` kèm `message`, không báo thành công.

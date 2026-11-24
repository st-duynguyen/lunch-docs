# Design: lunch-web

Mô tả hệ thống **đang chạy**. Gọi API nào: `contract/endpoints.md` §1. Luật khi sửa code: `rules/web.md`.

## 1. Cấu trúc

| File | Việc |
|---|---|
| `index.html` | Khung trang: chọn món, số lượng, nút đặt |
| `src/app.js` | Gắn nhãn, tải menu, xử lý bấm nút |
| `src/api.js` | `FakeApi` đọc dữ liệu mẫu trong `docs/contract/fixtures/`; `RealApi` gọi lunch-api. Thêm `?api=real` để dùng `RealApi` |
| `src/i18n/en.js` | Nhãn nút, thông báo; lấy đúng chữ từ `features/order.md` §3 |

## 2. Luồng đặt món

1. Mở trang → tải menu, hiện danh sách món.
2. Chọn món, số lượng, bấm nút đặt.
3. Gọi API đặt món; xong thì hiện thông báo đã đặt.

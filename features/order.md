# Feature: đặt món

Người dùng xem menu trong ngày, chọn món và số lượng, bấm đặt; xong thì thấy thông báo đã đặt.
Chức năng “Đặt món” ở `scope.md` §2. API: `contract/endpoints.md` §1. Màn hình: `design/web.md` §2.

Tự động hóa: chưa có test e2e; nhãn ở §3 được `lunch-web/tests/run.js` kiểm. Kiểm bằng tay theo §4.

## 1. Chức năng con

- `xem-menu`: mở trang thấy danh sách món (gọi `GET /api/menus`).
- `dat-mon`: chọn món, số lượng, bấm đặt (gọi `POST /api/orders`).
- `xem-don`: xem lại đơn vừa đặt (chỉ qua API `GET /api/orders/{id}`, chưa có màn hình).

## 2. Đường đi của người dùng

- Mở trang → chọn món → nhập số lượng → nút **Place order** → thông báo **Order placed**.

## 3. Handles

Nhãn chuẩn trên màn hình. FE đặt đúng chữ này (gom ở `src/i18n/en.js`), QC kiểm đúng chữ này.

| Handle | Nhãn |
|---|---|
| btn-order | Place order |
| msg-done | Order placed |
| msg-error | Could not place order |

## 4. Kịch bản kiểm chứng (chạy sau deploy)

Điều kiện trước: lunch-api chạy ở cổng 8001 (`python3 app.py`), lunch-web ở cổng 8002 (`npm start`),
mở http://localhost:8002/?api=real.

- **Bước 1: xem menu.** Mở trang → thấy 2 món Cơm gà, Bún chả.
  Đối chiếu: `curl -s localhost:8001/api/menus` → `items` có 2 phần tử.
- **Bước 2: đặt món.** Chọn Cơm gà, số lượng 1, bấm **Place order** → thấy **Order placed**.
  Đối chiếu: `curl -s localhost:8001/api/orders/o_001` → `status: PLACED`, `menuId: m1`.
- **Bước 3: số lượng sai.** `curl -s -X POST localhost:8001/api/orders -H 'Content-Type: application/json'
  -d '{"menuId":"m1","quantity":6}'` → `422`, `code: VALIDATION_ERROR`.
- **Bằng chứng.** Ảnh màn hình sau bước 2 và output các lệnh `curl`, lưu vào `qc/runs/<ngày>-local-order.md`.

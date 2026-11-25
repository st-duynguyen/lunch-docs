# Câu hỏi mở

| # | Câu hỏi | Ai hỏi | Mặc định nếu chưa chốt | Chốt |
|---|---|---|---|---|
| 1 | Đặt sau 11:00 thì chặn hay chỉ cảnh báo? | QC | Chặn | Chặn (BA chốt với khách, 05/11) |
| 2 | Ghi chú bắt buộc hay không? (C002, #6) | Tech lead | Không bắt buộc | |
| 3 | Gõ ghi chú quá 300 ký tự thì màn hình chặn nhập hay báo lỗi, thông báo gì? (C002, #6) | Tech lead | Chặn nhập ở ký tự 300, không thông báo; API vẫn trả `422 VALIDATION_ERROR` | |
| 4 | "Tối đa 300 ký tự" đếm thế nào với emoji / ký tự ghép? (C002, QC) | QC | Đếm theo code point: mỗi emoji đơn tính 1 ký tự (BE `len`, FE `[...s].length`) | |

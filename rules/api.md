# Rules: lunch-api

- Lỗi nghiệp vụ trả 4xx `{code, message}`, không để lọt 500.
- Không ghi log nội dung đơn (ghi chú có thể chứa thông tin cá nhân).
- Contract test đọc `docs/contract/fixtures/`, không tự viết JSON kỳ vọng.
- Không trả thêm field, không thêm mã lỗi ngoài `contract/`; cần thêm thì sửa contract trước (PR docs).

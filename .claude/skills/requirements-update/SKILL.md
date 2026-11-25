---
name: requirements-update
description: BA cập nhật requirements/ (spec màn hình, biên bản) theo một issue yêu cầu rồi tạo PR. Dùng khi nói "/requirements-update <link issue>", "cập nhật spec theo issue …".
---
1. `gh issue view <link> --json number,title,body` để đọc yêu cầu.
2. Tìm màn bị đụng trong bảng `requirements/screens/README.md`. Sửa `screen.md` của màn đó: thêm / đổi đúng phần
   khách nói (Component, Behavior). Không tự thêm giới hạn khách chưa nói (độ dài, định dạng): ghi "chưa chốt".
   Màn mới → tạo `screen-NN-<slug>/screen.md` theo mẫu màn có sẵn và thêm dòng vào bảng.
3. Nhãn mới chưa có trong Handles ở `features/` → ghi tạm, đánh dấu "nhãn chờ tech lead đưa vào Handles".
4. Nhánh `feature/req-<số issue>-<slug>`, commit `docs: requirements cho #<số issue>`, tạo PR vào `main`
   có dòng `Refs #<số issue>`. Báo lại link PR.

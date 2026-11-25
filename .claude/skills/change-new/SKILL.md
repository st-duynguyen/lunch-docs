---
name: change-new
description: Tech lead viết trọn PR docs từ một issue yêu cầu — changes/<ID>-<slug>/ (ID tự tăng), scope, contract, design, features, open-questions — rồi tạo PR. Dùng khi nói "tạo change", "/change-new <link issue> [quyết định của tech lead]".
---
Đầu vào: link issue + quyết định tùy chọn của tech lead (vd "tối đa 200 ký tự"); quyết định này ưu tiên hơn suy đoán.

1. `gh issue view <link> --json number,title,body` để đọc yêu cầu; đọc spec liên quan trong `requirements/`
   (chỉ trỏ tới, không chép lại; `requirements/` là phần BA giữ).
2. So với `scope.md` §1 và `contract/`: yêu cầu có trong Không làm → dừng, hỏi PM.
3. Tự đặt slug ngắn tiếng Anh (vd `order-note`), tự xác định thành phần bị đụng từ `design/` (api, web).
   Tạo nhánh `feature/<ID>-<slug>`, chạy `bash scripts/new-change.sh auto <slug> <thành phần…>` (ID tự tăng). Báo lại ID.
4. Viết `requirement.md`: vì sao, trỏ tới issue và spec trong `requirements/`, chức năng nào trong scope;
   mỗi file thành phần: Baseline, Delta, việc `Tn`.
5. Sửa phần bị đụng theo `CLAUDE.md` §5 mục 6: `scope.md`, `contract/` (+ JSON mẫu, `CHANGELOG.md`), `design/`,
   `features/` (Handles cho nhãn mới). Điểm khách chưa nói mà tech lead chưa quyết → dòng mới ở `open-questions.md`
   có cột "Mặc định nếu chưa chốt"; không tự quyết.
6. `bash scripts/status.sh` cho tới khi sạch. Commit `docs: <ID> <slug>`, tạo PR vào `main` có `Refs #<số issue>`,
   mô tả liệt kê câu hỏi mở cho BA. Báo lại ID và link PR.

---
name: change-new
description: Tạo phiếu việc mới changes/<ID>-<slug>/ từ một issue yêu cầu (link issue GitHub); ID tự tăng. Dùng khi nói "tạo change", "/change-new <link issue>".
---
1. `gh issue view <link> --json number,title,body` để đọc yêu cầu. Không chép vào `requirements/` (đó là phần BA giữ).
2. So với `scope.md` §1 và `contract/`: yêu cầu có trong Không làm → dừng, hỏi PM.
3. Tự đặt slug ngắn tiếng Anh (vd `order-note`), tự xác định thành phần bị đụng từ `design/` (api, web).
   Tạo nhánh `feature/<ID>-<slug>`, chạy `bash scripts/new-change.sh auto <slug> <thành phần…>` (ID tự tăng). Báo lại ID.
4. Viết `requirement.md`: vì sao, trỏ tới issue và spec liên quan trong `requirements/` (không chép lại), chức năng nào
   trong scope; mỗi file thành phần: Baseline, Delta, việc `Tn`.
5. Chạy `bash scripts/status.sh`. Chưa mở PR: tech lead làm tiếp contract, design, features rồi mới tạo PR
   (`CLAUDE.md` §5 mục 6).

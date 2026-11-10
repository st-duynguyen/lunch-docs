---
name: change-new
description: Tạo phiếu việc mới changes/<ID>-<slug>/ từ một biên bản yêu cầu; ID tự tăng. Dùng khi nói "tạo change", "/change-new".
---
1. Đọc biên bản (mới nhất trong `requirements/` nếu không nói), so với `scope.md` §1 và `contract/`:
   yêu cầu có trong Không làm → dừng, hỏi PM.
2. Tự đặt slug ngắn tiếng Anh (vd `order-note`), tự xác định thành phần bị đụng từ `design/` (api, web).
   Chạy `bash scripts/new-change.sh auto <slug> <thành phần…>` (ID tự tăng). Báo lại ID vừa tạo.
2b. Tạo nhánh `feature/<ID>-<slug>`, commit biên bản + phiếu việc, push, mở **PR draft** `docs: <ID> …`
   (CLAUDE.md §5 mục 6). Báo lại link PR để chuyển cho người làm contract.
3. Viết `requirement.md` (vì sao, UC), mỗi file thành phần: Baseline, Delta, việc `Tn` nối số.
4. Chạy `bash scripts/status.sh`.

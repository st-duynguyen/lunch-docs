---
name: task
description: Làm việc code của một thay đổi từ link PR docs — BE (lunch-api), FE (lunch-web) hoặc cả hai. Dùng khi nói "/task <link PR> [be|fe|all]", "làm BE / FE theo PR docs …".
---
Đầu vào: link PR của lunch-docs + phạm vi `be` | `fe` | `all` (không nói = `all`).
Repo code nằm cạnh lunch-docs: `../lunch-api`, `../lunch-web` (phiên mở bằng `claude --add-dir ../lunch-api ../lunch-web`).

1. `gh pr view <link> --json number,title,state,files`. Lấy ID từ thư mục `changes/<ID>-*/` trong danh sách file
   (hoặc từ tiêu đề `docs: <ID> …`). PR chưa `MERGED` → dừng, báo “contract chưa merge, chưa code” (CLAUDE.md §4).
2. `git checkout main && git pull` ở lunch-docs để có contract mới nhất.
3. Với từng phạm vi:
   - `be` → repo `../lunch-api`, việc trong `changes/<ID>-*/api.md`
   - `fe` → repo `../lunch-web`, việc trong `changes/<ID>-*/web.md`
   Đọc `CLAUDE.md` của repo đó rồi làm theo CLAUDE.md §5 mục 7: `bash docs/scripts/docs-ref.sh --set`, viết test
   trước cho đỏ, code cho xanh, nhánh `feature/<ID>-Tn`, commit và PR **draft** có `[<ID>-Tn]` trong tiêu đề.
4. `all`: làm BE rồi FE (hai repo độc lập, không chờ nhau).
5. Báo lại: mỗi repo một dòng `Tn · link PR draft · test xanh/đỏ`.

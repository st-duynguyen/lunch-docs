# CLAUDE.md — Team Lunch Order

Luật chung cho người và AI ở cả 3 repo. Repo code nạp file này bằng `@docs/CLAUDE.md`.

## 1. Dự án

Web đặt cơm trưa cho team: xem menu, đặt món trước 11:00. Phạm vi và use case: `scope.md` §2.

## 2. Repo

| Repo | Nội dung |
|---|---|
| `lunch-docs` | Tài liệu (repo này) |
| `lunch-api` | BE Python, thư viện chuẩn, `GET /api/menus`, `POST /api/orders` |
| `lunch-web` | FE HTML + JS, chạy được với `FakeApi` đọc `contract/fixtures/` |

Phối hợp 3 repo: repo code có `docs/` là symlink tới `../lunch-docs` và file `.docs-ref` ghi commit docs đang theo.
PR docs merge trước, PR code sau. Mỗi repo một nhánh việc, một PR.

## 3. Nguồn sự thật (theo thứ tự)

`scope.md` → `contract/` → `design/` + `changes/` → `features/` → `qc/` → `decisions.md`.
Hai nơi nói khác nhau → **dừng, báo**, không tự đoán rồi code tiếp.

## 4. Contract

- Đổi field / endpoint / mã lỗi → **PR docs merge trước**, rồi mới PR code.
- Lỗi trả `{code, message}`; thời gian ISO-8601 `+07:00`.
- Mỗi thông tin chỉ viết một lần; chỗ khác trỏ tới bằng `file §N`.

Enum canonical (phải **giống hệt** `contract/README.md` §2, `status.sh` so):

```text
Order.status:  PLACED | CANCELLED
Error.code:    VALIDATION_ERROR | NOT_FOUND
```

## 5. Quy trình

0. Lời khách nói → biên bản `requirements/<yyyy-mm-dd>-<slug>.md`: ngày, ai nói, nguyên văn. Chưa phải cam kết.
1. Mỗi yêu cầu là một phiếu việc `changes/<ID>-<slug>/` (`bash scripts/new-change.sh auto <slug> <thành phần…>`:
   ID tự tăng C001, C002…), việc mã `T1, T2…`.
2. Tiêu đề PR code có `[<ID>-Tn]`; tiến độ suy từ git (`bash scripts/progress.sh`), không tick tay.
3. Kỳ vọng test chỉ lấy từ contract / scope; chưa có nguồn → `⚠` + một dòng `open-questions.md`.
4. Không sửa assertion / tắt test để CI xanh.
5. Làm việc với Claude: các bước và prompt mẫu ở `claude-workflow.md` §2; AI tự làm gì, phải hỏi gì ở §7.
6. Phiếu việc + contract của một thay đổi đi chung **một PR docs**: nhánh `feature/<ID>-<slug>`, PR vào `main`, tiêu đề `docs: <ID> …`. Người mở phiếu
   việc mở PR này ở dạng draft ngay; người sau làm tiếp trên chính PR đó (`gh pr checkout <link>`), không mở PR mới.
   **Link PR docs là thứ chuyển tay** giữa BA, lead, dev, QC. Đổi contract thì sửa cùng lúc JSON mẫu
   `contract/fixtures/`, `contract/CHANGELOG.md`, tài liệu bị ảnh hưởng (`scope.md`, `design/`, `features/`);
   chạy `bash scripts/status.sh`. Xong thì chuyển PR sang ready để review. Test case QC viết sau khi PR docs merge,
   đi PR riêng `qc: <ID> …`.
7. Làm một việc `Tn` ở repo code: đọc phiếu việc + contract, `bash docs/scripts/docs-ref.sh --set`, viết test trước
   (đọc JSON mẫu, cho thấy đỏ) rồi code cho xanh; nhánh `feature/<ID>-Tn`, commit và PR có `[<ID>-Tn]` trong tiêu đề,
   mở PR **draft**. Merge do người quyết.
8. “Làm việc tiếp theo” không kèm ID: lấy thay đổi có ID lớn nhất trong `changes/`, việc `Tn` của repo đang đứng
   (file `api.md` cho lunch-api, `web.md` cho lunch-web) chưa có PR.

## 6. Vai trò

| Vai | Viết / chịu trách nhiệm |
|---|---|
| PM / BA | `requirements/`, `scope.md`, phần “vì sao” của phiếu việc; hỏi khách các dòng `open-questions.md` |
| Tech lead | `CLAUDE.md`, `claude-workflow.md`, `.claude/`, `scripts/`; chia việc `Tn` |
| Lead BE + FE | `contract/`, `rules/` của phần mình |
| Dev | `design/`, code, test; `traps.md` khi dính bẫy |
| QC | `qc/`, duyệt `features/`; đóng issue sau khi tự kiểm |

## 7. Git

- Nhánh `feature/<ID>-<slug>` (docs) hoặc `feature/<ID>-Tn` (code), không commit thẳng `main`.
- AI được tự commit, push nhánh việc, mở PR **draft**. PR thường, merge, push `main`: hỏi người
  (hook `.claude/hooks/guard.py` đọc `.claude/hooks/guard.conf`).
- PR ghi `Refs #N`, không `Closes`: QC đóng issue sau khi tự kiểm.

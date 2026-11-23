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

0. Yêu cầu mới: **PM / BA tạo issue** ở repo lunch-docs (`/issue-new`, theo mẫu `.github/ISSUE_TEMPLATE/yeu-cau.md`: khách nói gì,
   ai nói, ngày). Issue chưa phải cam kết.
1. Mỗi yêu cầu là một phiếu việc `changes/<ID>-<slug>/` (`bash scripts/new-change.sh auto <slug> <thành phần…>`:
   ID tự tăng C001, C002…), việc mã `T1, T2…`.
2. Tiêu đề PR code có `[<ID>-Tn]`; tiến độ suy từ git (`bash scripts/progress.sh`), không tick tay.
3. Kỳ vọng test chỉ lấy từ contract / scope; chưa có nguồn → `⚠` + một dòng `open-questions.md`.
4. Không sửa assertion / tắt test để CI xanh.
5. Làm việc với Claude: các bước và prompt mẫu ở `claude-workflow.md` §2; AI tự làm gì, phải hỏi gì ở §7.
6. Từ issue, **tech lead** viết một **PR docs** cho cả thay đổi: biên bản `requirements/<ngày>-<slug>.md` (chép nguyên
   văn từ issue), phiếu việc, contract (sửa cùng lúc JSON mẫu `contract/fixtures/`, `contract/CHANGELOG.md`),
   `scope.md`, `design/`, `features/`; chạy `bash scripts/status.sh`. Nhánh `feature/<ID>-<slug>`, tiêu đề
   `docs: <ID> …`, mô tả PR ghi `Refs #<số issue>`. Chỗ nào chưa rõ → ghi `open-questions.md`
   trong cùng PR và comment lên issue để PM / BA hỏi khách. **PM / BA review** PR: tài liệu có đúng yêu cầu khách không; **QC review**
   `features/`: kịch bản, tên nút có kiểm được không;
   duyệt xong mới merge. **Link PR docs** là thứ chuyển cho dev, QC. Test case QC viết sau khi merge, PR riêng `qc: <ID> …`.
7. Làm một việc `Tn` ở repo code: đọc phiếu việc + contract, `bash docs/scripts/docs-ref.sh --set`, viết test trước
   (đọc JSON mẫu, cho thấy đỏ) rồi code cho xanh; nhánh `feature/<ID>-Tn`, commit và PR có `[<ID>-Tn]` trong tiêu đề,
   mở PR **draft**. Merge do người quyết.
8. “Làm việc tiếp theo” không kèm ID: lấy thay đổi có ID lớn nhất trong `changes/`, việc `Tn` của repo đang đứng
   (file `api.md` cho lunch-api, `web.md` cho lunch-web) chưa có PR.

## 6. Vai trò

| Vai | Viết / chịu trách nhiệm |
|---|---|
| PM / BA | Tạo issue yêu cầu; **review PR docs** xem có đúng yêu cầu khách; hỏi khách các dòng `open-questions.md` |
| Tech lead | **Viết PR docs** từ issue: `requirements/`, `changes/`, `contract/`, `scope.md`, `design/`, `features/`; chia việc `Tn`; giữ `CLAUDE.md`, `claude-workflow.md`, `.claude/`, `scripts/` |
| Lead BE + FE | `rules/` của phần mình; góp ý contract trong PR docs |
| Dev | Code, test theo PR docs đã merge; `traps.md` khi dính bẫy |
| QC | `qc/`; review `features/` trong PR docs; đóng issue sau khi tự kiểm |

## 7. Git

- Nhánh `feature/<ID>-<slug>` (docs) hoặc `feature/<ID>-Tn` (code), không commit thẳng `main`.
- AI được tự commit, push nhánh việc, mở PR **draft**. PR thường, merge, push `main`: hỏi người
  (hook `.claude/hooks/guard.py` đọc `.claude/hooks/guard.conf`).
- PR ghi `Refs #N`, không `Closes`: QC đóng issue sau khi tự kiểm.

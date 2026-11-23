# Làm việc với Claude Code

Cách giao việc cho Claude từ lúc khách nói tới lúc có PR. File này chỉ nói **làm thế nào**: gõ gì, Claude làm gì.
Luật phải giữ ở `CLAUDE.md` §5, ai chịu trách nhiệm ở `CLAUDE.md` §6.

## 1. Mở phiên

```bash
cd lunch-docs && claude --add-dir ../lunch-api ../lunch-web
```

Một phiên làm được cả 3 repo. Claude tự đọc `CLAUDE.md`, `rules/` của phần đang sửa, và các lệnh `/…` trong
`.claude/skills/`. Hook `.claude/hooks/guard.py` chạy trước mỗi lệnh shell của Claude.

## 2. Các bước của một thay đổi

| Bước | Prompt mẫu | Claude làm | Người làm |
|---|---|---|---|
| 1. Issue | — (PM / BA tạo trên GitHub theo mẫu `yeu-cau`) | — | PM / BA ghi yêu cầu khách |
| 2. Phiếu việc | `/change-new <link issue>` | Chép yêu cầu vào `requirements/`, tạo `changes/<ID>-<slug>/`, chia `T1`, `T2` | Tech lead kiểm |
| 3. PR docs | `Cập nhật contract, design, features cho thay đổi này: …` rồi `Tạo PR cho thay đổi này` | Sửa contract, JSON mẫu, scope, design, features, chạy `status.sh`, mở PR `Refs #<issue>` | PM / BA review, **merge** |
| 4. Code | `/task <link PR docs> be` · `fe` · (trống = cả hai) | Test trước, code, PR draft `[<ID>-Tn]` | Review, **merge** |
| 5. Test case | `/qc-test-cases theo <link PR docs>` | Thêm case, đánh `⚠` chỗ chưa có nguồn | Hỏi khách các `⚠` |
| 6. Tiến độ | `bash scripts/progress.sh` | — | Đọc kết quả |
| 7. Kiểm chứng | `/dev-verify order` | Chạy kịch bản `features/`, ghi `qc/runs/` | Đóng issue |

Bước 2–3 do tech lead làm trong một phiên. Bước 4 chỉ bắt đầu khi PR docs ở bước 3 đã merge (`CLAUDE.md` §4).

## 3. Câu giao việc ngắn

Prompt ngắn là đủ vì luật đã nằm trong tài liệu. Không cần nhắc tên file, tên nhánh, cách đặt tiêu đề PR:
Claude đọc từ `CLAUDE.md` §5 và §7. Khi đổi người làm, chỉ cần chuyển **link PR docs**: Claude đọc PR để biết
thay đổi nào, mã gì, đang ở nhánh nào.

## 4. Khi nào Claude dừng chờ người

- Hai tài liệu nói khác nhau (`CLAUDE.md` §3): dừng, báo, không tự chọn.
- Kỳ vọng test không có nguồn: đánh `⚠`, ghi `open-questions.md`.
- PR docs chưa merge mà được giao code: dừng, báo.
- Lệnh nằm trong danh sách ASK của `.claude/hooks/guard.conf` (merge, PR thường, push `main`): hook hỏi người.

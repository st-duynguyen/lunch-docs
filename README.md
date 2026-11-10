# lunch-docs: tài liệu dự án Team Lunch Order

Repo **nguồn sự thật** của dự án đặt cơm trưa cho team. Repo code (`lunch-api`, `lunch-web`) trỏ tới đây
qua symlink `docs/` và khóa phiên bản bằng file `.docs-ref`.

| Thư mục / file | Trả lời câu hỏi |
|---|---|
| `CLAUDE.md` | Luật chơi chung là gì? |
| `scope.md` | Có làm không? (use case + tiêu chí chấp nhận) |
| `requirements/` | Khách đã nói gì? (đầu vào thô, chưa là cam kết) |
| `contract/` | API ra sao? (field, mã lỗi, JSON mẫu `fixtures/`) |
| `design/` | Hệ thống đang thế nào? |
| `changes/` | Đang làm việc gì? (mỗi yêu cầu một phiếu việc, việc mã `Tn`) |
| `rules/` | Sửa phần này phải giữ gì? |
| `features/` | Thử bằng tay thế nào sau deploy? |
| `qc/` | Test gì, kết quả ra sao? |
| `decisions.md` · `open-questions.md` · `traps.md` | Vì sao? Còn gì chưa chốt? Cần tránh gì? |
| `scripts/` | Máy kiểm tra giúp gì? |
| `claude-workflow.md` | Làm việc với Claude thế nào? (các bước, prompt mẫu) |
| `.claude/hooks/guard.conf` | AI được tự làm gì, phải hỏi gì? |

Kiểm tra tài liệu: `bash scripts/status.sh` · tiến độ: `bash scripts/progress.sh`

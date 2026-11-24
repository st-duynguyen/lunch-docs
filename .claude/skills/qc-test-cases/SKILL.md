---
name: qc-test-cases
description: Sinh test case vào qc/cases/<feature>.md từ contract + scope; nhận link PR docs hoặc mã thay đổi để biết thay đổi nào. Dùng khi nói "tạo test case", "/qc-test-cases".
---
1. Có link PR docs: `gh pr view <link> --json files` để biết thay đổi và file contract bị đổi. Rồi đọc
   `features/<feature>.md`, contract liên quan, `scope.md` §2.
2. Viết case theo `qc/README.md` §2 (bảng 7 cột) và §3 (mỗi chức năng con: bình thường, biên, lỗi). Mỗi kỳ
   vọng ghi cột Nguồn (`file §N`). Nối tiếp số ID đang có.
3. Kỳ vọng không có nguồn → ghi `⚠` ở Kỳ vọng và thêm một dòng `open-questions.md` (kèm mặc định). Không tự nghĩ ra.
4. PR docs đã merge → nhánh `feature/<ID>-qc`, mở PR `qc: <ID> …`. Chưa merge → ghi vào nhánh của PR docs đó.
5. Chạy `bash scripts/qc-lint.sh` và `bash scripts/status.sh`.

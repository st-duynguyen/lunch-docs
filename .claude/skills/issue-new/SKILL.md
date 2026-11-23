---
name: issue-new
description: PM / BA tạo issue yêu cầu mới trên GitHub từ lời khách, theo mẫu .github/ISSUE_TEMPLATE/yeu-cau.md. Dùng khi nói "/issue-new …", "tạo issue cho yêu cầu …".
---
Đầu vào: lời khách (nguyên văn) và, nếu có, ai nói, ngày, hạn cần có.

1. Đọc mẫu `.github/ISSUE_TEMPLATE/yeu-cau.md`. Điền đủ các mục; mục nào người dùng chưa nói thì ghi `(chưa rõ)`,
   không tự bịa. Ngày nói mặc định là hôm nay.
2. Tiêu đề: `Yêu cầu: <tóm tắt một dòng>`.
3. So nhanh với `scope.md` §1: yêu cầu rơi vào phần Không làm thì ghi thêm một dòng cảnh báo ở “Ghi chú thêm”.
4. In bản xem trước (tiêu đề + nội dung) cho người dùng.
5. Tạo issue: `gh issue create --title "<tiêu đề>" --body-file <file tạm>`. Hook sẽ hỏi xác nhận trước khi ghi lên GitHub.
6. Trả về link issue. Đây chưa phải cam kết; tech lead dùng link này cho `/change-new`.

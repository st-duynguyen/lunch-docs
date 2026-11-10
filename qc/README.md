# QC

## 1. Thư mục

| Đường dẫn | Chứa gì |
|---|---|
| `cases/<feature>.md` | Bộ test case của một feature (tên feature giống `features/<feature>.md`) |
| `runs/<yyyy-mm-dd>-<môi trường>-<feature>.md` | Một lượt chạy: chạy bản nào, từng case PASS / FAIL, bằng chứng |

## 2. Bảng test case

Mỗi dòng một case, 7 cột: `ID` · `Chức năng con` (khớp `features/` §1) · `Loại` · `P` · `Các bước` · `Kỳ vọng` · `Nguồn`.

- `ID`: `TC-<feature>-NNN`, không trùng (`bash scripts/qc-lint.sh` kiểm).
- `Loại`: Bình thường · Biên · Lỗi.
- `P`: P1 (phải PASS mới release) · P2.
- `Nguồn`: chỗ lấy kỳ vọng, dạng `file §N`. Kỳ vọng không có nguồn → ghi `⚠` ở cột Kỳ vọng và thêm một dòng
  `open-questions.md`. Không tự nghĩ ra kỳ vọng.

## 3. Suy case từ đâu

Với mỗi chức năng con, đi qua 3 loại:

- **Bình thường:** đường đi chính ở `features/` §2.
- **Biên:** giá trị ở sát giới hạn trong contract (vd số lượng đúng 5).
- **Lỗi:** giá trị vượt giới hạn, dữ liệu không có, mỗi mã lỗi trong contract ít nhất một case.

## 4. Ghi một lượt chạy

Mỗi lần chạy trên môi trường thật là một file `runs/`. Ghi: ngày, ai chạy, chạy bản nào của từng repo, bảng
`ID · Kết quả · Bằng chứng`, và tổng kết. Case FAIL thì mở issue, ghi số issue vào cột Bằng chứng.

#!/usr/bin/env bash
# new-change.sh <ID|auto> <slug> <thành phần…> — tạo phiếu việc changes/<ID>-<slug>/ từ _template, thêm dòng DRAFT.
# auto: ID = C + số kế tiếp sau thư mục lớn nhất trong changes/ (C001 → C002).
cd "$(dirname "$0")/.." || exit 2
id=${1:?ID hoặc auto}; slug=${2:?slug}; shift 2
if [ "$id" = auto ]; then
  n=$(ls -d changes/C[0-9][0-9][0-9]-* 2>/dev/null | sed -E 's#changes/C0*([0-9]+)-.*#\1#' | sort -n | tail -1)
  id=$(printf 'C%03d' $(( ${n:-0} + 1 )))
fi
d="changes/$id-$slug"; mkdir -p "$d"
sed "s/<ID>/$id/; s/<tên>/$slug/" changes/_template/requirement.md > "$d/requirement.md"
for c in "$@"; do sed "s/<ID>/$id/; s/<thành phần>/$c/" changes/_template/component.md > "$d/$c.md"; done
echo "| $id | $slug | DRAFT |" >> changes/README.md
echo "Đã tạo $d"; ls "$d"

#!/usr/bin/env bash
# progress.sh [ID] — (mặc định: thay đổi mới nhất) tiến độ suy từ PR, không tick tay. Mỗi việc `Tn` ở changes/<ID>-*/<thành phần>.md;
# PR ở repo lunch-<thành phần> có `[<ID>-Tn]` trong tiêu đề. Trạng thái: MERGED · DEV (PR đang mở) · TODO.
# Đọc PR trên GitHub qua `gh`; không có gh / mạng thì đọc git local ../lunch-<thành phần>.
cd "$(dirname "$0")/.." || exit 2
id="${1:-$(ls -d changes/C[0-9][0-9][0-9]-* 2>/dev/null | sort | tail -1 | sed -E 's#changes/(C[0-9]+)-.*#\1#')}"
dir=$(ls -d changes/"$id"-*/ 2>/dev/null | head -1) || true
[ -n "$dir" ] || { echo "Không có changes/$id-*"; exit 1; }
owner=$(git remote get-url origin 2>/dev/null | sed -E 's#.*[:/]([^/]+)/[^/]+$#\1#')
head -1 "$dir/requirement.md" | sed 's/^# //'
for f in "$dir"*.md; do
  comp=$(basename "$f" .md); [ "$comp" = requirement ] && continue
  repo="../lunch-$comp"
  grep -oE 'T[0-9]+ .*' "$f" | while read -r t rest; do
    tag="[$id-$t]"; st=""
    if command -v gh >/dev/null && [ -n "$owner" ]; then
      pr=$(gh pr list -R "$owner/lunch-$comp" --state all --limit 100 --json number,state,title \
        --jq "first(.[] | select(.title | contains(\"$tag\"))) | \"\(.state) #\(.number)\"" 2>/dev/null)
      case "$pr" in MERGED*) st="MERGED|PR ${pr#* }";; OPEN*) st="DEV|PR ${pr#* } đang mở";; esac
    fi
    if [ -z "$st" ] && [ -d "$repo/.git" ]; then
      if sha=$(git -C "$repo" log main -F --grep="$tag" --format=%h -1) && [ -n "$sha" ]; then
        st="MERGED|main $sha (git local)"
      elif c=$(git -C "$repo" log --all -F --grep="$tag" --format=%H -1) && [ -n "$c" ]; then
        st="DEV|$(git -C "$repo" branch --contains "$c" --format='%(refname:short)' | head -1) (git local)"
      fi
    fi
    st=${st:-"TODO|"}
    printf '  %-4s %-4s %-7s %s\n' "$t" "$comp" "${st%%|*}" "${st#*|}"
  done
done

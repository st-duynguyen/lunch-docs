#!/usr/bin/env bash
# status.sh — kiểm tài liệu, chạy trong CI mỗi PR. Báo:
#   LỆCH  fixture không khớp bảng Fields của contract; enum CLAUDE.md khác contract/README.md
#   GÃY   chỗ trỏ `file §N` tới mục không có thật
#   VƯỢT  CLAUDE.md dài quá 200 dòng
#   LỖI   fixture không phải JSON hợp lệ
# Exit 1 khi có lỗi (CI đỏ).
cd "$(dirname "$0")/.." || exit 2
python3 - <<'PY'
import glob, json, os, re, sys
bad = []
# 1. Fixture hợp lệ và khớp bảng Fields, xét từng mục "## …" có dòng Fixture:
for md in sorted(glob.glob("contract/*.md")):
    for sec in re.split(r"^(?=## )", open(md, encoding="utf-8").read(), flags=re.M):
        m = re.search(r"^Fixture: (\S+)", sec, re.M)
        if not m:
            continue
        where = md + " " + sec.splitlines()[0].lstrip("# ").split(" ")[0]
        fx = os.path.join("contract", m.group(1))
        try:
            data = json.load(open(fx, encoding="utf-8"))
        except Exception as e:
            bad.append(f"LỖI   {fx}: JSON sai ({e})"); continue
        fields = {r.group(1) for r in re.finditer(r"^\| (\w+) \|", sec, re.M)} - {"Field"}
        keys = set(data)
        if fields != keys:
            extra, miss = sorted(keys - fields), sorted(fields - keys)
            bad.append(f"LỆCH  {fx} ↔ {where}: fixture thừa {extra}, thiếu {miss}")
# 2. Enum CLAUDE.md == contract/README.md
blk = lambda p: re.search(r"```text\n(.*?)```", open(p, encoding="utf-8").read(), re.S).group(1)
if blk("CLAUDE.md") != blk("contract/README.md"):
    bad.append("LỆCH  enum CLAUDE.md §4 khác contract/README.md §2")
# 3. Chỗ trỏ `file §N`
for md in glob.glob("**/*.md", recursive=True):
    for path, n in re.findall(r"`?([\w./-]+\.md)`? §(\d+)", open(md, encoding="utf-8").read()):
        if not os.path.exists(path):
            bad.append(f"GÃY   {md}: trỏ {path} §{n}, file không có"); continue
        if not re.search(rf"^## {n}\.", open(path, encoding="utf-8").read(), re.M):
            bad.append(f"GÃY   {md}: trỏ {path} §{n}, không có mục ## {n}.")
# 4. Độ dài CLAUDE.md
n = sum(1 for _ in open("CLAUDE.md", encoding="utf-8"))
if n > 200:
    bad.append(f"VƯỢT  CLAUDE.md {n} dòng (> 200)")
for b in bad:
    print(b)
print("OK: tài liệu khớp" if not bad else f"\n{len(bad)} lỗi")
sys.exit(1 if bad else 0)
PY

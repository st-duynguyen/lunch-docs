#!/usr/bin/env bash
# docs-ref.sh --set | --check — chạy trong repo code. --set ghi sha main của docs vào .docs-ref;
# --check: sha trong .docs-ref phải là commit đã có trên main của docs (CI docs-pin gọi).
docs=docs
ref=main; git -C "$docs" rev-parse -q --verify main >/dev/null || ref=origin/main
case "$1" in
  --set) git -C "$docs" rev-parse "$ref" > .docs-ref && echo ".docs-ref = $(cat .docs-ref)";;
  --check)
    sha=$(cat .docs-ref)
    if git -C "$docs" merge-base --is-ancestor "$sha" "$ref" 2>/dev/null; then echo "OK: $sha có trên main docs"
    else echo "LỖI: .docs-ref $sha không có trên main docs"; exit 1; fi;;
  *) echo "Dùng: docs-ref.sh --set | --check"; exit 2;;
esac

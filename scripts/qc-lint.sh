#!/usr/bin/env bash
# qc-lint.sh — ID test case dạng TC-<feature>-NNN và không trùng.
cd "$(dirname "$0")/.." || exit 2
ids=$(grep -ohE '^\| TC-[a-z]+-[0-9]{3}' qc/cases/*.md | tr -d '| ')
dup=$(echo "$ids" | sort | uniq -d)
[ -z "$dup" ] && echo "OK: $(echo "$ids" | wc -l | tr -d ' ') case, không trùng ID" || { echo "LỖI: trùng $dup"; exit 1; }

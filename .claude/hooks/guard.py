#!/usr/bin/env python3
# Hook PreToolUse của Claude Code: đọc lệnh shell sắp chạy, so với guard.conf.
# Khớp DENY → chặn hẳn (người bấm đồng ý cũng không chạy); khớp ASK → bắt người xác nhận; khớp ALLOW → cho chạy thẳng; không khớp → để Claude Code hỏi như thường.
import json, os, re, sys

cmd = json.load(sys.stdin).get("tool_input", {}).get("command", "")
conf = os.path.join(os.path.dirname(os.path.abspath(__file__)), "guard.conf")
rules = [l.strip().split("=", 1) for l in open(conf, encoding="utf-8") if re.match(r"^(DENY|ASK|ALLOW)=", l)]

def decide(kind, reason):
    print(json.dumps({"hookSpecificOutput": {"hookEventName": "PreToolUse",
                                             "permissionDecision": kind, "permissionDecisionReason": reason}}))
    sys.exit(0)

for part in re.split(r"\s*(?:&&|\|\||;)\s*", cmd):
    for kind, pat in rules:
        if kind == "DENY" and re.search(pat, part):
            decide("deny", f"guard.conf: “{pat}” bị chặn — người tự chạy nếu thật sự cần")
for part in re.split(r"\s*(?:&&|\|\||;)\s*", cmd):
    for kind, pat in rules:
        if kind == "ASK" and re.search(pat, part):
            decide("ask", f"guard.conf: “{pat}” cần người xác nhận")
parts = [p for p in re.split(r"\s*(?:&&|\|\||;)\s*", cmd) if p]
if parts and all(any(k == "ALLOW" and re.search(p_, part) for k, p_ in rules) for part in parts):
    decide("allow", "guard.conf: việc AI được tự làm")
sys.exit(0)

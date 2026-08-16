#!/usr/bin/env python3
"""asset/session-*.html 에 doctype/head 껍데기를 씌운다. 이미 있으면 건너뜀."""
import pathlib
import sys

HEAD = """<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="noindex, nofollow">
"""

target = pathlib.Path(sys.argv[1])
for p in sorted(target.glob("session-*.html")):
    text = p.read_text(encoding="utf-8")
    if text.lstrip().lower().startswith("<!doctype"):
        print(f"skip  {p.name}")
        continue
    p.write_text(HEAD + text.lstrip() + "\n</html>\n", encoding="utf-8")
    print(f"wrap  {p.name}")

#!/usr/bin/env bash
# Obsidian vault 의 asset/ 에서 세션 자료를 가져와 GitHub Pages 에 올린다.
# 자료를 고쳤으면 vault 쪽만 고치고 이걸 실행하면 된다.
set -euo pipefail

VAULT="${VAULT:-$HOME/Documents/noah arch}"
SRC="$VAULT/asset"
cd "$(dirname "$0")"

[ -d "$SRC" ] || { echo "vault 를 못 찾음: $SRC" >&2; exit 1; }

cp "$SRC"/session-*.html "$SRC"/session-*.xlsx .
mkdir -p pdf && cp "$SRC"/pdf/*.pdf pdf/

# doctype/charset/viewport/noindex 가 없는 파일에 껍데기를 씌운다 (이미 있으면 건너뜀)
python3 wrap-head.py .

git add -A
if git diff --cached --quiet; then
  echo "바뀐 것 없음."
  exit 0
fi
git commit -m "자료 갱신 $(date +%F)"
git push
echo
echo "https://kiki3700.github.io/ai-session/ · 반영까지 1분쯤 걸린다"

#!/usr/bin/env bash
# new-post.sh — 새 글 생성 (new-post.bat가 Git Bash로 실행)
cd "$(dirname "$0")/.." || exit 1

B=$'\e[1m'; R=$'\e[0m'; ACC=$'\e[38;5;131m'; DIM=$'\e[2m'

echo
echo "  ${B}새 글 만들기${R}"
echo
echo "  ${ACC}1${R}) Blog"
echo "  ${ACC}2${R}) Investment Diary"
echo
read -rp "  선택 (1/2): " KIND
echo

if [ "$KIND" = "2" ]; then
  read -rp "  일기 이름 ${DIM}(그냥 Enter = 날짜로 자동)${R}: " NAME
  NAME=${NAME// /-}
  TODAY=$(date +%F)
  if [ -z "$NAME" ]; then
    TARGET="diary/${TODAY}"
    n=2
    while [ -d "content/${TARGET}" ]; do TARGET="diary/${TODAY}-${n}"; n=$((n+1)); done
  else
    TARGET="diary/${TODAY}-${NAME}"
  fi
elif [ "$KIND" = "1" ]; then
  # 카테고리 목록 (content/blog 아래 _index.md 있는 폴더)
  CATS=()
  while IFS= read -r d; do CATS+=("${d#content/blog/}"); done \
    < <(find content/blog -mindepth 2 -name "_index.md" | sed 's|/_index.md$||' | sort)
  echo "  ${B}카테고리${R}"
  i=1
  for c in "${CATS[@]}"; do printf "  ${ACC}%2d${R}) %s\n" "$i" "$c"; i=$((i+1)); done
  echo
  read -rp "  카테고리 번호: " CI
  CAT="${CATS[$((CI-1))]}"
  [ -z "$CAT" ] && { echo "  잘못된 번호 — 취소"; read -n1 -srp ""; exit 1; }
  read -rp "  글 이름 ${DIM}(영문 권장 — 폴더명이자 URL이 됨, 예: black-scholes-note)${R}: " NAME
  NAME=${NAME// /-}
  [ -z "$NAME" ] && { echo "  이름이 비어 있음 — 취소"; read -n1 -srp ""; exit 1; }
  TARGET="blog/${CAT}/${NAME}"
else
  echo "  1 또는 2를 입력 — 취소"; read -n1 -srp ""; exit 1
fi

hugo new "$TARGET" >/dev/null || { echo "  생성 실패"; read -n1 -srp ""; exit 1; }
FILE="content/${TARGET}/index.md"
echo
echo "  ${ACC}생성됨${R}  $FILE"

# Typora(기본 md 앱)로 열기
if command -v cygpath >/dev/null 2>&1; then
  cmd.exe /c start "" "$(cygpath -w "$FILE")" 2>/dev/null
elif command -v wslpath >/dev/null 2>&1; then
  cmd.exe /c start "" "$(wslpath -w "$FILE")" 2>/dev/null
fi
sleep 1

#!/usr/bin/env bash
# new-post.sh — 새 글 생성 (new-post.bat가 Git Bash로 실행)
cd "$(dirname "$0")/.." || exit 1

B=$'\e[1m'; R=$'\e[0m'; ACC=$'\e[38;5;131m'; DIM=$'\e[2m'

# 섹션의 정렬키를 조상 weight 체인으로 만든다 (예: foundations/information-theory -> "01.04.")
seckey() {
  local root="$1" rel="$2" key="" part w
  # p는 root 확장 뒤에 잡아야 한다 — local은 모든 단어를 먼저 확장하므로
  # 한 줄에 쓰면 $root 가 아직 비어 있다.
  local p="content/$root"
  local oldifs="$IFS"; IFS='/'
  for part in $rel; do
    p="$p/$part"
    w=$(grep -m1 '^weight:' "$p/_index.md" 2>/dev/null | tr -dc '0-9')
    key="${key}$(printf '%02d' "${w:-99}")."
  done
  IFS="$oldifs"
  printf '%s' "$key"
}

# 해당 섹션에서 다음에 쓸 2자리 번호 (기존 "NN. " 폴더의 최댓값 + 1)
next_num() {
  local dir="$1" max=0 n d
  for d in "$dir"/[0-9][0-9].\ *; do
    [ -d "$d" ] || continue
    n=$(basename "$d" | cut -c1-2)
    n=$((10#$n))
    [ "$n" -gt "$max" ] && max=$n
  done
  printf '%02d' $((max + 1))
}

echo
echo "  ${B}새 글 만들기${R}"
echo
echo "  ${ACC}1${R}) Quant Blog"
echo "  ${ACC}2${R}) Investment"
echo "  ${ACC}3${R}) Dev Blog"
echo
read -rp "  선택 (1/2/3): " KIND
echo

if [ "$KIND" = "2" ]; then
  # Investment: 1단 분류(industry-analysis, energy …) 아래에 "날짜-이름" 폴더로 만든다.
  ROOT="investment"
  CATS=()
  while IFS= read -r rel; do CATS+=("$rel"); done < <(
    find "content/$ROOT" -mindepth 2 -maxdepth 2 -name "_index.md" | sed 's|/_index.md$||' | while IFS= read -r d; do
      rel="${d#content/$ROOT/}"
      printf '%s\t%s\n' "$(seckey "$ROOT" "$rel")" "$rel"
    done | sort | cut -f2
  )
  echo "  ${B}카테고리${R}"
  i=1
  for c in "${CATS[@]}"; do printf "  ${ACC}%2d${R}) %s\n" "$i" "$c"; i=$((i+1)); done
  echo
  read -rp "  카테고리 번호: " CI
  CAT="${CATS[$((CI-1))]}"
  [ -z "$CAT" ] && { echo "  잘못된 번호 — 취소"; read -n1 -srp ""; exit 1; }

  read -rp "  글 이름 ${DIM}(영문 권장 — URL이 된다, 예: kospi-crash-review)${R}: " NAME
  NAME=${NAME// /-}
  [ -z "$NAME" ] && { echo "  이름이 비어 있음 — 취소"; read -n1 -srp ""; exit 1; }
  TODAY=$(date +%F)
  TARGET="${ROOT}/${CAT}/${TODAY}-${NAME}"
  [ -e "content/${TARGET}" ] && { echo "  이미 있음 — 취소"; read -n1 -srp ""; exit 1; }

  hugo new "$TARGET" >/dev/null || { echo "  생성 실패"; read -n1 -srp ""; exit 1; }
  FILE="content/${TARGET}/index.md"
  # 날짜는 폴더 정렬용 — URL에는 이름만 쓴다
  sed -i "0,/^slug: ''/s//slug: '${NAME}'/" "$FILE"

elif [ "$KIND" = "1" ] || [ "$KIND" = "3" ]; then
  # quant는 대분류/소분류 2단이라 글이 3단부터, dev는 flat이라 2단부터 놓인다.
  if [ "$KIND" = "3" ]; then ROOT="dev"; MIND=2; else ROOT="quant"; MIND=3; fi

  # 글을 담을 수 있는 섹션을 구조 순서(weight)대로 나열한다.
  # quant 대분류(content/quant/X/)는 제외 — 글은 하위 섹션에만 둔다. dev는 flat이라 전부 대상.
  # 하위 섹션은 자식 섹션이 있어도 글을 가질 수 있으므로 그대로 포함한다
  # (예: probability-statistics 는 linear-regression 을 품으면서 글도 10편 갖는다)
  CATS=()
  while IFS= read -r rel; do CATS+=("$rel"); done < <(
    find "content/$ROOT" -mindepth "$MIND" -name "_index.md" | sed 's|/_index.md$||' | while IFS= read -r d; do
      rel="${d#content/$ROOT/}"
      printf '%s\t%s\n' "$(seckey "$ROOT" "$rel")" "$rel"
    done | sort | cut -f2
  )

  echo "  ${B}카테고리${R} ${DIM}(구조 순서)${R}"
  i=1
  for c in "${CATS[@]}"; do printf "  ${ACC}%2d${R}) %s\n" "$i" "$c"; i=$((i+1)); done
  echo
  read -rp "  카테고리 번호: " CI
  CAT="${CATS[$((CI-1))]}"
  [ -z "$CAT" ] && { echo "  잘못된 번호 — 취소"; read -n1 -srp ""; exit 1; }

  read -rp "  글 이름 ${DIM}(영문 권장 — URL이 된다, 예: black-scholes-note)${R}: " NAME
  NAME=${NAME// /-}
  [ -z "$NAME" ] && { echo "  이름이 비어 있음 — 취소"; read -n1 -srp ""; exit 1; }
  [ -e "content/${ROOT}/${CAT}/${NAME}" ] && { echo "  이미 있음 — 취소"; read -n1 -srp ""; exit 1; }
  for d in "content/${ROOT}/${CAT}"/[0-9][0-9].\ "${NAME}"; do
    [ -e "$d" ] && { echo "  이미 있음: $(basename "$d") — 취소"; read -n1 -srp ""; exit 1; }
  done

  # 1) 번호 없는 이름으로 먼저 생성 (archetype 그대로 적용)
  # troubleshooting 글은 전용 양식(증상→재현→가설→원인→수정→배운것)을 쓴다
  KINDARG=()
  [ "$ROOT" = "dev" ] && [ "$CAT" = "troubleshooting" ] && KINDARG=(--kind dev-trouble)

  hugo new "${KINDARG[@]}" "${ROOT}/${CAT}/${NAME}" >/dev/null || { echo "  생성 실패"; read -n1 -srp ""; exit 1; }
  SRC="content/${ROOT}/${CAT}/${NAME}"

  # 2) slug 주입 — 폴더명의 "NN. "가 URL에 새어 들어가지 않게 한다.
  #    archetype에 있던 안내용 주석(# slug: ...)은 실제 값으로 대체되므로 지운다.
  if ! grep -q '^slug:' "$SRC/index.md"; then
    awk -v s="$NAME" '
      /^# slug:/ { next }
      !d && /^title:/ { print; print "slug: \"" s "\"   # 폴더 앞 \"NN. \"가 URL에 새지 않게 한다"; d=1; next }
      { print }
    ' "$SRC/index.md" > "$SRC/index.md.tmp" && mv "$SRC/index.md.tmp" "$SRC/index.md"
  fi

  # 3) 번호 붙여 이름 변경 (탐색기·Typora에서 읽는 순서대로 정렬되도록)
  NUM=$(next_num "content/${ROOT}/${CAT}")
  mv "$SRC" "content/${ROOT}/${CAT}/${NUM}. ${NAME}"
  FILE="content/${ROOT}/${CAT}/${NUM}. ${NAME}/index.md"

else
  echo "  1~3 중에서 입력 — 취소"; read -n1 -srp ""; exit 1
fi

echo
echo "  ${ACC}생성됨${R}  $FILE"
echo "  ${DIM}URL${R}      /${ROOT}/${CAT}/${NAME}/"

# Typora(기본 md 앱)로 열기
# 주의: Git Bash에서 cmd.exe /c는 /c가 C:\로 경로 변환되는 문제가 있어 explorer 사용
if command -v cygpath >/dev/null 2>&1; then
  explorer.exe "$(cygpath -w "$FILE")" || true
elif command -v wslpath >/dev/null 2>&1; then
  cmd.exe /c start "" "$(wslpath -w "$FILE")" 2>/dev/null || true
fi
sleep 1

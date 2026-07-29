# 글쓰기 가이드 — Typora로 편하게

Blog와 Investment Diary 모두 **글 하나 = 폴더 하나**(페이지 번들)다.
이미지는 그 폴더 안에 살고, Typora가 붙여넣기만으로 알아서 처리한다.

```
content/blog/financial-engineering/options/my-post/
├── index.md          ← 글 본문
├── payoff.png        ← 붙여넣은 이미지 (자동 저장됨)
└── delta-hedge.svg
```

## 0. Typora 최초 설정 (한 번만)

**이미지 자동 저장** — 파일 → 환경설정 → 이미지:

1. "이미지 삽입할 때..." → **"지정 폴더로 이미지 복사"** 선택, 폴더에 `./` 입력
   (= 지금 편집 중인 index.md와 같은 폴더로 복사된다)
2. **"가능하면 상대 경로 사용"** 체크
3. "로컬 이미지에 위 규칙 적용" 체크 (웹 이미지도 원하면 같이 체크)

이후로는 스크린샷/이미지를 **Ctrl+V** 하는 순간 파일이 글 폴더에 저장되고
`![](image-20260801.png)` 링크까지 자동으로 박힌다. 손댈 게 없다.

**수식 실시간 렌더링** — 파일 → 환경설정 → Markdown → 문법 지원:

- **"인라인 수식 $...$"** 체크 (Typora 재시작 필요)

블록 수식은 기본으로 켜져 있다: `$$` 치고 Enter → 수식 입력창이 열리고 즉시 렌더링.

**테마**: Typora 테마를 Newsprint로 두면 쓰는 화면이 블로그와 거의 같다.

## 1. 새 글 만들기 — 3가지 방법 (편한 순)

**① 더블클릭 (권장):** 저장소 루트의 `new-post.bat` 더블클릭 → b(블로그)/d(일기) 선택 →
이름 입력 → index.md가 기본 편집기(Typora)로 바로 열린다. 일기는 오늘 날짜가 자동으로 붙는다.

**② 폴더 복사:** 탐색기에서 기존 글 폴더(또는 `content/blog/writing-template/`,
`content/diary/2026-07-29-first-entry-example/`)를 복사 → 폴더명 바꾸고 →
index.md 열어서 front matter의 title·date만 고치면 끝. 터미널 불필요.

**③ 터미널:** 저장소 루트에서

```bash
hugo new blog/financial-engineering/options/my-post   # Blog
hugo new diary/2026-08-01-cpi-note                    # Diary
```

어느 방법이든 결과는 같다: `.../글이름/index.md` + front matter 자동 완성.
Typora에서 md를 여는 게 귀찮으면 `.md` 기본 앱을 Typora로 지정해두면 된다
(우클릭 → 연결 프로그램 → 항상 이 앱 사용).

## 2. 쓰면서

| 하고 싶은 것 | 방법 |
|---|---|
| 이미지 | 복사 → Ctrl+V. 끝. (0번 설정 덕분에 자동 저장·자동 링크) |
| 인라인 수식 | `$\mu\sigma$` — 타이핑 즉시 렌더링 |
| 블록 수식 | `$$` + Enter → 입력창에서 작성 |
| 표 | 서식 → 표 (Ctrl+T) |
| 각주·인용·코드 | 마크다운 그대로 — 블로그도 동일하게 렌더링 |
| 목록 미리보기 (일기) | front matter `description: "한 줄"` |
| 대표그림 (블로그 목록) | 자동: 본문 첫 이미지. 바꾸려면 front matter `cover: "파일명.png"` |

## 3. 미리보기와 발행

```bash
hugo server -D        # http://localhost:1313 — draft 포함 실시간 미리보기
```

Typora 화면이 곧 90% 미리보기지만, **발행 전 한 번은 hugo server로 확인**해라.
Typora(MathJax)와 블로그(KaTeX)의 수식 엔진이 달라서 아주 드물게 차이가 난다.

확인했으면: front matter의 `draft: true` 줄 삭제 → commit → push. GitHub Actions가 배포한다.

## 4. 수식 안전 규칙 — 검증 완료 (2026-07-29)

기존 23개 글의 수식 **1,060개 전부** + 구문 배터리 24종을
KaTeX(블로그)·MathJax(Typora)·Goldmark(Hugo 파서) 3중으로 돌려서 확정한 규칙이다.
복사용 실물 양식: `content/blog/writing-template/` (draft — 배포 안 됨).

**금지 2개 (블로그에서만 깨져서 더 위험):**

1. `\label` / `\eqref` → 번호는 `\tag{1}` 수동으로.
2. `math: true` 글 본문에서 통화 기호 `$` 단독 사용 → "100달러"로 풀어 쓰기.
   (렌더러가 다음 `$`와 짝지어 문장을 수식으로 오인. `math: false` 글은 무관.)

**나머지는 전부 안전 (검증됨):** `aligned`·`align`·`cases`·`pmatrix`·`bmatrix`,
`\tag`, `\operatorname(*)`, `\mathbb`·`\mathcal`·`\mathbf`·`\boldsymbol`, `\text{한글}`,
`\underbrace`, `\boxed`, `\tfrac`·`\dfrac`, `\left\right`·`\Big`, `\{ \}`와 `\lbrace` 둘 다,
`\prec`, `\substack`, `\overset`·`\underset`, 여러 줄 `\\` 정렬, 연산자 줄 끝, 한 줄 인라인 여러 개.

예전 규칙("`\lbrace`만 쓸 것", "연산자를 줄 끝에 두지 말 것")은 passthrough 도입 후
필요 없어졌다 — 취향대로 쓰면 된다.

## 5. 기존 글 (구식 방식)

이전 글들은 `static/img/posts/<글이름>/` + `/img/...` 절대경로 방식인데
그대로 작동한다. 옮길 필요 없음. 새 글만 번들로 쓰면 된다.

# Munseok and Quantitative Investing

Hugo + [Terminal 테마](https://github.com/panr/hugo-theme-terminal) 기반 블로그.
https://chlanstjr0301.github.io

## 구조

- 메뉴: **About** (`content/about.md`) / **Project** (`content/projects.md`) / **Blog** (`content/blog/`) / **Dev** (`content/dev/`) / **Investment Diary** (`content/diary/`)
- `/blog/`는 티스토리형 목록: 좌측 카테고리 패널(글 수 표시, 빈 카테고리 자동 숨김) + 우측 최신순 글 목록. 폴더 구조가 곧 카테고리다.
- 홈(`/`)은 `/blog/`로 리다이렉트되고, 상단 제호 클릭도 `/blog/`로 간다.
- 각 글에는 목차가 자동 생성된다 (넓은 화면: 우측 사이드바 + 스크롤 하이라이트, 좁은 화면: 상단 접이식).

## 글 쓰기

**Typora 기반 워크플로는 `WRITING.md` 참고.** 글 하나 = 폴더 하나(페이지 번들)가 기본이다.

```bash
hugo new blog/quantitative-finance/derivatives/my-post   # → my-post/index.md 생성
hugo new dev/build/my-tool                              # → dev 글 번들 생성
hugo new diary/2026-08-01-my-note                     # → 일기 번들 생성
```

- 저장 위치가 곧 카테고리. 새 카테고리는 폴더 생성 후 `_index.md`에 `title`, `weight`(목차 번호 순서)를 지정.
- front matter: `math: true` → KaTeX 수식 ($...$, $$...$$), `toc: false` → 글 내 목차 끄기, `draft: true` → 배포 제외.
- 이미지는 글 폴더 안에 두고 `![](파일명.png)` 상대경로로 참조 (Typora 붙여넣기가 자동으로 처리).
  구식 방식(`static/img/posts/` + `/img/...` 절대경로)도 기존 글에서 계속 작동한다.
- 목록의 대표그림: front matter `cover` 지정 → 없으면 본문 첫 그림(figure 쇼트코드 포함) 자동 사용 → 그것도 없으면 텍스트 행. 번들의 상대경로 이미지도 자동 인식된다.
- 인기 글: `hugo.toml`의 `params.sections.blog.featured`에 글 URL(RelPermalink)을 추가하면 /blog/ 상단에 고정된다.
- 검색: 빌드 시 `/index.json` 인덱스가 생성되고 /blog/ 검색창이 제목·내용·태그를 클라이언트에서 검색한다.

## Dev (`/dev/`)

개발 기록 공간. Blog가 "개념·이론 정리"라면 Dev는 **"만든 것과 깨진 것"**이다.
목록 레이아웃은 Blog와 같은 것(`layouts/_default/section.html`)을 공유하되,
섹션 파라미터로 카테고리 패널·검색을 껐다 켤 수 있다.

| 카테고리 | 담는 글 |
|---|---|
| `troubleshooting/` | 장애·버그 추적기 — Dev의 중심 |
| `build/` | 만든 것 (도구, 엔진, 파이프라인) |
| `notes/` | 언어·기술 학습 노트 |

**기술 스택은 폴더가 아니라 태그로 관리한다.** `#C++` `#Hugo` `#Python` 처럼.
폴더는 글 하나에 하나뿐이지만 스택은 본질적으로 여러 개라서다
(강의노트를 `CME295`·`lecture-note` 태그로 관리하는 것과 같은 원칙).

카테고리는 **1단(flat)**이다. Blog도 24개 하위섹션 중 3단으로 내려간 건
`probability-statistics/linear-regression`(10부작 시리즈) 하나뿐이다 —
깊이는 미리 설계하지 않고 분량이 요구할 때 만든다.
`layouts/partials/cat-node.html`이 재귀라 나중에 깊게 만들어도 코드 변경은 없고,
글을 옮길 때 front matter `aliases`로 옛 URL을 살려두면 된다.

`troubleshooting/`에 글을 만들면 전용 양식이 적용된다
(증상 → 재현 → 세운 가설과 기각 → 원인 → 수정 → 배운 것).

### 섹션별 목록 설정

`hugo.toml`의 `[params.sections.<섹션이름>]`이 목록 UI를 제어한다. 키는 전부 소문자.

| 키 | 뜻 | blog | dev |
|---|---|---|---|
| `catpanel` | 좌측 카테고리 패널(햄버거) | `true` | `false` |
| `search` | 목록 상단 검색창 | `true` | `false` |
| `pagination` | 글 하단 이전/다음 링크 | `true` | `true` |
| `featured` | 목록 상단 고정 인기 글 | 2편 | 없음 |

dev는 글이 0편이라 패널·검색을 꺼 뒀다. **10편쯤 쌓이면 `true`로 바꾸면 끝**이다.
검색은 `/index.json` 한 인덱스를 공유하되 `section` 필드로 걸러서,
Blog 검색에 Dev 글이 섞이지 않는다(반대도 마찬가지).

## Investment Diary (`/diary/`)

Blog와 분리된 기록 공간. 목록은 잉크 세로선 타임라인(월 노드 + 글 노드)이고, 글 본문은 블로그와 같은 뉴스프린트 레이아웃을 쓴다. Blog 검색·최신 글·인기 글에는 섞이지 않는다.

```bash
hugo new diary/2026-08-01-my-note.md   # archetypes/diary.md 적용
```

- front matter `description`: 목록에서 제목 아래 이탤릭 한 줄 미리보기로 표시 (비우면 제목만).
- 카테고리 없음 — 날짜가 곧 구조다. 양식 예시: `content/diary/2026-07-29-first-entry-example.md` (draft라 배포 안 됨).

## 로컬 미리보기

```bash
hugo server -D   # http://localhost:1313 (-D: draft 포함)
```

## 배포

`main`에 push하면 GitHub Actions(`.github/workflows/hugo.yml`)가 빌드해서 Pages로 배포.
**최초 1회 설정 필요**: 저장소 Settings → Pages → Source를 "GitHub Actions"로 변경.

## 테마

`themes/terminal`에 직접 포함(vendored). 업데이트하려면:

```bash
rm -rf themes/terminal && git clone --depth 1 https://github.com/panr/hugo-theme-terminal.git themes/terminal && rm -rf themes/terminal/.git
```

테마 커스터마이징은 테마 폴더를 건드리지 말고 루트 `layouts/`, `static/style.css`에서 오버라이드.

## 디자인 규칙 (Newsprint, 2026-07 개편)

Typora Newsprint 팔레트 기반의 라이트 단일 테마. 글꼴은 본문·라벨 모두 Noto Serif KR,
코드만 모노스페이스. 새 UI 요소를 만들 때 물을 것은 "포인트가 필요한가?" 하나다.

| 색 | 값 | 역할 |
|---|---|---|
| 종이 `--background` | `#f3f2ee` | 배경 |
| 잉크 `--foreground` | `#1f0909` | 본문·제목·구조(괘선, 정리 블록 선) |
| 적갈 `--accent` | `#963b2f` | 유일한 포인트 — 링크·태그·정리 라벨·호버·진행률 바 |
| 소프트 잉크 `--ink-soft` | `#656565` | 부속 정보: 메타·캡션·힌트 |
| 괘선 `--rule` | `#c5c5c5` | 가는 구분선 |

드래그 선택 영역은 Newsprint 원본 값(`rgba(32,43,51,.63)` + 흰 글자)으로 반전된다.

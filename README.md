# Munseok and Quantitative Investing

Hugo + [Terminal 테마](https://github.com/panr/hugo-theme-terminal) 기반 블로그.
https://chlanstjr0301.github.io

## 구조

- 메뉴: **About** (`content/about.md`) / **Project** (`content/projects.md`) / **Blog** (`content/blog/`)
- `/blog/`는 티스토리형 목록: 좌측 카테고리 패널(글 수 표시, 빈 카테고리 자동 숨김) + 우측 최신순 글 목록. 폴더 구조가 곧 카테고리다.
- 홈(`/`)은 `/blog/`로 리다이렉트되고, 상단 제호 클릭도 `/blog/`로 간다.
- 각 글에는 목차가 자동 생성된다 (넓은 화면: 우측 사이드바 + 스크롤 하이라이트, 좁은 화면: 상단 접이식).

## 글 쓰기

```bash
hugo new blog/financial-engineering/options/my-post.md
```

- 저장 위치가 곧 카테고리. 새 카테고리는 폴더 생성 후 `_index.md`에 `title`, `weight`(목차 번호 순서)를 지정.
- front matter: `math: true` → KaTeX 수식 ($...$, $$...$$), `toc: false` → 글 내 목차 끄기, `draft: true` → 배포 제외.
- 이미지는 `static/img/posts/<글이름>/`에 두고 `/img/posts/<글이름>/파일명`으로 참조.
- 목록의 대표그림: front matter `cover: "/img/..."` 지정 → 없으면 본문 첫 그림(figure 쇼트코드 포함) 자동 사용 → 그것도 없으면 텍스트 행.
- 인기 글: `hugo.toml`의 `params.featured`에 글 URL(RelPermalink)을 추가하면 /blog/ 상단에 고정된다.
- 검색: 빌드 시 `/index.json` 인덱스가 생성되고 /blog/ 검색창이 제목·내용·태그를 클라이언트에서 검색한다.

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

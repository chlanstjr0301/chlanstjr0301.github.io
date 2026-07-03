# Munseok's Blog

Hugo + [Terminal 테마](https://github.com/panr/hugo-theme-terminal) 기반 블로그.
https://chlanstjr0301.github.io

## 구조

- 메뉴: **About** (`content/about.md`) / **Project** (`content/projects.md`) / **Blog** (`content/blog/`)
- `/blog/`는 전체 글의 트리 목차. 폴더 구조가 곧 카테고리이며, 글을 추가하면 목차가 자동 갱신된다.
- 각 글에는 목차가 자동 생성된다 (넓은 화면: 우측 사이드바 + 스크롤 하이라이트, 좁은 화면: 상단 접이식).

## 글 쓰기

```bash
hugo new blog/financial-engineering/options/my-post.md
```

- 저장 위치가 곧 카테고리. 새 카테고리는 폴더 생성 후 `_index.md`에 `title`, `weight`(목차 번호 순서)를 지정.
- front matter: `math: true` → KaTeX 수식 ($...$, $$...$$), `toc: false` → 글 내 목차 끄기, `draft: true` → 배포 제외.
- 이미지는 `static/img/posts/<글이름>/`에 두고 `/img/posts/<글이름>/파일명`으로 참조.

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

## 백업

리뉴얼 이전(Jekyll Chirpy) 상태는 `backup/chirpy` 브랜치에 보존.

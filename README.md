# Munseok's Log

Hugo 블로그. 테마 없이 루트 `layouts/`와 `assets/css/`만으로 만든다.
https://chlanstjr0301.github.io

## 구조

| 탭 | 폴더 | 담는 글 |
|---|---|---|
| Dev Blog | `content/dev/` | Backend · Server/Infra · Python · Java |
| Quant Blog | `content/quant/` | 수학·통계, 금융공학, 밸류에이션 이론 정리 |
| Investment | `content/investment/` | Industry Analysis · Energy · Interesting Data · Guru Study · History Study · Thought (분류 폴더 아래에 `날짜-이름` 폴더) |
| Project | `content/projects.md` | 프로젝트 소개 |
| About | `content/about.md` | 자기소개 |

- 홈(`/`): 세 블로그의 **최근 포스트** 6편 + **추천 포스트**(front matter `featured: true`).
- 전체 글: `/archive/` (연도별 목록).
- 섹션 목록: 카드 그리드 + 상단 분류 칩(글이 있는 하위 폴더만, 글 수 표시).
  - 최상위 섹션·대분류는 최신순, **시리즈 폴더**(하위 폴더가 없는 소분류)는 폴더명 `01.`, `02.` 순서.
- 글 페이지: 경로, 제목, 요약, 날짜·읽기 시간·저자 → 본문 → 태그 → 시리즈 목록 → 이전/다음 글 → 댓글(giscus).
  목차는 넓은 화면에서 우측 고정, 좁은 화면에서 본문 위 접기.

폴더가 곧 분류다. 새 분류는 폴더를 만들고 `_index.md`에 `title`, `weight`(칩 순서)를 쓴다.
글을 다른 폴더로 옮기면 URL이 바뀌므로, 이미 배포된 글이면 front matter `aliases`에 옛 주소를 남긴다.
분류 이름만 바꿀 때는 폴더명은 그대로 두고 `_index.md`의 `title`만 고친다.
**시리즈**: 섹션 아래 2단 이상 들어간 폴더(예: `quant/foundations/probability-statistics/`)는 시리즈로 취급해 폴더명 번호순으로 정렬하고, 글 아래에 시리즈 목록을 붙인다.

## 글 쓰기

Typora 워크플로는 `WRITING.md` 참고. 글 하나 = 폴더 하나(페이지 번들).

```bash
hugo new quant/quantitative-finance/derivatives/my-post   # Quant Blog
hugo new dev/python/my-note                                # Dev Blog
hugo new --kind dev-trouble dev/server-infra/ci-fail       # Dev Blog 장애 기록 양식 (증상→재현→가설→원인→수정)
hugo new investment/industry-analysis/2026-08-01-hbm-supply   # Investment
```

`new-post.bat`(더블클릭)으로도 만들 수 있다.

front matter 요약:

| 키 | 뜻 |
|---|---|
| `description` | 카드·SNS 미리보기에 쓰는 한두 줄 요약 |
| `tags` | 태그. 분류 폴더 없이 섹션 바로 아래 둔 글은 첫 태그가 카드 분류 라벨이 된다 |
| `cover` | 카드 썸네일 그림. 없으면 본문 첫 그림, 그것도 없으면 분류 이름 텍스트 카드 |
| `featured: true` | 홈 '추천 포스트'에 노출 |
| `math: true` | KaTeX 수식 (`$...$`, `$$...$$`) |
| `toc: false` | 목차 끄기 |
| `comments: false` | 이 글만 댓글 끄기 |
| `draft: true` | 배포 제외 |

## 디자인

- 글꼴: Pretendard(본문·제목), JetBrains Mono(코드), KaTeX 기본 글꼴(수식).
- 라이트/다크: 기본은 다크. 헤더 버튼으로 바꾸면 브라우저에 기억한다. 댓글 창도 같이 바뀐다.
- 색: `assets/css/main.css` 맨 위 `:root`(라이트)와 `[data-theme="dark"]`(다크) 변수만 고치면 전체에 반영된다.
- 코드 하이라이팅: `assets/css/syntax.css` (`hugo gen chromastyles`로 생성, 라이트 github / 다크 github-dark).

## 파일 지도

```
layouts/
  baseof.html          공통 뼈대 (head, 헤더, 푸터)
  home.html            홈
  section.html         섹션·분류 목록
  single.html          글 / 단독 페이지
  archive.html         전체 글 (content/archive.md 가 사용)
  taxonomy.html, term.html   태그 목록 / 태그별 글
  _partials/           header, footer, card, breadcrumb, post-nav(시리즈·이전/다음), is-series, comments, scripts, cover-src
  _markup/             render-heading(# → h2, 제목 링크), render-image(그림 번호 캡션·지연 로딩), render-passthrough(수식 보호)
  home.rss.xml         홈 RSS (세 블로그 글만)
  _shortcodes/         def, thm, cor, rmk (정의·정리 블록), cite (인용), barchart (막대 비교 차트), social
data/                  authors.toml(저자), refs.yaml(참고문헌), projects.yaml(Project 페이지)
assets/js/site.js      테마 전환, 목차 강조, 코드 복사, 각주·수식·인용 미리보기, 검색, 조회수
assets/css/            main.css, syntax.css
```

## 로컬 미리보기

```bash
hugo server --printPathWarnings          # http://localhost:1313 — 실제 배포될 화면 (초안 숨김)
hugo server -D -F --printPathWarnings    # 초안(-D)·미래 날짜 글(-F)까지 보기 — 쓰던 글 확인할 때만
```

## 배포

`main`에 push하면 GitHub Actions(`.github/workflows/hugo.yml`)가 빌드해서 Pages로 배포한다.

## 조회수 켜기 (GoatCounter, 무료)

GitHub Pages는 정적 호스팅이라 조회수를 셀 서버가 없다. 그래서 GoatCounter(개인 비상업 무료)에 숫자를 맡긴다.

1. https://www.goatcounter.com 에서 계정을 만들고 사이트 코드를 정한다 (예: `munseok` → `munseok.goatcounter.com`).
2. GoatCounter 설정(Settings)에서 **"Allow adding visitor counts on your website"** 를 켠다.
3. `hugo.toml`의 `goatcounter = ""` 에 코드를 넣고 push.

켜면 글 머리(날짜 옆), 카드, 줄 목록에 눈 아이콘과 누적 조회수가, 홈 '추천 포스트' 옆에 사이트 전체 합계가 보인다.
기록이 아직 없는 글은 숫자를 숨긴다. GoatCounter는 숫자를 최대 몇 시간 캐시하고, "오늘" 조회수는 이 방식으로는 나오지 않는다.

## 검색

배포 워크플로가 `hugo` 다음에 `npx pagefind --site public`으로 색인을 만든다. 색인 대상은 글 본문(`data-pagefind-body`)뿐이다.
로컬에서 확인하려면 `hugo -d public && npx pagefind --site public` 후 `public`을 아무 정적 서버로 띄운다.


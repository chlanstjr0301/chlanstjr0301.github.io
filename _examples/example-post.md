---
# ===== front matter: 글의 메타데이터 =====
title: "예제 글 — 이 파일을 복사해서 시작"   # 필수. 목차와 페이지에 표시되는 제목
date: 2026-07-04T12:00:00+09:00              # 필수. 미래 시각이면 빌드에서 제외되니 주의
tags: [example, template]                    # 선택. 글 하단·태그 페이지에 #태그로 표시
description: "목록에 표시될 한 줄 소개. 없으면 본문 앞부분이 잘려 나가니 꼭 쓰기."
math: true                                   # 수식($, $$) 쓰면 true
toc: true                                    # 글 내 목차. 끄려면 false
draft: true                                  # true면 사이트에 안 올라감. 발행할 때 false로
---

## 개괄

description과 별개로, 본문 첫 문단은 글의 도입부. 여기부터 렌더링된다.

## 문법 예시

### 수식 (math: true 필요)

인라인 수식은 $E = mc^2$ 처럼, 블록 수식은:

$$
dS_t = \mu S_t \, dt + \sigma S_t \, dW_t
$$

### 코드

```python
def hello():
    return "Hello, World!"
```

### 이미지

이미지는 `static/img/posts/글이름/` 폴더에 넣고 아래처럼 참조:

![대체 텍스트](/img/posts/example/fig001.png)

### 이미지 + 설명 캡션 (사진 밑 오렌지 바)

{{</* figure src="/img/posts/example/fig001.png" alt="대체 텍스트" caption="사진 밑에 붙는 설명. 오렌지 바로 표시됨." class="center" */>}}

- `class`: `left` / `center` / `right` 정렬
- 캡션 없이 정렬만 필요하면 `{{</* image src="..." position="center" */>}}`

### 표

| 항목 | 값 |
|------|-----|
| A    | 1   |
| B    | 2   |

### 인용과 각주

> 인용문은 이렇게.

각주는 이렇게[^1] 단다.

[^1]: 각주 내용은 글 맨 아래 자동 정리됨.

## 발행 절차

1. 이 파일을 `content/blog/<카테고리>/새글이름.md`로 복사
2. front matter 수정, 본문 작성
3. `hugo server -D`로 로컬 확인
4. `draft: true` 줄 삭제 (또는 false)
5. `git add . && git commit -m "..." && git push`

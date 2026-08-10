---
title: "Interest 2"   # 글 제목 (bat가 자동 입력 — 한글로 고쳐 쓰면 됨)
date: 2026-08-09T20:20:52+09:00   # 작성일 — 목록 정렬 기준 (자동 입력)
tags: []            # 태그 목록. 예: [asset-allocation, Bayesian] — 글 하단에 #링크로 표시
description: ""     # 한 줄 요약 — 목록·검색 결과·SNS 미리보기에 쓰임
math: true          # 수식 사용 여부 ($...$, $$...$$) — 수식 없는 글이면 false
toc: true           # 목차 자동 생성 (넓은 화면: 우측 사이드바) — 끄려면 false
draft: true         # 초안 표시 — 이 줄을 지우면(또는 false) 배포된다
# cover: "파일명.png"  # (선택) 목록 대표그림 지정 — 없으면 본문 첫 이미지 자동
---

글의 도입 문단. 무엇을 다루고 어디까지 유도하는지 두세 문장으로 쓴다.

**기호 정리.** 필요하면 여기서 기호를 미리 정의한다: $\Sigma$는 $N\times N$ 공분산 행렬.

# 1. 첫 섹션

인라인 수식은 $w'\Sigma w$ 처럼, 번호 붙는 블록 수식은 이렇게:

$$
\Pi = \delta\Sigma w_{eq} \tag{1}
$$

여러 줄 유도는 aligned로:

$$
\begin{aligned}
f(w) &= w'\mu - \frac{\delta}{2}w'\Sigma w \\
\nabla_w f &= \mu - \delta\Sigma w = 0
\end{aligned}
$$

{{< thm name="정리 1" >}}
정리 내용. 조건과 결론을 한 문장으로.
{{< /thm >}}

<details>
<summary>증명</summary>

증명 내용. 끝나면 $\blacksquare$

</details>

# 2. 둘째 섹션

이미지는 복사해서 **Ctrl+V** — 이 폴더에 자동 저장된다.

<!-- 더 많은 구문(cases·행렬·boxed·표·각주)은 content/blog/writing-template/ 에서 복사 -->

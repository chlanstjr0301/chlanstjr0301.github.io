---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
tags: []
description: ""   # 목록·검색에 쓰이는 한 줄 요약
math: true
toc: true
draft: true
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

{{ `{{< thm name="정리 1" >}}` }}
정리 내용. 조건과 결론을 한 문장으로.
{{ `{{< /thm >}}` }}

<details>
<summary>증명</summary>

증명 내용. 끝나면 $\blacksquare$

</details>

# 2. 둘째 섹션

이미지는 복사해서 **Ctrl+V** — 이 폴더에 자동 저장된다.

<!-- 더 많은 구문(cases·행렬·boxed·표·각주)은 content/blog/writing-template/ 에서 복사 -->

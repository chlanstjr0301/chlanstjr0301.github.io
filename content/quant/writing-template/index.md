---
title: "글 양식 — 검증된 구문 모음 (draft, 배포 안 됨)"
date: 2026-07-29T10:00:00+09:00
tags: [template]
description: "Typora(MathJax)와 블로그(KaTeX) 양쪽에서 깨지지 않음이 검증된 구문만 모아둔 복사용 양식."
math: true
toc: true
draft: true
---

이 글의 모든 구문은 **KaTeX(블로그)·MathJax(Typora)·Goldmark(Hugo 파서) 3중 검증**을 통과했다.
새 글 쓸 때 여기서 복사해 가면 로컬과 배포가 항상 같게 나온다. 규칙 요약은 `WRITING.md` 4절.

# 1. 인라인 수식

첨자·프라임·별표 자유롭게: $w'\Sigma w_{eq}^*$, 분포는 $\varepsilon \sim N(0, \tau\Sigma)$,
집합은 $\{ x \in \mathbb{R} : x > 0 \}$ 또는 $\lbrace y \rbrace$ — 이제 둘 다 안전하다.
한 줄에 여러 개($x_i$와 $x_j$)도, _이탤릭_ 과의 공존도 문제없다.

# 2. 블록 수식

$$ 는 자기 줄에 두는 걸 권장한다 (기존 글 관행).

**번호는 `\tag{}`로 수동** (`\label`/`\eqref`는 블로그에서 깨지는 유이한 금지어):

$$
\Pi = \delta\Sigma w_{eq} \tag{1}
$$

**여러 줄 정렬** — `&`와 `\\`, 연산자가 줄 끝에 와도 안전:

$$
\begin{aligned}
f(t,T) &= \lim_{S\to T} F(t,T,S) \\
&= -\frac{\partial}{\partial T}\ln P(t,T)
\end{aligned}
$$

**경우 나누기**:

$$
S_{t+\Delta t} =
\begin{cases}
 uS_t, & \text{up state},\\
 dS_t, & \text{down state}.
\end{cases}
$$

**행렬**:

$$
\begin{bmatrix} \Pi \\ Q \end{bmatrix}, \qquad
\begin{pmatrix} a & b \\ c & d \end{pmatrix}
$$

**강조 상자·밑줄 설명·연산자 이름**:

$$
\boxed{\ w^* = \frac{1}{\delta}\Sigma^{-1}\mu\ }, \qquad
\underbrace{\delta\Sigma w_{eq}}_{\text{균형 리스크 프리미엄}}, \qquad
\operatorname*{arg\,min}_{w}\ \operatorname{Var}(w'R)
$$

# 3. 정리·증명 블록

{{< thm name="보조정리 1" >}}
$(\tau\Sigma)^{-1} + P'\Omega^{-1}P$ 는 양정치이므로 가역이다.
{{< /thm >}}

<details>
<summary>증명</summary>

양정치 행렬의 합은 양정치이고, $P'\Omega^{-1}P \succeq 0$ 이므로 성립한다. $\blacksquare$

</details>

`def`(정의), `rmk`(주석), `cor`(따름정리)도 같은 꼴로 쓴다.
Typora에서는 쇼트코드가 일반 텍스트로 보이는데, 정상이다 — 렌더링은 `hugo server`에서 확인.

# 4. 이미지·표·각주

이미지는 이 폴더에 붙여넣기(Ctrl+V)만 하면 된다: `![캡션](파일명.png)`

| 기호 | 의미 | 차원 |
|---|---|---|
| $\Sigma$ | 공분산 행렬 | $N \times N$ |
| $P$ | 견해 행렬 | $K \times N$ |

각주는 이렇게[^1] 단다.

[^1]: 각주 내용. 수식도 된다: $\tau > 0$.

# 5. 조심할 것 (전체 목록)

1. `\label`·`\eqref` 금지 → `\tag{숫자}` 수동 번호. Typora에선 되니까 더 위험하다.
2. `math: true` 글의 **본문**에서 통화 기호 `$` 단독 사용 금지 — "100\$ 수준" 대신 "100달러".
   렌더러가 다음 `$`와 짝지어 문장을 수식으로 오인한다. (`math: false` 글은 무관.)
3. 그 외 전부 안전 — 예전 규칙이던 "`\{` 대신 `\lbrace`", "연산자를 줄 끝에 두지 말 것"은
   현재 설정(passthrough)에서 더 이상 필요 없다. 취향대로 쓰면 된다.

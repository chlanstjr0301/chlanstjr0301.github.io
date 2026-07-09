---
title: "Introduction to Linear Regression (1/10)"
date: 2026-07-08T00:00:00+08:00
tags: [Mathematical Statistics, Linear Regression]
description: "선형회귀분석 첫번째 글. 선형회귀분석에 필요한 기하와 대수적 도구"
authors: [munseok]
math: true
toc: true
draft: false
---

# 1. 들어가며
"Introduction to Linear Regression"시리즈에서는 총 10차례에 걸쳐 선형회귀분석에 대해 다뤄보도록 하겠습니다. 주제가 주제이니 만큼, 모든 내용을 다루면 끝이 없기 때문에 필요한 부분은 나중에 주제별로 따로 글을 쓰겠습니다. 제가 처음 회귀분석을 마주한건 고등학교 생활기록부를 채우기 위해 회귀분석을 공부하던 때였습니다. 그때는 단순 선형회귀분석과 정규방정식에 대해 다루었기 때문에, "뭐야 그냥 선 하나 잘 긋는거잖아?"라고 생각했습니다. 대학에 들어와서 회귀분석을 자주 마주하며 공부하면 할수록 이놈은 끝이 없다는 생각을 하게 되었고, 자연스럽게 관련 내용을 정리하고 싶은 욕심이 생겼습니다.

다중선형회귀분석을 배울때 이 모든 것이 피타고라스 정리로 귀결된다는 것을 깨닫고 매우 충격먹었던 기억이 있습니다. 그래서 해당 시리즈에서는 개인적으로 시각적으로 설명하면 좋다고 느낀 부분을 많이 시각화 해놓았습니다. 

이 글은 "Introduction to Linear Regression" 시리즈의 1편입니다. 시리즈 전체에서 반복적으로 사용할 기하와 대수적 도구들을 미리 정리해 두었습니다. 

# 2. 관측공간의 기하
{{< rmk >}}
**Remark 1** (확률벡터와 실현값). 기하 논증에서 $y$는 관측된 하나의 실현값, 즉 $\mathbb{R}^n$의 고정된 벡터다. 반면 기댓값·분산·분포를 말하는 논증에서 $y$는 확률벡터, 즉 가측함수 $y : \Omega \to \mathbb{R}^n$이다. 두 해석은 충돌하지 않는다. 이 시리즈의 기하 명제는 특정 자료의 성질이 아니라 $\mathbb{R}^n$의 임의의 벡터에 대해 성립하는 항등식이므로, 어떤 표본점 $\omega \in \Omega$가 뽑히든 실현값 $y(\omega)$에 대해 성립한다. 즉 확률벡터에 대해서는 모든 $\omega$에서 성립하는 pathwise 명제가 되고, 당연히 확률 1로도 성립한다. 이하에서는 두 해석을 문맥으로 구분하고 표기는 $y$ 하나로 통일한다.
{{< /rmk >}}

{{< rmk >}}
**Remark 2** (관측벡터와 확률벡터). 표본 크기가 $n$일 때, 변수 하나는 $\mathbb{R}^n$의 벡터 하나이다. 즉 변수 $x$의 관측치 $x_1, \dots, x_n$을 쌓은

$$x = (x_1, x_2, \dots, x_n)' \in \mathbb{R}^n$$

을 하나의 화살표로 본다. 통계학에서는 이 공간을 관측공간 또는 subject space라고 부른다.

이 관측벡터는 확률벡터와 다음과 같이 연결된다. 각 관측치 $x_i$는 확률변수 $x_i : \Omega \to \mathbb{R}$의 실현값이다. 즉 관측이란 표본점 $\omega \in \Omega$ 하나가 뽑혀 값 $x_i(\omega)$가 결정되는 일이고, Remark 1의 관례대로 확률변수와 그 실현값을 같은 기호로 적는다. 확률변수들을 쌓은 $x = (x_1, \dots, x_n)' : \Omega \to \mathbb{R}^n$은 확률벡터이고, 위의 관측벡터는 그 실현값 $x(\omega)$다. 이하의 기하량 — 길이, 사잇각, 사영 — 은 $\mathbb{R}^n$의 임의의 벡터에 대해 정의되고, 이들 사이의 항등식은 $\mathbb{R}^n$ 전체에서 성립하는 대수적 항등식이다. 따라서 어떤 $\omega \in \Omega$가 뽑히든 실현값 $x(\omega)$에 대해 성립하고, 확률벡터에 대한 pathwise 항등식이 된다(Remark 1). 예컨대 $\Vert x^* \Vert^2 = \sum_i (x_i - \bar{x})^2$는 $\mathbb{R}^n$의 모든 벡터에서 성립하는 항등식으로, 실현값으로 해석하면 관측된 제곱합이라는 숫자이고, 확률벡터로 해석하면 확률변수로서의 제곱합 통계량이다.

벡터 하나가 관측치 하나에 대응하므로 $n$이 커도, 변수가 $k$개라면 관련된 모든 벡터는 고작 $k$차원 이하의 부분공간 안에서 움직인다. 그래서 그림은 언제나 2, 3차원으로 그릴 수 있다.
{{< /rmk >}}

이 관점이 강력한 이유는 기술통계량이 전부 기하량으로 번역되기 때문이다.[^Wickens-1995] $\mathbb{R}^n$에 유클리드 내적 $\langle u, v \rangle = \sum_{i=1}^n u_i v_i$와 노름 $\Vert u \Vert = \sqrt{\langle u, u \rangle}$를 준다. 중심화한 벡터를 $x^* = x - \bar{x}\mathbf{1}_n$이라 하면

$$\Vert x^* \Vert^2 = \sum_{i=1}^n (x_i - \bar{x})^2 = (n-1)\, s_x^2, \qquad
\langle x^*, y^* \rangle = \sum_{i=1}^n (x_i - \bar{x})(y_i - \bar{y}) = (n-1)\, s_{xy}$$

이다. 여기서 $s_x^2$는 표본분산, $s_{xy}$는 표본공분산이다. 즉 중심화 벡터의 길이는 표본표준편차에 비례하고($\Vert x^* \Vert = \sqrt{n-1}\, s_x$), 내적은 표본공분산에 비례한다.

내적공간에서 두 벡터 $u, v \neq \mathbf{0}$의 사잇각 $\theta$는 정의상 $\cos\theta = \frac{\langle u, v \rangle}{\Vert u \Vert \Vert v \Vert}$를 만족하는 $[0, \pi]$의 각이다.[^angle] 이를 $x^*, y^*$에 적용하면

$$\cos\theta =
\frac{\langle x^*, y^* \rangle}{\Vert x^* \Vert\, \Vert y^* \Vert} =
\frac{\sum (x_i - \bar{x})(y_i - \bar{y})}
{\sqrt{\sum (x_i - \bar{x})^2}\sqrt{\sum (y_i - \bar{y})^2}} =
r_{xy}$$

로, 표본상관계수의 정의식과 정확히 일치한다. 즉 상관계수는 사잇각의 코사인이고, 무상관($r_{xy} = 0$)은 직교($\theta = \pi/2$)다.

# 3. 최소제곱과 정사영
## 3.1. Column space
{{< def >}}
**Definition 1** (column space). $n \times p$ 행렬 $X$의 column space는
$$\mathcal{C}(X) = \lbrace Xb : b \in \mathbb{R}^p \rbrace \subseteq \mathbb{R}^n$$
으로 정의한다. 이는 $X$의 열벡터들이 생성하는(span) $\mathbb{R}^n$의 부분공간이며, 그 차원은 $\dim \mathcal{C}(X) = \operatorname{rank}(X)$다. 특히 $\operatorname{rank}(X) = p$(full column rank)이면 $\mathcal{C}(X)$는 $\mathbb{R}^n$ 안의 $p$차원 부분공간이다.
{{< /def >}}

회귀모형 $y = X\beta + \varepsilon$에서 체계적 부분 $X\beta$이 취할 수 있는 값의 전체, 즉 사상 $b \mapsto Xb$의 치역이 정확히 $\mathcal{C}(X)$다. 이 시리즈에서는 별도 언급이 없는 한 $X$의 full column rank를 가정한다.

## 3.2. 최소제곱 문제

최소제곱법(least squares method)은 잔차제곱합 $\Vert y - Xb \Vert^2$을 최소화하는 $b$로 계수를 추정하는 방법이다. 이는 다음 최적화 문제로 정식화된다.

$$\min_{b \in \mathbb{R}^p} \Vert y - Xb \Vert^2$$

$\lbrace Xb : b \in \mathbb{R}^p \rbrace = \mathcal{C}(X)$이므로(Definition 1), 이 문제는 "$\mathcal{C}(X)$의 점 가운데 $y$와의 거리가 최소인 점을 찾아라"와 동치다. 문제에 대한 답이 정사영이라는 것을 다음 정리를 통해 알 수 있다.

{{< thm >}}
**Theorem 1** (정사영 정리). $\hat{y} \in \mathcal{C}(X)$에 대해 다음 두 조건은 동치다.

(i) 모든 $z \in \mathcal{C}(X)$에 대해 $\Vert y - \hat{y} \Vert \leq \Vert y - z \Vert$.

(ii) $y - \hat{y} \perp \mathcal{C}(X)$, 즉 $X'(y - \hat{y}) = 0$.

또한 이러한 $\hat{y}$는 유일하다.
{{< /thm >}}

<details>
<summary>증명</summary>

먼저 (ii)의 두 표현이 동치임을 확인한다. $\mathcal{C}(X)$의 원소는 모두 $Xb$ ($b \in \mathbb{R}^p$) 꼴이고 $\langle y - \hat{y},\, Xb \rangle = b'X'(y - \hat{y})$이므로, 이 값이 모든 $b$에 대해 $0$일 필요충분조건은 $X'(y - \hat{y}) = 0$이다.

((ii) $\Rightarrow$ (i)) $y - \hat{y} \perp \mathcal{C}(X)$라 하자. 임의의 $z \in \mathcal{C}(X)$에 대해 $\hat{y} - z \in \mathcal{C}(X)$이므로 $y - \hat{y}$와 직교하고, 피타고라스 정리에 의해

$$\Vert y - z \Vert^2 =
\Vert (y - \hat{y}) + (\hat{y} - z) \Vert^2 =
\Vert y - \hat{y} \Vert^2 + \Vert \hat{y} - z \Vert^2 \geq
\Vert y - \hat{y} \Vert^2$$

이다. 이 부등식이 정확히 (i)이다. 등호는 $\Vert \hat{y} - z \Vert = 0$, 즉 $z = \hat{y}$일 때만 성립한다는 사실은 아래 유일성에서 기술하였다.

((i) $\Rightarrow$ (ii)) 대우를 보인다. (ii)가 거짓, 즉 어떤 $v \in \mathcal{C}(X)$에 대해 $c = \langle y - \hat{y}, v \rangle \neq 0$($v \neq \mathbf{0}$)이라 하자. 스칼라 $t$에 대해 $z_t = \hat{y} + tv \in \mathcal{C}(X)$로 두면

$$\Vert y - z_t \Vert^2 =
\Vert y - \hat{y} \Vert^2 - 2tc + t^2\Vert v \Vert^2$$

인데, $t = \frac{c}{\Vert v \Vert^2}$로 잡으면 우변이

$$\Vert y - \hat{y} \Vert^2 - \frac{c^2}{\Vert v \Vert^2} < \Vert y - \hat{y} \Vert^2$$

이다. 즉 $z_t$가 (i)의 부등식을 위반하므로 (i)이 거짓이다.

(유일성) $\hat{y}_1, \hat{y}_2 \in \mathcal{C}(X)$가 모두 (i)을 만족한다고 하자. (i) $\Rightarrow$ (ii)에 의해 $y - \hat{y}_1 \perp \mathcal{C}(X)$이므로, (ii) $\Rightarrow$ (i)의 피타고라스 전개를 $z = \hat{y}_2$에 적용하면

$$\Vert y - \hat{y}_2 \Vert^2 = \Vert y - \hat{y}_1 \Vert^2 + \Vert \hat{y}_1 - \hat{y}_2 \Vert^2$$

이다. 그런데 $\hat{y}_2$도 (i)을 만족하므로 $\Vert y - \hat{y}_2 \Vert \leq \Vert y - \hat{y}_1 \Vert$이고, 위 등식과 결합하면 $\Vert \hat{y}_1 - \hat{y}_2 \Vert^2 \leq 0$, 즉 $\hat{y}_1 = \hat{y}_2$이다. (Seber & Lee (2003), Theorem 1.4 및 Appendix B 참고.) $\blacksquare$
</details>

조건 $X'(y - Xb) = 0$을 풀어 쓰면 정규방정식

$$X'Xb = X'y$$

이고, full column rank 가정 하에서는 $v \neq 0$이면 $Xv \neq 0$이므로 $v'X'Xv = \Vert Xv \Vert^2 > 0$, 즉 $X'X$가 양정치이고 따라서 가역이다. 그러므로 해는

$$\hat{\beta} = (X'X)^{-1}X'y$$

로 유일하다. 위 해의 유도에서 미분은 쓰지 않았다. 같은 해는 목적함수 $\Vert y - Xb \Vert^2$을 $b$에 대해 미분하여 얻을 수도 있는데, 이 유도는 행렬 미분의 좋은 연습이므로 6절에서 다시 다룬다.

## 3.3. Projection matrix

정사영을 $y$에 작용하는 선형사상(Linear Map)으로 쓰기 위해 다음을 정의한다.

{{< def >}}
**Definition 2** (hat matrix). full column rank인 $X$에 대해
$$P = X(X'X)^{-1}X'$$
로 정의되는 $n \times n$ 행렬을 생각한다. 최소제곱 적합벡터가 $\hat{y} = X\hat{\beta} = X(X'X)^{-1}X'y = Py$로 쓰이므로, 회귀분석 문헌에서는 $y$에 모자를 씌워 $\hat{y}$을 만든다는 뜻에서 이를 hat matrix라 부른다 (Hoaglin & Welsch (1978)). 아래 Theorem 2에서 이 $P$가 실제로 $\mathcal{C}(X)$ 위로의 정사영행렬임을 본다.
{{< /def >}}

{{< thm >}}
**Theorem 2** (Characterization of Orthogonal Projection Matrices). 행렬 $A \in \mathbb{R}^{n \times n}$이 어떤 부분공간 위로의 정사영행렬일 필요충분조건은

$$A' = A \quad \text{그리고} \quad A^2 = A$$

인 것이며, 이때 사영의 상은 $\mathcal{C}(A)$이다. 특히 Definition 2의 $P = X(X'X)^{-1}X'$는 이 두 조건을 만족하므로 $\mathcal{C}(X)$ 위로의 정사영행렬이고, 나아가 $PX = X$가 성립한다.
{{< /thm >}}

<details>
<summary>증명</summary>

**($\Leftarrow$)** $A' = A = A^2$라 하자. 임의의 $y$에 대해 $Ay \in \mathcal{C}(A)$이고, 임의의 $Az \in \mathcal{C}(A)$에 대해

$$\langle y - Ay,\, Az \rangle = z'A'(y - Ay) = z'(Ay - A^2 y) = 0$$

이므로 $y - Ay \perp \mathcal{C}(A)$이다. Theorem 1에 의해 $Ay$는 $y$의 $\mathcal{C}(A)$ 위 정사영이며, 이는 모든 $y$에서 성립하므로 $A$는 $\mathcal{C}(A)$ 위로의 정사영행렬이다.

**($\Rightarrow$)** $A$가 부분공간 $\mathcal{M}$ 위로의 정사영이라 하자. 정의에 의해 모든 $y$에서 $Ay \in \mathcal{M}$이고 $y - Ay \perp \mathcal{M}$이다.

먼저 $\mathcal{M}$의 벡터는 $A$의 고정점(fixed point)이다. $w \in \mathcal{M}$이면 $w - Aw \perp \mathcal{M}$인데 $w, Aw \in \mathcal{M}$이라 $w - Aw \in \mathcal{M}$이기도 하므로, $\mathcal{M}$과 그 직교여공간에 동시에 속하는 $w - Aw$는 $0$이다. 즉 $Aw = w$.

*멱등*: 임의의 $y$에서 $Ay \in \mathcal{M}$이므로 위에서 언급한 성질에 의해 $A(Ay) = Ay$, 곧 $A^2 = A$.

*대칭*: 임의의 $y, z$에서 $Az \in \mathcal{M}$이고 $y - Ay \perp \mathcal{M}$이므로 $\langle y - Ay, Az \rangle = 0$, 곧 $z'(A' - A'A)y = 0$이 모든 $y, z$에서 성립하여 $A' = A'A$. 우변 $A'A$는 대칭이므로 $A'$도 대칭이고, 따라서 $A' = (A')' = A$.

**($P$에 대한 확인)** Definition 2의 $P$에 대해

$$P' = X\bigl((X'X)^{-1}\bigr)'X' = X\bigl((X'X)'\bigr)^{-1}X' = X(X'X)^{-1}X' = P$$

이고 (역행렬과 전치의 교환),

$$P^2 = X(X'X)^{-1}\underbrace{X'X(X'X)^{-1}}_{=\,I_p}X' = X(X'X)^{-1}X' = P$$

이므로 $P$는 대칭·멱등, 즉 위 특징화(Characterization)에 의해 $\mathcal{C}(P)$ 위로의 정사영이다. 한편 $PX = X(X'X)^{-1}X'X = X$이므로 $X$의 각 열이 $P$의 상에 있어 $\mathcal{C}(X) \subseteq \mathcal{C}(P)$이고, $P$의 정의에서 $\mathcal{C}(P) \subseteq \mathcal{C}(X)$이므로 $\mathcal{C}(P) = \mathcal{C}(X)$이다. 따라서 $P$는 $\mathcal{C}(X)$ 위로의 정사영이다. (Seber & Lee (2003), Theorem B.1.6 참고.) $\blacksquare$
</details>

# 4. Annihilator와 직교분해

{{< def >}}
**Definition 3** (annihilator). $M = I_n - P$를 annihilator 또는 residual maker라 한다.
{{< /def >}}

{{< thm >}}
**Theorem 3** (annihilator의 성질). $M = I_n - P$는 다음을 만족한다.
$$\text{(i) } MX = 0, \qquad
\text{(ii) } M' = M = M^2, \qquad
\text{(iii) } PM = MP = 0$$
따라서 $M$은 직교여공간 $\mathcal{C}(X)^\perp$ 위로의 정사영이며, 임의의 $y \in \mathbb{R}^n$은
$$y = Py + My, \qquad Py \perp My$$
로 유일하게 직교분해되고
$$\Vert y \Vert^2 = \Vert Py \Vert^2 + \Vert My \Vert^2$$
이 성립한다.
{{< /thm >}}

<details>
<summary>증명</summary>

(i) $MX = X - PX = X - X = 0$ (Theorem 2 (iii)).

(ii) 대칭성은 $M' = I' - P' = I - P = M$. 멱등성은
$$M^2 = (I - P)(I - P) = I - 2P + P^2 = I - 2P + P = I - P = M$$

(iii) $PM = P(I - P) = P - P^2 = 0$이고 전치를 취하면 $MP = 0$.

$M$이 대칭 멱등이므로 Theorem 2의 역방향에 의해 $\mathcal{C}(M)$ 위로의 정사영인데, (i)과 $P + M = I$에서 $\mathcal{C}(M) = \mathcal{C}(X)^\perp$임이 확인된다. 직교분해의 유일성: $y = u_1 + v_1 = u_2 + v_2$ ($u_i \in \mathcal{C}(X)$, $v_i \in \mathcal{C}(X)^\perp$)이면 $u_1 - u_2 = v_2 - v_1$은 $\mathcal{C}(X)$와 $\mathcal{C}(X)^\perp$에 동시에 속하므로 자기 자신과 직교, 곧 영벡터다. 피타고라스는 $\langle Py, My \rangle = y'P'My = y'PMy = 0$에서 즉시 나온다. $\blacksquare$
</details>

{{< figure src="/img/posts/2026-07-08-Linear-Regression-1/fig1.png" caption="관측벡터 y의 직교분해" class="center" >}}

회귀 분석에서 $Py = \hat{y}$는 적합값, $My = e$는 잔차이고, 위 피타고라스가 제곱합 분해의 원형이다. 잔차가 모든 설명변수와 직교한다는 사실도 (i)의 즉각적 귀결이다.

$$X'e = X'My = (MX)'y = 0$$

{{< rmk >}}
**Remark 2** (왜 annihilator가 따로 필요한가). 시리즈 후반에서 $M$은 $P$ 이상으로 자주 등장한다. 첫째, 잔차의 분포이론은 전부 $e = My = M\varepsilon$ 위에서 전개된다. 모형을 대입하면 $My = MX\beta + M\varepsilon = M\varepsilon$이기 때문이다. 둘째, FWL 정리(2편)에서 "$X_2$를 $X_1$에 대해 직교화한다"는 조작이 정확히 $M_1 X_2$다. 셋째, 과소특정 분석(3편)에서 누락변수의 효과가 잔차에 흡수되는 메커니즘이 $M_1 y = M_1 X_2 \beta_2 + M_1 \varepsilon$이라는 한 줄로 표현된다.
{{< /rmk >}}

# 5. 멱등행렬과 trace trick

## 5.1. 멱등행렬의 스펙트럼

{{< thm >}}
**Theorem 4** (멱등행렬의 고유값). 멱등행렬 $A$($A^2 = A$)의 고유값은 0 또는 1뿐이다.
{{< /thm >}}

<details>
<summary>증명</summary>

$Av = \lambda v$, $v \neq 0$이면

$$\lambda v = Av = A^2 v = A(\lambda v) = \lambda^2 v$$

이므로 $\lambda^2 = \lambda$, 곧 $\lambda \in \lbrace 0, 1 \rbrace$이다. $\blacksquare$
</details>

{{< thm >}}
**Theorem 5** (rank = trace). 멱등행렬 $A$에 대해 $\operatorname{rank}(A) = \operatorname{tr}(A)$.
{{< /thm >}}

<details>
<summary>증명</summary>

두 가지 증명을 제시한다. 첫째는 이 시리즈에서 실제로 쓰는 대칭 멱등의 경우이고, 둘째는 대칭성 없이도 성립함을 보이는 일반형이다.

**증명 1 (대칭 멱등: 스펙트럼 정리).** $A$가 대칭이면 스펙트럼 정리에 의해 직교대각화 $A = Q\Lambda Q'$가 존재한다 ($Q$ 직교, $\Lambda$ 대각). Theorem 4에 의해 $\Lambda$의 대각성분은 0과 1뿐이다. rank는 닮음변환에 불변이므로 $\operatorname{rank}(A) = \operatorname{rank}(\Lambda) = (\text{1의 개수})$이고, trace는 순환성에 의해 $\operatorname{tr}(A) = \operatorname{tr}(Q\Lambda Q') = \operatorname{tr}(\Lambda Q'Q) = \operatorname{tr}(\Lambda) = (\text{1의 개수})$이다. 둘이 같다.

**증명 2 (일반 멱등: 최소다항식).** $A^2 = A$이므로 $A$는 다항식 $t(t-1)$을 소멸시키고, 최소다항식은 $t(t-1)$의 약수다. 어느 경우든 서로 다른 일차인수의 곱이므로 $A$는 대각화 가능하다 (Horn & Johnson (2013), Theorem 1.3.7 및 §3.3). 이후는 증명 1과 동일하게, 대각형에서 rank와 trace가 모두 "고유값 1의 개수"로 일치하고 두 양 모두 닮음변환에 불변이므로 원래의 $A$에서도 성립한다. $\blacksquare$
</details>

이 정리를 $P$와 $M$에 적용하자. trace의 순환성 $\operatorname{tr}(ABC) = \operatorname{tr}(BCA)$을 쓰면

$$\operatorname{tr}(P) =
\operatorname{tr}\bigl(X(X'X)^{-1}X'\bigr) =
\operatorname{tr}\bigl((X'X)^{-1}X'X\bigr) =
\operatorname{tr}(I_p) = p$$

이고 따라서

$$\operatorname{rank}(P) = p, \qquad
\operatorname{rank}(M) = \operatorname{tr}(I_n - P) = n - p$$

이다. "잔차의 자유도가 $n - p$"라는 말의 정확한 의미가 이것이다. 잔차벡터는 $\mathbb{R}^n$에 살지만 실제로는 $(n-p)$차원 부분공간 $\mathcal{C}(X)^\perp$ 안에 갇혀 있다.

## 5.2. 이차형식의 기댓값

{{< thm >}}
**Theorem 6** (trace trick). 확률벡터 $z$가 $E[z] = \mu$, $\operatorname{Var}(z) = \Sigma$를 가지면 임의의 정방행렬 $A$에 대해
$$E[z'Az] = \mu'A\mu + \operatorname{tr}(A\Sigma)$$
특히 $E[\varepsilon] = 0$, $\operatorname{Var}(\varepsilon) = \sigma^2 I_n$이면 $E[\varepsilon'A\varepsilon] = \sigma^2\operatorname{tr}(A)$이다.
{{< /thm >}}

<details>
<summary>증명</summary>

$z'Az$는 스칼라이므로 자기 자신의 trace와 같다. trace의 순환성, 그리고 기댓값과 trace의 교환 가능성(둘 다 성분별 선형 연산)에 의해

$$E[z'Az] =
E[\operatorname{tr}(z'Az)] =
E[\operatorname{tr}(Azz')] =
\operatorname{tr}\bigl(A\,E[zz']\bigr)$$

인데 $E[zz'] = \operatorname{Var}(z) + E[z]E[z]' = \Sigma + \mu\mu'$이므로

$$E[z'Az] =
\operatorname{tr}(A\Sigma) + \operatorname{tr}(A\mu\mu') =
\operatorname{tr}(A\Sigma) + \mu'A\mu$$

마지막 등호는 다시 순환성이다($\operatorname{tr}(A\mu\mu') = \operatorname{tr}(\mu'A\mu) = \mu'A\mu$, 스칼라). (Seber & Lee (2003), Theorem 1.5 참고.) $\blacksquare$
</details>

응용 하나로 이 절을 닫는다. Remark 1의 구분을 상기하면, 여기서 $y$와 $e$는 확률벡터다. $e = My = M\varepsilon$이므로 멱등성($M'M = M$), rank = trace(Theorem 5), trace trick(Theorem 6)을 연달아 쓰면

$$E[\mathrm{SSE}] =
E[e'e] =
E[\varepsilon'M'M\varepsilon] =
E[\varepsilon'M\varepsilon] =
\sigma^2\operatorname{tr}(M) =
\sigma^2(n - p)$$

이고, $\hat{\sigma}^2 = \mathrm{SSE}/(n-p)$의 불편성이 즉시 따라온다. 이 세 도구의 조합은 과소특정 분석(3편)에서 $E[\hat{\sigma}^2]$의 편의를 계산할 때 그대로 반복된다.

# 6. 행렬 미분

## 6.1. 표기 규약

벡터 $x \in \mathbb{R}^p$에 대한 스칼라 함수 $f(x)$의 미분을 열벡터

$$\frac{\partial f}{\partial x} =
\left( \frac{\partial f}{\partial x_1}, \dots, \frac{\partial f}{\partial x_p} \right)'$$

로 정의한다(gradient 규약). 문헌에 따라 행벡터로 두는 규약도 있으므로 (Magnus & Neudecker (2019), Ch. 9의 layout 논의 참고), 다른 책과 결과를 대조할 때는 전치 여부를 항상 확인해야 한다. 이 시리즈는 위 규약으로 통일한다.

## 6.2. 두 가지 기본 공식

{{< thm >}}
**Theorem 7** (기본 미분 공식). 상수벡터 $a \in \mathbb{R}^p$와 정방행렬 $A \in \mathbb{R}^{p \times p}$에 대해
$$\text{(i) } \frac{\partial\, (a'x)}{\partial x} = a, \qquad
\text{(ii) } \frac{\partial\, (x'Ax)}{\partial x} = (A + A')x$$
특히 $A$가 대칭이면 (ii)는 $2Ax$이다.
{{< /thm >}}

<details>
<summary>증명</summary>

(i) $a'x = \sum_j a_j x_j$이므로 $\partial(a'x)/\partial x_i = a_i$. 성분을 모으면 $a$다.

(ii) $x'Ax = \sum_j \sum_k a_{jk} x_j x_k$를 $x_i$로 미분한다. 곱의 법칙에 의해 $j = i$인 항에서 $\sum_k a_{ik}x_k$가, $k = i$인 항에서 $\sum_j a_{ji}x_j$가 나온다. 전자는 $Ax$의, 후자는 $A'x$의 $i$번째 성분이다. 성분을 모으면 $(A + A')x$다. $\blacksquare$
</details>

이 둘이면 시리즈에서 필요한 행렬 미분의 거의 전부다. 더 체계적인 전개 — 미분형식 기반의 identification 정리, Kronecker 곱과 vec 연산자 — 는 Magnus & Neudecker (2019)를 참고하라. Kalman gain 유도 글에서 사용한 것과 같은 체계다.

## 6.3. 적용: 정규방정식의 해석적 유도

3.2절에서 기하로 얻었던 결과를 미분으로 재확인하자. 목적함수를 전개하면

$$S(b) =
\Vert y - Xb \Vert^2 =
y'y - 2b'X'y + b'X'Xb$$

이다. 가운데 항은 $y'Xb$가 스칼라여서 자신의 전치 $b'X'y$와 같음을 이용해 합쳤다. Theorem 7 (i)을 $a = X'y$에, (ii)를 $A = X'X$(대칭)에 적용하면

$$\frac{\partial S}{\partial b} =
-2X'y + 2X'Xb$$

이고, 1계 조건에서 정규방정식 $X'Xb = X'y$를 얻는다. Hessian은 $\partial^2 S / \partial b\, \partial b' = 2X'X$인데 full column rank 가정 하에 양정치이므로, 해는 유일한 전역 최소점이다.

같은 답에 도달하는 두 경로를 갖게 되었다. 기하 경로(Theorem 1)는 왜 잔차가 설명변수와 직교하는지를 보여주고, 해석 경로는 2계 조건까지 포함한 최적성을 확인해준다. 시리즈에서는 상황에 따라 편한 쪽을 쓴다.

# 7. 요약

이 글의 결과를 시리즈에서 인용할 형태로 압축하면 다음과 같다.

$$P = X(X'X)^{-1}X', \quad
M = I - P, \quad
P' = P = P^2, \quad
M' = M = M^2, \quad
MX = 0$$

$$y = Py + My, \quad
\Vert y \Vert^2 = \Vert Py \Vert^2 + \Vert My \Vert^2, \quad
\operatorname{tr}(P) = \operatorname{rank}(P) = p$$

$$E[z'Az] = \mu'A\mu + \operatorname{tr}(A\Sigma), \quad
\frac{\partial\,(a'x)}{\partial x} = a, \quad
\frac{\partial\,(x'Ax)}{\partial x} = (A + A')x$$


# 참고문헌

- Hoaglin, D. C., & Welsch, R. E. (1978). The Hat Matrix in Regression and ANOVA. *The American Statistician*, 32(1), 17–22.
- Horn, R. A., & Johnson, C. R. (2013). *Matrix Analysis* (2nd ed.). Cambridge University Press.
- Magnus, J. R., & Neudecker, H. (2019). *Matrix Differential Calculus with Applications in Statistics and Econometrics* (3rd ed.). Wiley.
- Seber, G. A. F., & Lee, A. J. (2003). *Linear Regression Analysis* (2nd ed.). Wiley.

[^Wickens-1995]: Wickens, T. D. (1995). *The Geometry of Multivariate Statistics*. Lawrence Erlbaum Associates.

[^angle]: 코시-슈바르츠 부등식에 의해 이 비율은 항상 $[-1, 1]$에 있으므로 그러한 $\theta$가 유일하게 존재한다. $x^*, y^* \neq \mathbf{0}$ 조건은 두 변수 모두 상수가 아니라는 뜻으로, 정확히 상관계수가 정의되는 조건과 같다.
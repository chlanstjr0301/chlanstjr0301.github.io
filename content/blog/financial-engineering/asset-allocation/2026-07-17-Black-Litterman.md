---
title: "Black-Litterman 모형의 수학적 유도"
date: 2026-07-17T12:00:00+09:00
tags: [asset-allocation, Black-Litterman, Bayesian, portfolio]
description: "Black-Litterman 모형을 역최적화부터 사후분포, 최적 포트폴리오까지 행렬대수로 완전히 유도한다."
math: true
toc: true
draft: false
---

Black-Litterman(1992) 모형은 평균-분산 최적화의 고질적 문제 — 기대수익률에 대한 극단적 민감도 — 를 베이즈 결합으로 해결한다. 이 글에서는 논문의 기호를 그대로 따르면서, 역최적화로 사전분포의 중심을 설정하고, 투자자의 견해를 우도로 결합하여 사후분포를 닫힌 형태로 유도하며, 최종 최적 포트폴리오가 균형 포트폴리오와 견해 포트폴리오의 선형결합임을 증명한다. 유도에 필요한 보조정리 두 개도 중간에 증명하고 넘어간다.

**기호 정리.** 자산 $N$개, 견해 $K$개, $\Sigma$는 알려진 $N\times N$ 양정치 공분산 행렬, $\delta > 0$은 시장 평균 위험회피계수이다.

# 0. 균형 리스크 프리미엄의 유도 (역최적화)

$$\Pi = \delta\Sigma w_{eq}$$

기대수익률 벡터 $\mu$를 아는 평균-분산 투자자의 문제는 다음과 같다.

$$\max_{w}\ f(w) = w'\mu - \frac{\delta}{2}w'\Sigma w$$

**1계조건 유도.** 각 항의 기울기를 계산한다.

- 첫째 항: $\nabla_w (w'\mu) = \mu$ (선형함수의 기울기는 계수 벡터 자체)
- 둘째 항: $\Sigma$가 대칭이므로 $\nabla_w(w'\Sigma w) = (\Sigma + \Sigma')w = 2\Sigma w$

따라서 목적함수의 기울기는

$$\nabla_w f = \mu - \delta\Sigma w$$

이를 0으로 놓으면 1계조건(FOC)이 된다.

$$\mu - \delta\Sigma w = 0 \quad\Longleftrightarrow\quad \delta\Sigma w = \mu \quad\Longleftrightarrow\quad w = \frac{1}{\delta}\Sigma^{-1}\mu$$

($\Sigma$가 양정치이므로 가역이라 $\Sigma^{-1}$이 존재한다.) 또한 헤시안(2차 도함수 행렬)이

$$\nabla^2_w f = -\delta\Sigma \prec 0$$

으로 음정치이므로 $f$는 강오목(strictly concave)이고, 위 1계조건은 전역 최댓값의 필요충분조건이다.

**역최적화.** 이를 거꾸로 쓰는 것이 역최적화(reverse optimization)이다. 균형에서는 시장 전체(대표 투자자)가 시가총액 포트폴리오 $w_{eq}$를 보유한다. 즉 "$w_{eq}$가 위 문제의 해가 되도록 하는 $\mu$는 무엇인가?"를 묻는 것이다. 1계조건 $\mu = \delta\Sigma w$에 $w = w_{eq}$를 대입하면

$$\boxed{\ \Pi \equiv \delta\Sigma w_{eq}\ }$$

이것이 식 (2)이다. CAPM을 "믿어서"가 아니라, 시장청산이라는 관측 가능한 사실에서 기대수익을 역산한 것이라는 점이 중요하다. 이것이 사전분포의 중심이 될 자연스러운 출발점을 제공한다.

# 1. 확률 모형의 설정

블랙-리터만은 $\mu$ 자체를 관측 불가능한 확률변수로 놓는다. 세 개의 가정은 다음과 같다.

**(가정 A, 사전분포)** $\mu = \Pi + \varepsilon^{(e)}$, $\varepsilon^{(e)} \sim N(0, \tau\Sigma)$. 즉 $\mu \sim N(\Pi, \tau\Sigma)$.

- $\tau > 0$은 스칼라 불확실성 계수이다. $\tau$가 작을수록 사전의 확신이 강하다.
- 공분산의 구조를 $\tau\Sigma$로 놓는 이유: 자산 간 상관구조를 보존하면서, 단일 파라미터 $\tau$로 전체 불확실성 수준을 조절하기 위함이다.

**(가정 B, 견해)** $P\mu = Q + \varepsilon^{(v)}$, $\varepsilon^{(v)} \sim N(0, \Omega)$. 조건부로 쓰면 $Q \mid \mu \sim N(P\mu, \Omega)$.

- $P$는 $K\times N$ 견해 행렬이다. $k$번째 행이 $k$번째 견해에 관여하는 자산의 가중치를 나타낸다.
- $Q$는 $K$-벡터로, 각 견해의 기대 초과수익이다.
- $\Omega$는 $K\times K$ 양정치 행렬로, 견해의 불확실성을 나타낸다.

**(가정 C, 독립성)** $\varepsilon^{(e)} \perp \varepsilon^{(v)}$, 그리고 수익률 충격 $u$ (아래 4절)도 이 둘과 독립.

# 2. 보조정리 1: 이차형식의 완전제곱

{{< thm >}}
**보조정리 1.** $M$이 대칭 양정치, $b$가 벡터일 때,

$$\mu' M \mu - 2\mu' b = (\mu - M^{-1}b)' M (\mu - M^{-1}b) - b'M^{-1}b$$
{{< /thm >}}
<details>
<summary>증명</summary>

우변의 첫 항을 전개한다. $m \equiv M^{-1}b$로 놓으면

$$(\mu - m)'M(\mu - m) = \mu'M\mu - \mu'Mm - m'M\mu + m'Mm$$

각 항을 정리한다.

- $\mu'Mm = \mu'M(M^{-1}b) = \mu'b$
- $m'M\mu = (M^{-1}b)'M\mu = b'(M^{-1})'M\mu = b'M^{-1}M\mu = b'\mu$

여기서 $M$이 대칭이므로 $(M^{-1})' = (M')^{-1} = M^{-1}$을 사용했다. 또한 $b'\mu$는 스칼라이므로 $b'\mu = (b'\mu)' = \mu'b$이다. 따라서

$$(\mu - m)'M(\mu - m) = \mu'M\mu - \mu'b - \mu'b + m'Mm = \mu'M\mu - 2\mu'b + b'M^{-1}b$$

마지막 항은 $m'Mm = (M^{-1}b)'M(M^{-1}b) = b'M^{-1}MM^{-1}b = b'M^{-1}b$이다. 우변 전체는

$$(\mu - m)'M(\mu - m) - b'M^{-1}b = \mu'M\mu - 2\mu'b + b'M^{-1}b - b'M^{-1}b = \mu'M\mu - 2\mu'b$$

좌변과 일치한다. $\blacksquare$

</details>

이 보조정리의 역할은 이차형식을 "완전제곱 + 상수" 꼴로 바꿔, 정규분포의 평균과 분산을 읽어내는 것이다.

# 3. 사후분포의 유도 — 식 (8), (9)

## 3.1 베이즈 정리의 적용

베이즈 정리에 의해

$$p(\mu \mid Q) = \frac{p(Q \mid \mu)\, p(\mu)}{p(Q)} \propto p(Q \mid \mu)\, p(\mu)$$

여기서 $p(Q)$는 $\mu$에 무관한 정규화 상수이므로, $\mu$에 대한 함수 형태만 보면 된다. 이제 각 밀도를 다변량 정규분포의 형태로 쓴다.

**사전분포** $p(\mu)$: 가정 A에 의해 $\mu \sim N(\Pi, \tau\Sigma)$이므로

$$p(\mu) \propto \exp\Bigl\{-\frac{1}{2}(\mu - \Pi)'(\tau\Sigma)^{-1}(\mu - \Pi)\Bigr\}$$

**우도** $p(Q \mid \mu)$: 가정 B에 의해 $Q \mid \mu \sim N(P\mu, \Omega)$이므로

$$p(Q \mid \mu) \propto \exp\Bigl\{-\frac{1}{2}(Q - P\mu)'\Omega^{-1}(Q - P\mu)\Bigr\}$$

둘을 곱하면 (exp의 지수끼리 더하면)

$$p(\mu \mid Q) \propto \exp\Bigl\{-\frac{1}{2}\bigl[(\mu - \Pi)'(\tau\Sigma)^{-1}(\mu - \Pi) + (Q - P\mu)'\Omega^{-1}(Q - P\mu)\bigr]\Bigr\}$$

## 3.2 지수부 전개

계산의 편의를 위해 $-2\log p(\mu \mid Q)$의 $\mu$-의존 부분을 정리한다.

$$-2\log p(\mu \mid Q) = \underbrace{(\mu - \Pi)'(\tau\Sigma)^{-1}(\mu - \Pi)}_{\text{사전 항}} + \underbrace{(Q - P\mu)'\Omega^{-1}(Q - P\mu)}_{\text{우도 항}} + c$$

($c$는 $\mu$에 무관한 모든 상수를 흡수한다.)

**사전 항 전개:**

$$(\mu-\Pi)'(\tau\Sigma)^{-1}(\mu-\Pi)$$

$A = (\tau\Sigma)^{-1}$로 놓으면 이는 $(\mu - \Pi)'A(\mu - \Pi)$이다. 전개하면

$$= \mu'A\mu - \mu'A\Pi - \Pi'A\mu + \Pi'A\Pi$$

$A$가 대칭이고 $\Pi'A\mu$는 스칼라이므로 $\Pi'A\mu = (\Pi'A\mu)' = \mu'A'\Pi = \mu'A\Pi$이다. 따라서

$$= \mu'(\tau\Sigma)^{-1}\mu - 2\mu'(\tau\Sigma)^{-1}\Pi + \underbrace{\Pi'(\tau\Sigma)^{-1}\Pi}_{\text{상수} \to c}$$

**우도 항 전개:**

$$(Q-P\mu)'\Omega^{-1}(Q-P\mu)$$

전개하면

$$= Q'\Omega^{-1}Q - Q'\Omega^{-1}P\mu - (P\mu)'\Omega^{-1}Q + (P\mu)'\Omega^{-1}P\mu$$

각 항을 정리한다.

- $(P\mu)'\Omega^{-1}P\mu = \mu'P'\Omega^{-1}P\mu$ (전치의 성질 $(AB)' = B'A'$)
- $(P\mu)'\Omega^{-1}Q = \mu'P'\Omega^{-1}Q$이고 이는 스칼라이므로 $Q'\Omega^{-1}P\mu = (Q'\Omega^{-1}P\mu)' = \mu'P'\Omega^{-1}Q$

따라서

$$= \mu'P'\Omega^{-1}P\mu - 2\mu'P'\Omega^{-1}Q + \underbrace{Q'\Omega^{-1}Q}_{\text{상수} \to c}$$

## 3.3 이차항·일차항 결합

두 항을 더하고 $\mu$에 의존하는 부분만 모으면

$$-2\log p(\mu\mid Q) = \mu'\underbrace{\bigl[(\tau\Sigma)^{-1} + P'\Omega^{-1}P\bigr]}_{\equiv\, \bar M}\mu\ -\ 2\mu'\underbrace{\bigl[(\tau\Sigma)^{-1}\Pi + P'\Omega^{-1}Q\bigr]}_{\equiv\, b} + c$$

즉

$$-2\log p(\mu\mid Q) = \mu'\bar M\mu - 2\mu' b + c$$

$\bar M$은 양정치($(\tau\Sigma)^{-1} \succ 0$)와 양반정치($P'\Omega^{-1}P \succeq 0$)의 합이므로 양정치이다.

## 3.4 완전제곱 완성

보조정리 1을 적용한다. $\mu'\bar M\mu - 2\mu'b$에서 $M = \bar M$으로 놓으면

$$\mu'\bar M\mu - 2\mu'b = (\mu - \bar M^{-1}b)'\bar M(\mu - \bar M^{-1}b) - b'\bar M^{-1}b$$

$b'\bar M^{-1}b$는 상수이므로 $c$에 흡수된다. 결과적으로

$$-2\log p(\mu\mid Q) = (\mu - \bar M^{-1}b)'\bar M(\mu - \bar M^{-1}b) + c'$$

## 3.5 정규분포 식별

다변량 정규분포 $N(\hat\mu, \hat\Sigma)$의 로그밀도는

$$-2\log p(x) = (x - \hat\mu)'\hat\Sigma^{-1}(x - \hat\mu) + \text{상수}$$

꼴이다. 위 결과와 비교하면

- 정밀도 행렬(공분산의 역행렬): $\hat\Sigma^{-1} = \bar M$, 즉 $\hat\Sigma = \bar M^{-1}$
- 평균: $\hat\mu = \bar M^{-1}b$

따라서

$$\boxed{\ \mu \mid Q \sim N(\bar\mu,\ \bar M^{-1}), \qquad \bar\mu = \bar M^{-1}b = \bigl[(\tau\Sigma)^{-1} + P'\Omega^{-1}P\bigr]^{-1}\bigl[(\tau\Sigma)^{-1}\Pi + P'\Omega^{-1}Q\bigr]\ }$$

식 (8), (9) 완성이다.

**해석.** 사후평균 $\bar\mu$는 정밀도 가중평균이다. 정밀도(precision)란 분산의 역수로, 정보의 양을 나타낸다.

- 사전의 정밀도: $(\tau\Sigma)^{-1}$ → 이것으로 $\Pi$를 가중
- 견해의 정밀도: $P'\Omega^{-1}P$ → 이것으로 견해 정보 $P'\Omega^{-1}Q$를 가중

$\Omega$가 작을수록(견해의 확신이 강할수록) 견해 쪽의 가중치가 커지고, $\tau$가 작을수록(사전의 확신이 강할수록) 균형 쪽의 가중치가 커진다.

# 4. 수익률의 예측분포 — 식 (10)

실현 수익률은 $r = \mu + u$이고, $u \sim N(0, \Sigma)$이다. 가정 C에 의해 $u$는 $(\varepsilon^{(e)}, \varepsilon^{(v)})$와 독립이므로, $Q$를 관측한 뒤의 사후분포 $\mu \mid Q$와도 독립이다.

독립인 정규확률변수의 합은 정규이고, 평균은 합, 분산도 합이므로

$$E[r \mid Q] = E[\mu \mid Q] + E[u] = \bar\mu + 0 = \bar\mu$$

$$\mathrm{Var}(r \mid Q) = \mathrm{Var}(\mu \mid Q) + \mathrm{Var}(u) = \bar M^{-1} + \Sigma$$

(독립이므로 공분산 항이 없다.) 따라서

$$\boxed{\ r \mid Q \sim N(\bar\mu,\ \bar\Sigma), \qquad \bar\Sigma \equiv \Sigma + \bar M^{-1}\ }$$

$\mu$가 확률변수이므로 추정 불확실성 $\bar M^{-1}$이 수익률 분산에 더해진다. $\bar\Sigma$는 순수한 수익률 변동성 $\Sigma$에 모수 불확실성 $\bar M^{-1}$이 얹힌 것이며, 이것이 실무 구현에서 가장 자주 빠뜨리는 부분이다.

# 5. 최적화 문제와 1계조건 — 식 (13)

투자자는 예측분포 $r \mid Q \sim N(\bar\mu, \bar\Sigma)$를 입력으로 평균-분산 최적화를 푼다.

$$\max_w\ w'\bar\mu - \frac{\delta}{2}w'\bar\Sigma w$$

0절과 동일한 논리를 적용한다. $\bar\Sigma \succ 0$이므로 목적함수는 강오목이고, 1계조건이 전역 최댓값의 필요충분조건이다.

$$\nabla_w\bigl[w'\bar\mu - \frac{\delta}{2}w'\bar\Sigma w\bigr] = \bar\mu - \delta\bar\Sigma w = 0$$

$$\therefore\quad \bar\mu = \delta\bar\Sigma w^* \quad\Longleftrightarrow\quad w^* = \frac{1}{\delta}\bar\Sigma^{-1}\bar\mu$$

3절에서 $\bar\mu = \bar M^{-1}b$이므로

$$w^* = \frac{1}{\delta}\bar\Sigma^{-1}\bar M^{-1}b$$

이제 남은 것은 순수 행렬대수로, $\bar\Sigma^{-1}\bar M^{-1}$을 다루기 좋은 꼴로 만드는 것이다.

# 6. 보조정리 2: Push-through 항등식

{{< thm >}}
**보조정리 2.** $U$가 $N\times K$, $V$가 $K\times N$이고 $I_K + VU$가 가역이면 $I_N + UV$도 가역이고

$$(I + UV)^{-1} = I - U(I + VU)^{-1}V$$
{{< /thm >}}
<details>
<summary>증명</summary>

$(I + UV)$에 $[I - U(I+VU)^{-1}V]$를 오른쪽에서 곱하여 $I$가 되는지 확인한다.

$$(I + UV)\bigl[I - U(I+VU)^{-1}V\bigr]$$

분배법칙으로 전개하면

$$= I\cdot I - I\cdot U(I+VU)^{-1}V + UV\cdot I - UV\cdot U(I+VU)^{-1}V$$

$$= I - U(I+VU)^{-1}V + UV - UVU(I+VU)^{-1}V$$

둘째·넷째 항에서 $U$를 왼쪽으로, $(I+VU)^{-1}V$를 오른쪽으로 묶는다. 또한 셋째 항의 $UV$를 $U\cdot I\cdot V = U(I+VU)^{-1}(I+VU)V$로 쓰면, 둘째~넷째 항 전체가

$$U\bigl[-(I+VU)^{-1} + (I+VU)^{-1}(I+VU) - VU(I+VU)^{-1}\bigr]V$$

가운데 괄호를 $(I+VU)^{-1}$로 묶으면

$$= U(I+VU)^{-1}\bigl[-I + (I+VU) - VU\bigr]V = U(I+VU)^{-1}\cdot 0\cdot V = 0$$

따라서 전체는 $I$이다. $\blacksquare$

**더 간단한 증명.** 셋째 항 $UV$를 $U\cdot I\cdot V$로 두고, 둘째와 셋째 항을 합치면

$$-U(I+VU)^{-1}V + UV = U\bigl[I - (I+VU)^{-1}\bigr]V = U\cdot(I+VU)^{-1}VU\cdot V$$

(마지막 등호는 $I - (I+VU)^{-1} = (I+VU)^{-1}[(I+VU) - I] = (I+VU)^{-1}VU$.) 이를 넷째 항 $-UVU(I+VU)^{-1}V$와 더하면

$$U(I+VU)^{-1}VUV - UVU(I+VU)^{-1}V$$

이것은... 복잡해지므로, 가장 깔끔한 증명은 직접 곱의 결과를 다음과 같이 정리하는 것이다:

$$(I+UV)[I - U(I+VU)^{-1}V] = I + UV - U(I+VU)^{-1}V - UVU(I+VU)^{-1}V$$

뒤 세 항에서 $V$ 앞의 부분을 모으면

$$= I + U\bigl[V - (I+VU)^{-1}V - VU(I+VU)^{-1}V\bigr]$$

$$= I + U\bigl[I - (I+VU)^{-1} - VU(I+VU)^{-1}\bigr]V$$

$$= I + U\bigl[I - (I + VU)(I+VU)^{-1}\bigr]V$$

$$= I + U\bigl[I - I\bigr]V = I \qquad\blacksquare$$

</details>

이 항등식은 $N$차원 역행렬을 $K$차원 역행렬로 바꿔준다. $K \ll N$이므로 계산상으로도 핵심이며, 아래에서 행렬 $A$가 자연스럽게 나타나는 지점이기도 하다.

# 7. $\bar\Sigma^{-1}\bar M^{-1}$의 단순화 — 식 (16)

## 7-1. 역행렬 곱의 변환

두 가역 행렬의 곱에 대해 $(XY)^{-1} = Y^{-1}X^{-1}$이 성립한다. 이를 거꾸로 쓰면 $Y^{-1}X^{-1} = (XY)^{-1}$이다. $X = \bar M$, $Y = \bar\Sigma$로 놓으면

$$\bar\Sigma^{-1}\bar M^{-1} = (\bar M\bar\Sigma)^{-1}$$

$\bar\Sigma = \Sigma + \bar M^{-1}$을 대입하면

$$\bar M\bar\Sigma = \bar M(\Sigma + \bar M^{-1}) = \bar M\Sigma + \bar M\bar M^{-1} = \bar M\Sigma + I$$

따라서

$$\bar\Sigma^{-1}\bar M^{-1} = (I + \bar M\Sigma)^{-1}$$

## 7-2. $\bar M\Sigma$ 계산

$\bar M = (\tau\Sigma)^{-1} + P'\Omega^{-1}P$이므로

$$\bar M\Sigma = \bigl[(\tau\Sigma)^{-1} + P'\Omega^{-1}P\bigr]\Sigma = (\tau\Sigma)^{-1}\Sigma + P'\Omega^{-1}P\Sigma$$

첫 항을 정리하면 $(\tau\Sigma)^{-1}\Sigma = \frac{1}{\tau}\Sigma^{-1}\Sigma = \frac{1}{\tau}I$이다. 따라서

$$\bar M\Sigma = \frac{1}{\tau}I + P'\Omega^{-1}P\Sigma$$

$$I + \bar M\Sigma = I + \frac{1}{\tau}I + P'\Omega^{-1}P\Sigma = \frac{1+\tau}{\tau}I + P'\Omega^{-1}P\Sigma$$

$\frac{1+\tau}{\tau}$을 인수로 뽑으면

$$= \frac{1+\tau}{\tau}\Bigl[I + \frac{\tau}{1+\tau}P'\Omega^{-1}P\Sigma\Bigr]$$

보조정리 2를 적용하기 위해 $\frac{\tau}{1+\tau}P'\Omega^{-1}P\Sigma$를 $UV$ 꼴로 분해한다.

$$\frac{\tau}{1+\tau}P'\Omega^{-1}P\Sigma = \underbrace{(P'\tau\Omega^{-1})}_{U:\ N\times K}\,\underbrace{\Bigl(\frac{P\Sigma}{1+\tau}\Bigr)}_{V:\ K\times N}$$

## 7-3. 보조정리 2 적용

$U = P'\tau\Omega^{-1}$ ($N\times K$), $V = \frac{P\Sigma}{1+\tau}$ ($K\times N$)로 놓으면

$$VU = \frac{P\Sigma}{1+\tau}\cdot P'\tau\Omega^{-1} = \frac{\tau}{1+\tau}P\Sigma P'\Omega^{-1}$$

보조정리 2에 의해

$$(I + UV)^{-1} = I - U(I+VU)^{-1}V = I - P'\tau\Omega^{-1}\Bigl[I + \frac{\tau}{1+\tau}P\Sigma P'\Omega^{-1}\Bigr]^{-1}\frac{P\Sigma}{1+\tau}$$

## 7-4. 가운데 역행렬 정리

$X \equiv \frac{P\Sigma P'}{1+\tau}$ ($K\times K$ 행렬)로 놓으면

$$I + VU = I + X\cdot\tau\Omega^{-1}$$

이를 정리한다. 목표는 $\tau\Omega^{-1}(I + X\tau\Omega^{-1})^{-1}$을 깔끔한 꼴로 만드는 것이다.

$I + X\tau\Omega^{-1}$에서 $\tau\Omega^{-1}$을 오른쪽으로 묶으려면, $I = \frac{\Omega}{\tau}\cdot\tau\Omega^{-1}$임을 이용한다.

$$I + X\tau\Omega^{-1} = \frac{\Omega}{\tau}\cdot\tau\Omega^{-1} + X\cdot\tau\Omega^{-1} = \Bigl(\frac{\Omega}{\tau} + X\Bigr)\tau\Omega^{-1}$$

(검증: 우변을 전개하면 $\frac{\Omega}{\tau}\cdot\tau\Omega^{-1} + X\tau\Omega^{-1} = I + X\tau\Omega^{-1}$. 맞다.)

양변의 역행렬을 취하면

$$\bigl(I + X\tau\Omega^{-1}\bigr)^{-1} = \bigl[\bigl(\frac{\Omega}{\tau} + X\bigr)\tau\Omega^{-1}\bigr]^{-1} = \frac{\Omega}{\tau}\bigl(\frac{\Omega}{\tau} + X\bigr)^{-1}$$

($(AB)^{-1} = B^{-1}A^{-1}$을 적용했다.) 이제 7-3에서 필요한 $\tau\Omega^{-1}(I + VU)^{-1}$을 계산하면

$$\tau\Omega^{-1}\cdot(I + X\tau\Omega^{-1})^{-1} = \tau\Omega^{-1}\cdot\frac{\Omega}{\tau}\bigl(\frac{\Omega}{\tau} + X\bigr)^{-1} = I\cdot\bigl(\frac{\Omega}{\tau} + X\bigr)^{-1} = \bigl(\frac{\Omega}{\tau} + X\bigr)^{-1}$$

$X = \frac{P\Sigma P'}{1+\tau}$을 대입하면

$$= \Bigl(\frac{\Omega}{\tau} + \frac{P\Sigma P'}{1+\tau}\Bigr)^{-1} \equiv A^{-1}$$

여기서 논문의 핵심 행렬이 정의된다.

$$\boxed{\ A \equiv \frac{\Omega}{\tau} + P\frac{\Sigma}{1+\tau}P'\ }$$

$A$가 양정치인 이유: $\Omega/\tau \succ 0$ (양정치)이고 $P\frac{\Sigma}{1+\tau}P' \succeq 0$ (양반정치)이므로 그 합은 양정치이다. 따라서 $A$는 가역이다.

## 7-5. 결합

7-1~7-4를 모두 합친다. 7-1에서 $\bar\Sigma^{-1}\bar M^{-1} = (I + \bar M\Sigma)^{-1}$이었고, 7-2에서 $I + \bar M\Sigma = \frac{1+\tau}{\tau}(I + UV)$이므로

$$\bar\Sigma^{-1}\bar M^{-1} = \frac{\tau}{1+\tau}(I + UV)^{-1}$$

7-3의 보조정리 2 결과와 7-4를 대입하면

$$(I+UV)^{-1} = I - P'\cdot\underbrace{\tau\Omega^{-1}(I+VU)^{-1}}_{= A^{-1}}\cdot\frac{P\Sigma}{1+\tau} = I - P'A^{-1}P\frac{\Sigma}{1+\tau}$$

따라서

$$\boxed{\ \bar\Sigma^{-1}\bar M^{-1} = \frac{\tau}{1+\tau}\Bigl[I - P'A^{-1}P\frac{\Sigma}{1+\tau}\Bigr]\ }$$

식 (16) 완성이다.

# 8. 최적 포트폴리오의 항별 전개 — 식 (17), (18)

5절의 $w^* = \frac{1}{\delta}\bar\Sigma^{-1}\bar M^{-1}b$에 식 (16)과 $b = (\tau\Sigma)^{-1}\Pi + P'\Omega^{-1}Q$를 대입한다.

$$w^* = \frac{1}{\delta}\cdot\frac{\tau}{1+\tau}\Bigl[I - P'A^{-1}P\frac{\Sigma}{1+\tau}\Bigr]\Bigl[(\tau\Sigma)^{-1}\Pi + P'\Omega^{-1}Q\Bigr]$$

곱을 분배법칙으로 펼치면 네 항이 된다. 전 과정에서 $\Pi = \delta\Sigma w_{eq}$, 즉 $\Sigma^{-1}\Pi = \delta w_{eq}$를 사용한다.

**항 1** — $I \times (\tau\Sigma)^{-1}\Pi$:

$$\frac{\tau}{\delta(1+\tau)}\cdot(\tau\Sigma)^{-1}\Pi = \frac{\tau}{\delta(1+\tau)}\cdot\frac{1}{\tau}\Sigma^{-1}\Pi = \frac{1}{\delta(1+\tau)}\cdot\Sigma^{-1}\Pi = \frac{1}{\delta(1+\tau)}\cdot\delta w_{eq} = \frac{w_{eq}}{1+\tau}$$

**항 2** — $I \times P'\Omega^{-1}Q$:

$$\frac{\tau}{\delta(1+\tau)}\cdot P'\Omega^{-1}Q = \frac{1}{1+\tau}\cdot P'\cdot\frac{\tau\Omega^{-1}Q}{\delta}$$

**항 3** — $-P'A^{-1}P\frac{\Sigma}{1+\tau} \times (\tau\Sigma)^{-1}\Pi$:

먼저 안쪽 곱을 계산한다.

$$\frac{\Sigma}{1+\tau}\cdot(\tau\Sigma)^{-1}\Pi = \frac{\Sigma}{1+\tau}\cdot\frac{1}{\tau}\Sigma^{-1}\Pi = \frac{1}{\tau(1+\tau)}\cdot I\cdot\Pi = \frac{\Pi}{\tau(1+\tau)}$$

$\Pi = \delta\Sigma w_{eq}$를 대입하면 $= \frac{\delta\Sigma w_{eq}}{\tau(1+\tau)}$이다. 전체 항은

$$-\frac{\tau}{\delta(1+\tau)}\cdot P'A^{-1}P\cdot\frac{\delta\Sigma w_{eq}}{\tau(1+\tau)} = -\frac{1}{1+\tau}\cdot P'\cdot A^{-1}P\frac{\Sigma}{1+\tau}w_{eq}$$

**항 4** — $-P'A^{-1}P\frac{\Sigma}{1+\tau} \times P'\Omega^{-1}Q$:

$$-\frac{\tau}{\delta(1+\tau)}\cdot P'A^{-1}P\frac{\Sigma}{1+\tau}\cdot P'\Omega^{-1}Q = -\frac{1}{1+\tau}\cdot P'\cdot A^{-1}P\frac{\Sigma}{1+\tau}P'\cdot\frac{\tau\Omega^{-1}Q}{\delta}$$

**결합.** 항 2, 3, 4가 전부 $\frac{1}{1+\tau}P'(\cdot)$ 꼴이므로, 괄호 안을 $\Lambda$로 정의하면

$$\boxed{\ w^* = \frac{1}{1+\tau}\bigl(w_{eq} + P'\Lambda\bigr)\ }$$

$$\Lambda = \frac{\tau\Omega^{-1}Q}{\delta} - A^{-1}P\frac{\Sigma}{1+\tau}\,w_{eq} - A^{-1}P\frac{\Sigma}{1+\tau}P'\,\frac{\tau\Omega^{-1}Q}{\delta}$$

식 (17), (18) 그대로이다.

**해석.** 최적 포트폴리오는 두 부분의 합이다:
1. $\frac{w_{eq}}{1+\tau}$: 축소된 균형 포트폴리오 (모수 불확실성으로 인한 축소)
2. $\frac{1}{1+\tau}P'\Lambda$: 견해 포트폴리오들의 선형결합

견해에 등장하지 않는 자산은 $P$의 해당 열이 0이므로 균형 대비 편차가 정확히 0이다. 즉, 의견을 표명하지 않은 자산은 균형 비중을 그대로 유지한다.

# 9. $\Lambda$의 압축 — 부록 식 (38)

식 (18)의 $\Lambda$는 세 항으로 복잡하다. 이를 단일 표현으로 압축한다.

**단계 1.** 첫째·셋째 항에서 공통인 $\frac{\tau\Omega^{-1}Q}{\delta}$를 오른쪽으로 묶는다.

$$\Lambda = \Bigl[I - A^{-1}P\frac{\Sigma}{1+\tau}P'\Bigr]\frac{\tau\Omega^{-1}Q}{\delta} - A^{-1}P\frac{\Sigma}{1+\tau}w_{eq}$$

**단계 2.** 대괄호 안을 정리한다. $A^{-1}$을 인수로 뽑으면

$$I - A^{-1}P\frac{\Sigma}{1+\tau}P' = A^{-1}\Bigl[A - P\frac{\Sigma}{1+\tau}P'\Bigr]$$

$A$의 정의 $A = \frac{\Omega}{\tau} + P\frac{\Sigma}{1+\tau}P'$에서 $P\frac{\Sigma}{1+\tau}P'$를 빼면

$$A - P\frac{\Sigma}{1+\tau}P' = \frac{\Omega}{\tau}$$

따라서

$$I - A^{-1}P\frac{\Sigma}{1+\tau}P' = A^{-1}\cdot\frac{\Omega}{\tau}$$

**단계 3.** 대입하면 첫 항이 크게 축약된다.

$$A^{-1}\cdot\frac{\Omega}{\tau}\cdot\frac{\tau\Omega^{-1}Q}{\delta} = A^{-1}\cdot\frac{\Omega}{\tau}\cdot\frac{\tau}{\delta}\Omega^{-1}Q = A^{-1}\cdot\frac{1}{\delta}\cdot\Omega\Omega^{-1}\cdot Q = A^{-1}\frac{Q}{\delta}$$

**결과.** 두 항을 합치면

$$\boxed{\ \Lambda = A^{-1}\Bigl(\frac{Q}{\delta} - P\frac{\Sigma}{1+\tau}\,w_{eq}\Bigr), \qquad A = \frac{\Omega}{\tau} + P\frac{\Sigma}{1+\tau}P'\ }$$

**해석.** 이 압축된 형태에서 각 요소의 의미가 명확하다.

- $\frac{Q}{\delta}$: 투자자가 선언한 견해를 위험회피계수로 정규화한 것
- $P\frac{\Sigma}{1+\tau}w_{eq}$: 축소된 균형 포트폴리오가 이미 함의하는 견해 포트폴리오들의 기대수익 (이를 $\delta$로 나눈 것)

따라서 괄호 안은 "(내가 선언한 견해) − (균형이 이미 함의하는 값)"이다. 균형이 이미 제공하는 것 이상의 초과 견해만이 포트폴리오를 움직인다.

앞의 $A^{-1}$은 그 초과 견해를 불확실성으로 조정하는 역할을 한다:
- $\Omega/\tau$: 견해 자체의 불확실성 (클수록 베팅이 줄어듦)
- $P\frac{\Sigma}{1+\tau}P'$: 견해 포트폴리오들 간 공분산 (겹칠수록 베팅이 줄어듦)

Property 3.2도 여기서 자연스럽게 따라 나온다: $\frac{\partial \Lambda}{\partial Q'} = \frac{1}{\delta}A^{-1}$이고 양정치 행렬의 대각원소는 양수이므로 $\frac{\partial\lambda_k}{\partial q_k} = \frac{(A^{-1})_{kk}}{\delta} > 0$이다. 즉, $k$번째 견해의 기대수익을 올리면 그 견해에 대한 베팅이 항상 증가한다.

# 10. 검산

## 견해가 없는 경우

$K = 0$ (견해 없음)이면 $P'\Omega^{-1}P = 0$이므로

$$\bar M = (\tau\Sigma)^{-1}, \quad \bar\mu = \bar M^{-1}\cdot(\tau\Sigma)^{-1}\Pi = \tau\Sigma\cdot\frac{1}{\tau}\Sigma^{-1}\Pi = \Pi$$

$$\bar\Sigma = \Sigma + \bar M^{-1} = \Sigma + \tau\Sigma = (1+\tau)\Sigma$$

최적 포트폴리오에 대입하면

$$w^* = \frac{1}{\delta}\bar\Sigma^{-1}\bar\mu = \frac{1}{\delta}\bigl[(1+\tau)\Sigma\bigr]^{-1}\Pi = \frac{1}{\delta(1+\tau)}\Sigma^{-1}\Pi = \frac{1}{\delta(1+\tau)}\cdot\delta w_{eq} = \frac{w_{eq}}{1+\tau}$$

식 (17)에서 $\Lambda = 0$으로 놓은 것과 정확히 일치한다.

**왜 $\frac{1}{1+\tau}$로 축소되는가?** $\mu$가 확정이 아닌 확률변수이므로 총분산이 $\Sigma$가 아니라 $(1+\tau)\Sigma$가 된다. 위험이 $(1+\tau)$배가 되었으니, 동일한 위험회피계수 하에서 위험자산 보유를 $\frac{1}{1+\tau}$로 줄이는 것이 최적이다.

## 차원 검산

$A$는 $K\times K$, $\Lambda$는 $K$-벡터, $P'\Lambda$는 $N$-벡터이다. $N$차원 역행렬은 $\Sigma^{-1}$ 하나($w_{eq}$ 정의 시)만 필요하고 나머지는 전부 $K$차원에서 계산된다. 견해 7개짜리 문제라면 자산이 500개여도 $7\times 7$ 역행렬 하나면 충분하다.

---

이것으로 논문 본문(2–3절)의 유도가 전부 완료되었다. 남은 것은 부록의 Property 3.1 — 견해를 하나 추가했을 때 $\hat\Lambda$가 식 (22)–(23)처럼 분해된다는 것 — 인데, 이는 $\hat A$의 블록 역행렬(Schur 보수 $d = c - b'A^{-1}b$)이 핵심이며, 보조정리 2와 짝을 이루는 내용이다.

---
title: "CRR 이항모형(Cox-Ross-Rubinstein Binomial Model)"
date: 2026-07-04 12:00:00 +0900
categories: [Finance, Stochastic Calculus]
tags: [wiener-process, brownian-motion, GBM, ito-lemma, CRR-binomial-model, option-pricing]
description: "Random walk에서 출발해 Wiener process, GBM, Itô's lemma를 거쳐 CRR 이항모형의 파라미터 u, d와 위험중립확률 p가 어떻게 결정되는지 유도합니다."
math: true
toc: true
draft: false
---

# 0. Introduction

CRR 이항모형(Cox-Ross-Rubinstein Binomial Model)은 옵션가격결정을 위한 가장 단순한 이산시간 모형입니다.[^crr] 연속시간의 Black-Scholes 모형과 달리, 한 스텝 동안 주가가 오르거나 내리는 두 가지 경우만 존재한다고 가정하기 때문에 무차익거래와 위험중립가격결정의 논리를 가장 투명하게 볼 수 있습니다. 또한 스텝 수를 늘리면 Black-Scholes 가격으로 수렴하고, 트리 구조 덕분에 아메리칸 옵션이나 경로의존 옵션처럼 닫힌 해가 없는 상품의 수치적 가격계산에도 그대로 확장됩니다.

CRR 모형에서는 한 스텝 동안 주가가 $u$배 또는 $d$배로 움직인다고 가정하며, 통상

$$
u=e^{\sigma\sqrt{\Delta t}},
\qquad
d=\frac1u,
\qquad
p=\frac{e^{r\Delta t}-d}{u-d}
$$

로 파라미터를 잡습니다. 대부분의 교재는 이 식을 주어진 것으로 받아들이고 트리 계산으로 넘어가지만, 이 글에서는 이 선택이 왜 그렇게 되는지를 바닥부터 확인합니다. 흐름은 다음과 같습니다. 먼저 random walk에서 출발해 스케일 조정의 극한으로 Wiener process를 얻고(1\~2절), 주가 모형인 GBM을 도입한 뒤(3절), Itô's lemma로 로그수익률의 분포를 유도해서 시간 $\Delta t$ 동안의 로그수익률 표준편차가 $\sigma\sqrt{\Delta t}$임을 보입니다(4\~5절). 그 다음 이 변동성을 이항모형의 한 스텝에 맞추는 것이 $u$와 $d$의 결정이고(6절), 측도를 실제세계 $\mathbb{P}$에서 위험중립측도 $\mathbb{Q}$로 바꾸는 것이 확률 $p$의 결정임을 확인합니다(7\~8절).

요약하면 핵심은 다음 한 줄입니다. $u$와 $d$는 GBM의 로그수익률 변동성 $\sigma\sqrt{\Delta t}$를 맞추기 위한 것이고, $p$는 위험중립세계에서 주가의 기대성장률이 무위험수익률 $r$이 되도록 맞추기 위한 것입니다.

---


# 1. Random Walk

서로 독립이고 동일한 분포를 따르는 확률변수열

$$
X_1,X_2,\dots
$$

를 생각해 봅시다. 각 $X_k$는 한 번의 이동을 나타내며,

$$
\mathbb{P}(X_k=1)=p,\qquad
\mathbb{P}(X_k=-1)=1-p
$$

라고 합시다. 이때 부분합 과정(partial sum process)은

$$
S_n=\sum_{k=1}^{n}X_k,\qquad S_0=0
$$

으로 정의합니다. 이것이 simple random walk입니다. iid인 증분들의 부분합과정이 random walk이고, 그 중에서 특별히 X_k in {+1, -1}이고 한번에 한 칸씩만 움직이면 simple random walk라고 합니다. 또 p = 1/2이면 symmetric simple random walk, p != 1/2이면 biased simple random walk라고 합니다.

각 이동의 기대값은

$$
\mathbb{E}[X_k]
=1\cdot p+(-1)(1-p)
=2p-1
$$

입니다. 또한 $X_k^2=1$이므로

$$
\mathbb{E}[X_k^2]=1
$$

이고,

$$
\operatorname{Var}(X_k)
=\mathbb{E}[X_k^2]-\{\mathbb{E}[X_k]\}^2
=1-(2p-1)^2.
$$

특히 대칭 random walk, 즉

$$
p=\frac12
$$

이면

$$
\mathbb{E}[X_k]=0,
\qquad
\operatorname{Var}(X_k)=1
$$

이 됩니다.

이때 $S_n$은 독립확률변수들의 합이므로

$$
\mathbb{E}[S_n]
=\sum_{k=1}^{n}\mathbb{E}[X_k]
=0
$$

이고,

$$
\operatorname{Var}(S_n)
=\sum_{k=1}^{n}\operatorname{Var}(X_k)
=n.
$$

따라서 대칭 random walk의 분산은 시간 $n$에 대해 선형적으로 증가합니다.

$$
\boxed{
\operatorname{Var}(S_n)=n
}
$$

---


# 2. Random Walk의 스케일 조정과 Wiener Process

시간 구간 $[0,t]$를 $n$개의 작은 구간으로 나누어 봅시다. 그러면 한 구간의 길이는

$$
h=\frac{t}{n}
$$

입니다. 대칭 random walk $S_n$을 시간 $t$에 맞게 스케일 조정하면

$$
W_t^{(n)}=\sqrt{h}\,S_n
=\sqrt{\frac{t}{n}}S_n
$$

으로 쓸 수 있습니다.

이제 평균과 분산을 계산해 봅시다.

먼저

$$
\mathbb{E}[W_t^{(n)}]
=\sqrt{\frac{t}{n}}\mathbb{E}[S_n]
=0
$$

입니다. 다음으로

$$
\operatorname{Var}(W_t^{(n)})
=\operatorname{Var}\left(\sqrt{\frac{t}{n}}S_n\right)
=\frac{t}{n}\operatorname{Var}(S_n)
=\frac{t}{n}\cdot n
=t.
$$

따라서

$$
\boxed{
\mathbb{E}[W_t^{(n)}]=0,
\qquad
\operatorname{Var}(W_t^{(n)})=t
}
$$

입니다.

한 시점 $t$에서의 분포만 보면, 중심극한정리에 의해

$$
\frac{S_n}{\sqrt n}
\xrightarrow{d}
N(0,1)
$$

이고, 따라서

$$
W_t^{(n)} =
\sqrt t \frac{S_n}{\sqrt n}
\xrightarrow{d}
\sqrt t N(0,1).
$$

그런데

$$
\sqrt t N(0,1)=N(0,t)
$$

이므로

$$
W_t^{(n)}
\xrightarrow{d}
N(0,t).
$$

즉, random walk를 공간에서 $\sqrt n$으로 나누고 시간 $t$에 맞게 $\sqrt t$를 곱해주면, 한 시점 $t$에서의 극한분포는

$$
N(0,t)
$$

가 됩니다.

그러나 Wiener process는 단순히 각 시점에서 정규분포를 갖는 확률변수가 아닙니다. Wiener process는 전체 시간경로를 갖는 확률과정입니다. 엄밀하게는 다음 조건을 만족하는 확률과정 $\lbrace W_t\rbrace_{t\ge 0}$를 표준 Wiener process 또는 Brownian motion이라고 합니다.[^shreve-bm]

1. $W_0=0$ almost surely.
2. $0\le s<t$에 대해 증분 $W_t-W_s$는 정규분포를 따릅니다.

   $$
   W_t-W_s\sim N(0,t-s).
   $$

3. 서로 겹치지 않는 시간구간의 증분은 독립입니다.
4. sample path $t\mapsto W_t(\omega)$는 거의 확실하게 연속입니다.

Random walk에서 Wiener process로 가는 더 강한 결과는 Donsker의 불변원리, 또는 functional central limit theorem입니다.[^donsker] 직관적으로 말하면, 선형보간한 random walk를 $1/\sqrt{n}$ 스케일로 줄이면 전체 경로가 Brownian motion으로 수렴합니다. 이와 관련된 상세한 내용은 다른 글에서 다뤄보도록 하겠습니다.

여기서 다음부터 사용할 핵심 성질은 Brownian motion의 increment가 정규분포를 따른다는 것입니다.

$$
\boxed{
W_{t+\Delta t}-W_t\sim N(0,\Delta t)
}
$$

따라서 표준정규분포를 따르는 확률변수 $Z\sim N(0,1)$에 대해

$$
W_{t+\Delta t}-W_t
\overset{d}{=}
\sqrt{\Delta t}\,Z
$$

라고 쓸 수 있습니다.

---


# 3. GBM(Geometric Brownian Motion)

금융에서 주가를 Brownian motion 자체로 두지는 않습니다. Brownian motion은 음수가 될 수 있기 때문입니다. 주가 $S_t$는 보통 양수여야 하므로, 주가의 상대변화율(relative change)을 확률적으로 모델링합니다.

Geometric Brownian Motion, 즉 GBM은 다음 SDE로 정의됩니다.

$$
dS_t=\mu S_t\,dt+\sigma S_t\,dW_t.
$$

동등하게 쓰면

$$
\frac{dS_t}{S_t}=\mu\,dt+\sigma\,dW_t.
$$

여기서 각 기호의 의미는 다음과 같습니다.

여기서 $t$는 연 단위로 측정한다고 합시다.

- $\mu$: drift coefficient. 단위시간당 기대 상대변화율이며, $t$를 연 단위로 잡으면 연율화된 drift로 해석합니다.
- $\sigma$: volatility coefficient. 단위시간당 변동성 계수이며, $t$를 연 단위로 잡으면 연율화된 변동성으로 해석합니다.
- $W_t$: Wiener process 또는 Brownian motion. $W_{t+\Delta t}-W_t\sim N(0,\Delta t)$를 만족합니다.

여기까지의 GBM은 실제세계 확률측도 $\mathbb{P}$ 아래에서 쓴 식입니다. 즉, 더 정확히 쓰면

$$
\frac{dS_t}{S_t}=\mu\,dt+\sigma\,dW_t^{\mathbb{P}}
$$

입니다. 여기서 $\mu$는 실제세계에서의 drift입니다. 시간 $t$를 연 단위로 측정하면, $\mu$는 연율화된 drift 또는 단위시간당 기대 상대변화율로 해석할 수 있습니다.

다만 옵션가격결정에서는 실제세계의 기대수익률 $\mu$가 직접 들어가지 않습니다. 옵션 가격은 투자자의 주관적 기대수익률이 아니라, 무차익거래 조건과 복제 포트폴리오 논리로 결정되기 때문입니다. 동적으로 기초자산을 헤지하면 주가의 실제 drift $\mu$에 대한 노출이 제거되고, 남는 것은 무위험수익률 $r$로 할인되는 구조입니다.

따라서 옵션가격결정에서는 실제측도 $\mathbb P$가 아니라 위험중립측도 $\mathbb Q$로 측도를 바꿉니다. 위험중립측도 아래에서는 주가의 drift가 $\mu$가 아니라 무위험수익률 $r$이 되며,

$$
\frac{dS_t}{S_t} =
r dt+\sigma dW_t^{\mathbb Q}
$$

로 쓸 수 있습니다. 따라서 옵션의 현재가격은 위험중립측도 아래에서 할인된 payoff의 기대값으로 계산됩니다.[^black-scholes]

$$
V_t =
e^{-r(T-t)}
\mathbb E^{\mathbb Q}_t
\left[
\text{Payoff}(S_T)
\right]
$$

이 측도전환이 정확히 어떻게 이루어지는지는 7절에서 다시 다룹니다.

---


# 4. Itô's Lemma와 GBM의 로그변환

이제 GBM에서 왜 로그수익률의 표준편차가 $\sigma\sqrt{\Delta t}$가 되는지 확인합니다.

GBM은

$$
dS_t=\mu S_t\,dt+\sigma S_t\,dW_t
$$

입니다. 여기서

$$
Y_t=\log S_t
$$

라고 합시다. 즉,

$$
Y_t=f(S_t),
\qquad
f(x)=\log x
$$

입니다.

Itô's lemma를 쓰기 위해 먼저 일반형을 정리해 봅시다. 확률과정 $X_t$가

$$
dX_t=a_t\,dt+b_t\,dW_t
$$

를 따른다고 합시다. 이때 $Y_t=f(t,X_t)$이면

$$
dY_t =
\left(
\frac{\partial f}{\partial t} +
a_t\frac{\partial f}{\partial x} +
\frac12 b_t^2\frac{\partial^2 f}{\partial x^2}
\right)dt +
b_t\frac{\partial f}{\partial x}dW_t.
$$

이 공식이 일반적인 전미분(total differential)과 다른 이유는 Brownian motion에 대해

$$
(dW_t)^2=dt,
\qquad
(dt)(dW_t)=0,
\qquad
(dt)^2=0
$$

이라는 계산규칙이 작동하기 때문입니다.[^oksendal]

이제 $X_t=S_t$로 둡니다. GBM은

$$
dS_t=\mu S_t\,dt+\sigma S_t\,dW_t
$$

이므로, Itô lemma의 일반형

$$
dX_t=a_t\,dt+b_t\,dW_t
$$

와 비교하면

$$
a_t=\mu S_t,
\qquad
b_t=\sigma S_t
$$

입니다.

또한 $f(x)=\log x$이므로

$$
\frac{\partial f}{\partial t}=0,
\qquad
\frac{\partial f}{\partial x}=\frac1x,
\qquad
\frac{\partial^2 f}{\partial x^2}=-\frac1{x^2}.
$$

따라서 Itô's lemma에 의해

$$
d\log S_t =
\left(
0 +
\mu S_t\frac1{S_t} +
\frac12(\sigma S_t)^2
\left(-\frac1{S_t^2}\right)
\right)dt +
\sigma S_t\frac1{S_t}dW_t.
$$

이를 정리하면

$$
d\log S_t =
\left(
\mu-\frac12\sigma^2
\right)dt +
\sigma dW_t.
$$

따라서

$$
\boxed{
d\log S_t =
\left(\mu-\frac12\sigma^2\right)dt +
\sigma dW_t
}
$$

입니다.

---


# 5. 시간 $\Delta t$ 동안 로그수익률의 분산

방금 얻은 식을 $t$부터 $t+\Delta t$까지 적분해 봅시다.

$$
\int_t^{t+\Delta t}d\log S_u =
\int_t^{t+\Delta t}\left(\mu-\frac12\sigma^2\right)du +
\int_t^{t+\Delta t}\sigma\,dW_u.
$$

따라서

$$
\log S_{t+\Delta t}-\log S_t =
\left(\mu-\frac12\sigma^2\right)\Delta t +
\sigma(W_{t+\Delta t}-W_t).
$$

즉,

$$
\log\frac{S_{t+\Delta t}}{S_t} =
\left(\mu-\frac12\sigma^2\right)\Delta t +
\sigma(W_{t+\Delta t}-W_t).
$$

그런데 Wiener process의 증분은

$$
W_{t+\Delta t}-W_t\sim N(0,\Delta t)
$$

입니다. 따라서 표준정규분포를 따르는 확률변수 $Z\sim N(0,1)$에 대해

$$
W_{t+\Delta t}-W_t
\overset{d}{=}
\sqrt{\Delta t}\,Z
$$

라고 쓸 수 있습니다. 따라서

$$
\log\frac{S_{t+\Delta t}}{S_t} =
\left(\mu-\frac12\sigma^2\right)\Delta t +
\sigma\sqrt{\Delta t}\,Z.
$$

이제 분산을 계산하면 deterministic term은 분산에 영향을 주지 않습니다. 따라서

$$
\operatorname{Var}\left(
\log\frac{S_{t+\Delta t}}{S_t}
\right) =
\operatorname{Var}(\sigma\sqrt{\Delta t}\,Z).
$$

상수배의 분산은 제곱배가 되므로

$$
\operatorname{Var}(\sigma\sqrt{\Delta t}\,Z)
=\sigma^2\Delta t\operatorname{Var}(Z).
$$

그리고 $Z\sim N(0,1)$이므로 $\operatorname{Var}(Z)=1$입니다. 따라서

$$
\boxed{
\operatorname{Var}\left(
\log\frac{S_{t+\Delta t}}{S_t}
\right)
=\sigma^2\Delta t
}
$$

이고, 표준편차는

$$
\boxed{
\operatorname{SD}\left(
\log\frac{S_{t+\Delta t}}{S_t}
\right)
=\sigma\sqrt{\Delta t}
}
$$

입니다.

이것이 "시간 $\Delta t$ 동안의 변동성은 $\sigma\sqrt{\Delta t}$이다"라는 말의 정확한 의미입니다. 이는 **주가수준 $S_t$의 표준편차가 아니라 로그수익률의 표준편차**입니다.

---


# 6. CRR 이항모형: $u$와 $d$의 결정

이제 이항모형으로 넘어가 봅시다. CRR 이항모형에서는 한 스텝 동안 주가가 두 값 중 하나로 움직인다고 가정합니다.[^crr]

$$
S_{t+\Delta t} =
\begin{cases}
 uS_t, & \text{up state},\\
 dS_t, & \text{down state}.
\end{cases}
$$

따라서 한 스텝 로그수익률은

$$
\log\frac{S_{t+\Delta t}}{S_t} =
\begin{cases}
 \log u, & \text{up state},\\
 \log d, & \text{down state}.
\end{cases}
$$

앞에서 GBM의 시간 $\Delta t$ 로그수익률 표준편차가

$$
\sigma\sqrt{\Delta t}
$$

임을 보였습니다. CRR 모형은 이 로그수익률의 한 스텝 움직임을 대칭적으로 잡습니다.

$$
\log u=+\sigma\sqrt{\Delta t},
\qquad
\log d=-\sigma\sqrt{\Delta t}.
$$

양변에 지수함수를 취하면

$$
\boxed{
 u=e^{\sigma\sqrt{\Delta t}},
 \qquad
d=e^{-\sigma\sqrt{\Delta t}}
}
$$

가 됩니다. 또한

$$
d=e^{-\sigma\sqrt{\Delta t}}
 =\frac1{e^{\sigma\sqrt{\Delta t}}}
 =\frac1u.
$$

따라서

$$
\boxed{
 d=\frac1u
}
$$

입니다.

이 선택의 의미는 다음과 같습니다.

<mark>주가수준의 변화폭을 직접 맞춘 것이 아니라, 로그수익률의 국소적 변동폭을 맞춘 것입니다.</mark>

또한 $d=1/u$이면 up 후 down과 down 후 up이 같은 가격으로 돌아옵니다.

$$
S_tud=S_tdu=S_t.
$$

즉, 이항트리가 recombining tree가 됩니다.

---


# 7. 실제세계 측도에서 위험중립측도로 넘어가기

실제세계 $\mathbb{P}$ 아래에서 GBM은

$$
\frac{dS_t}{S_t}
=\mu\,dt+\sigma\,dW_t^{\mathbb{P}}
$$

입니다. 여기서 $\mu$는 실제 기대수익률입니다. 반면 옵션가격결정에서 사용하는 기본식은

$$
V_0 =
\mathbb{E}^{\mathbb{Q}}\left[e^{-rT}V_T\right]
$$

입니다. 즉, 만기 payoff $V_T$를 실제확률 $\mathbb{P}$로 평균내는 것이 아니라, 위험중립측도 $\mathbb{Q}$ 아래에서 기댓값을 계산한 뒤 무위험이자율 $r$로 할인합니다.

배당이 없다고 가정하면 위험중립측도 $\mathbb{Q}$ 아래에서는 할인된 주가

$$
e^{-rt}S_t
$$

가 martingale이어야 합니다. 따라서 $\mathbb{Q}$ 아래에서 주가의 drift는 $\mu$가 아니라 $r$이 됩니다.

$$
\frac{dS_t}{S_t} =
r\,dt+\sigma\,dW_t^{\mathbb{Q}}.
$$

중요한 점은 단순히 $\mu$를 $r$로 바꿔 끼우는 것이 아니라는 점입니다. 측도를 $\mathbb{P}$에서 $\mathbb{Q}$로 바꾸면 Brownian motion도 함께 바뀝니다.

위험의 시장가격(market price of risk)을

$$
\lambda =
\frac{\mu-r}{\sigma}
$$

라고 합시다. 이는 위험 1단위당 요구되는 초과 수익률입니다. 그러면 새로운 Brownian motion을

$$
dW_t^{\mathbb{Q}} =
dW_t^{\mathbb{P}}+\lambda\,dt
$$

로 잡을 수 있습니다. 직관적으로 실제세계에서는 "평균적인 움직임"이지만, 위험중립세계에서는 "양의 shock이 발생한 움직임"으로 해석하기 위함입니다. 동치로 쓰면

$$
dW_t^{\mathbb{P}} =
dW_t^{\mathbb{Q}}-\lambda\,dt
$$

입니다. 이를 실제세계 GBM에 대입하면

$$
\begin{aligned}
\frac{dS_t}{S_t}
&= \mu\,dt + \sigma\,dW_t^{\mathbb{P}} \\
&= \mu\,dt + \sigma\left(dW_t^{\mathbb{Q}} - \lambda\,dt\right) \\
&= \left(\mu - \sigma\lambda\right)dt + \sigma\,dW_t^{\mathbb{Q}}.
\end{aligned}
$$

그런데

$$
\lambda=\frac{\mu-r}{\sigma}
$$

이므로

$$
\mu-\sigma\lambda =
\mu-\sigma\frac{\mu-r}{\sigma} =
r.
$$

따라서 위험중립측도 $\mathbb{Q}$ 아래의 dynamics는

$$
\boxed{
\frac{dS_t}{S_t} =
r\,dt+\sigma dW_t^{\mathbb{Q}}
}
$$

가 됩니다.

로그수익률로 쓰면 실제세계 $\mathbb{P}$ 아래에서는

$$
\log\frac{S_{t+\Delta t}}{S_t} =
\left(\mu-\frac12\sigma^2\right)\Delta t +
\sigma\sqrt{\Delta t}Z^{\mathbb{P}},
\qquad
Z^{\mathbb{P}}\sim N(0,1)
$$

이고, 위험중립측도 $\mathbb{Q}$ 아래에서는

$$
\log\frac{S_{t+\Delta t}}{S_t} =
\left(r-\frac12\sigma^2\right)\Delta t +
\sigma\sqrt{\Delta t}Z^{\mathbb{Q}},
\qquad
Z^{\mathbb{Q}}\sim N(0,1)
$$

입니다.

따라서 측도 전환의 핵심은 다음과 같이 정리할 수 있습니다.

$$
\boxed{
\mu\quad\longrightarrow\quad r
}
$$

그러나 변동성 항은 그대로 남습니다.

$$
\boxed{
\sigma\text{는 }\mathbb{P}\text{와 }\mathbb{Q}\text{ 모두에서 동일하게 남습니다.}
}
$$

따라서 시간 $\Delta t$ 동안의 로그수익률은 실제세계 $\mathbb P$ 아래에서도, 위험중립세계 $\mathbb Q$ 아래에서도 같은 확산계수 $\sigma$를 가집니다. 측도를 바꾸면 drift는 $\mu$에서 $r$로 바뀌지만, Brownian shock의 크기인 volatility는 그대로 남습니다.

즉, 6절에서 $u$와 $d$를 정할 때 사용한 로그수익률의 확률적 충격항의 표준편차

$$
\sigma\sqrt{\Delta t}
$$

는 어느 측도에서 보든 동일합니다. 그래서 $u$와 $d$는 측도와 무관하게 그대로 두고, 측도전환의 효과는 확률 쪽으로 넘깁니다. 이것이 다음 절에서 정할 위험중립확률 $p$의 역할입니다.

---


# 8. 위험중립확률 $p$의 도출

이제 확률 $p$를 정해야 합니다. 여기서 중요한 점은 $p$가 실제세계 확률이 아니라 위험중립확률이라는 것입니다.

위험중립세계에서는 주식의 기대성장률이 무위험이자율 $r$이어야 합니다. 따라서 한 스텝 뒤의 위험중립 기대가격은

$$
\mathbb{E}^{\mathbb{Q}}[S_{t+\Delta t}\mid S_t]
=S_te^{r\Delta t}
$$

이어야 합니다.

한편 이항모형에서는

$$
S_{t+\Delta t} =
\begin{cases}
 uS_t, & \text{with probability }p,\\
 dS_t, & \text{with probability }1-p.
\end{cases}
$$

그러므로

$$
\mathbb{E}^{\mathbb{Q}}[S_{t+\Delta t}\mid S_t]
=puS_t+(1-p)dS_t.
$$

위험중립조건을 적용하면

$$
puS_t+(1-p)dS_t=S_te^{r\Delta t}.
$$

양변을 $S_t$로 나누면

$$
pu+(1-p)d=e^{r\Delta t}.
$$

이제 $p$에 대해 풀면

$$
pu+d-pd=e^{r\Delta t}
$$

이고,

$$
p(u-d)=e^{r\Delta t}-d.
$$

따라서

$$
\boxed{
 p=\frac{e^{r\Delta t}-d}{u-d}
}
$$

입니다.

정리하면 CRR 모형에서 각 파라미터의 역할은 다음과 같습니다.

$$
\boxed{
u,d:\ \text{one-step volatility matching},
\qquad
p:\ \text{risk-neutral drift matching}
}
$$

즉, $u$와 $d$는 한 스텝 로그수익률의 변동성, 더 정확히는 Brownian shock의 크기를 맞추기 위해 정하고, 위험중립확률 $p$는 위험중립세계에서 주가의 기대성장률이 무위험수익률 $r$이 되도록 정합니다. 이렇게 파라미터를 잡으면 스텝 수를 늘릴수록 CRR 이항모형의 옵션가격은 Black-Scholes 가격으로 수렴합니다.[^crr]

---

# References

[^shreve-bm]: Steven E. Shreve, *Stochastic Calculus for Finance II: Continuous-Time Models*, Springer, 2004. Brownian motion, Ito calculus, risk-neutral pricing, and GBM are treated systematically.

[^donsker]: Patrick Billingsley, *Convergence of Probability Measures*, 2nd ed., Wiley, 1999. See also the standard statement of Donsker's invariance principle, often called the functional central limit theorem.

[^oksendal]: Bernt Oksendal, *Stochastic Differential Equations: An Introduction with Applications*, Springer. A standard reference for Ito's formula and stochastic calculus.

[^black-scholes]: Fischer Black and Myron Scholes, "The Pricing of Options and Corporate Liabilities," *Journal of Political Economy*, 81(3), 637-654, 1973. The paper derives an option valuation formula under lognormal stock dynamics.

[^crr]: John C. Cox, Stephen A. Ross, and Rubinstein, M. "Option Pricing: A Simplified Approach," *Journal of Financial Economics*, 7(3), 229-263, 1979. The CRR binomial model is a discrete-time arbitrage-pricing model that contains the Black-Scholes model as a limiting case.

- Black, F., & Scholes, M. (1973). "The Pricing of Options and Corporate Liabilities." *Journal of Political Economy*, 81(3), 637-654.
- Billingsley, P. (1999). *Convergence of Probability Measures* (2nd ed.). Wiley.
- Cox, J. C., Ross, S. A., & Rubinstein, M. (1979). "Option Pricing: A Simplified Approach." *Journal of Financial Economics*, 7(3), 229-263.
- Oksendal, B. *Stochastic Differential Equations: An Introduction with Applications*. Springer.
- Shreve, S. E. (2004). *Stochastic Calculus for Finance II: Continuous-Time Models*. Springer.
---
title: "Look Back Option"
date: 2026-05-26 12:00:00 +0900
categories: [Finance, Stochastic Calculus]
tags: [wiener-process, brownian-motion, gbm, ito-lemma, crr-binomial-model, option-pricing]
math: true
---

# CRR 이항모형
## 1. Random Walk

서로 독립이고 동일한 분포를 따르는 확률변수열

$$
X_1,X_2,\dots
$$

를 생각하자. 각 $X_k$는 한 번의 이동을 나타내며,

$$
\mathbb{P}(X_k=1)=p,\qquad
\mathbb{P}(X_k=-1)=1-p
$$

라고 하자. 이때 부분합 과정은

$$
S_n=\sum_{k=1}^{n}X_k,\qquad S_0=0
$$

으로 정의한다. 이것이 가장 기본적인 random walk이다.

각 이동의 기대값은

$$
\mathbb{E}[X_k]
=1\cdot p+(-1)(1-p)
=2p-1
$$

이다. 또한 $X_k^2=1$이므로

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

이 된다.

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

따라서 대칭 random walk의 분산은 시간 $n$에 대해 선형적으로 증가한다.

$$
\boxed{
\operatorname{Var}(S_n)=n
}
$$


## 2. Random Walk의 스케일 조정과 Wiener Process

시간 구간 $[0,t]$를 $n$개의 작은 구간으로 나누자. 그러면 한 구간의 길이는

$$
h=\frac{t}{n}
$$

이다. 대칭 random walk $S_n$을 시간 $t$에 맞게 스케일 조정하면

$$
W_t^{(n)}=\sqrt{h}\,S_n
=\sqrt{\frac{t}{n}}S_n
$$

으로 쓸 수 있다.

이제 평균과 분산을 계산하자.

먼저

$$
\mathbb{E}[W_t^{(n)}]
=\sqrt{\frac{t}{n}}\mathbb{E}[S_n]
=0
$$

이다. 다음으로

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

이다.

한 시점 $t$에서의 분포만 보면 중심극한정리에 의해

$$
\frac{S_n}{\sqrt{n}}
\Rightarrow N(0,1)
$$

이고, 따라서

$$
W_t^{(n)}
=\sqrt{t}\frac{S_n}{\sqrt{n}}
\Rightarrow N(0,t).
$$

즉, random walk를 적절히 시간과 공간에서 스케일 조정하면 한 시점의 극한분포는

$$
N(0,t)
$$

가 된다.

그러나 Wiener process는 단순히 각 시점에서 정규분포를 갖는 확률변수가 아니다. Wiener process는 전체 시간경로를 갖는 확률과정이다. 엄밀하게는 다음 조건을 만족하는 확률과정 $\{W_t\}_{t\ge 0}$를 표준 Wiener process 또는 Brownian motion이라고 한다.[^shreve-bm]

1. $W_0=0$ almost surely.
2. $0\le s<t$에 대해 증분 $W_t-W_s$는 정규분포를 따른다.

   $$
   W_t-W_s\sim N(0,t-s).
   $$

3. 서로 겹치지 않는 시간구간의 증분은 독립이다.
4. sample path $t\mapsto W_t(\omega)$는 거의 확실하게 연속이다.

Random walk에서 Wiener process로 가는 더 강한 결과는 Donsker의 불변원리, 또는 functional central limit theorem이다.[^donsker] 직관적으로 말하면, 선형보간한 random walk를 $1/\sqrt{n}$ 스케일로 줄이면 전체 경로가 Brownian motion으로 수렴한다.

이제 우리가 사용할 핵심 성질은 다음과 같다.

$$
\boxed{
W_{t+\Delta t}-W_t\sim N(0,\Delta t)
}
$$

즉,

$$
W_{t+\Delta t}-W_t
=\sqrt{\Delta t}\,Z,
\qquad Z\sim N(0,1)
$$


## 3. GBM(Geometric Brownian Motion)

금융에서 주가를 Brownian motion 자체로 두지는 않는다. Brownian motion은 음수가 될 수 있기 때문이다. 주가 $S_t$는 보통 양수여야 하므로, 주가의 상대변화율을 확률적으로 모델링한다.

Geometric Brownian Motion, 즉 GBM은 다음 SDE로 정의된다.

$$
dS_t=\mu S_t\,dt+\sigma S_t\,dW_t.
$$

동등하게 쓰면

$$
\frac{dS_t}{S_t}=\mu\,dt+\sigma\,dW_t.
$$

여기서 각 기호의 의미는 다음과 같다.

- $\mu$: drift, 기대수익률
- $\sigma$: volatility, 변동성
- $W_t$: Wiener process

여기까지의 GBM은 실제세계 확률측도 $\mathbb{P}$ 아래에서 쓴 식이다. 즉, 더 정확히 쓰면

$$
\frac{dS_t}{S_t}=\mu\,dt+\sigma\,dW_t^{\mathbb{P}}
$$

이다. 여기서 $\mu$는 실제세계에서 투자자들이 요구하는 기대수익률이다.

다만 옵션가격결정에서는 실제 기대수익률 $\mu$가 직접 들어가지 않는다. 수익률에 대한 기대는 사람마다 다르기 때문이다. 무차익거래 조건 아래에서는 위험중립측도 $\mathbb{Q}$로 측도를 바꾸고, 그 아래에서 할인된 payoff의 기대값을 계산한다. 이 전환을 다음 절에서 분리해서 정리하자.[^black-scholes]

---

## 4. Ito's Lemma와 GBM의 로그변환

이제 GBM에서 왜 로그수익률의 표준편차가 $\sigma\sqrt{\Delta t}$가 되는지 증명한다.

GBM은

$$
dS_t=\mu S_t\,dt+\sigma S_t\,dW_t
$$

이다. 여기서 $Y_t=\log S_t$라고 하자. 즉,

$$
Y_t=f(S_t),
\qquad
f(x)=\log x
$$

이다.

Ito's lemma에 따르면 $X_t$가

$$
dX_t=\mu_t\,dt+\sigma_t\,dW_t
$$

를 따르고 $Y_t=f(t,X_t)$이면

$$
dY_t
=
\left(
\frac{\partial f}{\partial t}
+\mu_t\frac{\partial f}{\partial x}
+\frac12\sigma_t^2\frac{\partial^2 f}{\partial x^2}
\right)dt
+\sigma_t\frac{\partial f}{\partial x}dW_t.
$$

이 공식이 일반적인 chain rule과 다른 이유는 Brownian motion에 대해

$$
(dW_t)^2=dt,
\qquad
(dt)(dW_t)=0,
\qquad
(dt)^2=0
$$

이라는 계산규칙이 작동하기 때문이다.[^oksendal]

이제 $f(x)=\log x$에 대해 미분하면

$$
\frac{\partial f}{\partial t}=0,
\qquad
\frac{\partial f}{\partial x}=\frac1x,
\qquad
\frac{\partial^2 f}{\partial x^2}=-\frac1{x^2}.
$$

또한

$$
dS_t=\mu S_t\,dt+\sigma S_t\,dW_t
$$

이므로

$$
(dS_t)^2
=(\mu S_t\,dt+\sigma S_t\,dW_t)^2.
$$

Ito 계산규칙을 적용하면

$$
(dt)^2=0,
\qquad
(dt)(dW_t)=0,
\qquad
(dW_t)^2=dt
$$

이므로

$$
(dS_t)^2=\sigma^2 S_t^2\,dt.
$$

따라서

$$
d\log S_t
=\frac1{S_t}dS_t
+\frac12\left(-\frac1{S_t^2}\right)(dS_t)^2.
$$

첫 번째 항은

$$
\frac1{S_t}dS_t
=\frac1{S_t}(\mu S_t\,dt+\sigma S_t\,dW_t)
=\mu\,dt+\sigma\,dW_t.
$$

두 번째 항은

$$
\frac12\left(-\frac1{S_t^2}\right)(dS_t)^2
=\frac12\left(-\frac1{S_t^2}\right)\sigma^2S_t^2\,dt
=-\frac12\sigma^2\,dt.
$$

둘을 합치면

$$
\boxed{
 d\log S_t
=
\left(\mu-\frac12\sigma^2\right)dt
+\sigma\,dW_t
}
$$

이다.

이것이 GBM에서 로그변환을 할 때 나타나는 중요한 보정항이다. 일반 미분법만 사용하면 $\mu dt+\sigma dW_t$가 나올 것 같지만, Ito's lemma 때문에

$$
-\frac12\sigma^2dt
$$

가 추가된다.

---

## 5. 시간 $\Delta t$ 동안 로그수익률의 분산

방금 얻은 식을 $t$부터 $t+\Delta t$까지 적분하자.

$$
\int_t^{t+\Delta t}d\log S_u
=
\int_t^{t+\Delta t}\left(\mu-\frac12\sigma^2\right)du
+
\int_t^{t+\Delta t}\sigma\,dW_u.
$$

따라서

$$
\log S_{t+\Delta t}-\log S_t
=
\left(\mu-\frac12\sigma^2\right)\Delta t
+
\sigma(W_{t+\Delta t}-W_t).
$$

즉,

$$
\log\frac{S_{t+\Delta t}}{S_t}
=
\left(\mu-\frac12\sigma^2\right)\Delta t
+
\sigma(W_{t+\Delta t}-W_t).
$$

그런데 Wiener process의 증분은

$$
W_{t+\Delta t}-W_t\sim N(0,\Delta t)
$$

이므로

$$
W_{t+\Delta t}-W_t
=\sqrt{\Delta t}\,Z,
\qquad Z\sim N(0,1)
$$

로 쓸 수 있다. 따라서

$$
\log\frac{S_{t+\Delta t}}{S_t}
=
\left(\mu-\frac12\sigma^2\right)\Delta t
+
\sigma\sqrt{\Delta t}\,Z.
$$

이제 분산을 계산하면 deterministic term은 분산에 영향을 주지 않는다. 따라서

$$
\operatorname{Var}\left(
\log\frac{S_{t+\Delta t}}{S_t}
\right)
=
\operatorname{Var}(\sigma\sqrt{\Delta t}\,Z).
$$

상수배의 분산은 제곱배가 되므로

$$
\operatorname{Var}(\sigma\sqrt{\Delta t}\,Z)
=\sigma^2\Delta t\operatorname{Var}(Z).
$$

그리고 $Z\sim N(0,1)$이므로 $\operatorname{Var}(Z)=1$이다. 따라서

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

이다.

이것이 “시간 $\Delta t$ 동안의 변동성은 $\sigma\sqrt{\Delta t}$이다”라는 말의 정확한 의미다. 엄밀히 말하면 이는 **주가수준 $S_t$의 표준편차가 아니라 로그수익률의 표준편차**이다.

---

## 6. CRR 이항모형

이제 이항모형으로 넘어가자. CRR 이항모형에서는 한 스텝 동안 주가가 두 값 중 하나로 움직인다고 가정한다.[^crr]

$$
S_{t+\Delta t}
=
\begin{cases}
 uS_t, & \text{up state},\\
 dS_t, & \text{down state}.
\end{cases}
$$

따라서 한 스텝 로그수익률은

$$
\log\frac{S_{t+\Delta t}}{S_t}
=
\begin{cases}
 \log u, & \text{up state},\\
 \log d, & \text{down state}.
\end{cases}
$$

앞에서 GBM의 시간 $\Delta t$ 로그수익률 표준편차가

$$
\sigma\sqrt{\Delta t}
$$

임을 보였다. CRR 모형은 이 로그수익률의 한 스텝 움직임을 대칭적으로 잡는다.

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

가 된다. 또한

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

이다.

이 선택의 의미는 다음과 같다.

$$
\boxed{
\text{주가수준의 변화폭을 직접 맞춘 것이 아니라,
로그수익률의 국소적 변동폭을 맞춘 것이다.}
}
$$

또한 $d=1/u$이면 up 후 down과 down 후 up이 같은 가격으로 돌아온다.

$$
S_tud=S_tdu=S_t.
$$

즉, 이항트리가 recombining tree가 된다.

---


## 7. 실제세계 측도에서 위험중립측도로 넘어가기

실제세계 $\mathbb{P}$ 아래에서 GBM은

$$
\frac{dS_t}{S_t}
=\mu\,dt+\sigma\,dW_t^{\mathbb{P}}
$$

이다. 여기서 $\mu$는 실제 기대수익률이다. 반면 옵션가격결정에서 사용하는 기본식은

$$
V_0
=
\mathbb{E}^{\mathbb{Q}}\left[e^{-rT}V_T\right]
$$

이다. 즉, 만기 payoff $V_T$를 실제확률 $\mathbb{P}$로 평균내는 것이 아니라, 위험중립측도 $\mathbb{Q}$ 아래에서 평균낸 뒤 무위험이자율 $r$로 할인한다.

배당이 없다고 가정하면 위험중립측도 $\mathbb{Q}$ 아래에서는 할인된 주가

$$
e^{-rt}S_t
$$

가 martingale이어야 한다. 따라서 $\mathbb{Q}$ 아래에서 주가의 drift는 $\mu$가 아니라 $r$이 된다.

$$
\frac{dS_t}{S_t}
=
r\,dt+\sigma\,dW_t^{\mathbb{Q}}.
$$

중요한 점은 단순히 $\mu$를 $r$로 바꿔 끼우는 것이 아니라는 점이다. 측도를 $\mathbb{P}$에서 $\mathbb{Q}$로 바꾸면 Brownian motion도 함께 바뀐다.

시장가격위험을

$$
\lambda
=
\frac{\mu-r}{\sigma}
$$

라고 하자. 그러면 새로운 Brownian motion을

$$
dW_t^{\mathbb{Q}}
=
dW_t^{\mathbb{P}}+\lambda\,dt
$$

로 잡을 수 있다. 동치로 쓰면

$$
dW_t^{\mathbb{P}}
=
dW_t^{\mathbb{Q}}-\lambda\,dt
$$

이다. 이를 실제세계 GBM에 대입하면

$$
\frac{dS_t}{S_t}
=
\mu\,dt+\sigma dW_t^{\mathbb{P}}
$$

이고,

$$
=
\mu\,dt+
\sigma(dW_t^{\mathbb{Q}}-\lambda\,dt)
$$

이므로

$$
=
(\mu-\sigma\lambda)dt+
\sigma dW_t^{\mathbb{Q}}.
$$

그런데

$$
\lambda=\frac{\mu-r}{\sigma}
$$

이므로

$$
\mu-\sigma\lambda
=
\mu-\sigma\frac{\mu-r}{\sigma}
=
r.
$$

따라서 위험중립측도 $\mathbb{Q}$ 아래의 dynamics는

$$
\boxed{
\frac{dS_t}{S_t}
=
r\,dt+\sigma dW_t^{\mathbb{Q}}
}
$$

가 된다.

로그수익률로 쓰면 실제세계 $\mathbb{P}$ 아래에서는

$$
\log\frac{S_{t+\Delta t}}{S_t}
=
\left(\mu-\frac12\sigma^2\right)\Delta t
+
\sigma\sqrt{\Delta t}Z^{\mathbb{P}},
\qquad
Z^{\mathbb{P}}\sim N(0,1)
$$

이고, 위험중립측도 $\mathbb{Q}$ 아래에서는

$$
\log\frac{S_{t+\Delta t}}{S_t}
=
\left(r-\frac12\sigma^2\right)\Delta t
+
\sigma\sqrt{\Delta t}Z^{\mathbb{Q}},
\qquad
Z^{\mathbb{Q}}\sim N(0,1)
$$

이다.

따라서 측도 전환의 핵심은 다음과 같이 정리할 수 있다.

$$
\boxed{
\mu\quad\longrightarrow\quad r
}
$$

그러나 변동성 항은 그대로 남는다.

$$
\boxed{
\sigma\text{는 }\mathbb{P}\text{와 }\mathbb{Q}\text{ 모두에서 동일하게 남는다.}
}
$$

따라서 시간 $\Delta t$ 동안 로그수익률의 표준편차는 실제세계에서도, 위험중립세계에서도

$$
\sigma\sqrt{\Delta t}
$$

이다.

이제 6절과 다음 절의 역할이 분리된다. $u$와 $d$는 로그수익률의 변동성을 맞추기 위해 정한다.

$$
\log u=+\sigma\sqrt{\Delta t},
\qquad
\log d=-\sigma\sqrt{\Delta t}.
$$

반면 확률 $p$는 위험중립세계에서 기대성장률을 $r$로 맞추기 위해 정한다.

$$
\boxed{
u,d:\ \text{local volatility matching},
 \qquad
p:\ \text{risk-neutral drift matching}
}
$$

이 구분이 없으면 6절에서는 실제세계 $\mathbb{P}$를 쓰다가 7절에서 갑자기 위험중립측도 $\mathbb{Q}$가 등장하는 것처럼 보인다. 정확히는 여기서 측도 전환이 일어나고, 그 다음 위험중립확률 $p$를 도출하는 것이다.

---

# 8. 위험중립확률 $p$의 도출

이제 확률 $p$를 정해야 한다. 여기서 중요한 점은 $p$가 실제세계 확률이 아니라 위험중립확률이라는 것이다.

위험중립세계에서는 주식의 기대성장률이 무위험이자율 $r$이어야 한다. 따라서 한 스텝 뒤의 위험중립 기대가격은

$$
\mathbb{E}^{\mathbb{Q}}[S_{t+\Delta t}\mid S_t]
=S_te^{r\Delta t}
$$

이어야 한다.

한편 이항모형에서는

$$
S_{t+\Delta t}
=
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

이다.

# 

---

# References

[^shreve-bm]: Steven E. Shreve, *Stochastic Calculus for Finance II: Continuous-Time Models*, Springer, 2004. Brownian motion, Ito calculus, risk-neutral pricing, and GBM are treated systematically.

[^donsker]: Patrick Billingsley, *Convergence of Probability Measures*, 2nd ed., Wiley, 1999. See also the standard statement of Donsker's invariance principle, often called the functional central limit theorem.

[^oksendal]: Bernt Oksendal, *Stochastic Differential Equations: An Introduction with Applications*, Springer. A standard reference for Ito's formula and stochastic calculus.

[^black-scholes]: Fischer Black and Myron Scholes, "The Pricing of Options and Corporate Liabilities," *Journal of Political Economy*, 81(3), 637-654, 1973. The paper derives an option valuation formula under lognormal stock dynamics.

[^crr]: John C. Cox, Stephen A. Ross, and Mark Rubinstein, "Option Pricing: A Simplified Approach," *Journal of Financial Economics*, 7(3), 229-263, 1979. The CRR binomial model is a discrete-time arbitrage-pricing model that contains the Black-Scholes model as a limiting case.

- Black, F., & Scholes, M. (1973). "The Pricing of Options and Corporate Liabilities." *Journal of Political Economy*, 81(3), 637-654.
- Billingsley, P. (1999). *Convergence of Probability Measures* (2nd ed.). Wiley.
- Cox, J. C., Ross, S. A., & Rubinstein, M. (1979). "Option Pricing: A Simplified Approach." *Journal of Financial Economics*, 7(3), 229-263.
- Oksendal, B. *Stochastic Differential Equations: An Introduction with Applications*. Springer.
- Shreve, S. E. (2004). *Stochastic Calculus for Finance II: Continuous-Time Models*. Springer.

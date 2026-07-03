---
title: "Look Back Option"
date: 2026-05-26T12:00:00+09:00
tags: [wiener-process, brownian-motion, gbm, ito-lemma, crr-binomial-model, option-pricing]
math: true
---

# 1. CRR 이항모형(Cox-Ross-Rubinstein Binomial Model)

## 1.1. Random Walk

서로 독립이고 동일한 분포를 따르는 확률변수열

$$
X_1,X_2,\dots
$$

를 생각하자. 각 $X_k$는 한 번의 이동을 나타내며,

$$
\mathbb{P}(X_k=1)=p,\qquad
\mathbb{P}(X_k=-1)=1-p
$$

라고 하자. 이때 부분합 과정(partial sum process)은

$$
S_n=\sum_{k=1}^{n}X_k,\qquad S_0=0
$$

으로 정의한다. 이것이 simple random walk이다. iid인 증분들의 부분합과정이 random walk이고, 그 중에서 특별히 X_k in {+1, -1}이고 한번에 한 칸씩만 움직이면 simple random walk라고 한다. 또 p = 1/2이면 symmetric simple random walk, p != 1/2이면 biased simple random walk라고 한다.

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

---


## 1.2. Random Walk의 스케일 조정과 Wiener Process

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

한 시점 $t$에서의 분포만 보면, 중심극한정리에 의해

$$
\frac{S_n}{\sqrt n}
\xrightarrow{d}
N(0,1)
$$

이고, 따라서

$$
W_t^{(n)}
=
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

가 된다.

그러나 Wiener process는 단순히 각 시점에서 정규분포를 갖는 확률변수가 아니다. Wiener process는 전체 시간경로를 갖는 확률과정이다. 엄밀하게는 다음 조건을 만족하는 확률과정 $\{W_t\}_{t\ge 0}$를 표준 Wiener process 또는 Brownian motion이라고 한다.[^shreve-bm]

1. $W_0=0$ almost surely.
2. $0\le s<t$에 대해 증분 $W_t-W_s$는 정규분포를 따른다.

   $$
   W_t-W_s\sim N(0,t-s).
   $$

3. 서로 겹치지 않는 시간구간의 증분은 독립이다.
4. sample path $t\mapsto W_t(\omega)$는 거의 확실하게 연속이다.

Random walk에서 Wiener process로 가는 더 강한 결과는 Donsker의 불변원리, 또는 functional central limit theorem이다.[^donsker] 직관적으로 말하면, 선형보간한 random walk를 $1/\sqrt{n}$ 스케일로 줄이면 전체 경로가 Brownian motion으로 수렴한다. 이와 관련된 상세한 내용은 다른 글에서 다뤄보도록 하겠음.

여기서 다음부터 사용할 핵심 성질은 Brownian motion의 increment가 정규분포를 따른다는 것이다.

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

라고 쓸 수 있다.

---


## 1.3. GBM(Geometric Brownian Motion)

금융에서 주가를 Brownian motion 자체로 두지는 않는다. Brownian motion은 음수가 될 수 있기 때문이다. 주가 $S_t$는 보통 양수여야 하므로, 주가의 상대변화율(relative change)을 확률적으로 모델링한다.

Geometric Brownian Motion, 즉 GBM은 다음 SDE로 정의된다.

$$
dS_t=\mu S_t\,dt+\sigma S_t\,dW_t.
$$

동등하게 쓰면

$$
\frac{dS_t}{S_t}=\mu\,dt+\sigma\,dW_t.
$$

여기서 각 기호의 의미는 다음과 같다.

여기서 $t$는 연 단위로 측정한다고 하자.

- $\mu$: drift coefficient. 단위시간당 기대 상대변화율이며, $t$를 연 단위로 잡으면 연율화된 drift로 해석한다.
- $\sigma$: volatility coefficient. 단위시간당 변동성 계수이며, $t$를 연 단위로 잡으면 연율화된 변동성으로 해석한다.
- $W_t$: Wiener process 또는 Brownian motion. $W_{t+\Delta t}-W_t\sim N(0,\Delta t)$를 만족한다.

여기까지의 GBM은 실제세계 확률측도 $\mathbb{P}$ 아래에서 쓴 식이다. 즉, 더 정확히 쓰면

$$
\frac{dS_t}{S_t}=\mu\,dt+\sigma\,dW_t^{\mathbb{P}}
$$

이다. 여기서 $\mu$는 실제세계에서의 drift이다. 시간 $t$를 연 단위로 측정하면, $\mu$는 연율화된 drift 또는 단위시간당 기대 상대변화율로 해석할 수 있다.

다만 옵션가격결정에서는 실제세계의 기대수익률 $\mu$가 직접 들어가지 않는다. 옵션 가격은 투자자의 주관적 기대수익률이 아니라, 무차익거래 조건과 복제 포트폴리오 논리로 결정되기 때문이다. 동적으로 기초자산을 헤지하면 주가의 실제 drift $\mu$에 대한 노출이 제거되고, 남는 것은 무위험수익률 $r$로 할인되는 구조이다.

따라서 옵션가격결정에서는 실제측도 $\mathbb P$가 아니라 위험중립측도 $\mathbb Q$로 측도를 바꾼다. 위험중립측도 아래에서는 주가의 drift가 $\mu$가 아니라 무위험수익률 $r$이 되며,

$$
\frac{dS_t}{S_t}
=
r dt+\sigma dW_t^{\mathbb Q}
$$

로 쓸 수 있다. 따라서 옵션의 현재가격은 위험중립측도 아래에서 할인된 payoff의 기대값으로 계산된다.[^black-scholes]

$$
V_t
=
e^{-r(T-t)}
\mathbb E^{\mathbb Q}_t
\left[
\text{Payoff}(S_T)
\right]
$$

---


## 1.4. Itô's Lemma와 GBM의 로그변환

이제 GBM에서 왜 로그수익률의 표준편차가 $\sigma\sqrt{\Delta t}$가 되는지 확인한다.

GBM은

$$
dS_t=\mu S_t\,dt+\sigma S_t\,dW_t
$$

이다. 여기서

$$
Y_t=\log S_t
$$

라고 하자. 즉,

$$
Y_t=f(S_t),
\qquad
f(x)=\log x
$$

이다.

Itô's lemma를 쓰기 위해 먼저 일반형을 정리하자. 확률과정 $X_t$가

$$
dX_t=a_t\,dt+b_t\,dW_t
$$

를 따른다고 하자. 이때 $Y_t=f(t,X_t)$이면

$$
dY_t
=
\left(
\frac{\partial f}{\partial t}
+
a_t\frac{\partial f}{\partial x}
+
\frac12 b_t^2\frac{\partial^2 f}{\partial x^2}
\right)dt
+
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

이라는 계산규칙이 작동하기 때문이다.[^oksendal]

이제 $X_t=S_t$로 둔다. GBM은

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

이다.

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
d\log S_t
=
\left(
0
+
\mu S_t\frac1{S_t}
+
\frac12(\sigma S_t)^2
\left(-\frac1{S_t^2}\right)
\right)dt
+
\sigma S_t\frac1{S_t}dW_t.
$$

이를 정리하면

$$
d\log S_t
=
\left(
\mu-\frac12\sigma^2
\right)dt
+
\sigma dW_t.
$$

따라서

$$
\boxed{
d\log S_t
=
\left(\mu-\frac12\sigma^2\right)dt
+
\sigma dW_t
}
$$

이다.

---


## 1.5. 시간 $\Delta t$ 동안 로그수익률의 분산

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

이다. 따라서 표준정규분포를 따르는 확률변수 $Z\sim N(0,1)$에 대해

$$
W_{t+\Delta t}-W_t
\overset{d}{=}
\sqrt{\Delta t}\,Z
$$

라고 쓸 수 있다. 따라서

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

이것이 “시간 $\Delta t$ 동안의 변동성은 $\sigma\sqrt{\Delta t}$이다”라는 말의 정확한 의미다. 이는 **주가수준 $S_t$의 표준편차가 아니라 로그수익률의 표준편차**이다.

---


## 1.6. CRR 이항모형(Cox-Ross-Rubinstein Binomial Model)

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


## 1.7. 실제세계 측도에서 위험중립측도로 넘어가기

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

이다. 즉, 만기 payoff $V_T$를 실제확률 $\mathbb{P}$로 평균내는 것이 아니라, 위험중립측도 $\mathbb{Q}$ 아래에서 기댓값을 계산한 뒤 무위험이자율 $r$로 할인한다.

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

위험의 시장가격(market price of risk)을

$$
\lambda
=
\frac{\mu-r}{\sigma}
$$

라고 하자. 이는 위험 1단위당 요구되는 초과 수익률이다. 그러면 새로운 Brownian motion을

$$
dW_t^{\mathbb{Q}}
=
dW_t^{\mathbb{P}}+\lambda\,dt
$$

로 잡을 수 있다. 직관적으로 실제세계에서는 "평균적인 움직임"이지만, 위험중립세계에서는 "양의 shock이 발생한 움직임"으로 해석하기 위함이다. 동치로 쓰면

$$
dW_t^{\mathbb{P}}
=
dW_t^{\mathbb{Q}}-\lambda\,dt
$$

이다. 이를 실제세계 GBM에 대입하면

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

따라서 시간 $\Delta t$ 동안의 로그수익률은 실제세계 $\mathbb P$ 아래에서도, 위험중립세계 $\mathbb Q$ 아래에서도 같은 확산계수 $\sigma$를 가진다. 측도를 바꾸면 drift는 $\mu$에서 $r$로 바뀌지만, Brownian shock의 크기인 volatility는 그대로 남는다.

즉, 로그수익률의 확률적 충격항의 표준편차는

$$
\sigma\sqrt{\Delta t}
$$

이다.

CRR 모형에서는 이 연속적인 정규분포 충격을 두 점짜리 움직임으로 근사한다. 따라서 로그가격의 한 스텝 위쪽 이동과 아래쪽 이동을 같은 크기로 잡아

$$
\log u=+\sigma\sqrt{\Delta t},
\qquad
\log d=-\sigma\sqrt{\Delta t}
$$

로 둔다. 즉,

$$
u=e^{\sigma\sqrt{\Delta t}},
\qquad
d=e^{-\sigma\sqrt{\Delta t}}
$$

이다.

여기서 $u$와 $d$는 한 스텝 로그수익률의 변동성, 더 정확히는 Brownian shock의 크기를 맞추기 위해 정한다. 반면 위험중립확률 $q$는 위험중립세계에서 주가의 기대성장률이 무위험수익률 $r$이 되도록 정한다.

$$
q u+(1-q)d=e^{r\Delta t}
$$

따라서

$$
q=\frac{e^{r\Delta t}-d}{u-d}.
$$

정리하면 역할은 다음과 같다.

$$
\boxed{
u,d:\ \text{one-step volatility matching},
\qquad
q:\ \text{risk-neutral drift matching}
}
$$

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

# 2. Look Back Option
## 2.1. Introduction to Look Back Option

룩백 옵션은 만기까지의 기초자산 가격 경로 전체를 보고, 그 경로상 최고가격 또는 최저가격을 행사조건에 반영하는 경로의존 옵션이다.
기호를 다음과 같이 둔다.

$$
S_{\max}=\max_{0\le t\le T}S(t),\qquad
S_{\min}=\min_{0\le t\le T}S(t)
$$

룩백 옵션은 크게 두 종류로 나뉜다.

1.1 유동 행사가 룩백 옵션(Floating-strike Lookback Option)

행사가격이 미리 고정되지 않고, 만기까지의 최저가 또는 최고가로 결정된다.

$$
C_T^{FL}=S_T-S_{\min}
$$

$$
P_T^{FL}=S_{\max}-S_T
$$

해석은 다음과 같다.

룩백 콜: 만기까지 가장 싼 가격에 산 뒤 만기 가격에 파는 효과

룩백 풋: 만기까지 가장 비싼 가격에 판 뒤 만기 가격에 되사는 효과

1.2 고정 행사가 룩백 옵션(Fixed-strike Lookback Option)

행사가격 $K$는 미리 고정되어 있고, 만기까지의 최고가 또는 최저가가 수익에 들어간다.

$$
C_T^{FX}=\max(S_{\max}-K,0)
$$

$$
P_T^{FX}=\max(K-S_{\min},0)
$$

해석은 다음과 같다.

고정 행사가 룩백 콜: 경로상 최고가가 고정 행사가보다 높을수록 유리

고정 행사가 룩백 풋: 경로상 최저가가 고정 행사가보다 낮을수록 유리

## 2.2. 시뮬레이션

다음과 같이 flag로 옵션 종류를 구분하자. K는 strike, 즉 행사가격이다.

```python
if flag == 1:
    payoff = S_T - S_min
elif flag == 2:
    payoff = S_max - S_T
elif flag == 3:
    payoff = max(S_max - K, 0)
elif flag == 4:
    payoff = max(K - S_min, 0)
```

예를 들어서 경로가 하나 있다고 하면

```python
path = [100, 110, 95, 120]
```

$S_T$는 120, $S_{\max}$는 120, $S_{\min}$은 95이다.

```python
def lookback_payoff(path, flag, strike=None):
    s_T = path[-1]
    s_max = max(path)
    s_min = min(path)

    if flag == 1:
        return s_T - s_min

    elif flag == 2:
        return s_max - s_T

    elif flag == 3:
        return max(s_max - strike, 0)

    elif flag == 4:
        return max(strike - s_min, 0)
```

와 같이 payoff를 계산할 수 있다. 첫번째와 두번째의 경우에는 strike를 계산에 요구하지 않는다.

### 2.2.1 이항모델을 통한 룩백옵션 가격 계산

CRR 이항모델에서는 한 기간 동안 주가가 두 가지 중 하나로 움직인다고 본다.

$$
S_{t+\Delta t}
=
\begin{cases}
 uS_t, & \text{with probability }p,\\
 dS_t, & \text{with probability }1-p.
\end{cases}
$$

여기서

$$
\Delta t=\frac{T-t}{m}=\frac{\tau}{m},
\qquad
u=e^{\sigma\sqrt{\Delta t}},
\qquad
d=\frac1u
$$

이다. 즉, 변동성 $\sigma$가 클수록 up/down 폭이 커진다.

옵션가격은 실제 확률이 아니라 위험중립확률로 계산한다.

위험중립세계에서는 기초자산의 기대수익률이 무위험이자율 $r$이 되어야 한다.

한 기간의 기대성장률은

$$
e^{r\Delta t}
$$

이어야 한다.

따라서

$$
pu+(1-p)d=e^{r\Delta t}
$$

이를 $p$에 대해 풀면

$$
p=\frac{e^{r\Delta t}-d}{u-d}
$$

이다. 이를 다음과 같이 코드로 표현해보자.

```python
tau = T - t

dt = tau / m

u = math.exp(sigma * math.sqrt(dt))
d = 1 / u

p = (math.exp(r * dt) - d) / (u - d)
```

룩백옵션은 경로의 최댓값/최솟값을 알아야 한다. 따라서 up을 1, down을 0으로 매칭시켜 경로들을 다음과 같이 만들 수 있다.

```python
for moves in itertools.product([0, 1], repeat=m):
```

$m$ 스텝 이항트리에서, 각 경로 $\omega = (\omega_1, \ldots, \omega_m) \in \{u, d\}^m$ 에 대해:
 
$$
V_t = e^{-r\tau} \sum_{\omega \in \{u,d\}^m} \mathbb{Q}(\omega) \cdot \text{Payoff}(\omega)
$$

이며, 경로의 수는 총 $2^m$ 개이다.


따라서 현재시점 t에서 만기 T까지 남은 기간을 m등분해서 룩백옵션 가격을 CRR이항모형으로 구하는 코드는 다음과 같다. 학습을 위한 코드이므로 따로 예외처리는 하지 않았다.

```python
import math
import itertools


def lookback_payoff(path, flag, strike=None):
    s_T = path[-1]
    s_max = max(path)
    s_min = min(path)

    if flag == 1:
        return s_T - s_min
    elif flag == 2:
        return s_max - s_T
    elif flag == 3:
        return max(s_max - strike, 0)
    elif flag == 4:
        return max(strike - s_min, 0)

def price_lookback_binomial(s_current, r, T, t, sigma, m, flag, strike=None):
    tau = T - t

    dt = tau / m

    u = math.exp(sigma * math.sqrt(dt))
    d = 1 / u

    p = (math.exp(r * dt) - d) / (u - d)

    expected_payoff = 0

    for moves in itertools.product([0, 1], repeat=m):
        path = [s_current]
        probability = 1

        for move in moves:
            previous_price = path[-1]

            if move == 1:
                next_price = previous_price * u
                probability = probability * p
            else:
                next_price = previous_price * d
                probability = probability * (1 - p)

            path.append(next_price)

        payoff = lookback_payoff(path, flag=flag, strike=strike)

        expected_payoff = expected_payoff + probability * payoff

    option_price = math.exp(-r * tau) * expected_payoff

    return option_price


price = price_lookback_binomial(
    s_current=100,
    r=0.05,              # 연율화된 연속복리 무위험수익률
    T=252/252,           # 0부터 T까지 1년
    t=(252-90)/252,      # 현재 시점: 만기까지 90거래일 남은 상태
    sigma=0.5,           # 연율화된 변동성
    m=12,
    flag=1
)

print(price)
```

### 2.2.2 GBM Monte Carlo를 통한 룩백옵션 가격 계산

이항모델은 직관적이고 정확하게 모든 경로를 계산할 수 있지만, 경로 수가 너무 빨리 늘어난다. 그래서 m이 커지면 이항모델로 모든 경로를 세는 것이 사실상 불가능 하다. 이 때문에 Monte Carlo를 사용한다.

Monte Carlo에서는 기초자산이 GBM을 따른다고 가정한다.

$$
dS_t
=
rS_t\,dt+\sigma S_t\,dW_t^{\mathbb{Q}}
$$

위험중립측도에서 drift는 r이다.

이 확률미분방정식의 이산시간 해는 다음이다.

$$
S_{t+\Delta t}
=
S_t
\exp\left[
\left(r-\frac12\sigma^2\right)\Delta t
+
\sigma\sqrt{\Delta t}\,Z
\right]
$$

여기서

$$
Z\sim N(0,1)
$$

이다.

따라서 이를 다음과 같이 쓸 수 있다.

```python
next_price = current_price * math.exp(
    (r - 0.5 * sigma ** 2) * dt
    + sigma * math.sqrt(dt) * z
)
```

이를 통해 경로 하나를 만드는 함수를 다음과 같이 쓸 수 있다.

```python
import random
import math


def simulate_gbm_path(s0, r, tau, sigma, m):
    dt = tau / m

    path = [s0]

    for _ in range(m):
        z = random.gauss(0, 1)

        current_price = path[-1]

        next_price = current_price * math.exp(
            (r - 0.5 * sigma ** 2) * dt
            + sigma * math.sqrt(dt) * z
        )

        path.append(next_price)

    return path
```

이제 경로 하나가 아니라 여러 개의 경로를 만들고, 각 경로에서 payoff를 계산한 뒤 평균을 내면 된다. 위험중립측도에서 시뮬레이션하고 있으므로 현재시점 $t$에서의 옵션가격은

$$
V_t
=
e^{-r\tau}
\mathbb E^{\mathbb Q}[\text{Payoff}]
$$

이다. Monte Carlo에서는 이 기대값을 표본평균으로 근사한다.

$$
V_t
\approx
e^{-r\tau}
\frac1N
\sum_{i=1}^{N}
\text{Payoff}^{(i)}
$$

여기서 $N$은 시뮬레이션 경로 수이다.

이를 코드로 쓰면 다음과 같다.

```python
def price_lookback_monte_carlo(
    s_current,
    r,
    T,
    t,
    sigma,
    m,
    flag,
    strike=None,
    n_paths=10000,
    seed=None
):
    if seed is not None:
        random.seed(seed)

    tau = T - t

    payoff_sum = 0

    for _ in range(n_paths):
        path = simulate_gbm_path(
            s0=s_current,
            r=r,
            tau=tau,
            sigma=sigma,
            m=m
        )

        payoff = lookback_payoff(
            path=path,
            flag=flag,
            strike=strike
        )

        payoff_sum = payoff_sum + payoff

    expected_payoff = payoff_sum / n_paths

    option_price = math.exp(-r * tau) * expected_payoff

    return option_price
```

예를 들어 이항모델에서와 같은 조건으로 floating strike lookback call을 계산하면 다음과 같다.

```python
price = price_lookback_monte_carlo(
    s_current=100,
    r=0.05,              # 연율화된 연속복리 무위험수익률
    T=252/252,           # 0부터 T까지 1년
    t=(252-90)/252,      # 현재 시점: 만기까지 90거래일 남은 상태
    sigma=0.5,           # 연율화된 변동성
    m=90,                # 남은 90거래일을 90개 구간으로 관측
    flag=1,
    n_paths=100000,
    seed=42
)

print(price)
```

여기서 $m$은 한 경로 안에서 가격을 몇 번 관측할지를 의미한다. 룩백옵션은 경로의 최댓값 또는 최솟값에 의존하므로, $m$이 너무 작으면 실제 경로 중간의 극값을 놓칠 수 있다. 예를 들어 만기까지 90거래일이 남아 있고 매 거래일 가격을 관측한다고 보면 $m=90$으로 둘 수 있다.

Monte Carlo 가격은 이항모델처럼 모든 경로를 정확히 세는 값이 아니라 난수 시뮬레이션으로 얻은 추정값이다. 따라서 $n_{\text{paths}}$를 늘리면 추정오차는 줄어들지만 계산시간은 길어진다.


## 2.3. 또 다른 룩백 옵션

Conze and Viswanathan(1991)[^Conze]은 룩백 옵션을 다음과 같이 네 가지로 구분한다.

| 분류 | 대표 payoff | 의미 |
|---|---|---|
| Standard Lookback | $S_T - m_T$, $M_T - S_T$ | 최저가에 사고 최고가에 파는 구조 |
| Options on Extrema | $(M_T - K)^+$, $(K - m_T)^+$ | 일반 옵션에서 $S_T$를 최고값 또는 최저값으로 대체한 구조 |
| Limited Risk Options | $(S_T - K)^+ \mathbf{1}_{\{M_T < L\}}$ 등 | 일정 cutoff가 터지면 payoff가 사라지는 제한위험 구조 |
| Partial Lookback | $(S_T - \lambda m_T)^+$, $(\lambda M_T - S_T)^+$ | 최저가/최고가를 일부만 반영하여 더 싸게 만든 구조 |

Standard Lookback과 Options on Extrema가 앞서 봤던 두 가지 룩백옵션이다. 남은 Limited Risk Options와 Partial Lookback을 살펴보자.

### 2.3.1. Limited Risk Options

Limited risk option은 일반 옵션과 비슷한 payoff를 가지지만, 경로상의 극값이 특정 수준을 넘으면 payoff가 사라진다. 예를 들어 limited risk call은 다음과 같은 형태로 쓸 수 있다.

$$
H_T^{LRC}
=
(S_T-K)^+\mathbf 1_{\{M_T<L\}}.
$$

즉 일반 콜처럼 $S_T>K$이면 이익이 생기지만, 만기 전 주가가 cutoff level $L$ 이상으로 올라가 버리면 payoff가 $0$이 된다. 이는 콜옵션을 발행한자가 극단적인 상승 위험에 노출되는 것을 제한하려는 구조로 이해할 수 있다.

Limited risk put은 대칭적으로

$$
H_T^{LRP}
=
(K-S_T)^+\mathbf 1_{\{m_T>L\}}
$$

처럼 쓸 수 있다. 여기서는 주가가 너무 낮은 cutoff를 건드리면 payoff가 사라진다. 표기 충돌을 피하기 위해 cutoff를 $L$로 썼다.

중요한 점은 이 옵션은 만기가 길어진다고 항상 가치가 증가하지 않는다. 만기가 길어지면 일반 옵션의 시간가치는 증가할 수 있지만, 동시에 cutoff 조건이 발동되어 payoff가 사라질 가능성도 증가한다.

### 2.3.2. Partial Lookback Options

lookback call은 최저가 $m_T$에 살 수 있지만, partial lookback call은 최저가보다 일정 비율 높은 가격에 사는 구조이다. 예를 들어 $\lambda>1$일 때

$$
H_T^{PLC}
=
(S_T-\lambda m_T)^+
$$

로 쓸 수 있다. $\lambda=1$이면 standard lookback call이 된다. $\lambda>1$이면 행사가격이 $m_T$보다 높아지므로 옵션이 싸진다.

Partial lookback put은 대칭적으로 $0<\lambda<1$일 때

$$
H_T^{PLP}
=
(\lambda M_T-S_T)^+
$$

처럼 쓸 수 있다. $\lambda=1$이면 standard lookback put이고, $\lambda<1$이면 최고가보다 낮은 가격에 팔 수 있는 권리가 되므로 standard lookback put보다 싸다.

이 구조는 룩백 옵션의 경제적 의미는 유지하되 비용을 낮추기 위한 compromise이다. 즉 최저점 매수 또는 최고점 매도라는 이상적인 권리를 완전히 사는 대신, 그 일부만 산다.


---

# References

[^shreve-bm]: Steven E. Shreve, *Stochastic Calculus for Finance II: Continuous-Time Models*, Springer, 2004. Brownian motion, Ito calculus, risk-neutral pricing, and GBM are treated systematically.

[^donsker]: Patrick Billingsley, *Convergence of Probability Measures*, 2nd ed., Wiley, 1999. See also the standard statement of Donsker's invariance principle, often called the functional central limit theorem.

[^oksendal]: Bernt Oksendal, *Stochastic Differential Equations: An Introduction with Applications*, Springer. A standard reference for Ito's formula and stochastic calculus.

[^black-scholes]: Fischer Black and Myron Scholes, "The Pricing of Options and Corporate Liabilities," *Journal of Political Economy*, 81(3), 637-654, 1973. The paper derives an option valuation formula under lognormal stock dynamics.

[^crr]: John C. Cox, Stephen A. Ross, and Rubinstein, M. "Option Pricing: A Simplified Approach," *Journal of Financial Economics*, 7(3), 229-263, 1979. The CRR binomial model is a discrete-time arbitrage-pricing model that contains the Black-Scholes model as a limiting case.

[^Conze]: Antoine Conze, and Viswanathan. “Path Dependent Options: The Case of Lookback Options.” The Journal of Finance, vol. 46, no. 5, 1991, pp. 1893–907. JSTOR, https://doi.org/10.2307/2328577. Accessed 27 May 2026.

- Black, F., & Scholes, M. (1973). "The Pricing of Options and Corporate Liabilities." *Journal of Political Economy*, 81(3), 637-654.
- Billingsley, P. (1999). *Convergence of Probability Measures* (2nd ed.). Wiley.
- Cox, J. C., Ross, S. A., & Rubinstein, M. (1979). "Option Pricing: A Simplified Approach." *Journal of Financial Economics*, 7(3), 229-263.
- Oksendal, B. *Stochastic Differential Equations: An Introduction with Applications*. Springer.
- Shreve, S. E. (2004). *Stochastic Calculus for Finance II: Continuous-Time Models*. Springer.

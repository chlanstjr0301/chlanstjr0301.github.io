---
title: "Swap 1"   # 글 제목 (bat가 자동 입력 — 한글로 고쳐 쓰면 됨)
date: 2026-08-10T06:05:46+09:00   # 작성일 — 목록 정렬 기준 (자동 입력)
tags: []            # 태그 목록. 예: [asset-allocation, Bayesian] — 글 하단에 #링크로 표시
description: ""     # 한 줄 요약 — 목록·검색 결과·SNS 미리보기에 쓰임
math: true          # 수식 사용 여부 ($...$, $$...$$) — 수식 없는 글이면 false
toc: true           # 목차 자동 생성 (넓은 화면: 우측 사이드바) — 끄려면 false
draft: false         # 초안 표시 — 이 줄을 지우면(또는 false) 배포된다
# cover: "파일명.png"  # (선택) 목록 대표그림 지정 — 없으면 본문 첫 이미지 자동
---

금리스왑와 통화스왑의 기초

# 1. 금리스왑의 가격결정

금리스왑(interest rate swap)은 동일한 통화와 명목원금을 기준으로 고정금리 현금흐름과 변동금리 현금흐름을 교환하는 계약이다. 일반적인 plain vanilla 금리스왑에서는 명목원금 자체를 교환하지 않고, 각 지급일에 계산된 이자 차액만 결제한다.

이 글에서는 먼저 단일 커브(single-curve) 체계에서 할인계수와 선도금리의 무차익 관계를 유도한다. 이후 고정 레그와 변동 레그의 현재가치, 신규 스왑의 공정 고정금리, 기존 스왑의 가치, 재설정일 사이에서의 평가, 마지막으로 현대적인 다중 커브(multi-curve) 가격결정식을 차례로 정리한다.

## 1.1 계약 설정

현재 가치평가 시점을 $t$, 이자계산 시작일을 $T_0$, 미래 지급일을 $T_1, \dots, T_n$이라 하자.

$$t \leq T_0 \lt T_1 \lt T_2 \lt \cdots \lt T_n$$

현재 시작하는 spot-starting swap에서는 $T_0=t$이고, 미래에 시작하는 forward-starting swap에서는 $t\lt T_0$이다.

각 구간의 이자계산기간을

$$\alpha_i=\operatorname{YearFrac}(T_{i-1},T_i)$$

라고 한다. 예를 들어 반기 지급이면 보통 $\alpha_i\approx 0.5$이다. 정확한 값은 Actual/360, Actual/365, 30/360과 같은 day-count convention에 따라 결정된다.

명목원금은 $N$, 계약에서 약정한 고정금리는 $K$라고 하자. $T$에 1원을 지급하는 무이표채의 $t$시점 가격, 즉 할인계수는

$$P(t,T)$$

로 표기한다. 따라서 $P(t,T)$는 현재의 1원이 미래에 얼마가 되는지를 나타내는 값이 아니라, 미래 $T$의 1원을 현재 $t$로 할인한 가치다.

고정 레그의 각 $T_i$에서의 현금흐름은

$$NK\alpha_i$$

이다.

변동금리는 $T_{i-1}$에 확정되어 $T_i$에 지급된다. $[T_{i-1},T_i]$에 적용되는 확정 변동금리를 $L_i$라고 하면, 시장 표준인 단순복리 방식에서 변동 레그의 현금흐름은

$$N\alpha_iL_i$$

이다.

고정금리 지급·변동금리 수취 포지션을 payer swap, 고정금리 수취·변동금리 지급 포지션을 receiver swap이라고 한다.

## 1.2. 할인계수와 선도금리의 관계

### 1.2.1. 선도 누적계수의 무차익 증명

$T_{i-1}$의 1원을 $T_i$까지 운용했을 때의 선도 누적계수를 $G_i(t)$라고 하자. 이 누적계수에는 원금과 이자가 모두 포함된다.

$t$시점에 다음 포트폴리오를 구성한다.

만기 $T_{i-1}$인 무이표채 1단위를 공매도한다.

만기 $T_i$인 무이표채를 $P(t,T_{i-1})/P(t,T_i)$단위 매수한다.

이 포트폴리오의 $t$시점 가치는

$$P(t,T_{i-1})-\frac{P(t,T_{i-1})}{P(t,T_i)}P(t,T_i)=0$$

이다. 미래 현금흐름은 다음과 같다.

| 시점       |                  현금흐름 |
| ---------- | ------------------------: |
| $T\_{i-1}$ |                      $-1$ |
| $T\_i$     | $P(t,T\_{i-1})/P(t,T\_i)$ |

따라서 이 포트폴리오는 $T_{i-1}$에 1원을 지급하고 $T_i$에 $P(t,T_{i-1})/P(t,T_i)$원을 받는 선도대출을 복제한다. 초기 가치가 0인 공정 선도대출의 누적계수는 무차익에 의해

$$\boxed{G_i(t)=\frac{P(t,T_{i-1})}{P(t,T_i)}}$$

이어야 한다.

만약 시장의 선도 누적계수가 이 값보다 크다면 선도대출을 매수하고 복제 포트폴리오를 매도하여 양의 확정 현금흐름을 만들 수 있다. 반대로 시장의 선도 누적계수가 더 작다면 거래 방향을 뒤집으면 된다. 따라서 위 등식은 일물일가와 무차익 조건에 의해 강제된다.

누적계수에는 원금 1이 포함되어 있으므로, 원금을 제외한 기간 이자율은

$$\boxed{G_i(t)-1=\frac{P(t,T_{i-1})}{P(t,T_i)}-1}$$

### 1.2.2. 단순복리 선도금리

단순복리 선도금리를 $F_i^{(s)}(t)$라고 하자. 단순복리에서는 원금 1의 누적금액이

$$1+\alpha_iF_i^{(s)}(t)$$

이므로

$$G_i(t)=1+\alpha_iF_i^{(s)}(t)$$

이다. 무차익 누적계수를 대입하면

$$1+\alpha_iF_i^{(s)}(t)=\frac{P(t,T_{i-1})}{P(t,T_i)}$$

이고, 따라서

$$\boxed{F_i^{(s)}(t)=\frac{1}{\alpha_i}\left[\frac{P(t,T_{i-1})}{P(t,T_i)}-1\right]}$$

이다.

### 1.2.3. 연 m회 복리 선도금리

연 $m$회 복리 선도금리를 $F_i^{(m)}(t)$라고 하자. 한 복리기간의 금리는 $F_i^{(m)}(t)/m$이고, $\alpha_i$년 동안의 복리 횟수는 $m\alpha_i$회다. 따라서

$$G_i(t)=\left(1+\frac{F_i^{(m)}(t)}{m}\right)^{m\alpha_i}$$

이다. 무차익 누적계수를 대입하면

$$\left(1+\frac{F_i^{(m)}(t)}{m}\right)^{m\alpha_i}=\frac{P(t,T_{i-1})}{P(t,T_i)}$$

이고, 따라서

$$\boxed{F_i^{(m)}(t)=m\left[\left(\frac{P(t,T_{i-1})}{P(t,T_i)}\right)^{1/(m\alpha_i)}-1\right]}$$

이다. 이 표현은 이론적으로 $m\alpha_i$가 정수인 경우를 전제로 한다. 실제 상품에 비정규 기간이 포함되면 별도의 stub 및 day-count 규약을 적용한다.

### 1.2.4. 연속복리 선도금리

연속복리 선도금리를 $F_i^{(c)}(t)$라고 하자. 연속복리 누적계수는

$$G_i(t)=\exp\left(\alpha_iF_i^{(c)}(t)\right)$$

이다. 무차익 누적계수를 대입하면

$$\exp\left(\alpha_iF_i^{(c)}(t)\right)=\frac{P(t,T_{i-1})}{P(t,T_i)}$$

이고, 양변에 자연로그를 취하면

$$\boxed{F_i^{(c)}(t)=\frac{1}{\alpha_i}\log\left(\frac{P(t,T_{i-1})}{P(t,T_i)}\right)}$$

이다.

### 1.2.5. 세 복리 규약의 관계

세 선도금리는 서로 다른 경제적 수익률이 아니라 동일한 누적계수를 서로 다른 방식으로 표시한 값이다.

$$1+\alpha_iF_i^{(s)}(t)=\left(1+\frac{F_i^{(m)}(t)}{m}\right)^{m\alpha_i}$$

$$\left(1+\frac{F_i^{(m)}(t)}{m}\right)^{m\alpha_i}=\exp\left(\alpha_iF_i^{(c)}(t)\right)$$

$$\exp\left(\alpha_iF_i^{(c)}(t)\right)=\frac{P(t,T_{i-1})}{P(t,T_i)}$$

따라서 원금을 제외한 기간 이자율은 세 경우 모두

$$\alpha_iF_i^{(s)}(t)=\left(1+\frac{F_i^{(m)}(t)}{m}\right)^{m\alpha_i}-1$$

$$\left(1+\frac{F_i^{(m)}(t)}{m}\right)^{m\alpha_i}-1=\exp\left(\alpha_iF_i^{(c)}(t)\right)-1$$

$$\exp\left(\alpha_iF_i^{(c)}(t)\right)-1=\frac{P(t,T_{i-1})}{P(t,T_i)}-1$$

로 일치한다.

문서의

$$f_i=\frac{B_{i-1}}{B_i}-1$$

은 $B_i=P(0,T_i)$로 두었을 때의 한 기간 유효 선도금리다. $\alpha_i=1$이면 단순복리 연율 $F_i^{(s)}(0)$과 일치한다.

실제 plain vanilla 금리스왑에서는 일반적으로 단순복리 방식으로 변동 쿠폰을 계산한다. 따라서 이하에서 별도의 복리 표시가 없으면

$$F_i(t)=F_i^{(s)}(t)$$

로 둔다.

## 1.3. 고정 레그의 현재가치

고정금리 수취자의 고정 레그 현재가치는 각 고정 쿠폰을 해당 지급일까지 할인한 합이다.

$$PV_{\mathrm{fix}}(t)=NK\sum_{i=1}^n\alpha_iP(t,T_i)$$

다음 quantity를 스왑 연금계수(swap annuity)라고 한다.

$$\boxed{A(t;T_1,\dots,T_n)=\sum_{i=1}^n\alpha_iP(t,T_i)}$$

문맥이 명확하면 이를 $A(t)$로 줄여 쓴다. 따라서

$$\boxed{PV_{\mathrm{fix}}(t)=NKA(t)}$$

이다.

명목원금까지 교환하는 고정금리채권의 관점에서 쓰면

$$PV_{\mathrm{fixed\ bond}}(t)=NKA(t)+NP(t,T_n)$$

이다. 일반적인 금리스왑에서는 원금 자체를 실제로 교환하지 않지만, 채권 복제 논증을 위해 양쪽 레그에 동일한 가상의 원금 $N$을 붙일 수 있다. 양쪽에 동일한 원금을 추가하므로 스왑의 순가치에는 영향을 주지 않는다.

## 1.4. 변동 레그의 현재가치

먼저 모든 변동금리가 아직 확정되지 않은 경우를 생각하자. 이는 현재 시작하는 신규 스왑의 재설정 직후 또는 미래에 시작하는 forward-starting swap에 해당한다.

단일 커브 체계에서는 동일한 할인곡선으로 현금흐름을 할인하고 선도금리를 산출한다. 표준적인 단순복리 방식에서 변동 레그의 현재가치는

$$PV_{\mathrm{flt}}(t)=N\sum_{i=1}^n\alpha_iF_i(t)P(t,T_i)$$

이다.

### 1.4.1. 단순복리의 경우

단순복리 선도금리 식에 의해

$$\alpha_iF_i^{(s)}(t)=\frac{P(t,T_{i-1})}{P(t,T_i)}-1$$

이다. 양변에 $P(t,T_i)$를 곱하면

$$\alpha_iF_i^{(s)}(t)P(t,T_i)=P(t,T_{i-1})-P(t,T_i)$$

이다. 따라서 $i$번째 변동이자의 현재가치는

$$\boxed{PV_i^{(s)}(t)=N\left[P(t,T_{i-1})-P(t,T_i)\right]}$$

이다.

여기서 $-P(t,T_i)$가 나타나는 이유는 변동 레그가 원금과 이자를 합한 $N[1+\alpha_iF_i^{(s)}(t)]$을 지급하는 것이 아니라 이자 $N\alpha_iF_i^{(s)}(t)$만 지급하기 때문이다. 원금과 이자를 합한 금액의 현재가치는

$$\left[1+\alpha_iF_i^{(s)}(t)\right]P(t,T_i)=P(t,T_{i-1})$$

이고, 여기서 원금 1의 현재가치 $P(t,T_i)$를 빼면 이자만의 현재가치가 된다.

### 1.4.2. 연 m회 복리의 경우

연 $m$회 복리로 표시한다면 원금을 제외한 기간 이자는

$$N\left[\left(1+\frac{F_i^{(m)}(t)}{m}\right)^{m\alpha_i}-1\right]$$

이다. 따라서 현재가치는

$$PV_i^{(m)}(t)=N\left[\left(1+\frac{F_i^{(m)}(t)}{m}\right)^{m\alpha_i}-1\right]P(t,T_i)$$

이다. 무차익 누적계수를 대입하면

$$PV_i^{(m)}(t)=N\left[\frac{P(t,T_{i-1})}{P(t,T_i)}-1\right]P(t,T_i)$$

이므로

$$\boxed{PV_i^{(m)}(t)=N\left[P(t,T_{i-1})-P(t,T_i)\right]}$$

이다.

### 1.4.3. 연속복리의 경우

연속복리로 표시한다면 원금을 제외한 기간 이자는

$$N\left[\exp\left(\alpha_iF_i^{(c)}(t)\right)-1\right]$$

이다. 따라서 현재가치는

$$PV_i^{(c)}(t)=N\left[\exp\left(\alpha_iF_i^{(c)}(t)\right)-1\right]P(t,T_i)$$

이다. 무차익 누적계수를 대입하면

$$PV_i^{(c)}(t)=N\left[\frac{P(t,T_{i-1})}{P(t,T_i)}-1\right]P(t,T_i)$$

이므로

$$\boxed{PV_i^{(c)}(t)=N\left[P(t,T_{i-1})-P(t,T_i)\right]}$$

이다.

연속복리 금리를 사용하면서 이자 현금흐름을 $N\alpha_iF_i^{(c)}(t)$로 계산하면 안 된다. 연속복리에서 정확한 이자 현금흐름은 $N[\exp(\alpha_iF_i^{(c)}(t))-1]$이다. $N\alpha_iF_i^{(c)}(t)$는 금리와 기간이 충분히 작을 때만 사용할 수 있는 1차 근사다.

### 1.4.4. 전체 변동 레그와 망원합

복리 규약에 맞게 이자 현금흐름을 정의하면 세 경우 모두 각 기간의 현재가치는

$$N\left[P(t,T_{i-1})-P(t,T_i)\right]$$

로 같다. 따라서 전체 변동 레그의 현재가치는

$$PV_{\mathrm{flt}}(t)=N\sum_{i=1}^n\left[P(t,T_{i-1})-P(t,T_i)\right]$$

이다. 합을 전개하면

$$P(t,T_0)-P(t,T_1)+P(t,T_1)-P(t,T_2)+\cdots+P(t,T_{n-1})-P(t,T_n)$$

이므로 중간 할인계수들이 모두 소거된다. 따라서

$$\boxed{PV_{\mathrm{flt}}(t)=N\left[P(t,T_0)-P(t,T_n)\right]}$$

이다.

스왑이 현재 $t=T_0$에서 시작하면

$$P(t,T_0)=P(t,t)=1$$

이므로

$$\boxed{PV_{\mathrm{flt}}(t)=N\left[1-P(t,T_n)\right]}$$

이다. 이는 원금 교환을 제외한 변동이자 쿠폰만의 현재가치다.

마지막에 가상의 원금 $N$을 추가하면 변동금리채권의 현재가치는

$$N\left[1-P(t,T_n)\right]+NP(t,T_n)=N$$

이 된다. 이것이 변동금리채권은 금리 재설정 직후 액면가와 같다는 결과다.

## 1.5. 신규 스왑의 공정 고정금리

신규 스왑은 계약 체결 시점에 어느 한쪽에도 가치가 없어야 한다. 따라서 고정 레그와 변동 레그의 현재가치가 같아지도록 고정금리 $K$를 결정한다.

$$PV_{\mathrm{fix}}(t)=PV_{\mathrm{flt}}(t)$$

단일 커브에서 모든 변동금리가 아직 확정되지 않았다면

$$NKA(t)=N\left[P(t,T_0)-P(t,T_n)\right]$$

이다. 따라서 공정 스왑금리, 즉 par swap rate는

$$\boxed{S(t;T_0,T_n)=\frac{P(t,T_0)-P(t,T_n)}{\displaystyle\sum_{i=1}^n\alpha_iP(t,T_i)}}$$

이다.

현재 시작하는 스왑에서는 $T_0=t$이고 $P(t,t)=1$이므로

$$\boxed{S(t;t,T_n)=\frac{1-P(t,T_n)}{\displaystyle\sum_{i=1}^n\alpha_iP(t,T_i)}}$$

이다.

반면 미래 $T_0\gt t$에 시작하는 forward-starting swap에서는

$$\boxed{S(t;T_0,T_n)=\frac{P(t,T_0)-P(t,T_n)}{\displaystyle\sum_{i=1}^n\alpha_iP(t,T_i)}}$$

를 사용한다. 여기서 $T_1,\dots,T_n$은 실제 고정금리 지급일이다.

단순복리 선도금리를 이용하면 같은 스왑금리를 다음과 같이 쓸 수도 있다.

$$S(t;T_0,T_n)=\frac{\displaystyle\sum_{i=1}^n\alpha_iF_i(t)P(t,T_i)}{\displaystyle\sum_{i=1}^n\alpha_iP(t,T_i)}$$

즉 공정 스왑금리는 선도금리의 단순평균이 아니라, $\alpha_iP(t,T_i)$를 가중치로 사용한 가중평균이다.

## 1.6. 기존 스왑의 가치평가

과거에 고정금리 $K$로 스왑을 체결했는데 현재 시장의 공정 스왑금리가 $S_t$로 변했다고 하자. 먼저 현재가 변동금리 재설정일이고, 남은 변동금리가 모두 아직 확정되지 않은 경우를 생각한다. 재설정일 사이에서 평가하는 경우는 8절에서 별도로 다룬다.

남은 지급일에 대한 스왑 연금계수를

$$A(t)=\sum_{i=1}^n\alpha_iP(t,T_i)$$

라고 하자. 현재 시장의 공정 스왑금리는

$$S_t=\frac{P(t,T_0)-P(t,T_n)}{A(t)}$$

이다.

### 1.6.1. 고정금리 수취자

고정금리 수취·변동금리 지급자의 가치는

$$V_{\mathrm{rec}}(t)=PV_{\mathrm{fix}}(t)-PV_{\mathrm{flt}}(t)$$

이다. 따라서

$$V_{\mathrm{rec}}(t)=NKA(t)-N\left[P(t,T_0)-P(t,T_n)\right]$$

이고, 시장 스왑금리의 정의를 대입하면

$$\boxed{V_{\mathrm{rec}}(t)=NA(t)(K-S_t)}$$

이다.

### 1.6.2. 고정금리 지급자

고정금리 지급·변동금리 수취자의 가치는 반대 부호이므로

$$\boxed{V_{\mathrm{pay}}(t)=NA(t)(S_t-K)}$$

이다. 따라서

$$S_t\gt K\quad\Longrightarrow\quad V_{\mathrm{pay}}(t)\gt 0$$

이고,

$$S_t\lt K\quad\Longrightarrow\quad V_{\mathrm{rec}}(t)\gt 0$$

이다. 시장금리가 상승하면 기존의 낮은 고정금리를 계속 지급할 수 있는 payer swap이 유리해지고, 시장금리가 하락하면 기존의 높은 고정금리를 수취하는 receiver swap이 유리해진다.

## 1.7. 재설정일 사이에서의 가치평가

7절의 간단한 식은 현재가 변동금리 재설정일이어서 다음 변동금리가 아직 확정되지 않은 경우에 바로 적용된다. 현재 $t$가 재설정일 사이에 있다면 첫 번째 남은 변동 쿠폰은 이미 과거에 확정되어 있으므로 별도로 처리해야 한다.

직전 재설정일과 다음 지급일이

$$T_{k-1}\lt t\lt T_k$$

이고, $T_k$에 지급될 변동금리 $L_k$가 이미 $T_{k-1}$에 확정되었다고 하자. 여기서 $L_k$는 $[T_{k-1},T_k]$ 구간에 적용되는 금리다. 이때 남은 변동 레그의 현재가치는

$$PV_{\mathrm{flt}}(t)=N\alpha_kL_kP(t,T_k)+N\sum_{i=k+1}^n\alpha_iF_i(t)P(t,T_i)$$

이다.

$i=k+1$ 이후의 선도금리 부분은 망원합되어

$$N\sum_{i=k+1}^n\alpha_iF_i(t)P(t,T_i)=N\left[P(t,T_k)-P(t,T_n)\right]$$

이 된다. 따라서

$$PV_{\mathrm{flt}}(t)=N\alpha_kL_kP(t,T_k)+N\left[P(t,T_k)-P(t,T_n)\right]$$

이고,

$$\boxed{PV_{\mathrm{flt}}(t)=N\left[\left(1+\alpha_kL_k\right)P(t,T_k)-P(t,T_n)\right]}$$

이다.

남은 고정 레그의 연금계수를

$$A_k(t)=\sum_{i=k}^n\alpha_iP(t,T_i)$$

라고 하면 고정금리 수취자의 가치는

$$\boxed{V_{\mathrm{rec}}(t)=NKA_k(t)-N\left[\left(1+\alpha_kL_k\right)P(t,T_k)-P(t,T_n)\right]}$$

이다. 고정금리 지급자의 가치는 이 식의 반대 부호다.

필요하다면 남은 현금흐름과 동일한 가치를 갖는 쿠폰 등가 스왑금리를

$$S_t^{\mathrm{rem}}=\frac{\left(1+\alpha_kL_k\right)P(t,T_k)-P(t,T_n)}{A_k(t)}$$

로 정의할 수 있다. 그러면

$$V_{\mathrm{rec}}(t)=NA_k(t)\left(K-S_t^{\mathrm{rem}}\right)$$

로 쓸 수 있다. 다만 $S_t^{\mathrm{rem}}$는 현재 시점에서 새로 시작하는 표준 시장 스왑금리와 지급기간 및 첫 쿠폰 구조가 다를 수 있으므로 구분해야 한다.

## 1.8. 채권의 차이로 보는 금리스왑

금리스왑의 양쪽 레그에 동일한 가상의 원금 $N$을 추가하면 각 레그를 채권으로 해석할 수 있다.

고정 레그에 만기 원금을 추가하면 고정금리채권이 되고, 변동 레그에 같은 원금을 추가하면 변동금리채권이 된다. 동일한 원금을 양쪽에 추가했으므로 두 채권 가치의 차이는 원래 스왑의 가치와 같다.

고정금리 지급·변동금리 수취자의 관점에서는

$$\text{payer swap}=\text{변동금리채 롱}-\text{고정금리채 롱}$$

이므로

$$\boxed{V_{\mathrm{pay}}(t)=B_{\mathrm{flt}}(t)-B_{\mathrm{fix}}(t)}$$

이다.

반대로 고정금리 수취·변동금리 지급자의 관점에서는

$$\text{receiver swap}=\text{고정금리채 롱}-\text{변동금리채 롱}$$

이므로

$$\boxed{V_{\mathrm{rec}}(t)=B_{\mathrm{fix}}(t)-B_{\mathrm{flt}}(t)}$$

이다.

재설정일 직후에는 변동금리채의 가치가 액면가 $N$으로 돌아온다. 반면 재설정일 사이에서는 다음 쿠폰이 이미 확정되어 있으므로 변동금리채의 가치는 일반적으로 $N$과 다르다. 8절의 변동 레그에 만기 원금을 더하면

$$B_{\mathrm{flt}}(t)=N\left(1+\alpha_kL_k\right)P(t,T_k)$$

를 얻는다.

## 1.9. 가장 일반적인 형태: 다중 커브 가격결정

지금까지는 고정 레그와 변동 레그의 지급일이 같고, 하나의 커브로 선도금리를 산출하면서 동일한 커브로 현금흐름을 할인하는 단일 커브 체계를 가정했다.

현대적인 금리스왑 가격결정에서는 일반적으로 할인 커브와 금리 예측 커브를 구분한다. 또한 고정 레그와 변동 레그의 지급주기가 서로 다를 수 있다.

고정 지급일을

$$T_1^K,\dots,T_m^K$$

고정 accrual factor를 $\alpha_j^K$, 변동 지급일을

$$T_1^L,\dots,T_n^L$$

변동 accrual factor를 $\alpha_i^L$이라고 하자.

현금흐름 할인에 사용하는 discount curve를 $P_d(t,T)$, 변동금리 예측에 사용하는 projection curve의 선도금리를 $F_p(t;T_{i-1}^L,T_i^L)$라고 하자.

고정 레그의 현재가치는

$$PV_{\mathrm{fix}}(t)=NK\sum_{j=1}^m\alpha_j^KP_d(t,T_j^K)$$

이고, 모든 변동금리가 아직 확정되지 않았다면 변동 레그의 현재가치는

$$PV_{\mathrm{flt}}(t)=N\sum_{i=1}^n\alpha_i^LF_p(t;T_{i-1}^L,T_i^L)P_d(t,T_i^L)$$

이다.

따라서 신규 스왑의 공정 고정금리는

$$\boxed{K^*=\frac{\displaystyle\sum_{i=1}^n\alpha_i^LF_p(t;T_{i-1}^L,T_i^L)P_d(t,T_i^L)}{\displaystyle\sum_{j=1}^m\alpha_j^KP_d(t,T_j^K)}}$$

이다. 이것이 현대적인 다중 커브 스왑 가격결정식이다.

projection curve를 가상의 할인계수 $P_p(t,T)$로 나타내면 단순복리 선도금리는

$$F_p(t;T_{i-1}^L,T_i^L)=\frac{1}{\alpha_i^L}\left[\frac{P_p(t,T_{i-1}^L)}{P_p(t,T_i^L)}-1\right]$$

로 쓸 수 있다. 그러나 $P_p$는 변동금리 예측을 위한 curve quantity이며, 반드시 거래 가능한 무이표채 가격을 의미하는 것은 아니다.

단일 커브에서는

$$P_p(t,T)=P_d(t,T)=P(t,T)$$

이므로

$$\alpha_iF_i(t)P(t,T_i)=P(t,T_{i-1})-P(t,T_i)$$

가 되어 변동 레그의 분자가 망원합으로 단순화된다.

반면 다중 커브에서는 일반적으로

$$P_p(t,T)\neq P_d(t,T)$$

이므로

$$\alpha_i^LF_p(t;T_{i-1}^L,T_i^L)P_d(t,T_i^L)$$

에서 인접 기간의 항들이 서로 소거되지 않는다. 따라서 일반적으로

$$PV_{\mathrm{flt}}(t)\neq N\left[P_d(t,T_0^L)-P_d(t,T_n^L)\right]$$

이며, 단일 커브의 단순한 망원합 공식은 더 이상 성립하지 않는다.

실무적으로는 담보화된 현금흐름을 OIS discount curve로 할인하고, 변동금리의 tenor에 맞는 projection curve로 각 미래 변동금리를 예측한다. 이미 확정된 첫 번째 변동 쿠폰이 있다면 그 항은 선도금리 대신 실제 확정금리를 사용해야 한다.

## 1.10. 전체 구조 요약

### 1.10.1. 단일 커브와 모든 변동금리가 미확정인 경우

스왑 연금계수는

$$A(t)=\sum_{i=1}^n\alpha_iP(t,T_i)$$

이고, 고정 레그와 변동 레그의 현재가치는 각각

$$PV_{\mathrm{fix}}(t)=NKA(t)$$

$$PV_{\mathrm{flt}}(t)=N\left[P(t,T_0)-P(t,T_n)\right]$$

이다. 따라서 공정 스왑금리는

$$\boxed{S_t=\frac{P(t,T_0)-P(t,T_n)}{A(t)}}$$

이다.

기존 payer swap과 receiver swap의 가치는

$$\boxed{V_{\mathrm{pay}}(t)=NA(t)(S_t-K)}$$

$$\boxed{V_{\mathrm{rec}}(t)=NA(t)(K-S_t)}$$

이다.

### 1.10.2. 재설정일 사이에서의 변동 레그

첫 번째 남은 변동금리 $L_k$가 이미 확정되어 있다면

$$\boxed{PV_{\mathrm{flt}}(t)=N\left[\left(1+\alpha_kL_k\right)P(t,T_k)-P(t,T_n)\right]}$$

이다.

### 1.10.3. 다중커브

다중 커브에서 변동 레그의 현재가치는

$$PV_{\mathrm{flt}}(t)=N\sum_{i=1}^n\alpha_i^LF_p(t;T_{i-1}^L,T_i^L)P_d(t,T_i^L)$$

이고, 공정 고정금리는

$$\boxed{S_t=\frac{\displaystyle\sum_{i=1}^n\alpha_i^LF_p(t;T_{i-1}^L,T_i^L)P_d(t,T_i^L)}{\displaystyle\sum_{j=1}^m\alpha_j^KP_d(t,T_j^K)}}$$

이다.

핵심은 다음 한 식으로 요약된다.

$$\boxed{\text{공정 스왑금리}=\frac{\text{변동 레그의 현재가치}}{\text{고정금리 1단위 레그의 현재가치}}}$$

따라서 스왑금리는 미래 변동금리의 단순평균이 아니다. 각 미래 변동금리에 accrual factor와 할인계수를 반영하여 계산한 가중평균이며, 단일 커브에서는 할인계수의 무차익 관계 때문에 그 분자가 망원합으로 단순화된다.



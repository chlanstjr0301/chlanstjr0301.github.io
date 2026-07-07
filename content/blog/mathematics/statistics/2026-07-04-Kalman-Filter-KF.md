---
title: "Kalman Filter — KF (Linear Kalman Filter)"
date: 2026-07-04T12:00:00+09:00
tags: [statistics, kalman-filter]
description: "선형 칼만 필터: 상태공간 모형에서 예측-갱신 재귀식 유도."
math: true
toc: true
draft: true
---



# Introduction
![Norbert Wiener](./images/norbert_wiener.png)
*Figure 1. Norbert Wiener, 1963. Source: Wikimedia Commons, File: Norbert Wiener.png. Author: Garry Olsh. License: CC0 1.0.*

이전 글의 금융수학 파트에서 Wiener Process에 대해 다뤄보았습니다. Wiener Process에서 Wiener는 미국의 수학자이자 컴퓨터과학자인 Norbert Wiener를 지칭하는 것입니다. Norbert Wiener는 제2차 세계대전 중 레이더 및 대공화기 제어 문제와 관련된 신호 예측·필터링 문제를 해결하기 위해 Wiener Filter를 개발하였으며, 이 연구는 1942년 기밀 보고서로 먼저 배포된 후 종전 후인 1949년에 공개 출판되었습니다.[^wiener-1949] Wiener Filter는 관측값들의 선형 결합을 통해 원 신호를 추정하는 필터입니다. 
causal Wiener Filter의 경우 현재 시점의 추정값은 현재 및 과거 관측값들의 가중합으로 표현됩니다. $\hat{x}_t = \sum_{k=0}^{\infty} h_k z_{t-k}$ 이때 필터 계수 $h_k$는 신호와 노이즈의 자기상관함수 또는 파워 스펙트럼 밀도에 의해 결정됩니다. 이를 위해 Wiener Filter는 보통 $x(t)$와 $n(t)$가 Wide-Sense Stationary process(WSS Process, 광의의 정상성 과정)이며, 두 과정의 2차 통계적 특성이 시간에 따라 변하지 않는다고 가정합니다. 다만 이 방식은 신호와 노이즈의 통계적 구조를 사전에 알고 있어야 하며, 시간에 따라 변하는 시스템이나 순차적으로 갱신되는 상태 추정 문제에는 직접 적용하기 어렵습니다. 이러한 한계를 보완하는 대표적인 접근이 상태공간모형을 기반으로 한 Kalman Filter입니다.

![Rudolf E. Kálmán](./images/kalman_eth.jpg)
*Figure 2. Rudolf E. Kálmán. Source: ETH-Bibliothek Zürich, Bildarchiv, via Wikimedia Commons. Photographer unknown. License: CC BY-SA 4.0.*

1960년, R.E.Kalman은 Wiener의 필터링 문제에 대한 재귀적 해법을 제시하였습니다.[^kalman-1960]  이후 디지털 컴퓨팅의 발전에 힘입어 칼만 필터는 항법, 신호처리 등 다양한 분야에서 광범위하게 연구 및 응용되어 왔습니다. 이 글에서는 칼만필터와 이에 대한 비선형 시스템으로의 확장인 확장 칼만 필터(EKF; Extended Kalman Filter)와 무향 칼만필터(UKF;Unscented Kalman Filter)도 함께 다뤄보겠습니다.

# KF(Kalman filter)
이 파트의 내용은 An Introduction to the Kalman Filter(Greg, 1995.)[^Greg-1995]를 기반으로 쓰여졌습니다. python 코드는 pykalman라이브러리를 기반으로 소개하고 있습니다. `pykalman`은 Kalman Filter, Kalman Smoother, EM algorithm을 제공하는 Python 오픈소스 라이브러리입니다.

## Problem Setting
우리가 추정하고 싶은 것은 시간 $k$에서의 hidden state $x_k \in \mathbb{R}^n$이다. 하지만 $x_k$는 직접 관측되지 않는다. 대신 measurement $z_k \in \mathbb{R}^m$이 주어진다.

KF는 다음 선형 상태공간모형(SSM; State Space Model)을 가정한다.

$$
x_k = A x_{k-1} + B u_{k-1} + w_{k-1}
$$

$$
z_k = Hx_k + v_k
$$

$$
w_{k-1} \sim \mathcal{N}(0,Q)
$$

$$
v_k \sim \mathcal{N}(0,R)
$$

여기서 각 항의 의미는 다음과 같다.
- $x_k$: Hidden State Vector, $k$시점의 시스템 내부 상태를 나타내는 은닉 상태 벡터
- $z_k$: Measurement Vector, $k$시점에 실제 측정된 오차가 포함된 관측 벡터
- $u_{k-1}$: Known Control Input, $k-1$시점에서 시스템에 인위적으로 가해진 기지(已知)의 제어 입력 벡터
- $A$: State Transition Matrix, 이전 상태에서 다음 상태로의 전이를 기술하는 상태 전이 행렬
- $B$: Control Input Matrix, 제어 입력이 상태 변환에 가하는 메커니즘을 정의한 제어 입력 행렬 
- $H$: Observation Matrix, 은닉 상태로부터 관측 가능한 변수를 매핑하는 관측 행렬
- $w_{k-1}$: Process Noise, 시스템 모델의 불확실성을 나타내며, 공분산 $Q$를 따르는 시스템 잡음
- $v_k$: Measurement Noise, 관측 기기나 데이터 자체의 불확실성을 나타내며, 공분산 $R$을 따르는 관측 잡음

차원은 다음과 같이 둘 수 있다.

$$
x_k \in \mathbb{R}^n, \quad
z_k \in \mathbb{R}^m, \quad
u_{k-1} \in \mathbb{R}^{\ell}
$$

$$
A \in \mathbb{R}^{n \times n}, \quad
B \in \mathbb{R}^{n \times \ell}, \quad
H \in \mathbb{R}^{m \times n}
$$

상태방정식

$$
x_k = A x_{k-1} + B u_{k-1} + w_{k-1}
$$

은 현재 상태 $x_k$가 이전 상태 $x_{k-1}$, control input $u_{k-1}$, 그리고 process noise $w_{k-1}$에 의해 결정된다는 뜻이다.

관측방정식

$$
z_k = Hx_k + v_k
$$

은 실제 state $x_k$가 관측공간에서는 $Hx_k$로 보이고, 여기에 measurement noise $v_k$가 섞인다는 뜻이다.

KF는 매 시점마다 두 가지 객체를 갱신한다.

$$
\hat{x}_k
$$

$$
P_k
$$

여기서 $\hat{x}_k$는 measurement $z_k$까지 반영한 뒤의 posterior state estimate이다.

$$
\hat{x}_k = E[x_k \mid z_1,\dots,z_k]
$$

그리고 $P_k$는 posterior estimate error covariance이다.

$$
P_k = E[(x_k-\hat{x}_k)(x_k-\hat{x}_k)^T]
$$

즉, KF는 단순히 상태의 점추정값만 계산하는 것이 아니라, 그 추정값의 불확실성까지 함께 업데이트한다.
## Assumptions
## Prediction Step
## Update Step
## Intuition
## Python Example
## Limitation

# Conclusion
이번글에서는 노이즈가 정규분포를 따른다고 가정하는 KF와 posterior를 평균과 공분산 중심의 Gaussian approximation으로 추적하는 EKF, UKF를 다뤄봤습니다. 다음글에서는 이러한 가정이 없는 PF(Particle Filter), EPF(Extended Particle Filter), UPF(Unscented Particle Filter)를 다뤄보도록 하겠습니다. Particle Filter는 PDF를 점 질량(Particle) 표현으로 나타내는 순차 몬테카를로 방법으로, 일반적인 상태공간 모델에 적용할 수 있으며 전통적인 칼만 필터 방법을 일반화합니다.[^Arulampalam-2002] 금융데이터는 Fat tail, Jump 그리고 Regime Switch 등과 같은 이유로 가우시안 가정을 위배합니다. Particle Filter는 분포 형태에 제약이 없으므로 현실을 보다 잘 반영할 수 있습니다. 하지만 파라미터 추정의 불안정성과 계산 비용 문제 등 실용적 한계도 존재하며, 이는 다음 시간에 자세히 다뤄보도록 하겠습니다. 읽어주셔서 감사합니다.


# References
[^wiener-1949]: Wiener, N. (1949). *Extrapolation, Interpolation, and Smoothing
of Stationary Time Series, with Engineering Applications.* MIT Press.
(Originally issued as a classified report, February 1942.)

[^kalman-1960]: Kalman, R. E. (March 1, 1960). "A New Approach to Linear Filtering and Prediction Problems." ASME. J. Basic Eng. March 1960; 82(1): 35–45. https://doi.org/10.1115/1.3662552

[^Greg-1995]: Gre
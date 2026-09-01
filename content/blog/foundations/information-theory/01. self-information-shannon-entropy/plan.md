문석에게는 약 15~18시간짜리 정석 플랜이 적합하다. 기초 확률 설명에는 시간을 거의 쓰지 않고, 다음 세 가지에 집중하는 구성이다.

1. Shannon의 역사적 문제의식
2. (-\log p)와 entropy의 수학적 필연성
3. entropy와 압축 길이를 연결할 때 필요한 정확한 조건

글 분량은 수식·각주 제외 약 7,000~9,000자 정도가 적당하다.

## 1. 글의 전체 서사

글은 다음 흐름으로 가는 것이 가장 자연스럽다.

[
\text{Shannon의 통신 문제}
\rightarrow
\text{가능성의 수를 어떻게 측정할 것인가}
\rightarrow
\text{확률을 정보량으로 변환}
\rightarrow
\text{평균 정보량으로서 entropy}
\rightarrow
\text{압축에 대한 제한된 operational interpretation}
]

### 도입: Claude Shannon은 무엇을 측정하려 했는가

도입부는 단순한 인물 소개가 아니라 1948년 논문의 문제 설정으로 시작한다.

* 통신의 핵심은 메시지의 의미가 아니라 가능한 메시지 가운데 하나가 선택되었다는 사실
* 가능한 경우가 (N)개이고 균등하면 필요한 정보량은 (\log_2N)
* Hartley의 아이디어를 Shannon이 비균등 확률분포와 확률과정으로 일반화
* “불확실성의 양을 어떻게 측정할 것인가?”라는 질문으로 본론 진입

Shannon의 생애는 다음 네 가지만 조사하면 충분하다.

* MIT에서의 Boolean algebra와 relay circuit 연구
* Bell Labs에서 통신 문제를 연구한 배경
* 1948년 「A Mathematical Theory of Communication」
* 1951년 영어 entropy 추정 실험

도입부에서 생애 전체를 나열하지 말고, “왜 이 사람이 정보의 양을 정의하려 했는가”에 필요한 사실만 쓴다.

### 본론 1: 균등한 선택과 Hartley information

균등한 (N)개 가능성을 구별하는 데 필요한 이진 질문 수를 생각한다.

[
N=2^k
\quad\Longrightarrow\quad
k=\log_2N.
]

두 독립적인 선택의 가능성 수가 (N_1N_2)이면

[
\log_2(N_1N_2)
==============

\log_2N_1+\log_2N_2.
]

여기서 로그가 등장하는 이유를 먼저 설명한다.

### 본론 2: 비균등한 사건과 자기정보량

확률 (p)인 사건의 정보량 (I(p))에 다음 조건을 둔다.

[
I(1)=0,
\qquad
I(pq)=I(p)+I(q),
]

그리고 연속성과 단조성을 가정한다.

증명은 다음 치환으로 짧고 엄밀하게 처리할 수 있다.

[
J(t)=I(e^{-t}),\qquad t\geq0.
]

그러면

[
J(s+t)=J(s)+J(t).
]

연속적인 Cauchy 함수방정식의 해는

[
J(t)=ct
]

이므로

[
I(p)=-c\ln p.
]

(I(1/2)=1) bit로 정규화하면

[
\boxed{I(p)=-\log_2p}.
]

여기서 반드시 다음 역사적 주석을 넣는다.

> 이 유도는 자기정보량에 대한 현대적인 공리적 재구성이다. Shannon의 1948년 논문은 개별 사건의 (I(p))보다 분포 전체의 entropy (H(p_1,\ldots,p_n))를 직접 공리화했다.

### 본론 3: Shannon entropy

확률변수 (X)의 실현값 (x)가 주는 자기정보량은

[
I_X(x)=-\log_2p_X(x)
]

이고, 이를 관측하기 전의 평균 정보량은

[
\begin{aligned}
H(X)
&=\mathbb E[I_X(X)]\
&=-\sum_xp_X(x)\log_2p_X(x).
\end{aligned}
]

두 개념을 명확히 분리한다.

| 개념             | 시점         | 값         |
| -------------- | ---------- | --------- |
| 자기정보량 (I_X(x)) | (x)를 관측한 뒤 | 실현값마다 다름  |
| entropy (H(X)) | 관측하기 전     | 분포 전체의 평균 |

### 본론 4: Shannon의 4기호 예시

[
P(A)=\frac12,\quad
P(B)=\frac14,\quad
P(C)=P(D)=\frac18
]

에 대해

[
A\mapsto0,\quad
B\mapsto10,\quad
C\mapsto110,\quad
D\mapsto111
]

를 배정한다.

[
\mathbb E[\ell(X)]
==================

# \frac12(1)+\frac14(2)+\frac18(3)+\frac18(3)

\frac74.
]

한편

[
H(X)
====

# -\sum_xp(x)\log_2p(x)

\frac74.
]

이 예에서는 모든 확률이

[
p(x)=2^{-\ell(x)}
]

꼴인 dyadic probability이므로 entropy와 평균 코드 길이가 정확히 일치한다.

Prefix-free code의 구조는 짧게만 설명한다. 이진트리, Kraft–McMillan 부등식, Huffman 최적성은 별도 글로 넘긴다.

### 본론 5: entropy의 기본 성질

첫 글에서는 다음 세 가지 정도가 적절하다.

1. 비음성

[
H(X)\geq0.
]

2. 퇴화분포에서만 0

[
H(X)=0
\iff
P(X=x_0)=1.
]

3. 유한한 알파벳 (|\mathcal X|=m)에서

[
H(X)\leq\log_2m,
]

등호는 균등분포일 때 성립한다.

최댓값 증명은 KL divergence를 아직 도입하지 않았으므로 Lagrange multiplier나 엄격한 오목성을 이용한다.

[
\frac{\partial^2}{\partial p_i^2}
\left(-p_i\log p_i\right)
=========================

-\frac{1}{p_i}<0.
]

따라서 entropy는 확률 simplex에서 오목하며, 대칭성에 의해 균등분포에서 최대화된다.

Bernoulli entropy

[
h(p)=-p\log_2p-(1-p)\log_2(1-p)
]

의 그래프를 넣으면 이 성질을 시각적으로 정리할 수 있다.

### 본론 6: 압축 해석의 정확한 범위

다음 내용을 “정리 예고” 형식으로 넣는다.

이진 prefix code의 최적 평균 길이를 (L^*)라 하면

[
H(X)\leq L^*<H(X)+1.
]

i.i.d. 블록 (X^n)을 함께 부호화하면

[
H(X)
\leq
\frac{L_n^*}{n}
<
H(X)+\frac1n.
]

따라서

[
\lim_{n\to\infty}\frac{L_n^*}{n}=H(X).
]

이 결과를 통해 다음처럼 정리한다.

> entropy는 개별 기호의 실제 코드 길이가 아니라, 반복되는 정보원을 점근적으로 무손실 부호화할 때 필요한 최소 평균 비트 수이다.

증명은 「Shannon source coding theorem」 글로 넘긴다.

### 결론: 영어와 언어모델로 연결

Shannon이 1951년 인간의 다음 문자 예측을 이용해 영어의 entropy를 추정했다는 사실을 짧게 소개한다.

이때 다음 연결만 제시한다.

[
\text{예측 가능성}
\Longleftrightarrow
\text{짧은 부호 길이}
\Longleftrightarrow
\text{낮은 entropy rate}.
]

Cross-entropy, KL divergence, 언어모델은 뒤 글의 주제이므로 공식까지 전개하지 않는다.

---

## 2. 공부 플로우와 예상시간

| 단계 | 공부할 내용               | 산출물          |        시간 |
| -- | -------------------- | ------------ | --------: |
| 1  | 글의 범위 설정             | 포함·제외 목록     |       30분 |
| 2  | Shannon과 Hartley의 역사 | 5개 사건 타임라인   |     1.5시간 |
| 3  | Shannon 1948 원전 발췌독  | 주장–출처 표      |     2.5시간 |
| 4  | 자기정보량의 공리적 유도        | 직접 쓴 증명 노트   |     1.5시간 |
| 5  | entropy 정의와 성질       | 정의·정리·증명 노트  |       2시간 |
| 6  | 부호화 해석 검증            | 조건과 반례 정리    |       2시간 |
| 7  | 글의 상세 목차 작성          | 문단별 핵심 문장    |       1시간 |
| 8  | 초고 작성                | 7,000~9,000자 | 3.5~4.5시간 |
| 9  | 그래프·이진트리 제작          | 그림 3개        |     1.5시간 |
| 10 | 수식·인용·표현 검수          | 최종 원고        |     1.5시간 |
| 합계 |                      |              |    약 17시간 |

## 3. 구체적인 학습 일정

### 1일차: 역사와 문제 설정 — 4시간

#### 1. Shannon 1948 Introduction 읽기 — 45분

다음 질문에 답하면서 읽는다.

* Shannon은 communication을 어떻게 정의하는가?
* 의미론을 왜 공학적 문제에서 분리하는가?
* 가능한 메시지 수에 로그를 적용하는 이유는 무엇인가?
* bit의 단위는 어떻게 정의되는가?

#### 2. Hartley 1928 확인 — 30분

논문 전체를 정독할 필요는 없다.

* 균등한 (N)개 선택지
* (\log N)이라는 정보 측도
* Shannon이 무엇을 일반화했는가

정도만 파악한다.

#### 3. Shannon의 인물사 조사 — 45분

연대기보다 다음 인과관계를 정리한다.

[
\text{relay circuit}
\rightarrow
\text{Boolean representation}
\rightarrow
\text{통신의 수학적 추상화}
\rightarrow
\text{정보이론}.
]

#### 4. Shannon 1948 §6, §10 읽기 — 1.5시간

* §6: entropy의 세 공리
* §10: 4기호 예시
* Appendix 2: 유일성 증명의 전체 구조만 확인

마지막 30분 동안 도입부를 5문단으로 설계한다.

---

### 2일차: 수학적 핵심 — 5시간

#### 1. 자기정보량 유도 — 1.5시간

다음을 직접 증명한다.

[
I(pq)=I(p)+I(q)
\quad\Longrightarrow\quad
I(p)=-K\log p.
]

특히 연속성 가정이 없으면 병적인 Cauchy 함수가 존재한다는 점까지 이해한다. 본문에는 한 문장만 넣으면 된다.

#### 2. entropy 성질 — 2시간

직접 증명할 항목은 다음과 같다.

* (H(X)\geq0)
* (H(X)=0)의 필요충분조건
* (H(X)\leq\log|\mathcal X|)
* entropy의 오목성
* Bernoulli entropy의 최대점

#### 3. 부호화와의 관계 — 1.5시간

이 단계에서는 다음 구분을 정확히 이해하는 것이 목표다.

* ideal length와 실제 integer code length
* symbol code와 block code
* prefix-free와 uniquely decodable
* dyadic distribution과 일반 분포
* entropy와 entropy rate

---

### 3일차: 작성 — 5~6시간

#### 1. 주장–근거 표 작성 — 40분

| 주장         | 근거           | 위치    |
| ---------- | ------------ | ----- |
| 로그 측도의 역사  | Hartley 1928 | 서론    |
| entropy 공리 | Shannon 1948 | §6    |
| 4기호 예시     | Shannon 1948 | §10   |
| 평균 길이 하한   | MIT 6.441    | Ch. 6 |
| 영어 entropy | Shannon 1951 | 결론부   |

이 표를 먼저 만들면 글을 쓴 뒤 출처를 억지로 붙이는 문제가 줄어든다.

#### 2. 초고 작성 — 4시간

작성 순서는 실제 글의 순서와 다르게 하는 것이 효율적이다.

1. 자기정보량 유도
2. entropy 정의
3. 4기호 예시
4. 기본 성질
5. 부호화 주의사항
6. Shannon 도입부
7. 결론

역사적 도입은 마지막에 쓰는 편이 본문과 정확하게 연결된다.

#### 3. 문체 정리 — 1시간

다음 표현을 제거한다.

* “entropy는 무질서이다”
* “압축 결과는 랜덤이다”
* “(-\log p)는 실제 코드 길이다”
* “Shannon이 자기정보량 공리에서 entropy를 유도했다”
* “영어의 entropy는 정확히 1 bit이다”

---

### 4일차: 그림과 검수 — 2시간

추천 그림은 세 개다.

1. Shannon–Hartley 짧은 타임라인
2. 4기호 prefix tree
3. (-\log_2p)와 Bernoulli entropy 그래프

검수 순서는 다음과 같다.

* 모든 로그의 밑이 일관적인가?
* (p=0)에서 (0\log0=0)을 명시했는가?
* 독립성 또는 i.i.d. 가정을 빠뜨리지 않았는가?
* 평균 길이와 개별 길이를 혼동하지 않았는가?
* Shannon 원전의 전개와 현대적 재구성을 구분했는가?

## 4. 3Blue1Brown 영상은 이렇게 사용

영상의 내용을 본문에서 다시 설명할 필요는 없다. 두 군데만 배치하면 된다.

4기호 예시 뒤:

> 가변길이 부호와 prefix tree가 어떻게 연결되는지 시각적으로 확인하려면 3Blue1Brown의 「Reinventing Entropy」가 특히 유용하다. 여기서는 해당 직관을 반복하기보다 자기정보량과 entropy의 수학적 정의에 집중한다.

글 마지막 Reference:

> 3Blue1Brown, “Reinventing Entropy” — 특히 dyadic probability, prefix tree, fractional bit에 대한 시각적 설명이 좋다.

추천 구간은 다음과 같다.

* 3:29–10:23: 가변길이 부호와 prefix-free code
* 14:47–20:48: (-\log_2p)와 fractional information
* 25:05–29:24: entropy와 압축 한계
* 21:23–24:18: Shannon의 영어 예측 실험

## 5. 이번 글에서 공부하지 않아도 되는 것

범위를 지키기 위해 다음은 뒤 글로 넘기는 것이 좋다.

* Kraft–McMillan 부등식의 정식 증명
* Huffman algorithm의 최적성 증명
* AEP와 typical set
* Shannon source coding theorem의 완전한 증명
* 결합·조건부 entropy와 chain rule
* Cross-entropy와 KL divergence
* entropy rate의 일반 이론
* differential entropy
* Shannon entropy와 알고리즘적 무작위성의 관계

첫 글의 목표는 압축 이론 전체를 설명하는 것이 아니다. 정확한 목표는 다음 명제 하나를 독자가 납득하도록 만드는 것이다.

[
\boxed{
\text{개별 결과의 정보량은 }-\log_2p,\quad
\text{분포의 entropy는 그 평균이다.}
}
]

그리고 “왜 이것이 압축과 관계되는가”를 dyadic 예시와 source coding theorem의 예고를 통해 제한적으로 보여주면 된다.

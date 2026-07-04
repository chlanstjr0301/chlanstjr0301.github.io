---
title: "Credit Creation [1/6]: 은행은 어떻게 돈을 만드는가"   # 필수. 목차와 페이지에 표시되는 제목
date: 2026-07-04T12:00:00+09:00              # 필수. 미래 시각이면 빌드에서 제외되니 주의
tags: [example, template]                    # 선택. 글 하단·태그 페이지에 #태그로 표시
description: "목록에 표시될 한 줄 소개. 없으면 본문 앞부분이 잘려 나가니 꼭 쓰기."
math: true                                   # 수식($, $$) 쓰면 true
toc: true                                    # 글 내 목차. 끄려면 false
draft: true                                  # true면 사이트에 안 올라감. 발행할 때 false로
---
# Introduction
제가 경제학에 대해 처음 관심을 가지게 된 것은 고등학교 1학년 때 "EBS 자본주의" 다큐 시리즈를 봤을 때 였습니다. 자본주의 다큐 1부 "돈은 빚이다"를 보고 굉장히 충격을 먹었던 기억이 아직도 새록새록 합니다. 최근에 해당 다큐멘터리를 다시 봤는데, 신용창조 관련하여 이해가 안되는 부분들이 있어 이에 관해 공부해보고 정리하고자 합니다.

제 문제의식은 다음과 같습니다.
1) 시중은행이 지급준비율만큼의 돈만 남겨두고 돈을 빌려준다면, 화폐시스템에서 가장 중요한 변수는 이자율과 지급준비율일 것이다. 그러나 나는 뉴스에서 한국은행 또는 이에 준하는 정부기관이 지급준비율을 얼마로 정했다는 것을 들어본적조차 없다.
2) 빚은 빚으로 갚아야 하므로 자본주의 사회는 돈을 찍어내는 것을 멈출 수 없다. 성장과 부채의 균형발전이 가장 이상적일 것이다. 그렇다면, 중앙은행의 목표는 물가안정이라기 보다는 물가안정과 경제발전의 균형이여야 하는가.

이에 대한 궁금증을 해결하기 위해 관련 공부를 하며 아래 5개의 글로 "Credit Creation"시리즈를 연재하고자 합니다.

| 순서 | 추천 제목                                               | 부제                                                 |
| -: | --------------------------------------------------- | -------------------------------------------------- |
|  1 | Credit Creation [1/8]: 은행은 어떻게 돈을 만드는가          | *Money Creation in the Modern Economy*로 보는 현대 화폐창조 |
|  2 | Credit Creation [2/8]: 통화승수는 왜 현실을 설명하지 못하는가   | 대출가능자금설, 준비금, 내생화폐 논쟁                              |
|  3 | Credit Creation [3/8]: 화폐는 중앙은행이 만드는가, 은행이 만드는가 | 화폐창조 논쟁의 주요 문헌과 쟁점                                 |
|  4 | Credit Creation [4/8]: 담보가치는 어떻게 신용을 결정하는가      | Kiyotaki–Moore의 *Credit Cycles*                    |
|  5 | Credit Creation [5/8]: 작은 충격은 왜 큰 경기변동이 되는가     | Bernanke–Gertler–Gilchrist의 금융가속기                  |


본 글은 McLeay, Radia & Thomas, "Money Creation in the Modern Economy"를 읽고 독자의 이해를 돕기 위한 저만의 해설을 덧붙인 글입니다.[^McLeay-2014] 영란은행은 학술적 목적으로 자료에 대한 재사용을 허가하고 있으므로, 본 글에서는 위 자료의 사진을 이용하였습니다.[^BOE-legal]

# McLeay, Radia & Thomas, “Money Creation in the Modern Economy”
## Two misconceptions about money creation
EBS의 다큐멘터리 시리즈 "자본주의"를 보면 은행이 단순히 중개자로서 저축자들이 맡긴 예금을 빌려준다는 오해에 대해 다루고 있습니다. 실제로는 대출 행위가 예금을 창조하기 대문입니다.[^ebs-capitalism]

가계가 은행 계좌에 돈을 더 저축하기로 하면 은행이 대출해줄 수 있는 가용 자금을 늘리는 것 같이 느껴집니다. 그러나 여러분이 저축하지 않았더라면 이는 재화와 서비스의 대금으로 기업으로 가고 이는 다시 은행으로 오게 됩니다. 은행을 단순 중개자로 보는 관점은 현대 경제의 현실에서 상업은행이 예금화폐의 창조자라는 사실을 간과하는 것입니다. 대출행위가 통화량을 늘리고, 대중이 보유한 화폐의 압도적 대부분은 은행예금의 형태를 띱니다. 즉, **대출 행위가 예금을 창조**합니다. 이것이 첫번째 오해에 대한 부분입니다.

다큐멘터리에서는 중앙은행이 중앙은행 화폐의 양을 통제함으로써 경제 내 대출과 예금의 양을 결정한다는 것입니다. 이는 이른바 통화승수(money multipiler) 접근이라고 합니다. 이 이론이 성립하려면, 지급준비금의 양이 대출에 대한 구속적 제약(binding constraint)이어야 하고, 중앙은행이 지급준비금의 양을 직접 결정하여야 합니다. 이에 관해 자세히 설명 해보겠습니다.

화폐창조를 설명할 때 가장 먼저 등장하는 모형은 교과서적 통화승수 모형입니다. 이 모형은 본원통화와 광의통화 사이에 일정한 비례관계가 존재한다고 가정합니다.

본원통화를 (H), 광의통화를 (M), 민간이 보유한 현금을 (C), 은행의 지급준비금을 (R), 예금을 (D)라고 하면 다음과 같이 쓸 수 있습니다.

$$
H = C + R
$$

$$
M = C + D
$$

여기서 각 기호의 의미는 다음과 같습니다.

* (H): 본원통화, 즉 중앙은행이 직접 발행한 화폐입니다.
* (M): 광의통화, 즉 민간이 보유한 현금과 예금을 포함한 넓은 의미의 통화량입니다.
* (C): 비은행 민간이 보유한 현금입니다.
* (R): 은행의 지급준비금입니다. 이는 중앙은행 예치금과 은행 시재금을 포함하는 개념으로 이해할 수 있습니다.
* (D): 은행예금입니다.

민간의 현금-예금 비율을

$$
c = \frac{C}{D}
$$

은행의 준비금-예금 비율을

$$
\rho = \frac{R}{D}
$$

라고 두면, 본원통화와 광의통화는 다음과 같이 정리됩니다.

$$
H = C + R = cD + \rho D = (c+\rho)D
$$

$$
M = C + D = cD + D = (1+c)D
$$

따라서 통화승수 (m)은 다음과 같습니다.

$$
m = \frac{M}{H}
= \frac{1+c}{c+\rho}
$$

이 식이 교과서적 통화승수 모형의 기본 형태입니다.

특수하게 민간이 현금을 보유하지 않고,

$$
C = 0
$$

초과지급준비도 없으며, 지급준비율이 (r)이라고 가정하면

$$
c = 0, \qquad \rho = r
$$

이므로 통화승수는 다음과 같이 단순화됩니다.

$$
m = \frac{1}{r}
$$

예를 들어 지급준비율이 10%라면

$$
m = \frac{1}{0.1} = 10
$$

입니다. 이 경우 교과서적 모형에서는 중앙은행이 지급준비금 100을 추가로 공급하면 예금은 최대 1,000까지 증가할 수 있다고 설명합니다.

$$
\Delta D = \frac{1}{r}\Delta R
$$

$$
\Delta D = \frac{1}{0.1} \times 100 = 1{,}000
$$

따라서 이 모형의 핵심 논리는 다음과 같이 요약됩니다.

$$
\Delta R
\rightarrow
\Delta D
\rightarrow
\Delta L
$$

즉 중앙은행이 지급준비금을 늘리면 은행의 대출 여력이 증가하고, 은행대출이 반복적으로 예금을 만들어 광의통화가 증가한다는 설명입니다.

그러나 이 논리가 현실에서 작동하려면 중요한 조건이 필요합니다. 첫째, 지급준비금이 은행대출의 구속적 제약이어야 합니다. 둘째, 중앙은행이 지급준비금의 양을 직접 고정해야 합니다. Bank of England의 *Money Creation in the Modern Economy*도 통화승수 이론이 성립하려면 지급준비금이 대출의 구속적 제약이어야 하며, 중앙은행이 지급준비금의 양을 직접 결정해야 한다고 설명합니다. 그러나 동시에 현대 경제에서는 이 두 조건이 강하게 성립하지 않는다고 지적합니다. 

현실에서 은행은 단순히 기존 예금을 받아 그것을 다시 빌려주는 기관이 아닙니다. 은행이 대출을 실행하면 동시에 차입자의 예금계좌에 예금이 생깁니다. 즉 대출이 예금을 만듭니다. Bank of England는 현대 경제에서 대부분의 화폐가 상업은행의 대출을 통해 창조되며, 은행은 예금을 먼저 받은 뒤 이를 대출하는 단순 중개기관이 아니라고 설명합니다. 

은행의 대차대조표로 보면 이 과정은 다음과 같습니다.

은행이 (L)만큼 대출을 실행하면 은행의 자산에는 대출이 증가합니다.

$$
\Delta \text{Loans} = +L
$$

동시에 은행의 부채에는 차입자의 예금이 증가합니다.

$$
\Delta \text{Deposits} = +L
$$

따라서 은행대출은 다음과 같은 회계적 효과를 가집니다.

$$
\Delta \text{Loans} = \Delta \text{Deposits}
$$

이 점에서 현실의 화폐창조 순서는 교과서적 통화승수 모형과 다릅니다. 교과서적 설명은 대체로 다음 방향을 가정합니다.

$$
R \rightarrow D \rightarrow L
$$

반면 현대 은행제도에서는 다음 순서가 더 현실적입니다.

$$
L \rightarrow D \rightarrow R^d
$$

은행이 먼저 수익성 있는 대출기회를 보고 대출을 실행합니다. 그 결과 예금이 생깁니다. 이후 지급결제, 현금인출, 유동성 규제 등을 충족하기 위해 은행의 지급준비금 수요가 결정됩니다. Bank of England는 은행이 대출 규모를 먼저 결정하고, 그 결과 예금이 창출되며, 필요한 중앙은행화폐 수요는 이후 발생한다고 설명합니다. 

따라서 현대 통화정책에서 중앙은행은 일반적으로 지급준비금의 양을 직접 고정해 광의통화를 조절하지 않습니다. 중앙은행은 주로 단기금리, 즉 지급준비금의 가격을 설정합니다. Bank of England는 중앙은행이 지급준비금의 양이 아니라 지급준비금의 가격, 곧 금리를 설정함으로써 통화정책을 수행한다고 설명합니다. 

이와 같은 관점은 다른 문헌에서도 확인됩니다. Carpenter and Demiralp는 미국 자료를 분석하면서 지급준비금, 통화량, 은행대출 사이의 관계가 표준 통화승수 모형이 제시하는 강한 기계적 관계와 맞지 않는다고 지적합니다. 특히 금융위기 이후 지급준비금이 크게 증가했음에도 은행대출과 통화량이 단순 승수식으로 증가하지 않았다는 점은 통화승수 모형의 현실 설명력이 제한적임을 보여줍니다. ([연방준비제도][1])

Disyatat 역시 전통적 은행대출경로가 지급준비금 또는 예금의 양적 변화에 지나치게 초점을 맞추고 있다고 비판합니다. 그는 통화정책의 핵심이 은행의 대차대조표, 자금조달비용, 위험인식, 대출조건을 통해 작동한다고 봅니다. 이는 단순한 지급준비금 공급 증가가 곧바로 대출 증가로 이어진다는 통화승수적 설명과 다릅니다. ([BIS][2])

따라서 교과서적 통화승수 모형은 완전히 무의미한 모형이라기보다, 특정한 제도적 가정 아래에서 성립하는 교육용 모형으로 보는 것이 적절합니다. 이 모형은 본원통화, 지급준비금, 예금, 광의통화의 회계적 관계를 이해하는 데에는 유용합니다. 그러나 현대 은행제도에서 실제로 화폐가 창조되는 인과방향을 설명하기에는 한계가 있습니다.

정리하면 다음과 같습니다.

$$
\text{교과서적 통화승수 모형}
:
R \rightarrow D \rightarrow L
$$

$$
\text{현대 은행제도}
:
L \rightarrow D \rightarrow R^d
$$

교과서적 모형에서는 중앙은행이 지급준비금을 공급하면 은행이 이를 바탕으로 예금과 대출을 승수적으로 늘린다고 설명합니다. 그러나 현실에서는 은행이 먼저 대출을 실행하고, 그 결과 예금이 창출됩니다. 이후 필요한 지급준비금 수요가 발생하며, 중앙은행은 일반적으로 지급준비금의 양보다 금리를 통해 통화정책을 수행합니다.

그러므로 통화승수 모형의 핵심 한계는 다음 한 문장으로 요약할 수 있습니다.

$$
\boxed{
\text{통화승수 모형은 회계적 관계를 보여주지만, 현대 화폐창조의 인과방향을 정확히 설명하지는 못합니다.}
}
$$

## References

* McLeay, M., Radia, A., & Thomas, R. (2014). **Money Creation in the Modern Economy**. *Bank of England Quarterly Bulletin*, 2014 Q1.
* Carpenter, S. B., & Demiralp, S. (2010). **Money, Reserves, and the Transmission of Monetary Policy: Does the Money Multiplier Exist?** Finance and Economics Discussion Series, Federal Reserve Board. ([연방준비제도][1])
* Disyatat, P. (2010). **The Bank Lending Channel Revisited**. BIS Working Papers No. 297. ([BIS][2])
* Ihrig, J. E., Weinbach, G. C., & Wolla, S. A. (2021). **Teaching the Linkage Between Banks and the Fed: R.I.P. Money Multiplier**. Federal Reserve Bank of St. Louis. ([stlouisfed.org][3])

[1]: https://www.federalreserve.gov/pubs/feds/2010/201041/201041pap.pdf?utm_source=chatgpt.com "Money, Reserves, and the Transmission of Monetary Policy"
[2]: https://www.bis.org/publ/work297.pdf?utm_source=chatgpt.com "The bank lending channel revisited"
[3]: https://www.stlouisfed.org/publications/page-one-economics/2021/09/17/teaching-the-linkage-between-banks-and-the-fed-r-i-p-money-multiplier?utm_source=chatgpt.com "Teaching the Linkage Between Banks and the Fed"



여러분은 중앙은행이 지급준비금의 양을 결정했다는 소식을 들어보신적이 있으신가요. 아마 없을겁니다. 현실에서는 지급준비금이 대출에 대한 구속적 제약도 아니고, 중앙은행이 가용 지급준비금의 양을 고정하지도 않습니다. 

은행은 먼저 자신에게 열려 있는 수익성 있는 대출 기회에 따라 대출 규모를 결정하는데, 이는 결정적으로 영란은행이 설정한 금리에 달려 있습니다. 은행 시스템이 얼마나 많은 예금을 창조하는지를 결정하는 것이 대출 결정들입니다. 예금의 양은 다시 은행들이 지급준비금으로 보유하고자 하는 중앙은행 화폐의 양에 영향을 주는데

## Money creation in reality

## QE-creating broad money directly with monetary policy

## The link between QE and quantitles of money

## Two misconceptions about how QE works

## Conclusion


# reference
[^McLeay-2014]: McLeay, Michael and Radia, Amar and Thomas, Ryland, Money Creation in the Modern Economy (March 14, 2014). Bank of England Quarterly Bulletin 2014 Q1, Available at SSRN: https://ssrn.com/abstract=2416234

[^BOE-legal]: Rules for using material from our website, Legal, Bank of England: https://www.bankofengland.co.uk/legal

[^ebs-capitalism]: EBS 다큐프라임 자본주의 제1부 돈은 빚이다: https://www.youtube.com/watch?v=0LYMTsj_eqc




사용한 그림 저작권 관련:
영란 은행의 copyright 공시중
You may (and unless otherwise specifically stated, such as in the case of the Rulebook and the Database, where terms concerning re-use are set out below at ‘PRA Rulebook’ and ‘Bank of England Database’ respectively) download, display or print the Resources for personal use or internal use within an individual organisation for non-commercial purposes.

부분에 따라 자료의 사진을 블로그 글에 출처를 밝히고 사용하였음


McLeay, Michael and Radia, Amar and Thomas, Ryland, Money Creation in the Modern Economy (March 14, 2014). Bank of England Quarterly Bulletin 2014 Q1, Available at SSRN: https://ssrn.com/abstract=2416234
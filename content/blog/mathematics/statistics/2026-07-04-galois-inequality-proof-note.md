---
title: "증명 노트 — Galois 부등식"
date: 2026-07-04T13:00:00+09:00
tags: [statistics, proof-note]
description: "Q-Q Plot 글 Theorem 1(Galois 부등식)의 증명 전문: φ(u) ≤ x ⟺ u ≤ F(x)를 6단계로 증명한다."
authors: [munseok, suyeonnnh]
math: true
toc: true
draft: false
---

[Q-Q Plot](/blog/mathematics/statistics/2026-07-04-q-q-plot/) 글 **Theorem 1 (Galois 부등식)** 의 증명 전문이다. 임의의 $u \in (0,1)$, $x \in \mathbb{R}$에 대해

$$\varphi(u) \le x \iff u \le F(x).$$

## Step 1. Existence of $$\varphi(u)\in\mathbb{R}$$

Let $A_u:=\{x\in\mathbb{R}:F(x)\ge u\}.$

We want to show that $\varphi(u):=\inf A_u$ exists as a real number.

It is enough to show that $A_u$ is nonempty and bounded below. Then, by the completeness property of $$\mathbb{R}$$, $$\inf A_u\in\mathbb{R}$$ exists.

**1) $A_u$ is nonempty set**

Suppose $\lim_{x\to\infty}F(x)=1$ and $0<u<1.$

Since $u<1$, we have $1-u>0$

By the definition of the limit

$$
\lim_{x\to\infty}F(x)=1,
$$

for $$\varepsilon=1-u>0$$, there exists $$M\in\mathbb{R}$$ such that

$$
x\ge M \implies |F(x)-1|<1-u.
$$

Hence, for all $$x\ge M$$,

$$
F(x)>1-(1-u)=u.
$$

Therefore,

$$
F(x)>u,
$$

so in particular,

$$
F(x)\ge u.
$$

Thus $A_u\neq\varnothing$

**2) $A_u$ is bounded below**

Suppose

$$
\lim_{x\to-\infty}F(x)=0
$$

and

$$
0<u<1.
$$

Since $$u>0$$, we may take

$$
\varepsilon=u>0.
$$

By the definition of the limit

$$
\lim_{x\to-\infty}F(x)=0,
$$

there exists $$m\in\mathbb{R}$$ such that

$$
x\le m \implies |F(x)-0|<u.
$$

Since $$F(x)\ge 0$$, this implies

$$
x\le m \implies F(x)<u.
$$

Therefore, no $$x\le m$$ can belong to $$A_u$$, because elements of $$A_u$$ must satisfy

$$
F(x)\ge u.
$$

Hence, if $$x\in A_u$$, then

$$
x>m.
$$

Thus $$m$$ is a lower bound of $$A_u$$. Therefore,

$$
A_u \text{ is bounded below}.
$$

**3) Conclusion**

We have shown that $A_u\neq\varnothing$ and $A_u \text{ is bounded below}.$ 
Therefore, by the completeness property of $$\mathbb{R}$$, the infimum

$$
\inf A_u
$$

exists in $$\mathbb{R}$$.

Hence,

$$
\varphi(u)=\inf\{x\in\mathbb{R}:F(x)\ge u\}
$$

is well-defined and satisfies

$$
\varphi(u)\in\mathbb{R}.
$$


## Step 2. $A_u$ is upward closed

**WTS: If $$x\in A_u$$ and $$x'>x$$, then $$x'\in A_u$$.**

Suppose

$$
x\in A_u
$$

and

$$
x'>x.
$$

Since $$x\in A_u$$, by the definition of $$A_u$$,

$$
F(x)\ge u.
$$

Also, since $$F$$ is nondecreasing and $$x'>x$$, we have

$$
F(x')\ge F(x).
$$

Therefore,

$$
F(x')\ge F(x)\ge u.
$$

Hence,

$$
F(x')\ge u,
$$

so by the definition of $$A_u$$,

$$
x'\in A_u.
$$

Thus $$A_u$$ is upward closed.

## Step 3. $x > \varphi(u) \implies x \in A_u$

We want to show that

$$
x>\varphi(u) \implies x\in A_u.
$$

Suppose

$$
x>\varphi(u).
$$

Since

$$
\varphi(u)=\inf A_u,
$$

we have

$$
x>\inf A_u.
$$

Let

$$
\varepsilon:=x-\varphi(u)>0.
$$

By the $$\varepsilon$$-characterization of the infimum, there exists some

$$
a\in A_u
$$

such that

$$
\varphi(u)\le a<\varphi(u)+\varepsilon.
$$

Since

$$
\varphi(u)+\varepsilon = \varphi(u)+x-\varphi(u)= x
$$

we obtain

$$
\varphi(u)\le a<x.
$$

Hence,

$$
a\in A_u
$$

and

$$
x>a.
$$

Since $$A_u$$ is upward closed, it follows that

$$
x\in A_u.
$$

Therefore,

$$
x>\varphi(u)\implies x\in A_u.
$$

## Step 4. $F(\varphi(u)) \ge u$, 즉 $\varphi(u) \in A_u$[^Bartle-326] [^Bartle-432] [^Bartle-561]

We want to show that

$$
F(\varphi(u))\ge u.
$$

Equivalently, we want to show that

$$
\varphi(u)\in A_u.
$$

Define a sequence $$(x_n)$$ by

$$
x_n:=\varphi(u)+\frac{1}{n}.
$$

Then, for every $$n\in\mathbb{N}$$,

$$
x_n>\varphi(u).
$$

By Step 3, we have

$$
x_n\in A_u
$$

for every $$n\in\mathbb{N}$$.

By the definition of $$A_u$$, this means that

$$
F(x_n)\ge u
$$

for every $$n\in\mathbb{N}$$.

We record this inequality as

$$(1)\qquad F(x_n)\ge u.$$

Also, since

$$
x_n=\varphi(u)+\frac{1}{n},
$$

we have

$$
x_n>\varphi(u)
$$

for every $$n\in\mathbb{N}$$, and

$$
x_n\to \varphi(u).
$$

In other words, $$(x_n)$$ approaches $$\varphi(u)$$ from the right.

Since $$F$$ is right-continuous at $$\varphi(u)$$, it follows that

$$
\lim_{n\to\infty}F(x_n)=F(\varphi(u)).
$$

Now, by (1), the sequence $$(F(x_n))$$ satisfies

$$
F(x_n)\ge u
$$

for every $$n\in\mathbb{N}$$.

By the order limit theorem, inequalities are preserved under limits. Therefore,

$$
\lim_{n\to\infty}F(x_n)\ge u.
$$

Since

$$
\lim_{n\to\infty}F(x_n)=F(\varphi(u)),
$$

we obtain

$$
F(\varphi(u))\ge u.
$$

Therefore, by the definition of $$A_u$$,

$$
\varphi(u)\in A_u.
$$

## Step 5. $$A_u=[\varphi(u),\infty)$$

We want to show that

$$
A_u=[\varphi(u),\infty).
$$

We prove the two inclusions separately.

**1) $$[\varphi(u),\infty)\subseteq A_u$$**

Let

$$
x\in[\varphi(u),\infty).
$$

Then

$$
x\ge \varphi(u).
$$

There are two cases.

First, suppose

$$
x=\varphi(u).
$$

By Step 4, we have

$$
\varphi(u)\in A_u.
$$

Hence,

$$
x\in A_u.
$$

Second, suppose

$$
x>\varphi(u).
$$

By Step 3, we have

$$
x\in A_u.
$$

Therefore, in both cases,

$$
x\in A_u.
$$

Hence,

$$
[\varphi(u),\infty)\subseteq A_u.
$$

**2) $$A_u\subseteq[\varphi(u),\infty)$$**

Let

$$
x\in A_u.
$$

Since

$$
\varphi(u)=\inf A_u,
$$

the number $$\varphi(u)$$ is a lower bound of $$A_u$$.

Therefore, every element of $$A_u$$ is greater than or equal to $$\varphi(u)$$. Hence,

$$
\varphi(u)\le x.
$$

Thus,

$$
x\in[\varphi(u),\infty).
$$

Therefore,

$$
A_u\subseteq[\varphi(u),\infty).
$$

Combining the two inclusions, we obtain

$$
A_u=[\varphi(u),\infty).
$$

## Step 6. Completion of the equivalence

We want to prove that

$$
\varphi(u)\le x \iff u\le F(x).
$$

First, observe that

$$
\varphi(u)\le x
$$

is equivalent to

$$
x\in[\varphi(u),\infty).
$$

By Step 5, we have

$$
[\varphi(u),\infty)=A_u.
$$

Therefore,

$$
x\in[\varphi(u),\infty)
\iff
x\in A_u.
$$

By the definition of $$A_u$$,

$$
x\in A_u
\iff
F(x)\ge u.
$$

Equivalently,

$$
F(x)\ge u
\iff
u\le F(x).
$$

Combining these equivalences, we obtain

$$
\varphi(u)\le x
\iff
x\in[\varphi(u),\infty)
\iff
x\in A_u
\iff
u\le F(x).
$$

Therefore,

$$
\varphi(u)\le x \iff u\le F(x).
$$

$$
\blacksquare
$$

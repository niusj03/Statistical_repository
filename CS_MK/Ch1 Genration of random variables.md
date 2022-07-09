[toc]



* Given a theoretical density function $f (\cdot)$ or a cdf $F(\cdot)$, we want to generate a random sample $x_1,...,x_n$ from $f(\cdot)$ or $F(\cdot)$, which is the topic of chapter1.
* Aims of this chapter
  * Introduce some basic Monto Carlo simulation techniques for ==generating random samples== from univariate and multivariate distributions ==with known parameters==
  * Assuming that ==random number or r.v.s uniformly distributed in the unit interval $(0,1)$ can be satisfactorily produced== on the computer

# 1.1 The Inversion Method

## Generating samples from continuous distribution

### A basic result

* Let $X$ be an r.v. with cdf $F(\cdot)$. Note that $F(\cdot)$ is a non-decreasing function, the inverse function $F^{-1}(\cdot)$​ can be defined by

$$
F^{-1}(u)=inf\{x:F(x)\geq u\},{\;}{\;}u\in(0,1)
$$

* If $U\sim U(0,1)$​, then $F(X)=U\sim U(0,1)$​ 

  which is equivalent to $X=F^{-1}(U)\sim F(x)$​ 

### ==The inversion method (Algorithm)==

* Step 1: Draw $U=u$ from $U(0,1)$ ==生成随机数的过程==

* Step 2: Return $x=F^{-1}(u)$​

### Several examples

* Exponential distribution

* Standard Laplace distribution

* Weibull distribution

* Cauchy distribution

  * $(arctan{\;}x)'=\frac{1}{1+x^2}$
  * $ (arctan{\;}(\frac{x-\mu}{\sigma}))'=\frac{1}{\sigma\{1 +(\frac{x-\mu}{\sigma})^2\}}$

  

### Comments 

* If $F^{-1}(\cdot)$ is not available analytically, the inversion method may not be efficient.

## Generating sample from discrete distribution

### Basic idea

* Aim: suppose that we want to generate a random number from a discrete r.v. X with pmf:
  $$
  Pr(X=x_i)=p_i,{\;}{\;}p_i>0,{\;}{\;}i=1,...,d,{\;}{\;}\sum_{i=1}^d p_i=1
  $$
  where $d$ is finite or $+\infty$.

  * ==We write $X\sim FDiscrete_d(\{x_i\},\{p_i\})$ when $d$ is finite.==

* The cdf of $X\sim FDiscrete_d(\{x_i\},\{p_i\})$ is
  $$
  Pr(X\leq x)=\sum_{x_i\leq x}p_i=
  \begin{cases}
  0 {\;}{\;}{\;}if{\;}x<x_1 \\
  p_1{\;}{\;}{\;}if{\;}x_1\leq x<x_2\\
  p_1+p_2{\;}{\;}{\;}if{\;}x_2\leq x<x_3\\\\
  \vdots\\
  p_1+p_2+\cdots+p_{d-1} {\;}{\;}{\;}if{\;}x_{d-1}\leq x<x_d\\
  1 {\;}{\;}{\;}if{\;}x\geq x_d
  \end{cases}
  $$
  
* ==Method:== To this end, we first generate a random number $U=u\sim U(0,1)$​, and then set

$$
X=x=\begin{cases}
x_1,{\;}if{\;}u<p_1 \\
x_2,{\;}if{\;}p_1\leq u<p_1+p_2 \\
{\;}\vdots \\
x_{d-1},{\;}if{\;} \sum_{i=1}^{d-2}p_j\leq u<\sum_{i=1}^{d-1} p_j\\
x_d,if{\;} \sum_{i=1}^{d-1}p_i\leq u<1
\end{cases}
$$

### ==The algorithm==

* Step 1: Draw $U=u$ from $U(0,1)$

* Step 2: If $u<p_1$, set $X=x_1$​ and stop

  ​             If $u<p_1+p_2$, set $X=x_2$​ and stop

  ​             $\vdots$

  ​             If $u<\sum_{j=1}^{d-1} p_j$​​, set $X=x_{d-1}$​​​​ and stop 

  ​             if $u<1$, set $X=x_d$ and stop

* Remarks 
  * Let $F$ denote the cdf of the r.v. $X$.
  * If $\{x_i,i\geq 1\}$​ are ordered as $x_{(1)}<x_{(2)}<\cdots$​ and the corresponding prob. $Pr\{X=x_{(i) }\}$​ is denoted by $p_{(i)}$​, then $F(x_{(i)})=\sum_{j=1}^ip_{(j)}$​​.
  * So $X=x_{(i)}$​ if $F(x_{(i-1)})\leq U < F(x_{(i)})$​

### The most efficient procedure

* * The most efficient procedure is to rearrange $\{x_i,i\geq1 \}$ as $\{x_1',x_2'...\}$ such that $\{p_1'\geq p_2'\geq \cdots\}$​​
  * Then if $U<p_1'$, set $X=x_1'$ and stop
  * If $U<p_1'+p_2'$, set $X=x_2'$ and stop;...

* Theoretical justification

  * Note that $U\sim U(0,1)$

  * For $0<a<b<1$​ we have $Pr(a\leq U\leq b)=b-a$. Then 
    $$
    Pr(X=x_i)=Pr(\sum_{j=1}^{i-1}p_j\leq U<\sum_{j=1}^ip_j)=p_i,{\;}{\;}i\geq1
    $$

### Several examples

* Finite discrete distribution

* Poisson distribution

  ==The algorithm is as follows==

  * Step1: generate $U=u$ from $U(0,1)$
  * Step2: Let $i=0,p=p_0$ and $F=p$
  * Step3: If $u<F$, set $X=i$ and stop
  * Step4: Otherwise, let $p\leftarrow p\lambda/(i+1), F\leftarrow F+p,i\leftarrow i+1$ and go back to Step3

* Binomial distribution

## Summary

* A key result: If X has continuous cdf $F(\cdot)$, then $F(X)\sim U(0,1)$

Drawback 

# 1.2 The Grid Method

* Let $X\sim f(x)$​ be a continuous r.v. with ==finite support== $S_X=[a,b]$​
* To genweate $X$​, we first select a set of appropriate grid points $\{x_i\}_{i=1}^d$​, that ==cover== the support $S_x$​​, and then approximate the pdf $f(x)$ by a discrete distribution at $\{x_i\}_{i=1}^d$ With prob.

$$
p_i=\frac{f(x_i)}{\sum_{j=1}^d f(x_j)},{\;}{\;}i=1,...,d
$$

* In other words, we have $X\sim FDiscrete_d(\{x_i\},\{p_i\})$​

* To generate

* How to choose the grid points in practice

  * Let $S_X=[a,b]$, we may select the equal-space grid points
    $$
    x_i=a+\frac{i(b-a)}{d}
    $$
    
  * When $d \rightarrow +\infty$, $\{x_i\}_{i=1}^d$ cover the whole interval $[a,b]$
  
* w

# 1.3 The rejection Method/ acceptance-rejection(AR) method

## Generating samples from continuous distributions

* Basic idea of the rejection method

  * Background: If ==direct sampling from the target density $f(x)$ with support $S_X$ is very difficult or inefficient==, but the sampling from another density $g(x)$ having ==same support $S_X$== is relatively easy.

  * We can ==transfer the **target density** to the **surrogate density** $g(\cdot)$ by first sampling from $g(\cdot)$== and ==adjusting the generated samples s.t. part of them become i.i.d samples of $f(x)$.==

* Formulation

  * Aim: draw random samples from the **target density** $f(x)$, $x\in S_X$

  * ==Condition==: if we can find some ==envelope constant== $c(c\geq1)$ and an ==envelope density== $g(x)$ having ==the same support== $S_X$ s.t. $f(x)$ ==minorities== $cg(x)$; i.e.
    $$
    f(x)\leq cg(x){\;}{\;}{\;}{\;}\forall x\in S_X
    $$
      then we can apply the following procedure to generate i.i.d samples from $f(x)$.

  * Method

    * Step 1: Draw $U\sim U(0,1)$ and independently draw $Y\sim g(\cdot)$: using ==inverse method==
    * Step 2: ==If $U\leq f(Y)/\{cg(Y)\}$==, return $X=Y$; otherwise, go to Step 1

* Understand the AR algorithm

  * Adjustor/调整器

    * Let $X\sim f(\cdot)$, $Y\sim g(\cdot)$ and $Y_1,...,Y_n\sim^{i.i.d}g(\cdot)$. Furthermore, we define
      $$
      h(\cdot)=\frac{f(\cdot)}{cg(\cdot)} \tag{1.3}
      $$
      which is called the ==adjustor==

    * The samples $\{Y_i\}_{i=1}^n$ can be divided into two groups: say $\{Y_i\}_{i=1}^m$ and $\{Y_i\}_{i=m+1}^n$ s.t. $\{U_i\leq h(Y_i)\}_{i=1}^m$ while $\{U_i>h(Y_1)\}_{i=m+1}^n$, where $U_1,...,U_n\sim^{i.i.d}U(0,1)$
    * Thus, we return $X_i=Y_i$ for $i=1,...,m$. That is $Y_1,...,Y_m\sim^{i.i.d} f(\cdot)$

  * Understand of step 2

    * $f(Y),g(Y)$ and $h(Y)$ are three r.v.'s

    * The adjustor $h(Y)$ is independent of the $U$

    * The adjustor should be bounded between 0 and 1,i.e.
      $$
      0\leq h(Y) \leq 1 \tag{1.4}
      $$
      
    * Step2 indicates that $X$ has the conditional distribution density of $Y|\{U\leq h(Y)\}$ evaluated at $Y=x$, i.e.
      $$
      f(x)=f_Y(x|U\leq h(Y)) \tag{1.5}
      $$

### Theoretical justification of the AR algorithm

* According to the Bayes Theorem 
  $$
  f_Y(x|B)=Pr(B|x)f_Y(x)/Pr(B)
  $$

* From $(1.3)$, we have
  $$
  h(x)g(x)=\frac{1}{c}f(x) \tag{1.6}
  $$
  Then we have (note that $f_y(x)=g(x)$)
  $$
  f_Y(x|U\leq h(Y))=\frac{Pr(U\leq h(Y)|Y=x)g(x)}{Pr(U\leq h(Y))} \tag{1.7}
  $$

* Since Y is independent of U, we have
  $$
  Pr\{U\leq h(Y)|Y=x \}=Pr\{U\leq h(x)|Y=x \}=Pr\{U\leq h(x) \}=h(x)\tag{1.9}
  $$

  $$
  Pr\{U\leq h(Y) \}=\int_{S_x}Pr\{U\leq h(Y)|Y=x \}g(x) dx
  =\int_{S_x}h(x)g(x)dx
  =\int_{S_x}\frac{1}{c}f(x)dx=\frac{1}{c} \tag{1.10}
  $$

* Therefore, $(1.7)$ becomes $f_Y(x|U\leq h(Y))=f(x)$, implying $(1.5)$

## The efficiency of the rejection method

* ==Acceptance probability== 
  
  * Form $(1.10)$, the efficiency of the jection method is determined by the acceptance probability $\frac{1}{c}$
  * Thus, a small $c$ will result in a better rejection method
  
* Determination of c

  * ==Theorem==: c can be determined by maximizing the ratio of $f(x)$ over $g(x)$

  $$
  c=max_{x\in S_x}\frac{f(x)}{g(x)} \tag{1.11}
  $$

  * Motivation

    We have to fina a $c$ such that
    $$
    \frac{f(Y)}{g(Y)}\leq c\tag{1.12}
    $$
    $(1.11)$ is a sufficient condition of $(1.12)$

  * If we have found a $c$ satisfying $(1.12)$, then, for any $c^*\geq 1$, we obtain
    $$
    \frac{f(Y)}{g(Y)}\leq c\leq c\cdot c^*\hat{=}c_1
    $$
    we find many $c_1's$ to satisfy $(1.12)$. ==We prefer a smaller $c$==

* The optimal c

  We usually consider a family of envelope densities indexed by $\theta$, say $\{g_{\theta}(x):\theta \in \Theta \}$, as the candidate envelops 

  * Define 
    $$
    c_\theta=max_{x\in S_x}\frac{f(x)}{g_\theta(x)}=\frac{f(\hat{x})}{g_\theta (\hat{x})}\tag{1.13}
    $$
    where $\hat{x}$ is the ==mode== of the function $\frac{f(x)}{g_\theta (x)}$, i.e.
    $$
    \hat{x}=arg{\;}max_{x\in S_x}\frac{f(x)}{g_\theta (x) }
    $$

* Since $log(\cdot)$ is a monotonic increasing function, we have that both $h(\cdot)$ and $ log\{h(\cdot) \}$ share the mode.
  
  Thus we can also consider
  $$
  \hat{x}=arg{\;}max_{x \in S_X} \{log f(x)-log g_\theta (x) \}
  $$
  
* Then the optimal c is $c_{opt}=min_{\theta \in \Theta}c_\theta$

### Remark 

* The normalizing constant of $f(\cdot)$ is not necessary to be known (the envelop constant will contain this)
* This property is particularly important in Bayesian calculations

### Expectation iteration number



* Let $N$ be the number of iterations in the AR algorithm, i.e., the number of pairs $(U,V)$ Required bedore

  Then $N$ has a geometric distribution 
  $$
  Pr(N=n)=p(1-p)^{n-1},n=1,\cdots,\infty
  $$

* The expected number of iterations until one sample is accpeted is $E(N)=\frac{1}{p}=c$



### ==The rejection Method== 

The rejection method is as follows

* Step1: Draw $V\sim U(0,1)$ and independently draw $Y\sim g_1(\cdot)$
* Step2: If $V\leq \frac{f(Y)}{c_{opt}g_1(Y)}$, return $X=Y$; Otherwise, go to step1

The acceptance probability is $\frac{1}{c}$

## Examples 

* Gamma distribution
* Generating normal distribution from Laplace distribution
  * $(|x|)'=sgn(x)$
* ==Generating normal distribution from Cauchy distribution==

* Truncated univariated normal distribution 

## Log-concave density

* Definition

  We say a pdf $f(x)$ is log-concave if its log is concave, i,e, $\frac{d^2 log\{f(x) \}}{dx^2}\leq0$









## Summary 

* Requirements for the AR method:

  * Required to find an envelope density $g(x)$ satisfying:

    * Has the same support as $f(x)$
    * Has a ==large variance/ dispersion== than $f(x)$
    * Easy to draw a sample from $g(x)$

  * Required to find an envelop constant (has two types)

    * $$
      c=max_{x\in S_x}\frac{f(x)}{g(x)}\tag{1.14}
      $$

    * $$
      c_{opt}=min_{\theta \in \Theta}max_{x\in S_X}\frac{f(x)}{g_{\theta}(x)} \tag{1.14}
      $$

* Merits 
  * Generate i.i.d samples ==exactly== from the target density $f(x)$
  * ==Stopping rule== is very clear
  * It can be applied to both cases: (==not need to normalize==)
    * $f(x)$ is completely known
    * $f(x)$ could be known up to a normalizing constant

* Drawbacks 
  * Difficult to find ==an automatic envelop density== $g(x)$ or ==a class of envelop densities== $g_{\theta}(x)$ indexed by a parameter $\theta$
  * Sometimes, the optimization $(1.14)$ is even more difficult

# 1.4 The sampling/ Importance Resampling Method

* Background: if it is difficult to generate a sample from $f(x)$, but it is relatively easy to draw a sample from $g(x)$, then we can write
  $$
  f(x)=\frac{f(x)}{g(x)}\cdot g(x){\;} \hat{=}{\;} w(x)\cdot g(x)
  $$

* Generate $X^{(1)},X^{(2)},\cdots,X^{(J)}\sim^{i.i.d} g(x)$
* Then adjust the generated samples $  \{ X^{(j)} \}_{j=1}^J$ s.t. part of them becomes samples from $f(x)$ by comparing their ratios $w(X^{(j)})=\frac{f(X^{(j)})}{g(X^{(j)})}$

## The SIR without replacement

### Formulation 

* it consists of a ==sampling step== and an ==importance resampling step==

* It starts by simulating $J$ i.i.d samples $ \{X^{(j)} \}_{j=1}^J$ from an ==importance sampling density== or ==proposal density== $g(x)$ with the same support $S_X$.

  Then, it calculates the ratios
  $$
  w(X^{(j)})=\frac{f(X^{(j)})}{g(X^{(j)})}\tag{1.15}
  $$
  and probabilities
  $$
  w_j=\frac{w(X^{j})}{\sum_{j'=1}^J w(X^{(j')})}, {\;}j=1,\cdots,J \tag{1.16}
  $$

* Finally, a second sampling of size $I{\;} (I\leq J)$ is drawn from the discrete distribution on $\{X^{(j)}\}_{j=1}^J$ with probabilities $\{w_j \}_{j=1}^J$





* How to choose the proposal function

  The 





### Example 

* Simulation from a density defined in the unit interval





## Justification 







# 1.5 The Stochastic Representation(SR) Method

## One-to-many SR

* Defintion: ==one-to-many SR==

  * Let $X$ and $\{Y_j \}_{j=1}^n$ be r.v.'s and $g(\cdot)$ a function

  * If $X$ and $g(Y_1,\cdots,Y_n)$ have the same distribution, denoted by
    $$
    X=^d g(Y_1,\cdots,Y_n)\tag{1.20}
    $$
    we say $(1.20)$ is a one-to-many stochastic representations (SR) of $X$

    

## Many-to-one SR

* Let $X$ has a difficult-sampling density $f_X(x)$, but $Y$ has an easy-sampling density $f_Y(y)$, and we have $G(X)=^dY$

  * When G is a one-to-one map, then $X=^d G^{-1}(Y)$

    The pdf of $Y=G(X)$ is
    $$
    f_Y(y)=f_X(x)\cdot |\frac{dx}{dy}|=f_X(G^{-1}(y))\cdot |\frac{dx}{dy} | \tag{1.21}
    $$
    where $|a|$ denotes the absolute value of a.

  * when the map G is ==many-to-one== so that the inverse is not uniquely determined

* wlog, we assume that $G(X)=Y$ has two solutions $X_i=h_i(Y),i=1,2.$

  Hence, the pdf of $Y=G(X)$ is
  $$
  f_Y(y)=\sum_{i=1}^2 f_X(x_i)\cdot |\frac{dx_i}{dy} |=\sum_{i=1}^2 f_X(h_i(y))\cdot|\nabla h_i(y) |\tag{1.22}
  $$
  where 
  $$
  \nabla h_i(y)=\frac{dx_i}{dy}=(\frac{dy}{dx_i} )^{-1}=\{\frac{dG(x)}{dx}|_{x=x_i} \}^{-1} \hat{=}\{\nabla G(x_i) \}^{-1}\tag{1.23}
  $$

* Generation method

  Given a r.v. $Y$ with density $f_Y(y)$, we can obtain a r.v. $X$ with density $f_X(x)$ by choosing $X=h_1(Y)$ with prob.
  $$
  \frac{f_X(h_1(y))|\nabla h_1(y)| }{f_Y(y)}=\frac{f_X(h_1(y))|\nabla h_1(y)| }{f_X(h_1(y))\cdot|\nabla h_1(y) |+f_X(h_2(y))\cdot|\nabla h_2(y) |}\\
  =\{1+\frac{f_X(x_2)}{f_X(x_1)}|\frac{\nabla h_2(y)}{\nabla h_1(y)} |  \}^{-1}\\
  =\{1+\frac{f_X(x_2)}{f_X(x_1)}|\frac{\nabla G(x_1)}{\nabla G(x_2)} |  \}^{-1}
  $$
  and choosing $X=h_2(Y)$ otherwise.

* Algorithm 
  * Step1: Draw $U=u\sim U(0,1)$ and independently draw $Y=y\sim f_Y(\cdot)$
  * Step2: Set $x_1=h_1(y)$ and $x_2=h_2(y)$
  * Step3: If $u\leq \{1+\frac{f_X(x_2)}{f_X(x_1)}|\frac{\nabla G(x_1)}{\nabla G(x_2)} |  \}^{-1}$, return $X=x_1$, otherwise return $X=x_2$

## SR for multivariate case

* Background

  Suppose that we have the following mapping
  $$
  X_i=g_i(Y_1,\cdots,Y_n),{\;}{\;}i=1,\cdots,d
  $$
  for a set of known functions $ \{g_i \}_{i=1}^d$ and it is easy to generate $\{Y_j \}_{j=1}^n$, then we can first generate $\{Y_j \}_{j=1}^n$ and then set $X_i=g_i(Y_1,\cdots,Y_n)$ for $i=1,\cdots,d$

* The SR method is also known as the transformation method

* Examples 













## Mixture representation

* Background 

  * Sometimes, it is difficult if we directly generate a random variable (or vector) $X\sim f_X(x)$, but ==the argumented vector $(X,Y)^T\sim f_{(X,Y)}(x,y)$ is relatively easy to generate==

  * We may first generated the augmented vector and then pick up the desired components

  * Statistically, we can represent $f_X(x)$ as the marginal distribution of $f_{(X,Y)}(x,y)$ in the form
    $$
    f_X(x)=\int_{Y}f(X,Y)(x,y)dy\tag{1.27}
    $$
    or in the mixture form
    $$
    f_X(x)=\int_Yf_Y(y)f_{(X|Y)}(x|y)dy {\;}or{\;}f_X(x)=\sum_{k\in Y}p_kf_k(x)
    $$
    depending on if $Y$ is continuous or discrete









# 1.6 The Conditional Sampling(CS) Method

* Background 

  * When the ==joint distribution of a d-vector is very difficlut to generate== but ==one marginal distribution and d-1 univariate conditional distribution are easy to simulate==

  * Let $\boldsymbol{x}=(X_1,\cdots,X_d)^{T}$ and its density $f_{\boldsymbol{x}}(\boldsymbol{x})$ can be factorized as
    $$
    f_{\boldsymbol{x}}(\boldsymbol{x})=f_1(x_1)\Pi_{i=2}^{d} f_i(x_i|x_1,x_2,\cdots,x_{i-1})\tag{1.33}
    $$

* Remarks 

  * The beauty of the conditional sampling(CS) method is that it reduce the problem of generating a d-dimensional vector into d univariate generation problems

  * The decomposition of $(1.33)$ is ==not unique==. There are $d!$ different representations.
  * Better representation will result in a more efficient d random variables

* The condition sampling method

  * Step1: Draw $X_1$ from $f_1(x_1)$

  * Step2: Draw $X_2$ from $f_2(x_2|x_1)$

  * Step3: Draw $X_3$ from $f_3(x_3|x_1,x_2)$

    $\vdots$

  * Stepd: Draw $X_d$ from $f_d(x_d|x_1,x_2,\cdots,x_{d-1})$

 

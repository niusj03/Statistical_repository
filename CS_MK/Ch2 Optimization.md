[toc]

# 1. Standard Concepts

* Two motivations / optimization problem

  * Finding the ==MLE of parameters==

    * Likelihood function

    * We want to calculate
      $$
      \boldsymbol{\hat{\theta}}=arg{\;}max_{\boldsymbol{\theta } \in \boldsymbol{\Theta }}l(\boldsymbol{\theta }|Y_{obs})
      $$
  
  * Finding the ==posterior mode==
  
    * When sample sizes are small to moderate
  
    * The observed posterior distribution $p(\boldsymbol{\theta}|Y_{obs})$ 
  
    * $$
      \boldsymbol{\widetilde{\theta}} =arg{\;}max_{\boldsymbol{\theta } \in \boldsymbol{\Theta }}log\{{p(\boldsymbol{\theta}|Y_{obs})\}}
      $$

## Order relations

* Basic assumptions 
  * Two functions $f(x)$ and $g(x)$ Defined on a common interval $I$
  * $x_0$ be either an internal point or a boundary point of $I$
  * $g(x)\neq 0$ for $x$ close (but not equal) to $x_0$

* Big $O$
* Small $o$
* Asymptotic equality $\asymp$

## Stationary points

* ==Weierstrass theorem==

  * A continuous function $f(x)$ defined on a closed finite interval $[a,b]$ attains its **maximum** and **minimum** values on the interval
  * These extermal values are necessarily finite

* ==Principle of Fermat==

  * The **extremal points** could occur at the endpoints $a$ or $b$ or at an interior point $c$
  * When $f(x)$ is differentiable, ==principle of Fermat== requires that $f'(c)=0$, $c$ is an interior point

* ==Critical point/ extremal point==

  * Endpoint 
  * Stationary point:  the points obey the **stationary condition**: $f'(c)=0$ & c is an interior point
    * **Optimal point**: means a minimum or maximum
    * **Saddle point**: the point which obeys the **stationary condition** but not an optimal point

* Notations for open boundary
  * If the domain is not a closed finite interval $[a,b]$, then the **minimum or maximum may not exist**
  * For open interval (finite), the endpoints is also critical points
  * We can roll out such behavior by examining the limit of $f(x)$ as $x$ spproaches an open boundary

* Local & Saddle points

  Testing the second derivative $f''(c)$ to find the nature of a stationary point $c$

  * If $f''(c)>0$, then $c$ at least qualifies as a local minimum
  * If $f''(c)<0$, then $c$ at least qualifies as a local maximum
  * If $f''(c)=0$, then $c$ can be local minimum, maximum & saddle point

## Convex & concave functions

* Convex: If $f'(x)\geq0$ for all $x$, then $f(x)$ Is said to be **convex**
  * Any stationary point of a convex function is a minimum
  * If $f(x)$ is strictly convex, there is at most one stationary point
  * Whenever it exists, the stationary point furnishes the global minimum
* Concave: If $f''(x)\leq0$ for all $x$, then $f(x)$ Is said to be **concave**

## Taylor theorem

* Notations 
  * The $n$-order derivative of $f(x)$ is denoted by $f^{(n)}(x)$

* Theorem 2.2(Taylor theorem)

  Suppose $f(x)$ has a derivate of order $n+1$ on an open interval $(a,b)$ around the point $x_0\in(a,b)$. Then for all $x\in (a,b)$, we have
  $$
  f(x)=f(x_0)+\sum_{j=1}^n\frac{(x-x_0)^j}{j!}f^{(j)}(x_0)+\frac{(x-x_0)^{n+1}}{(n+1)!}f^{(n+1)}(x^*)
  $$
  for some $x^*$ between $x_0$ and $x$.

  If $f^{(n+1)}(x^*)$ is bounded, then the remainder
  $$
  R_{n+1}(x)=\frac{(x-x_0)^{n+1}}{(n+1)!}f^{(n+1)}(x^*)=O(|x-x_0|^{n+1})
  $$
  

## Rates of convergence

* During the process of optimization, ==a sequence in the form of $\{x^{(t)} \}_{t=1}^\infty$ is produced and converges to $x^*$==

* If there exists a constant $c\in[0,1)$ s.t.
  $$
  lim_{t\rightarrow \infty}\frac{|x^{(t+1)}-x^*|}{|x^{(t)}-x^* |^q}=c
  $$
  we say the the sequence $\{x^{(t)} \}_{t=1}^\infty$ converges to $x^*$ at rate $q$

  * if $q=2$, we say that $\{x^{(t)} \}_{t=1}^\infty$ converges ==quadratically==

  * if $q=1$, we say that $\{x^{(t)} \}_{t=1}^\infty$ converges ==linearly==
  
  * Superlinear convergence:
  
    If there exists a sequence 



## The case of multiple dimensions

* For a real-valued function $f(\boldsymbol{x})$ defined on the n-dimensional Euclidean space $R^n$, the ==differential== $df(\boldsymbol{x})$ is
  $$
  df(\boldsymbol{x})=(\frac{\partial f(\boldsymbol{x})}{\partial x_1},\cdots,\frac{\partial f(\boldsymbol{x})}{\partial x_n})_{1\times n}
  $$
  In optimization, its transpose is called the ==gradient vector==
  $$
  \nabla f(\boldsymbol{x})=\{df(\boldsymbol{x}) \}^T=
  \left(\begin{matrix}
  \frac{\partial f(\boldsymbol{x})}{\partial x_1}\\
  \vdots\\
  \frac{\partial f(\boldsymbol{x})}{\partial x_n}
  
  \end{matrix}
  \right)
  $$

* In statistics, $\nabla l(\boldsymbol{\theta}|Y_{obs})$ is called ==score vector==, where $l(\boldsymbol{\theta}|Y_{obs})$ is the log-likelihood function and $\boldsymbol{\theta} \in \boldsymbol{\Theta}$.

* In mathematics and optimization, the symmetric matrix of second partial derivatives constitutes the ==second differential $d^2 f(\boldsymbol{x})$ or Hessian matrix==
  $$
  \nabla^2f(\boldsymbol{x})=d^2f(\boldsymbol{x})=
  \left(\begin{matrix}
  \frac{\partial^2 f(\boldsymbol{x})}{\partial x_1 \partial x_1}&& \frac{\partial^2 f(\boldsymbol{x})}{\partial x_1 \partial x_2}&&\cdots && \frac{\partial^2 f(\boldsymbol{x})}{\partial x_1 \partial x_n}\\
  \vdots && \vdots &&\ &&\vdots\\
  \frac{\partial^2 f(\boldsymbol{x})}{\partial x_n \partial x_1}&& \frac{\partial^2 f(\boldsymbol{x})}{\partial x_n \partial x_2} && \cdots && \frac{\partial^2 f(\boldsymbol{x})}{\partial x_n \partial x_n}
  
  \end{matrix}
  \right)
  $$

* In statistics, $ -\nabla^2 l(\boldsymbol{\theta}|Y_{obs})$ is called ==observed information matrix==

# 2. Newton's Method and its Variants

## Newton's method and root finding

$$
x^{(t+1)}=x^{(t)}-\frac{g(x^{(t)})}{g'(x^{(t)})}\tag{2.4}
$$

### Two ways of formulation





### Convergence properties

* From the prespective of functional iteration, Newton's method can be rephrased as
  $$
  x^{(t+1)}=f(x^{(t)})\tag{2.5}
  $$
  where
  $$
  f(x)=x-\frac{g(x)}{g'(x)}\tag{2.6}
  $$

* Then we have 

$$
f'(x^{(\infty)})=0\tag{2.7}
$$

* Let $\epsilon^{(t+1)}=x^{(t+1)}-x^{(\infty)}$ be the ==current error== in approximating $x^{(\infty)}$, then according to second-order Taylor expansion around $x^{(\infty)}$
  $$
  \epsilon^{(t+1)}=x^{(t+1)}-x^{(\infty)}=\frac{1}{2}f''(z)(\epsilon^{(t)})^2 \tag{2.8}
  $$
  where $z$ again lies between $x^{(t)}$ and $x^{(\infty)}$

## Newton's method and optimization



## The Newton-Raphson algorithm

* Aims: find the MLEs of the parameter vector $\theta$, i.e. to calculate
  $$
  \boldsymbol{\hat{\theta}}=arg{\;}max_{\theta\in\Theta}l(\theta|Y_{obs})\tag{2.12}
  $$
  where $l(\boldsymbol{\theta}|Y_{obs})$ is the log-likelihood function, which is **twice continuously differentiable and concave**

### Score vector & Information matrices

* We call $\nabla l(\theta|Y_{obs})$ as **gradient vector** and $\nabla^2l(\theta|Y_{obs})$ as the **Hessian matrix**, $\nabla$ denotes the derivative operator

* Statistically, $\nabla l(\theta|Y_{obs})$ is called the **score vector**

* **Observed information matrix**: $I(\theta|Y_{obs})=-\nabla^2l(\theta|Y_{obs})$

* **Fisher/expected information matrix**
  $$
  \boldsymbol{J(\theta)}=E\{I(\theta|Y_{obs}) \}=-\int
  $$
  where $f(Y_{obs};\theta)=\Pi_{i=1}^n f(x_i;\theta)$ is the joint density of $X_1,\cdots,X_n\sim^{i.i.d}f(x,\theta)$



### Derivation of the N-R algorithm





* Let $\theta^{(0)}$ be an initial value of $\hat{\theta}$ and $\theta^{(t)}$ the t-th approximation of $\hat{\theta}$, the NR algorithm is defined by
  $$
  \theta^{(t+1)}=\theta^{(t)}+I^{-1}(\theta^{(t)}|Y_{obs})\nabla l(\theta^{(t)}|Y_{obs})\tag{2.13}
  $$
  
* 



## The Fisher scoring algorithm







# 3. The Expectation-Maximization(EM) Algorithm

* For **missing/incomplete data problems**, the NR algorithm is often difficult to apply while the EM algorithm could be a useful alternative

* The EM algorithm is an iterative deterministic method for finding the **MLEs or the posterior mode**

* Applications

  * **Missing/incomplete data problems** & **latent variables problems**

  * There are no missing data in **latent variables problems**

    However, when the **optimization problem is very complicated**, we could simplify the complicated optimiazation by introducing some **latent variables/data**

* Idea 
  * Instead of performing a complicated optimization
  * Arguments the observed data with latent data to perform **a series of simple optimizations**

## The formulation of the EM algorithm

* Aim: solving the MLEs $\hat{\theta}$ Defined by 
  $$
  \hat{\boldsymbol{\theta}}=arg{\;}max_{\theta\in\Theta} l(\boldsymbol{\theta}|Y_{obs}) \tag{2.12}
  $$
  which is extremely difficult

* Argument the observed data $Y_{obs}$ with a latent variables $Z$ (Or latent vector $\boldsymbol{z}$) such that both 

  * The **complete-data log-likelihood** $l(\boldsymbol{\theta}|Y_{obs},z)$ 
  * The **conditional predictive distribution** $f(z|Y_{obs},\boldsymbol{\theta})$

  are available, where $z$ is the realization of $Z$ and "available" means

  * The MLEs of $\boldsymbol{\theta}$ based on the complete-data $Y_{com}=\{Y_{obs},Y_{mis}  \}=Y\{Y_{obs},z \}$ are given by
    $$
    \boldsymbol{\hat{\theta}}=arg{\;}max_{{\theta\in\Theta} }l(\boldsymbol{\theta}|Y_{com})
    $$
    

* Description of the EM Algorithm 

  * Each iteration of the EM Algorithm consists of an **expectation step** and a **maximization step**

  * E-step is to compute the Q-function (sometimes called **surrogate function**)
    $$
    Q(\boldsymbol{\theta}|\boldsymbol{\theta^{(t)}})=E\{l(\boldsymbol{\theta}|Y_{obs},Z)|Y_{obs},\boldsymbol{\theta^{(t)}} \}\\
    =\int_Z l(\boldsymbol{\theta}|Y_{obs},z)\times f(z|Y_{obs},\boldsymbol{\theta^{(t)}})dz \tag{2.17}
    $$

  * M-step is to maximize the Q-function with respect to $\boldsymbol{\theta}$ to obtain
    $$
    \boldsymbol{\theta^{(t+1)}}=arg{\;}max_{\theta^{(t)}\in\Theta}Q(\boldsymbol{\theta}|\boldsymbol{\theta^{(t)}})
    $$

  * The two-step process is repeated **until convergence occurs**



### Modern EM Algorithm

* Step1: Find the ==complete-data log-likelihood $l(\theta|Y_{obs},z)$==

* Step2: Find the ==conditional predictive distribution $f(z|Y_{obs},\theta)$==

* E-step: compute the ==conditional expectation $E(Z|Y_{obs},\theta)$==

* M-step: Find the complete-data MLE $\hat{\theta}$, and update $\hat{\theta}$ by replacing $z$ with $E(Z|Y_{obs},\theta)$ 

  

  

## The ascent property of the EM algorithm

* One of the advantages of the EM algorithm is **numerical stability**
  * i.e. EM algorithm **increases the observed-data log-likelihood $l(\boldsymbol{\theta}|Y_{obs})$ at each iteration**
  * Which avoids

### Derivation of ascent

* The bayes theorem gives
  $$
  \frac{f(Y_{obs},z|\boldsymbol{\theta})}{f(Y_{obs}|\boldsymbol{\theta})}=f(z|Y_{obs},\boldsymbol{\theta}){\;} or\\
  \frac{L(\boldsymbol{\theta}|Y_{obs},z)}{L(\boldsymbol{\theta}|Y_{obs})}=f(z|Y_{obs},\boldsymbol{\theta})
  $$
  We have
  $$
  l(\boldsymbol{\theta}|Y_{obs})-l(\boldsymbol{\theta}|Y_{obs},z)=-log\{f(z|Y_{obs},\boldsymbol{\theta}) \}
  $$
  Integrating both sides with respect to $log\{f(z|Y_{obs},\boldsymbol{\theta^{(t)}}) \}$, we obtain
  $$
  l(\boldsymbol{\theta}|Y_{obs})-Q(\boldsymbol{\theta}|\boldsymbol{\theta^{(t)}})=-H(\boldsymbol{\theta}|\boldsymbol{\theta^{(t)}})\tag{2.31}
  $$
  Where the Q-function is defined by $(2.17)$ and 
  $$
  H(\boldsymbol{\theta}|\boldsymbol{\theta^{(t)}})=\int_Z log\{f(z|Y_{obs},\boldsymbol{\theta}) \}\times f(z|Y_{obs},\boldsymbol{\theta^{(t)}})  \tag{2.32}\\
  =E[log\{f(Z|Y_{obs},\boldsymbol{\theta}) \}|Y_{obs},\boldsymbol{\theta^{(t)}}]
  $$

* It follows that
  $$
  H(\boldsymbol{\theta^{(t)}}|\boldsymbol{\theta^{(t)}})-H(\boldsymbol{\theta}|\boldsymbol{\theta^{(t)}})\geq0
  $$

* Thus for all $\boldsymbol{\theta},\boldsymbol{\theta^{(t)}}\in \boldsymbol{\Theta}$, we have
  $$
  l()
  $$
  
* Then it follows that
  $$
  l(\boldsymbol{\theta^{(t+1)}}|Y_{obs})-l(\boldsymbol{\theta^{(t)}}|Y_{obs})\geq Q(\boldsymbol{\theta^{(t+1)}}|\boldsymbol{\theta^{(t)}})-Q(\boldsymbol{\theta^{(t)}}|\boldsymbol{\theta^{(t)}})\geq 0 \tag{2.34}
  $$
  

### Generalized EM

* GEM algorithm choose $\boldsymbol{\theta^{(t+1)}}$ s.t.

$$
Q(\boldsymbol{\theta^{(t+1)}}|\boldsymbol{\theta^{(t)}})\geq Q(\boldsymbol{\theta^{(t)}}|\boldsymbol{\theta^{(t)}})
$$

* GEM algorithm also has the ascent property from $(2.34)$

### Convergence of the EM

* Suppose that a sequence of EM iterates $\{\boldsymbol{\theta^{(t)}} \}_{t=1}^{\infty}$ satisfies

  * $\frac{\partial Q(\boldsymbol{\theta}|\boldsymbol{\theta^{(t)}})}{\partial \boldsymbol{\theta}}|_{\boldsymbol{\theta}=\boldsymbol{\theta^{(t+1)}}}=\boldsymbol{0}$
  * $\{\boldsymbol{\theta^{(t)}} \}_{t=1}^{\infty}$ converges to some value $\boldsymbol{\theta^*}$
  * Let $f(z|Y_{obs},\boldsymbol{\theta})$ be sufficiently smooth

  Then it follows that $\frac{\partial l(\boldsymbol{\theta}|Y_{obs})}{\partial \boldsymbol{\theta}}|_{\boldsymbol{\theta}=\boldsymbol{\theta^{*}}}=\boldsymbol{0}$

* If $\{\boldsymbol{\theta^{(t)}} \}_{t=1}^{\infty}$ converge, they converge to a stationary point of $l(\boldsymbol{\theta}|Y_{obs})$

* Trouble

   when there are **multiples stationary points** (local maxima or saddle points), the EM algorithm **may not converge to the global maximum**

* Solutions

  In order to reach the global maximum, we may consider

  * Starting the parameters at good but suboptimal estimates such as **moment estimate**
  * Choosing multiple starting points

## Missing information principle and standard errors

### Missing information principle

* integrating both sides of $(2.30)$ with respect to $log\{f(z|Y_{obs},\boldsymbol{\theta}) \}$, we have
  $$
  l(\boldsymbol{\theta}|Y_{obs})=Q(\boldsymbol{\theta}|\boldsymbol{\theta})-H(\boldsymbol{\theta}|\boldsymbol{\theta})
  $$
  Differentiating 
  $$
  -\nabla^2 l(\boldsymbol{\theta}|Y_{obs})=-\nabla^{2,0} Q(\boldsymbol{\theta}|\boldsymbol{\theta})+\nabla^{2,0} H(\boldsymbol{\theta}|\boldsymbol{\theta})
  $$
  Where $\nabla^{i,j}Q(x|y)=\frac{\partial ^{i,j}Q(x|y)}{\partial x^i \partial y^J}$



* Definition of three information matrices

  * Observed information
    $$
    I_{obs}=-\nabla^2l(\boldsymbol{\theta}|Y_{obs})=I(\boldsymbol{\theta}|Y_{obs})_{\boldsymbol{\theta}=\boldsymbol{\hat{\theta}}}
    $$

  * Complete information
    $$
    I_{com}=-\nabla^{2,0}Q(\boldsymbol{\hat{\theta}}|\boldsymbol{\hat{\theta}})
    $$

  * missing information
    $$
    I_{mis}=-\nabla^{2,0}H(\boldsymbol{\hat{\theta}}|\boldsymbol{\hat{\theta}})
    $$

* MIssing information principle

  * If we evaluate the function $-\nabla^2 l(\boldsymbol{\theta}|Y_{obs})=-\nabla^{20} Q(\boldsymbol{\theta}|\boldsymbol{\theta})+\nabla^{20} H(\boldsymbol{\theta}|\boldsymbol{\theta})$ at the converged value $\boldsymbol{\hat{\theta}}$, then it becomes
    $$
    I_{obs}=I_{com}-I_{mis}
    $$
  
* Namely, the observed information equals the complete information minus the missing information
  
  

### The estimated standard errors

* Louis showed that
  $$
  -\nabla^{2,0}H(\boldsymbol{\theta}|\boldsymbol{\theta})=
  $$
  w

* The estimated standard errors are the square roots of the diagonal elements for the inverse information matrix; i.e. $I^{-1}(\boldsymbol{\hat{\theta}}|Y_{obs})$

* Advantages of the EM

  * Numerical stability
  * Sufficiently uses the structure of complete data

* Limitations of the EM and solution

  * The EM holds the ==ascent property== at the cost of ==slow convergence==

    Speed EM-type algorithm via a so-called "working parameter" method

  * For some problems, the E-step has no explicit expressions

    Use the Monte Carlo EM algorithm 

  * Sometimes, the M-step may be difficult to achieve

    Using the ECM algorithm















# 4. The ECM Algorithm

### Background 

* The ECM algorithm replaces a complicated M-step with ==**several computationally simpler conditional maximaization steps**==
* As a consequence, it typically converges ==more slowly== than the EM algorithm in terms of ==**number of iterations**==, but can be ==**fastor in total computer time**==
* the ECM algorithm preserve the **monotone convergence property** of the EM algorithm



### Basic idea

* The ECM replaces each M-step of the EM by ==a sequence of K conditional maximization steps==, i.e. **CM-steps**

* Each CM-steps maximizes the Q-function defined in $(2.17)$ over $\boldsymbol{\theta}$ but with some vector function of $\boldsymbol{\theta}$, $g_k(\boldsymbol{\theta}){\;}(k=1.\cdots,k)$ fixed at its previous value

* For example

  Let $\boldsymbol{\theta}=(\boldsymbol{\theta_1}^T,\boldsymbol{\theta_2}^T)^T$, where $\boldsymbol{\theta_1}=(\theta_1,\cdots, \theta_r)^T$ and $\boldsymbol{\theta_2}= (\theta_{r+1},\cdots, \theta_q)^T$

  The M-step of calculating M is replaced by

  * Given $\boldsymbol{\theta_2}^{(t)}$, to calculate
    $$
    w
    $$

  * Given $\boldsymbol{\theta_1}^{(t)}$, to calculate
    $$
    \boldsymbol{\theta_2}^{(t+1)}=arg{\;}max_{}
    $$
    

























# 5. Minorization-Maximization(MM) Algorithm

* EM-type algorithms press the ascent property that ensures monotone convergence, they may bot be applied to generalized linear models and Cox proportional models due to ==absence of a missing-data structure== in these models





A brief review

## The MM idea

* Aim: Let $l(\theta |Y_{obs})$ denote the log-likelihood function and we want to find the MLEs $\hat{\theta}$ defined by $(2.12)$

* The function $Q(\boldsymbol{\theta}|\boldsymbol{\theta^{(t)}})$ is said to ==**minorize**== $l(\boldsymbol{\theta}|Y_{obs})$ at $\boldsymbol{\theta}=\boldsymbol{\theta^{(t)}}$ if
  $$
  Q(\boldsymbol{\theta}|\boldsymbol{\theta^{(t)}})\leq l(\boldsymbol{\theta}|Y_{obs}) \tag{2.43}
  $$
  and 
  $$
  Q(\boldsymbol{\theta^{(t)}}|\boldsymbol{\theta^{(t)}})=l(\boldsymbol{\theta^{(t)}}|Y_{obs})\tag{2.44}
  $$
  
  * If the $Q(\cdot|\boldsymbol{\theta^{(t)}})$ function satisfying the above restriction is called the ==**optimal lower-bound(OLB)**== of $l(\boldsymbol{\theta}|Y_{obs})$ with the ==**tangent point**== being $\boldsymbol{\theta}=\boldsymbol{\theta^{(t)}}$
  
* The ==ascent property==

  * If $\boldsymbol{\theta^{(t+1)}}$ is the maximizer of $Q(\boldsymbol{\theta}|\boldsymbol{\theta^{(t)}})$, i.e. 
    $$
    \boldsymbol{\theta^{(t+1)}}=arg{\;}max_{\boldsymbol{\theta}\in\boldsymbol{\Theta}} Q(\boldsymbol{\theta}|\boldsymbol{\theta^{(t)}})\tag{2.45}
    $$
    then we have
    $$
    l(\boldsymbol{\theta^{(t+1)}}|Y_{obs})
    \geq Q(\boldsymbol{\theta^{(t+1)}}|\boldsymbol{\theta^{(t)}})
    \geq Q(\boldsymbol{\theta^{(t)}}|\boldsymbol{\theta^{(t)}})
    \geq l(\boldsymbol{\theta^{(t)}}|Y_{obs})\tag{2.46}
    $$
    An Increase in $Q(\boldsymbol{\theta}|\boldsymbol{\theta^{(t)}})$ force $l(\boldsymbol{\theta}|Y_{obs})$ ==uphill==

* The monotone convergence

  Under ...

* The generalized MM algorithm

  It is not necessary to maximize the minorizing function.

  It suffices to find $\boldsymbol{\theta^{(t+1)}}$ such that
  $$
  Q(\boldsymbol{\theta^{(t+1)}}|\boldsymbol{\theta^{(t)}})
  \geq Q(\boldsymbol{\theta^{(t)}}|\boldsymbol{\theta^{(t)}})
  $$
  
* ==EM is a special case of MM algorithms==

  The inequality $(2.33)$ can be written as 
  $$
  l(\theta|Y_{obs})\geq Q(\theta |\theta^{(t)})+l(\theta^{(t)}|Y_{obs}-Q(\theta^{(t)}|\theta^{(t)}))\\
  \hat{=} Q^*(\theta|\theta^{(t)}) , \forall \theta,\theta^{(t)}\in \Theta
  $$
  

## The quadratic lower-bound(QLB) algorithm

* Aim:  Let $l(\theta |Y_{obs})$ denote the log-likelihood function and we want to find the MLEs $\hat{\theta}$ defined by $(2.12)$

* The **quadratic lower-bound(QLB)** algorithm is a ==special MM algorithm== (finding the surrogate function)

* The **key idea:**

  Transfer the optimization from the intractable $l(\boldsymbol{\theta}|Y_{obs})$ to a **quadratic surrogate function** $Q(\boldsymbol{\theta}|\boldsymbol{\theta^{(t)}})$

* And a key for the QLB is to find a positive definite matrix B(>0) that does not depend on $\theta$ s.t.
  $$
  \nabla^2 l(\theta |Y_{obs})+ \boldsymbol{B} \geq 0, \forall \theta \in \Theta \tag{2.47}
  $$
  i.e. $+\boldsymbol{B}$ is a ==non-negative definite matrix==

* Construction of a surrogate function $Q$

  * The second-order Taylor expansion of $l(\theta |Y_{obs})$ around $\theta^{(t)}$

  * Replacing $\nabla^2 l(\theta^*|Y_{obs})$ above by $-\boldsymbol{B}$, we can construct a quadratic surrogate function
    $$
    Q(\theta|\theta^{(t)})=l(\theta^{(t)}|Y_{obs})+(\theta - \theta^{(t)})^T \nabla l(\theta^{(t)}|Y_{obs})-\frac{1}{2}(\theta - \theta^{(t)})^T \boldsymbol{B}(\theta - \theta^{(t)}) \tag{2.48}
    $$

    * We can prove that ==this Q-function minorities $l(\theta|Y_{obs})$ at $\theta=\theta^{(t)}$==

* The QLB algorithm is defined by
  $$
  \boldsymbol{\theta^{(t+1)}}=\boldsymbol{\theta^{(t)}}+\boldsymbol{B^{-1}}\nabla l(\boldsymbol{\theta^{(t)}}|Y_{obs}) \tag{2.49}
  $$

  * Just like EM Algorithm, the QLB algorithm also holds the ==**ascent property**==, leading to **monotone convergence**
  * The algorithm has the advantage of requiring a ==single matrix inversion== instead of repeated inversions as in the NR algorithm

* Application 
  * QLB depends on the existence of a positive definite $\boldsymbol{B}$ satisfying $(2.47)$
  * Only ...





## The De Pierro(DP) algorithm

* DP algorithm is also a special member of MM algorithm
* Applications of DP algorithm
* Main idea
  * Transfer the optimization of a ==high-dimensional function== $l(\boldsymbol{\theta}|\boldsymbol{\theta^{(t)}})$ To the optimiazation of a ==**low dimensional surrogate function** $Q(\boldsymbol{\theta}|\boldsymbol{\theta^{(t)}})$==
    * $Q(\boldsymbol{\theta}|\boldsymbol{\theta^{(t)}})$ is a sum of linear combinations of ==a set of one-dimensional concave functions==
  * Maximizing $Q(\boldsymbol{\theta}|\boldsymbol{\theta^{(t)}})$ can be implemented via the ==one-step NR method==

* Construction of a ==surrogate function==

  * We can construct a surrogate function as follows
    $$
    Q(\theta|\theta^{(t)})=\sum_{i=	1}^m \sum_{j\in J_i} \lambda_{ij}f_i(\lambda_{ij}^{-1}x_{ij}(\theta-\theta^{(t)})+x_{(i)}^T\theta^{(t)} ) \tag{2.52}
    $$
    for $\theta, \theta^{(t)}\in\Theta$, where $\lambda_{ij}\hat{=}\lambda_{ij(1)}$

  * It can be shown that this $Q(\theta|\theta^{(t)})$ function minorizes $l(\theta|Y_{obs})$ at $\theta=\theta^{(t)}$

* w

  * The DP Algorithm is defined by
    $$
    \theta^{(t+1)}=arg{\;}max_{\theta \in \Theta}Q(\theta|\theta^{(t)})
    $$

  * Iokllkjkghgjhv

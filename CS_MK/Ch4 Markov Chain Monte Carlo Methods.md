# Bayes Formulae and Inverse Bayes Formula(IBF)

## The point-wise, function-wise and sampling-wise IBF

**Bayes Theorem**

* The first form in event
* The second form in densities
* The third form in mixture

**Support**

* r.v. X taking values in the space $\mathcal{X}$, r.v. Y taking values in the space $\mathcal{Y}$

* Marginal supoort of $Y$
* Joint support of $(X,Y)$

**Conditional support**

* The conditional support of $X|(Y=y)$ and $Y|(X=x)$ are defined by

  * $$
    S_{(X|Y)}(y)=\{x: f_{(X|Y)}(x|y)>0, x\in \mathcal{X}  \}{\;} \forall y\in S_Y
    $$

  * $$
    S_{(Y|X)}(x)=\{y: f_{(Y|X)}(y|x)>0, y\in  \mathcal{Y} \}{\;} \forall x\in S_X
    $$

  * In practice, we usually have 
    $$
    S_{(Y|X)}(x)\in S_Y {\;}\forall x\in S_X\\
    S_{(X|Y)}(y)\in S_X {\;}\forall y\in S_Y\\
    $$
    

**Product space**

* If $S_{(X,Y)}=S_X \times S_Y$, we say $S_{(X,Y)}$ is a ==product space==; otherwise, it is called a ==non-product space==





**Point-wise formula**

* $$
  f_X(x)=\{\int_{S_Y} \frac{f_{(Y|X)}(y|x)}{f_{(X|Y)}(x|y)} \}^{-1}, {\;}for {\;} any{\;}x\in S_X \tag{4.3}
  $$

* $$
  f_Y(y)=\{\int_{S_X} \frac{f_{(X|Y)}(x|y)}{f_{(Y|X)}(y|x)} \}^{-1}, {\;}for {\;} any{\;}y\in S_Y \tag{4.4}
  $$

* Two conditional pdfs can uniquely determine marginal densities provided that the integer in $(4.3)$ and $(4.4)$ Exist



**Function-wise formula**

* $$
  f_X(x)=\{\int_{S_X} \frac{f_{(X|Y)}(x|y_0)}{f_{(Y|X)}(y_0|x)} \}^{-1}\frac{f_{(X|Y)}(x|y_0)}{f_{(Y|X)}(y_0|x)} \tag{4.5}
  $$

  for all $x \in S_X$ and an arbitrary fixed $y_0 \in S_Y$

* In fact, we only need $f_{(X|Y)}(x|y_0)$ and $f_{(Y|X)}(y_0|x)$ are ==enough to determine the $f_X(x)$==



**Sampling-wise formula**

By dropping the normalizing constant in $(4.5)$, we obtain the so-called sampling-wise formula
$$
f_X(x)\infty \frac{f_{(X|Y)}(x|y_0)}{f_{(Y|X)}(y_0|x)}
$$






## Monte Carlo versions of the IBF

**Harmonic mean formula**

* 

* Defintion

  * Given a sample $z_1,\cdots,z_n,$ the mean is $\overline{z}=(1/n)\sum_{i=1}^n z_i$

  * The harmonic mean is
    $$
    \tilde{z}=\{\frac{1}{n} \sum_{i=1}^n z_i^{-1} \}^{-1} {\;}or {\;}\frac{1}{\tilde{z}}=\frac{1}{n} \sum_{i=1}^n \frac{1}{z_i}
    $$
    



















## Generalization to the case of three random variables

**Assumptions and Goal**





Since 
$$
f_{(X_1,X_2,X_3)}(x_1,x_2,x_3)=f_{X_1}(x_1)f_{(X_2|X_1)}(x_2|x_1)f_3(X_3|x_1,x_2)
$$
By $(4.3)$, we have
$$
f_{(X_2|X_1)}(x_2|x_1)=\{\int \frac{f_3(x_3|x_1,x_2)}{f_2(x_2|x_1,x_3)}dx_3\}^{-1}
$$

$$
f_{(X_1|X_2)}(x_1|x_2)=\{\int \frac{f_3(x_3|x_1,x_2)}{f_2(x_1|x_2,x_3)}dx_3\}^{-1}
$$

Hence, by using $(4.3)$ Again, we have
$$
f_{X_1}(x_1)=\{\int\frac{f_{(X_2|X_1)}(x_2|x_1)}{f_{(X_1|X_2)}(x_1|x_2)} \}^{-1}
$$




# The Bayesian Methodology







## The posterior distribution



* The joint distribution of $Y_{com}$ and $\theta$:
  $$
  f(Y_{com},\theta)=f(Y_{com}|\theta)\pi(\theta)
  $$
  where $f(Y_{com}|\theta)$ is called **the sampling distribution**

* Obtain the posterior distribution
  $$
  p(\theta|Y_{com})=\frac{f(Y_{com}|\theta)\pi(\theta)}{f(Y_{com})} \infty f(Y_{com}|\theta)\pi(\theta) \tag{4.14}
  $$
  where 
  $$
  f(Y_{com})=\int f(Y_{com},\theta)d\theta=\int f(Y_{com}|\theta)\pi(\theta)  d\theta \tag{4.15}
  $$
  is the normalizing constant of $p(\theta|Y_{com})$



## Nuisance parameters



## Posterior predictive distribution

## Bayes factor

## Estimation of marginal likelihood





# The Data Augmentation(DA) algorithm

## Missing data mechanism



















# The Gibbs Sampler

## The formulation of the Gibbs sampling







## The two-block Gibbs sampling










艺术与科学发现中的平行性







# Bootstrap Confidence Intervals

Bootstrap sample mean

Bootstrap sample std

Asymptotic CI

Normality-based BCI

Non-normality-based BCI

Quantity interest

Mean of population distribution



==Empirical distribution function== based on the observations $\boldsymbol{x}=(x_1,\cdots,x_n)^T$ is defined by 
$$
\hat{F_n}(x)=\frac{1}{n}\sum_{i=1}^n I(x_i \leq x)
$$
where we assume $x_1\leq x_2 \leq \cdots \leq x_n$





Null hypothesis $H_0$: $F(\cdot)=G(\cdot)$ against $H_1: F(\cdot)\neq G(\cdot)$

Test statistic: $t(\boldsymbol{x})=\overline{Z}-\overline{Y}=\frac{1}{n}\sum_{i=1}^nZ_i-\frac{1}{m}\sum_{j=1}^mY_j$ , where $\boldsymbol{x}=\{\boldsymbol{z},\boldsymbol{y} = (Z_1,\cdots,Z_n,Y_1,\cdots,Y_m) \}$





# Hypothesis Testing with the Bootstrap

## Testing equality of two unknown distribution

**Background**

* Observed two indep random samples $z=(z_1,\cdots,z_n)^T$ and $y=(y_1,\cdots,y_m)^T$ drawn from possibly different cdfs $F(\cdot)$ and $G(\cdot)$
* Wish to test $H_0: F(\cdot)=G(\cdot)$ against $H_1: F(\cdot)\neq G(\cdot)$ 

**Ways**

* Let $\boldsymbol{x}=\{\boldsymbol{z},\boldsymbol{y} \}$ denote the combined sample

  * A bootstrap hypothesis test is based on a test statistic, denote by $t(\bold{x})=\overline{Z}-\overline{Y}=\frac{1}{n}\sum_{i=1}^n Z_i-\frac{1}{m}\sum_{j=1}^m Y_j$, where $\boldsymbol{x}=\{\boldsymbol{z},\boldsymbol{y} \}=(Z_1,\cdots,Z_n,Y_1,\cdots,Y_m)^T$

  * The observed value of $t(\bold{x})$ is denoted by $t_{obs}=t(\boldsymbol{x})=\overline{z}-\overline{y}=\frac{1}{n}\sum_{i=1}^n z_i-\frac{1}{m}\sum_{j=1}^m y_j$

* We seek an ==Achieved significance level(ASL) \ bootstrap p-value== of the test
  * ==ASL== is defined by $ASL=Pr\{t(\boldsymbol{x^*})\geq t_{obs}|H_0 \}$, 
  * where $\boldsymbol{x^*}=(X_1^*,\cdots,X_{n+m}^*)^T$, $X_1^*,\cdots,X_{n+m}^*$ is a ==random sample== from a population random variable $X^*$with cdf $F_0(\cdot)$
  * $F_0(\cdot)$: Let the ==empirical distribution== based on $\boldsymbol{x}$ be $\hat{F_0}(\cdot)$, putting prob $\frac{1}{n+m}$ on each component of $x$

**Steps**

1. Generate G bootstrap samples $\{\boldsymbol{x^*}(g) \}_{g=1}^G$ of size n+m with replacement from $\bold{x}=\{\bold{z},\bold{y} \}$

2. For each bootstrap sample, calculate
   $$
   t(\boldsymbol{x^*}(g))=\overline{z}^*(g)-\overline{y}^*(g)=\frac{1}{n}\sum_{i=1}^n z_i^*(g)-\frac{1}{m}\sum_{j=1}^m y_j^*(g)
   $$
   where $g=1,\cdots,G$

3. Estimate ASL by
   $$
   \hat{ASL}=\frac{number{\;} of{\;} \{t(\boldsymbol{x^*}(g))\geq t_{obs} \}}{G}
   $$
   









## Testing equality of two group means

* Null hypotheis $H_0: \mu_z=\mu_y$ against $H_1: \mu_z>\mu_y$

**Equal variance**

* The two-sample t statistic and its realization are defined by 
  $$
  t(\bold{x})=\frac{\overline{Z}-\overline{Y}}{S\sqrt{1/n+1/m}} {\;}and{\;}t(\boldsymbol{x})\frac{\overline{z}-\overline{y}}{s\sqrt{1/n+1/m}}
  $$
  where 
  $$
  s^2=\frac{\sum_{i=1}^n (z_i-\overline{z})^2+\sum_{j=1}^m(y_j-\overline{y})^2}{n+m-2}
  $$

* Assuming normal populations, under $H_0$, we have $t(\boldsymbol{x})\sim t(n+m-2)$

**Unequal variance**

* When $\sigma_1^2\neq \sigma^2_2$, the test statistic and its realization:
  $$
  t(\bold{x})=\frac{\overline{Z}-\overline{Y}}{\sqrt{S_1^2/n+S_2^2/m}}{\;} and{\;}t(\boldsymbol{x})=\frac{\overline{z}-\overline{y}}{\sqrt{s_1^2/n+s_2^2/m}}
  $$
  where 
  $$
  s_1^2=\frac{\sum_{i=1}^n(z_i-\overline{z})^2}{n-1} {\;} and {\;}s_2^2=\frac{\sum_{j=1}^m(y_i-\overline{y})^2}{m-1} {\;}
  $$
  

* Even for the normal populations, the $t(\bold{x})$ no longer follows a t-dimensional

  Thus a number of approximate solutions have been proposed

* Called ==Behren-Fisher problem==





## One sample problem

* Consider hypothesis $H_0: \mu_z=\mu_0$ against $H_1: \mu_z<\mu_0$



**With known variance**

* Assuming a normal population and a known variance, the test statistic and its realization are
  $$
  Z=\frac{\overline{Z}-\mu_0}{\sigma/\sqrt{n}}{\;}and{\;}z=\frac{\overline{z}-\mu_0}{\sigma/\sqrt{n}}
  $$

* Under $H_0,Z\sim N(0,1).$ Then the ASL or the p-value is given by 
  $$
  ASL=p-value=\Phi(\frac{\overline{z}-\mu_0}{\sigma/\sqrt{n}})\tag{5.14}
  $$
  

**Unknown variance**

* When $\sigma^2$ is unknown, the t-test gives
  $$
  ASL=p-value=Pr\{t(n-1)<\frac{\overline{z}-\mu_0}{s/\sqrt{n}} \}\tag{5.15}
  $$
  where $s^2=\frac{\sum_{i=1}^n (z_i-\overline{z})^2}{n-1}$















|      | 1                      | 2                      | 3      | 4                  | 5                 |
| ---- | ---------------------- | ---------------------- | ------ | ------------------ | ----------------- |
|      |                        | Matlab(荔园)           | 大数据 | 大数据             | Matlab(2教)       |
|      |                        | 多元统计分析(单)(一教) |        |                    | SAS(双周)（一教） |
|      |                        |                        |        |                    |                   |
|      | 大数据(单周)           | SAS(一教)              |        |                    |                   |
|      | 英语写作(一教)（双周） |                        |        | 多元统计分析(一教) |                   |
|      |                        |                        |        |                    | 英语写作 (一教)   |


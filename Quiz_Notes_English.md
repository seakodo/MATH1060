# Quiz Notes (1)

# Lecture 2

## Z-Score

For a sample: $z=\frac{x-\bar{x}}{s}$

For a population: $z=\frac{x-\mu}{\sigma}$

## Percentiles

$Percentile=\frac{\text{number of values}\le x}{\text{total number of values}}$

## Quartiles (IQR)

Steps:

1. Sort the data
2. Q2：Median

```markdown
# Find the median
x = c(1,2,3,...)
median(x)
```

# Lecture 3 - Combinatorics

### Playing Card Definitions

```markdown
The basic composition of a standard deck of playing cards (French-suited deck) and the numbers symbolizing the calendar are as follows:

Basic structure and counts
Total number of cards: 52 cards + 2 jokers/wild cards(Red Joker, Black Joker)

Number of suits: 4 ((Spade) spades ♠, (Heart) hearts ♥, (Club) clubs ♣, (Diamond) diamonds ♦)

    Number of cards per suit: 13 cards (A, 2 through 10, J, Q, K)

Number of colors: 2 (26 black cards, 26 red cards)

Face cards (Court cards): 12 cards (4 each of J(Jack), Q(Queen), K(King))

Number cards (Pip cards): 40 cards (4 each of A through 10; some counting conventions classify A as a special card, leaving 36 cards from 2 through 10)

Number of ACEs (A, ace): 4 cards (ace of spades, ace of hearts, ace of clubs, ace of diamonds)
```

### When to Use ✖️ and When to Use ➗

- AND, involving a multistage process
    - $P(A \cap B) = P(A) \times P(B \mid A)$
- OR
    - $P(A \cup B) = P(A) + P(B) \quad (\text{when } A, B \text{ are mutually exclusive})$
    - $P(A \cup B) = P(A) + P(B) - P(A \cap B) \quad (\text{when } A, B \text{ are not mutually exclusive})$

## 3 Counting Methods

n: the number of available choices for each position

r: the number of positions

**Do not misread the numbers!**

Main considerations:

- Whether replacement is allowed
- Whether order matters

|  | Replacement allowed | Does order matter | Common scenarios |
| --- | --- | --- | --- |
| $n^r$ | <span style="color: #659c83;">Yes</span> | <span style="color: #659c83;">**Order matters**</span> | • All possible outcomes of rolling 2 dice<br>• All possible outcomes of tossing 3 coins |
| Permutations<br>$_nP_r=\frac{n!}{(n-r)!}$ | <span style="color: #e74c3c;">No</span> | <span style="color: #659c83;">**Order matters**</span> | • Randomly drawing 2 balls from a collection, with the first being a red ball and the second being a basketball<br>• Selecting 2 of 10 candidates to fill different positions |
| Combinations:<br>$_nC_r=(^n_r)=\frac{n!}{r!(n-r)!}$ | <span style="color: #e74c3c;">No</span> | <span style="color: #e74c3c;">**Order does not matter**</span> | • Randomly drawing any 2 balls from a collection |

**Some problems can be solved using either $nCr$ or $nPr$**

Spiner = Spinner

## Bayes’ Theorem

$P(B|A)=\frac{P(A|B)\cdot P(B)}{P(A)}$

Total Probability: $P(A)=P(A|B)P(B)+P(A|B^c)P(B^c)$

Problem characteristics: given P(+|U), find P(U|+)

Steps:

1. Define $U$ and $U_c$, and list the values of $P(U)$ and $P(U_c)$; their sum is 1
2. Let $+=\text{test positive}$
3. Identify and calculate the following from the problem:
    1.  $P(+|U)$ : true positive
    2.  $P(-|U)$ : false negative
    3.  $P(+|U_c)$: false positive
    4.  $P(-|U_c)$: true negative
    
    Use the formulas: $P(+|U) + P(-|U)=1$, $P(+|U_c) + P(-|U_c)=1$
    
4. Substitute into the formula

## Lecture 3 R Code

```markdown
# n!
factorial(n)
# nCr
nCr <- function(n, r) {
  choose(n, r)
}
  # or
choose(n, r)
# nPr
nPr <- function(n, r) {
  choose(n, r) * factorial(r)
}
nPr(n, r)
```

# Lecture 4 - Discrete Probability Distributions

## General Formulas

- Expected Value (Mean): $E(X)=\mu=\sum_{i}x_iP(x_i)$
- Variance ($\sigma^2$) and Standard Deviation($\sigma$): $\sigma^2=E(X^2)-\mu^2$

## Binomial Distribution

Problem characteristics:

- Given: n (trial count, sample size), p (fixed probability)
- Find: the probability of obtaining more than, exactly, exactly, … m successes in n trials
- Steps:
    1. Write the formulas: $P(X=x)=(_x^n)p^x(1-p)^{n-x}$, $E(X)=np$, $\sigma=\sqrt{np(1-p)}$
    2. Define $X$ and state its distribution: X has a binomial distribution for p = ???, $X\sim Bin(n, p)$
    3. Find the probability of obtaining exactly m successes: 
        
        $P(X=m)=(_x^n)p^x(1-p)^{n-x}=dbinom(m, n, p)$
        
    4. Find the probability of obtaining at most m successes:
        
        $P(X\le m)=\sum_{i=0}^m(_{x_{i}}^n)p^{x_{i}}(1-p)^{n-x_{i}}=pbinom(m, n, p)$
        
    5. Find the probability of obtaining more than m successes
        
        $P(X> m)=1-P(X\le m)=1-\sum_{i=0}^m(_{x_{i}}^n)p^{x_{i}}(1-p)^{n-x_{i}}=1-pbinom(m, n, p)$
        

## Poisson Distribution

Problem characteristics:

- Given: a time interval and the average number of successes $\lambda$ in that interval
- Common scenarios: time intervals, the number of defects per unit area, the number of printing errors per page
- Find: the probability that the number of successes in the time interval is greater than, equal to, less than, … a given number

Steps:

1. Write the formulas: $P(X=x)=\frac{e^{\lambda}\lambda^x}{x!}$, $E(X)=\lambda$, $\sigma=\sqrt{\lambda}$
2. State the distribution: $X\sim Pois(\lambda)$
3. If the time interval of interest differs from the interval given in the problem, scale the number of events proportionally to the interval of interest
4. Find the probability of exactly m events in the interval: $P(X=x)=\frac{e^{\lambda}\lambda^x}{x!}$= $dpois(x, \lambda)$
5. Find the probability of $\le$m events in the interval: $P(X\le m)=\sum_{i=0}^{m}\frac{e^{\lambda}\lambda^{x_{m}}}{x_{m}!}$= $ppois(m, \lambda)$
6. Find the probability of >m events in the interval: $P(X>m)=1-P(X\le m)=1-\sum_{i=0}^{m}\frac{e^{\lambda}\lambda^{x_{m}}}{x_{m}!}$= $1-ppois(m, \lambda)$

# Lecture 5 - Continuous Distributions

## Uniform Distribution

Problem characteristics

- Given: the range of x, f(x) = value
- Find: P (a < X < b), mean ($\mu$), variance ($\sigma^2$)

Steps:

- To find P (a < X < b), write the formula: $P (a < X < b)=\int_{a}^{b}f(x)dx$
    - That is, P (a < X < b) = $f(x) \times (b - a)$
- To find $\mu$: write the formula: $\mu=\frac{a + b}{2}$
- To find $\sigma^2$: write the formula: $\sigma^2=\frac{(b - a)^2}{12}$ (12 is a constant)

## Standard Normal Distribution

Problem characteristics:

- Given: $\mu$, $\sigma$; **If n is given in the problem, the CLT is very likely needed!**
- The range of X is given
- Find: the probability that X lies in an interval, such as P (1 < X < 3), or P(X>2)

Steps:

1. Write the formulas: $\phi(Z)=\frac{1}{\sqrt{2\pi}}e^{-\frac{z^2}{2}}$, $Z=\frac{X-\mu}{\sigma}\approx N(0, 1)$ 
    
    (ϕ(Z) denotes the special case of the PDF with mean $\mu = 0$ and standard deviation $\sigma = 1$)
    
2. List $\mu$, $\sigma$
3. Write: P (a < X < b), replacing a and b with the actual values from the problem
4. Convert X to Z: apply the same calculation to all parts of the inequality above
    1. P (a < X < b) = P( $\frac{a - \mu}{\sigma}$ < $\frac{X-\mu}{\sigma}$ < $\frac{b - \mu}{\sigma}$)
    2. = P( $\frac{a - \mu}{\sigma}$ < Z < $\frac{b - \mu}{\sigma}$)   (write $\frac{X-\mu}{\sigma}$ as Z)
    3. = P(Z<$\frac{b - \mu}{\sigma}$)  - P(Z< $\frac{a - \mu}{\sigma}$)  
    4. = $\phi(\frac{b-\mu}{\sigma}) - \phi(\frac{b-\mu}{\sigma})$   Calculate: (pnorm($\frac{b - \mu}{\sigma}$)  - pnorm( $\frac{a - \mu}{\sigma}$) , right-hand value - left-hand value)

## Sampling Distributions (Use CLT)

Sampling Distributions is distribution of means of samples in size n drawn from a population.

Problem characteristics:

- n, the sample size, is given; for example, the number of repetitions is explicitly stated
    - If $n\ge30$: s can be used in place of $\sigma$; $\sigma$ may be unknown
    - If $n<30$: the problem must explicitly state that the distribution is normal, and $\sigma$ must be known
- The range of $\bar{X}$ is given
- Find: the probability that $\bar{X}$ lies in a specified range, such as P (a < $\bar{X}$<b)

Steps:

1. Write the formulas: $\phi(Z)=\frac{1}{\sqrt{2\pi}}e^{-\frac{z^2}{2}}$, $Z=\frac{\bar{X}-\mu}{\sigma_{\bar{X}}}$, $\sigma_{\bar{X}}=\frac{\sigma}{\sqrt{n}}$, $\mu_{\bar{X}}=\mu$
2. List
    - n
    - Write $\sigma$; if $\sigma$ is unknown, write $\sigma=s$, and indicate whether this is because $n<30$ or because the problem states that the distribution is normal
    - $\mu$
3. Calculate $\sigma_{\bar{X}}$: $\sigma_{\bar{X}}=\frac{\sigma}{\sqrt{n}}$
4. Write P (a < $\bar{X}$ < b), replacing a and b with the actual values from the problem
5. Convert X to Z: apply the same calculation to all parts of the inequality above
    1. P (a < $\bar{X}$ < b) = P( $\frac{a - \mu}{\sigma_{\bar{X}}}$ < $\frac{\bar{X}-\mu}{\sigma_{\bar{X}}}$ < $\frac{b - \mu}{\sigma_{\bar{X}}}$)
    2. = P( $\frac{a - \mu}{\sigma_{\bar{X}}}$ < Z < $\frac{b - \mu}{\sigma_{\bar{X}}}$)   (write $\frac{\bar{X}-\mu}{\sigma_{\bar{X}}}$ as Z)
    3. = P(Z<$\frac{b - \mu}{\sigma_{\bar{X}}}$)  - P(Z< $\frac{a - \mu}{\sigma_{\bar{X}}}$)  
    4. =  $\phi(\frac{b-\mu}{\sigma_{\bar{X}}}) - \phi(\frac{b-\mu}{\sigma_{\bar{X}}})$, calculate: pnorm($\frac{b - \mu}{\sigma_{\bar{X}}}$)  - pnorm( $\frac{a - \mu}{\sigma_{\bar{X}}}$)  

## Given a Probability Above or Below a Value, Find the Corresponding Value

From Lecture 5 Sample, Question 2, (c)

Problem characteristics:

- The given variables are the same as in Standard Normal Distribution and Sampling Distributions
- However, the range of $X$ or $\bar{X}$ is not given; instead, a probability such as P(X < b) or P(X > a) is given, for example $p_a$, $p_b$
- Find: a or b

Steps:

1. Follow the same initial steps
2. Write P ($X$ > a) = $p_a$ (using a as an example)
3. For P ($X$> a), convert it to the form P($\bar{X}$<a), with 1 - $p_a$ on the right-hand side
4. For P ($X$< b), no conversion is needed
5. P($X$<a) = 1 - $p_a$
    1. P(X < $\frac{a-\mu}{\sigma}$)=1 - $p_a$
    2. $\phi(\frac{a-\mu}{\sigma})=1-p_a$
    3. $\frac{a-\mu}{\sigma}$ =$\phi^{-1}(1-p_a)$ = qnorm(1 - $p_a$)
    4. Solve for a

## Binomial to Normal Approximation (May Not Be on the Exam)

Problem characteristics:

- Given: n, p, and the binomial conditions are satisfied (the outcomes are binary)
- Find P (a < X < b)

Steps:

1. Write the formulas: $X\stackrel{\text{approx}}{\sim}N(\mu=np, \sigma=\sqrt{np(1-p)})$, $Z=\frac{X-\mu}{\sigma}$
2. List n, p
3. Calculate np and n(1-p)
4. Because np $\ge$ 5, and n(1-p) $\ge$ 5
5. Therefore, the normal approximation is appropriate
6. Calculate $\mu$=np, $\sigma=\sqrt{np(1-p)}$
7. Write: P (a $\le$ X $\le$ b), replacing a and b with the actual values from the problem
8. Convert X to Y(0.5 is a constant):
    
    Using the continuity correction: P (a $\le$ X $\le$ b) $\approx$ P (a - 0.5 $\le$ Y $\le$ b + 0.5)
    
    For P (a $<$ X $<$ b), move a and b inward by 0.5
    
    The a and b below are the corrected values
    
9. Convert Y to Z: apply the same calculation to all parts of the inequality above
    1. P (a < Y < b) = P( $\frac{a - \mu}{\sigma}$ < $\frac{Y-\mu}{\sigma}$ < $\frac{b - \mu}{\sigma}$)
    2. = P( $\frac{a - \mu}{\sigma}$ < Z < $\frac{b - \mu}{\sigma}$)   (write $\frac{Y-\mu}{\sigma}$ as Z)
    3. = P(Z<$\frac{b - \mu}{\sigma}$)  - P(Z< $\frac{a - \mu}{\sigma}$)  
    4. = pnorm($\frac{b - \mu}{\sigma}$)  - pnorm( $\frac{a - \mu}{\sigma}$)  

## Poisson to Normal Approximation (May Not Be on the Exam)

Problem characteristics:

- Given: the number of occurrences in a fixed time interval ($\mu$), with $\mu\ge10$
- Find P (a < X < b)

Steps:

1. Write the formulas: $X\stackrel{\text{approx}}{\sim}N(\mu, \sigma=\sqrt{\mu})$, $Z=\frac{X-\mu}{\sigma}$
2. List $\mu$
3. Because $\mu$ $\ge$ 10
4. Therefore, the normal approximation is appropriate
5. Calculate $\sigma=\sqrt{\mu}$
6. Write: P (a < X < b), replacing a and b with the actual values from the problem
7. Convert X to Y(0.5 is a constant):
    
    Using the continuity correction: P (a $\le$ X $\le$ b) $\approx$ P (a - 0.5 $\le$ Y $\le$ b + 0.5)
    
    For P (a $<$ X $<$ b), move a and b inward by 0.5
    
    The a and b below are the corrected values
    
8. Convert X to Z: apply the same calculation to all parts of the inequality above
    1. P (a < Y < b) = P( $\frac{a - \mu}{\sigma}$ < $\frac{Y-\mu}{\sigma}$ < $\frac{b - \mu}{\sigma}$)
    2. = P( $\frac{a - \mu}{\sigma}$ < Z < $\frac{b - \mu}{\sigma}$)   (write $\frac{Y-\mu}{\sigma}$ as Z)
    3. = P(Z<$\frac{b - \mu}{\sigma}$)  - P(Z< $\frac{a - \mu}{\sigma}$)  
    4. = pnorm($\frac{b - \mu}{\sigma}$)  - pnorm( $\frac{a - \mu}{\sigma}$)  

# Lecture 6 - Confidence Interval (2 Quiz in Midterm)

## Finding the Best Estimate

- Best estimate for µ: $\hat{μ}=\bar{x}$
- Best estimate for σ: $\hat{σ}=s$

## Calculating the Error Bound for a Confidence Interval

Problem characteristics:

- Given: n (n > 30), $\bar{x}$, σ (s),  **Confidence Level** (1 - $\alpha$, e.g., 95%)
- Find: Error Bound ($E$)
    - Question wording: what’s the 90% CI for the mean of ….
    - **2 within the mean, means (x - 2, x + 2)!**

Steps:

1. Write the formula: $E=z_{\frac{\alpha}{2}}\cdot\frac{σ}{\sqrt{n}}$
2. List n, σ, $\bar{x}$, CI=1 - $a$ = <Confidence Level>
    1. $\bar{x}$ may need to be calculated as “sum of the given data/n”, using mean() in RStudio
    2. s($\sigma$) may need to be calculated from all the data values, using sd() in RStudio
3. Calculate $z_{\frac{a}{2}}$: 
    1. 1 - $a$ = Confidence Level
    2. **$1-\frac{\alpha}{2}$ = $\frac{1 + \text{Confidence Level}}{2}$**
    3. $z_{\frac{\alpha}{2}}$ =  $\phi^{-1}(1-\frac{\alpha}{2})$ = qnorm(1 - $\frac{\alpha}{2}$)
4. Calculate E:  $E=z_{\frac{\alpha}{2}}\cdot\frac{σ}{\sqrt{n}}$
5. $\therefore$ confidence interval: ($\bar{x}$ - E, $\bar{x}$ + E) with xx% confidence

## Calculating the Sample Size

Problem characteristics:

- Given: **Confidence Interval** (1 - $\alpha$, e.g., 95%), σ (s), $E$
- Find: n (sample size)

Steps:

1. Write the formula: $n=(\frac{z_{\frac{\alpha}{2}}\cdotσ}{E})^2$
2. List: CI=1 - $\alpha$ = Confidence Level, σ (s), $E$
3. Calculate $z_{\frac{a}{2}}$:
    1. 1 - $\alpha$ = Confidence Level
    2. $1-\frac{\alpha}{2}$ = $\frac{1 + \text{Confidence Level}}{2}$
    3. $z_{\frac{\alpha}{2}}$ = $\phi^{-1}(1-\frac{\alpha}{2})$ = qnorm(1 - $\frac{\alpha}{2}$)
4. Calculate n: $n=(\frac{z_{\frac{\alpha}{2}}\cdotσ}{E})^2$, substitute the values, and **remember to round up**

## Selecting the Sampling Distribution Based on n

Read from left to right: the combination of the first three columns determines the **Sampling Distribution** in the fourth column

| **Sample Size** | **Pop. Distribution** | **Pop. Standard Deviation** | **Sampling Distribution** |
| --- | --- | --- | --- |
| n ≥ 30 | Any | Known or (σ ≈  s) | Normal |
| n < 30 | Normal | Known  | Normal |
| n < 30 | Normal | Unknown | t-Distribution |

## Student’s t-Distribution

Problem characteristics:

- Given: n (n ≤ 30), $\bar{x}$, s,  CI (1 - $\alpha$, Confidence Level), and the population must have a normal distribution
- Unknown: σ (population standard deviation)
- Find: Error Bound ($E$)

Steps:

1. Write the formula: $E=t_{\frac{\alpha}{2},df}\cdot\frac{s}{\sqrt{n}}$ , note that $\frac{\alpha}{2}$ and df are at the same subscript level, separated by a comma
2. State that n < 30 and the distribution is normal, so use the t-Distribution
3. List n, $\bar{x}$, s, 1 - $\alpha$
4. Calculate: 1 - $\frac{\alpha}{2}$ = $\frac{1 + \text{Confidence Level}}{2}$
5. Calculate: df = n - 1
6. Calculate: $t_{\frac{\alpha}{2},df}$ = qt(1 - $\frac{\alpha}{2}$, df)
7. Find $E$: $E=t_{\frac{\alpha}{2},df}\cdot\frac{s}{\sqrt{n}}$
8. $\therefore$  confidence interval: ($\bar{x}$ - E, $\bar{x}$ + E) with xx% confidence
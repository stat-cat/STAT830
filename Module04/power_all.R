# install.packages("pwr")
library(pwr)

## Independent sample t-test with equal sample sizes

mu1 <- 12
mu2 <- 10
sigma <- 5
n1 <- 15
n2 <- 15
alpha <- .05
tails <- 2
Delta <- mu1 - mu2
df <- n1 + n2 - 2
delta <- Delta / (sigma*sqrt(1/n1+1/n2))
crit.lo <- qt(alpha/tails, df)
crit.hi <- qt(1-alpha/tails, df)
power.lo <- pt(crit.lo, df, delta)
power.hi <- 1 - pt(crit.hi, df, delta)
(power.tot <- power.lo + power.hi)

pwr.t.test(n=n1,d=Delta/sigma, sig.level=alpha, type="two.sample",
           alternative="two.sided")

delta1 <- c(0,.5,1,2,5)
x <- seq(-10,10,.01)

plot(x, dt(x,df, delta1[1]),type="l",col="black", lwd=2)
lines(x, dt(x,df, delta1[2]),col="blue", lwd=2, lty=2)
lines(x, dt(x,df, delta1[3]),col="green", lwd=2, lty=3)
lines(x, dt(x,df, delta1[4]),col="red", lwd=2)
lines(x, dt(x,df, delta1[5]),col="purple",  lwd=2)

## Independent sample t-test with unequal sample sizes

mu1 <- 12
mu2 <- 10
sigma <- 5
n1 <- 20
n2 <- 10
alpha <- .05
tails <- 2
Delta <- mu1 - mu2
df <- n1 + n2 - 2
delta <- Delta / (sigma*sqrt(1/n1+1/n2))
crit.lo <- qt(alpha/tails, df)
crit.hi <- qt(1-alpha/tails, df)
power.lo <- pt(crit.lo, df, delta)
power.hi <- 1 - pt(crit.hi, df, delta)
(power.tot <- power.lo + power.hi)

pwr.t2n.test(n1=n1,n2=n2,d=Delta/sigma, sig.level=alpha, 
             alternative="two.sided")

#### Balanced 1-Way ANOVA

mu <- c(40,50,60)
sigma <- 15
n <- 8
alpha <- 0.05
ss.mu <- sum((mu-mean(mu))^2)
Omega <- n * ss.mu / sigma^2
g <- length(mu)


(crit.hi <- qf(1-alpha,g-1,g*(n-1)))
(power.f <- 1 - pf(crit.hi,g-1,g*(n-1),Omega))


pwr.anova.test(k=g, n=n, f=sqrt(ss.mu/(g*sigma^2)), sig.level=alpha)

### The effect size is f, defined above in balanced 1-Way ANOVA


### Bivariate Correlation (Fisher's z-transformation)

n <- 64
r.0 <- .20
r.A <- .30
alpha <- .05
tails <- 2
(z.a2 <- qnorm(1-alpha/tails,0,1))
(sd <- 1/sqrt(n-3))

(z.r0 <- 0.5*log((1+r.0)/(1-r.0)))
(cv.lo <- z.r0 - z.a2*sd)
(cv.hi <- z.r0 + z.a2*sd)

(z.rA <- 0.5*log((1+r.A)/(1-r.A)))
(z.cv.lo <- -(z.rA - cv.lo)/sd)
(z.cv.hi <- -(z.rA - cv.hi)/sd)

power.lo <- pnorm(z.cv.lo,0,1)
power.hi <- 1-pnorm(z.cv.hi,0,1)
(power.tot <- power.lo + power.hi)

## Cohen's uses different approach (doesn't use alternative value of rho)

pwr.r.test(n=n, r=r.0, sig.level=alpha, alternative="two.sided")


### Power for linear models (e.g. Multiple Regression)

R2 <- .20
n <- 50
p <- 3
alpha <- 0.05

Omega <- (R2/(1-R2)) * n     ### From Proc Power Documentation
df1 <- p
df2 <- n-p-1

crit.F <- qf(1-alpha, df1, df2)
(power <- 1 - pf(crit.F, df1, df2, Omega))


pwr.f2.test(u=df1, v=df2, f2=R2/(1-R2), sig.level=alpha)


### Power for Comparing 2 Proportions Equal Sample sizes

n <- 50
p1 <- .70
p2 <- .50
alpha <- 0.05
tails <- 2
se <- sqrt(2/n)

cv.lo <- qnorm(alpha/tails,0,1)*se
cv.hi <- qnorm(1-alpha/tails,0,1)*se

d1 <- asin(sqrt(p1))
d2 <- asin(sqrt(p2))
d12.2 <- 2*(d1-d2)

z.cv.lo <- -(d12.2-cv.lo)/se
z.cv.hi <- -(d12.2-cv.hi)/se
power.lo <- pnorm(z.cv.lo,0,1)
power.hi <- 1-pnorm(z.cv.hi,0,1)
(power.tot <- power.lo + power.hi)

pwr.2p.test(h=d12.2, n=n, sig.level=alpha, alternative="two.sided")


### Power for Comparing 2 Proportions Unequal Sample sizes

n1 <- 50
n2 <- 40
p1 <- .70
p2 <- .50
alpha <- 0.05
tails <- 2
se <- sqrt(1/n1+1/n2)

cv.lo <- qnorm(alpha/tails,0,1)*se
cv.hi <- qnorm(1-alpha/tails,0,1)*se

d1 <- asin(sqrt(p1))
d2 <- asin(sqrt(p2))
d12.2 <- 2*(d1-d2)

z.cv.lo <- -(d12.2-cv.lo)/se
z.cv.hi <- -(d12.2-cv.hi)/se
power.lo <- pnorm(z.cv.lo,0,1)
power.hi <- 1-pnorm(z.cv.hi,0,1)
(power.tot <- power.lo + power.hi)

pwr.2p2n.test(h=d12.2, n1=n1, n2=n2, sig.level=alpha, alternative="two.sided")


### Power for chi-square tests

N <- 200
alpha <- 0.05
(p <- matrix(c(.34,.22,.14,.15,.10,.05),byrow=T,ncol=3))
(p1 <- rowSums(p))
(p2 <- colSums(p))
(p12 <- p1 %o% p2)
(ES <- sqrt(sum(((p-p12)^2/p12))))

ES.w2(p)

(df <- (nrow(p)-1)*(ncol(p)-1))
Omega <- N*ES^2

cv.test <- qchisq(1-alpha,df)
(power <- 1 - pchisq(cv.test,df,Omega))

pwr.chisq.test(w=ES, N=N, df=df, sig.level=alpha)




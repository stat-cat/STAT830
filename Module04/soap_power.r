# soap2.r, soap experiment, Table 3.12, page 64
# This script demonstrates how to calculate sample size or power for a one-way ANOVA 
# using the 'pwr' package in R.

# Install the pwr package if it is not already installed
# install.packages("pwr")
library(pwr)

# Number of treatment groups (k in ANOVA).
# Here we have 3 treatments being compared.
v = 3 

# Minimum difference between treatment means that we want to be able to detect.
# This is the "effect size" of interest (delta).
del = 0.25

# Estimated error variance (σ²). 
# Typically obtained from prior data, pilot studies, or literature.
sig2 = 0.007

# Significance level (α). 
alpha = 0.05

# Desired power (1 - β). 
pwr = 0.90

# Calculate f (the standardized effect size used in ANOVA).
# Formula: f = sqrt( (delta^2) / (2 * k * σ²) )
f = sqrt(del^2 / (2 * v * sig2))

# Use pwr.anova.test to calculate required sample size per group 
# given the number of groups (k), desired alpha, desired power, and effect size (f).
pwr.anova.test(k = v, sig.level = alpha, power = pwr, f = f)

# Alternatively: specify sample size per group (n) instead of power,
# and see what power results for that sample size.

# With n = 4 subjects per group
pwr.anova.test(k = v, sig.level = alpha, n = 4, f = f)

# With n = 5 subjects per group
pwr.anova.test(k = v, sig.level = alpha, n = 5, f = f)

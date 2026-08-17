# Significance level
alpha = .05    

# Number of treatment groups (v = k in ANOVA)
v = 3          

# Minimum difference in group means we want to detect (effect size on original scale)
Delta = .25    

# Sample size per group
n = 4          

# Estimated error variance (σ^2), often from pilot data
sig2 = .007    

# Standardized effect size (phi): measures how large Delta is relative to variability
# Formula: sqrt( Delta^2 / (2 * v * σ^2) )
phi = sqrt(Delta^2 / (2*v*sig2))   

# Noncentrality parameter (δ^2) for the noncentral F distribution
# Formula: v * n * phi^2
delta2 = v * n * phi^2             

# Critical F-value for given α, numerator df = v-1, denominator df = (n-1)*v
F_crit = qf(1 - alpha, v - 1, (n - 1) * v)

# Power calculation: probability of rejecting H0 when the true effect = Delta
# Uses noncentral F distribution with noncentrality = delta2
pf(F_crit, 
   v - 1,        # numerator df
   (n - 1) * v,  # denominator df
   delta2,       # noncentrality parameter
   lower = FALSE # compute upper tail probability
)

# Alternative power calculation using the 'pwr' package
# Here, f = phi is Cohen's effect size for ANOVA
library(pwr)
pwr.anova.test(k = v, f = phi, sig.level = alpha, n = 4)



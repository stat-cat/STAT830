# Group means (treatment averages) from the experiment
y_bar_1_dot <- 36.0
y_bar_2_dot <- 18.0
y_bar_3_dot <- 27.7
y_bar_4_dot <- 28.0
y_bar_5_dot <- 28.3
y_bar_6_dot <- 37.7
y_bar_7_dot <- 30.3

# Collect all treatment means into a single vector
y_bar_i_dot <- c(y_bar_1_dot, y_bar_2_dot, y_bar_3_dot, y_bar_4_dot,
                 y_bar_5_dot, y_bar_6_dot, y_bar_7_dot)

# Basic design parameters
v <- 7      # number of treatments (groups)
r <- 3      # number of replicates per treatment
N <- v*r    # total sample size
m <- 3      # number of contrasts being tested
mse <- 21.6 # mean square error from ANOVA
alpha <- 0.05  # significance level

# Critical t-values for confidence intervals
(t_unadj <- qt(alpha/2, N-v, lower.tail=FALSE))    # unadjusted t (no multiplicity correction)
(t_adj <- qt(alpha/2/m, N-v, lower.tail=FALSE))    # adjusted t (Bonferroni correction for m tests)

# ----------------------------
# Contrast 1: 
# c1 = average of treatments 1,4,7 minus average of treatments 2,3,5,6
c1 <- c(1/3, -1/4, -1/4, 1/3, -1/4, -1/4, 1/3)

# Estimate of contrast (linear combination of means)
(c1_est <- sum(c1*y_bar_i_dot))

# Standard error of contrast
(c1_se <- sqrt(mse*sum(c1^2/r)))

# Unadjusted confidence interval for contrast 1
(c1_unadj_ci <- c(c1_est - t_unadj*c1_se, c1_est + t_unadj*c1_se))

# Bonferroni-adjusted confidence interval for contrast 1
(c1_adj_ci <- c(c1_est - t_adj*c1_se, c1_est + t_adj*c1_se))

# ----------------------------
# Contrast 2:
# c2 = average of treatments 1 and 7 minus average of treatments 2,3,4,5,6
c2 <- c(0.5, -0.2, -0.2, -0.2, -0.2, -0.2, 0.5)

# Estimate, standard error, and CIs for contrast 2
(c2_est <- sum(c2*y_bar_i_dot))
(c2_se <- sqrt(mse*sum(c2^2/r)))
(c2_unadj_ci <- c(c2_est - t_unadj*c2_se, c2_est + t_unadj*c2_se))
(c2_adj_ci <- c(c2_est - t_adj*c2_se, c2_est + t_adj*c2_se))


# ----------------------------
# Contrast 3:
# c3 = average of treatments 1,2,4,5,6,7 minus treatment 3
c3 <- c(1, 1, -6, 1, 1, 1, 1)/6 

# Estimate, standard error, and CIs for contrast 3
(c3_est <- sum(c3*y_bar_i_dot))
(c3_se <- sqrt(mse*sum(c3^2/r)))
(c3_unadj_ci <- c(c3_est - t_unadj*c3_se, c3_est + t_unadj*c3_se))
(c3_adj_ci <- c(c3_est - t_adj*c3_se, c3_est + t_adj*c3_se))

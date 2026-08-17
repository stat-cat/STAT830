library(tibble)

options(digits=6)

# Read in the data
meat_packing <- tribble(
~Steak, ~Treatment, ~Count,
1, 1, 7.66,
6, 1, 6.98, 
7, 1, 7.8, 
12, 2, 5.26, 
5, 2, 5.44, 
3, 2, 5.8, 
10, 3, 7.41, 
9, 3, 7.33 ,
2, 3, 7.04, 
8, 4, 3.51,
4, 4, 2.91,
11, 4, 3.66
)

# Create a factor variable from treatment
meat_packing$fTreatment <- factor(meat_packing$Treatment, levels=1:4, labels=c("Commercial", "Vacuum", "Mixed Gas", "CO2"))

# Create a boxplot of log bacterial counts by packaging technique
# x-axis: treatment type, y-axis: log(count/cm²) of bacteria
boxplot(Count ~ fTreatment, data=meat_packing,
            xlab="Packaging technique", ylab="Log(count/cm2) of bacteria")

# Fit a linear model for Count using the factor variable Treatment
# This is equivalent to performing a one-way ANOVA
lm_fit <- lm(Count ~ fTreatment, data=meat_packing)

# Display the ANOVA table for the fitted model
(anova_res <- anova(lm_fit))


#------------------------------------------------------------------------------#
# Compute estimated contrasts and contrast CIs using emmeans package
library(emmeans)

# Compute least-squares means (group means adjusted for design)
(lsmType = lsmeans(lm_fit, ~ fTreatment)) 

# Show treatment factor levels
levels(meat_packing$fTreatment)

# Test specific contrasts of interest (differences between groups/combinations)
(meat_contrasts <- summary(contrast(lsmType, 
                 list(`T3-T4`=c( 0, 0, 1,-1),
                      `T2-T1`=c(-1, 1, 0, 0),
                      `(T1+T3)-(T2+T4)`=c( 1, 1,-1,-1)/2, 
                      `T1-(T2+T3+T4)`=c( 3,-1,-1, -1)/3),
                 infer = c(TRUE, TRUE),   # request CI and tests
                 level = 0.95, 
                 side = "two-sided")))

# Find the F-statistics by squaring the t-statistics
(meat_f_statistics <- meat_contrasts$t.ratio^2)
(F_crit <-  qf(0.05, 1, 8, lower.tail=FALSE))

#------------------------------------------------------------------------------#
# Manually compute estimated contrasts and contrast CIs
# Treatment group means
(y_bar_1_dot <- mean(meat_packing[meat_packing$fTreatment == "Commercial",]$Count))
(y_bar_2_dot <- mean(meat_packing[meat_packing$fTreatment == "Vacuum",]$Count))
(y_bar_3_dot <- mean(meat_packing[meat_packing$fTreatment == "Mixed Gas",]$Count))
(y_bar_4_dot <- mean(meat_packing[meat_packing$fTreatment == "CO2",]$Count))

# Extract the Mean Squared Error (MSE) from the ANOVA table
(mse <- anova_res["Residuals", "Mean Sq"])

# Store group means as a vector
y_bar_i_dot <- c(y_bar_1_dot, y_bar_2_dot, y_bar_3_dot, y_bar_4_dot)

v <- 4    # number of treatments
r <- 3    # number of replicates per treatment
N <- v*r  # total sample size

# Critical t-value for 95% CI with N-v degrees of freedom
(t_crit <- qt(0.025, N-v, lower.tail=FALSE))

# Critical F-value
(F_crit <- qf(0.05, 1, N-v, lower.tail=FALSE))

# Contrast: T3 - T4
c1 <- c(0, 0, 1, -1)                        # contrast coefficients
(c1_est <- sum(c1*y_bar_i_dot))             # contrast estimate
(c1_se <- sqrt(mse*sum(c1^2/r)))            # standard error
(c1_ci <- c(c1_est - t_crit*c1_se, 
            c1_est + t_crit*c1_se))         # confidence interval
(c1_F <- c1_est^2/mse/sum(c1^2/r))          # F-statistic

# Contrast: T2-T1
c2 <- c(-1, 1, 0, 0)
(c2_est <- sum(c2*y_bar_i_dot))
(c2_se <- sqrt(mse*sum(c2^2/r)))
(c2_ci <- c(c2_est - t_crit*c2_se, c2_est + t_crit*c2_se))
(c2_F <- c2_est^2/mse/sum(c2^2/r))

# Contrast: (T1+T2)-(T3+T4)
c3 <- c( 1, 1,-1,-1)/2
(c3_est <- sum(c3*y_bar_i_dot))
(c3_se <- sqrt(mse*sum(c3^2/r)))
(c3_ci <- c(c3_est - t_crit*c3_se, c3_est + t_crit*c3_se))
(c3_F <- c3_est^2/mse/sum(c3^2/r))

# Contrast: T1-(T2+T3+T4)
c4 <- c( 3,-1,-1, -1)/3
(c4_est <- sum(c4*y_bar_i_dot))
(c4_se <- sqrt(mse*sum(c4^2/r)))
(c4_ci <- c(c4_est - t_crit*c4_se, c4_est + t_crit*c4_se))
(c4_F <- c4_est^2/mse/sum(c4^2/r))

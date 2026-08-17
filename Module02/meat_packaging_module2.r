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

# Critical F-value at α = 0.05, with df1 = v-1 and df2 = N-v
(F_crit <- qf(0.05, 3, 8, lower.tail=FALSE))
(F_crit <- qf(0.95, 3, 8))

#------------------------------------------------------------------------------#
# Manually calculate the ANOVA table to show the underlying computations
# Overall (grand) mean of Count across all treatments
(y_bar_dot_dot <- mean(meat_packing$Count))

# Treatment group means
(y_bar_1_dot <- mean(meat_packing[meat_packing$fTreatment == "Commercial",]$Count))
(y_bar_2_dot <- mean(meat_packing[meat_packing$fTreatment == "Vacuum",]$Count))
(y_bar_3_dot <- mean(meat_packing[meat_packing$fTreatment == "Mixed Gas",]$Count))
(y_bar_4_dot <- mean(meat_packing[meat_packing$fTreatment == "CO2",]$Count))

# Deviations of each observation from its group mean (within-group errors)
# These will be used to compute the SSE
(err1 <- meat_packing[meat_packing$fTreatment == "Commercial",]$Count - y_bar_1_dot)
(err2 <- meat_packing[meat_packing$fTreatment == "Vacuum",]$Count - y_bar_2_dot)
(err3 <- meat_packing[meat_packing$fTreatment == "Mixed Gas",]$Count - y_bar_3_dot)
(err4 <- meat_packing[meat_packing$fTreatment == "CO2",]$Count - y_bar_4_dot)

# Deviations of each group mean from the grand mean
# These will be used to compute the SST
(td1 <- y_bar_1_dot - y_bar_dot_dot)
(td2 <- y_bar_2_dot - y_bar_dot_dot)
(td3 <- y_bar_3_dot - y_bar_dot_dot)
(td4 <- y_bar_4_dot - y_bar_dot_dot)

# Total number of observations and number of groups
N <- 12      # total sample size
v <- 4       # number of treatments

# Sum of Squares for Error (SSE): variability within groups
(SSE <- sum(c(err1^2, err2^2, err3^2, err4^2)))

# Mean Square Error (MSE): average within-group variance
(MSE <- SSE / (N - v))

# Sum of Squares for Treatments (SST): variability between group means
# Multiplying each squared deviation by group size (here, 3 observations per group)
(SST <- sum(c(3*td1^2, 3*td2^2, 3*td3^2, 3*td4^2)))

# Mean Square for Treatments (MST): average between-group variance
(MST <- SST/(v-1))

# Total Sum of Squares (SStot): overall variability in the data
(SStot <- SST + SSE)

# F-statistic: ratio of between-group variance to within-group variance
(F_value <- MST/MSE)

# p-value: probability of observing this F-value or larger under the null hypothesis
(p_value <- pf(F_value, 3, 8, lower.tail=FALSE))

# compare these values to what we obtained from anova()
anova_res

#------------------------------------------------------------------------------#
# Use the full and reduced model framework
full <- lm(Count ~ fTreatment, data=meat_packing)
reduced <- lm(Count ~ 1, data=meat_packing)

anova(full)
anova(reduced)

# Residual sums of squares
(SSE_full    <- sum(residuals(full)^2))
(SSE_reduced <- sum(residuals(reduced)^2))

# Extra SS explained by Treatment (SST)
(SST <- SSE_reduced - SSE_full)

# Proceed with inference as we did above
(MST <- SST/(v-1))
(MSE <- SSE_full/(N-v))

(F_value <- MST/MSE)
(p_value <- pf(F_value, 3, 8, lower.tail=FALSE))


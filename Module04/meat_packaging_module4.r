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

# ----------------------------
# Compute the following contrasts:
# 1. Pure CO2 versus gas mixture
# 2. Vacuum versus commercial
# 3. No gas versus added gas
# 4. Commercial packaging to the other three types of packaging

# No Adjustment
summary(contrast(lsmType, 
                 list(`T3-T4`=c( 0, 0, 1,-1),
                      `T2-T1`=c(-1, 1, 0, 0),
                      `(T1+T3)-(T2+T4)`=c( 1, 1,-1,-1)/2, 
                      `T1-(T2+T3+T4)`=c( 3,-1,-1, -1)/3),
                 infer = c(TRUE, TRUE),  
                 level = 0.95, 
                 side = "two-sided", adjust="none"))

# Bonferroni Adjustment
summary(contrast(lsmType, 
                 list(`T3-T4`=c( 0, 0, 1,-1),
                      `T2-T1`=c(-1, 1, 0, 0),
                      `(T1+T3)-(T2+T4)`=c( 1, 1,-1,-1)/2, 
                      `T1-(T2+T3+T4)`=c( 3,-1,-1, -1)/3),
                 infer = c(TRUE, TRUE),  
                 level = 0.95, 
                 side = "two-sided", adjust="bonferroni"))

# Scheffe's Adjustment
summary(contrast(lsmType, 
                 list(`T3-T4`=c( 0, 0, 1,-1),
                      `T2-T1`=c(-1, 1, 0, 0),
                      `(T1+T3)-(T2+T4)`=c( 1, 1,-1,-1)/2, 
                      `T1-(T2+T3+T4)`=c( 3,-1,-1, -1)/3),
                 infer = c(TRUE, TRUE),  
                 level = 0.95, 
                 side = "two-sided", adjust="scheffe"))


# ----------------------------
# Pairwise contrasts
#estimate pairwise contrasts with no adjustment
summary(contrast(lsmType, method = "pairwise", adjust="none"), 
infer = c(T, T), level = 0.95, side = "two-sided")

#estimate pairwise contrasts with Tukey's Method
summary(contrast(lsmType, method = "pairwise", adjust = "tukey"), 
infer = c(T, T), level = 0.95, side = "two-sided")

#estimate pairwise contrasts with Bonferroni's Method
summary(contrast(lsmType, method = "pairwise", adjust = "bonferroni"), 
infer = c(T, T), level = 0.95, side = "two-sided")

#estimate pairwise contrasts with Scheffe's Method
summary(contrast(lsmType, method = "pairwise", adjust = "scheffe"), 
infer = c(T, T), level = 0.95, side = "two-sided")

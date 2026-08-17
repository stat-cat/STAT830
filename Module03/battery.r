
# battery.r, battery experiment, Table 4.3, page 95, Dean & Voss text
# introduction to battery experiment is in section 2.5.2, page 26

setwd('S:/Biostats/BIO-STAT/Lynn Hinton/Teaching/STAT 830/Datasets')

battery.data = read.table("battery.txt", header=T)
battery.data$fType = factor(battery.data$Type)
dim(battery.data)

head(battery.data)
attach(battery.data)

model1 = aov(LPUC ~ fType, data=battery.data) # Fit aov model
anova(model1) # Display 1-way ANOVA

tapply(LPUC, fType, FUN=mean)

# Individual contrasts: estimates, CIs, tests

# library(lsmeans)
library(emmeans)

(lsmType = lsmeans(model1, ~ fType)) # Compute and save lsmeans
levels(battery.data$fType)
summary(contrast(lsmType, list(Duty=c( 1, 1,-1,-1)/2, #(T1+T2)-(T3+T4)
                              Brand=c( 1,-1, 1,-1)/2, #(T1+T3)-(T2+T4)
                                 DB=c( 1,-1,-1, 1)/2)), #(T1+T4)-(T2+T3)
        infer=c(T,T), level=0.95, side="two-sided")

## Trying without dividing by 2 gives wrong answers -- 
summary(contrast(lsmType, list(Duty=c( 1, 1,-1,-1),
                               Brand=c( 1,-1, 1,-1),
                               DB=c( 1,-1,-1, 1))),
        infer=c(T,T), level=0.95, side="two-sided")

# Multiple comparisons
confint(lsmType, level=0.90) # Display lsmeans and 90

# Tukey's method
summary(contrast(lsmType, method="pairwise", adjust="tukey"),
        infer=c(T,T), level=0.99, side="two-sided")

# Dunnett's method
summary(contrast(lsmType, method="trt.vs.ctrl", adjust="mvt", ref=1),
        infer=c(T,T), level=0.99, side="two-sided")

# Bonferroni method
summary(contrast(lsmType, method="pairwise", adjust="bonferroni"),
        infer=c(T,T), level=0.99, side="two-sided")


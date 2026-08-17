library(tibble)

options(digits=6)

trout <- tribble(~SULFA, ~HEMO,
1, 6.7, 1, 7.8,
1, 5.5, 1, 8.4,
1, 7.0, 1, 7.8,
1, 8.6, 1, 7.4,
1, 5.8, 1, 7.0,
2, 9.9, 2, 8.4,
2, 10.4, 2, 9.3,
2, 10.7, 2, 11.9,
2, 7.1,2, 6.4,
2, 8.6,2, 10.6,
3, 10.4,3, 8.1,
3, 10.6,3, 8.7,
3, 10.7,3, 9.1,
3, 8.8,3, 8.1,
3, 7.8,3, 8.0,
4, 9.3,4, 9.3,
4, 7.2,4, 7.8,
4, 9.3,4, 10.2,
4, 8.7,4, 8.6,
4, 9.3,4, 7.2)

# Create a boxplot of Hemoglobin counts by treatment
# x-axis: treatment type, y-axis: Hemoglobin level
boxplot(HEMO ~ factor(SULFA), data=trout,
        xlab="Treatment", ylab="Hemoglobin (grams per 100 ml)")

# Fit a linear model for Hemoglobin using the factor variable Treatment
trout_fit <- lm(HEMO ~ factor(SULFA), data=trout)

# Display the ANOVA table for the fitted model
anova(trout_fit)
# Residuals vs Fitted: look for a random ‘cloud’ around 0 (no curvature; constant spread).
# Normal Q–Q: points near the line indicate roughly normal residuals.
# Scale–Location: like Residuals vs Fitted but on sqrt(|resid|); we want a flat band (constant variance).
# Residuals vs Leverage: flags high-leverage points and influential cases 
plot(trout_fit)


#------------------------------------------------------------------------------#
# Check form of the model
# calculate standardized residuals of the model
trout$std_resids <- scale(residuals(trout_fit))[,1]
plot(trout$SULFA, trout$std_resids, xlab="Treatment", ylab = "Std. Residuals",
     pch = 19, col = rgb(0, 0, 0, alpha = 0.5), xaxt = "n")
axis(1, at = seq(1, 4, 1)) 
abline(h = 0, col = "darkred", lty = 2, lwd=2) # Add horizontal line at 0

#------------------------------------------------------------------------------#
# Check Outliers
# Plot the standardized residuals against treatment
plot(trout$SULFA, trout$std_resids, xlab="Treatment", ylab = "Std. Residuals",
     pch = 19, col = rgb(0, 0, 0, alpha = 0.5), xaxt = "n")
axis(1, at = seq(1, 4, 1)) 
abline(h = 0, col = "darkred", lty = 2, lwd=2) # Add horizontal line at 0

#------------------------------------------------------------------------------#
# Check for Independence
# Assume that the trout were collected in the order presented here
trout$order <- 1:40

# Plot the standardized residuals against order of collection
plot(trout$order, trout$std_resids, xlab="Order of Collection", ylab = "Std. Residuals",
     pch = 19, col = rgb(0, 0, 0, alpha = 0.5))
abline(h = 0, col = "darkred", lty = 2, lwd=2) # Add horizontal line at 0 

#----------------------------------------------------------------------------
# Check for Equal Variance
# Plot the standardized residuals against fitted values
trout$fitted_y <- fitted(trout_fit)
plot(trout$fitted_y, trout$std_resids, xlab="Fitted Values", 
     ylab = "Std. Residuals", pch = 19, col = rgb(0, 0, 0, alpha = 0.5))
abline(h = 0, col = "darkred", lty = 2, lwd=2) # Add horizontal line at 0
# For each treatment, calculate the mean and variance of HEMO
aggregate(HEMO ~ factor(SULFA), data=trout, var)
#----------------------------------------------------------------------------
# Check for Normality
qqnorm(trout$std_resids, pch = 19, col = rgb(0, 0, 0, alpha = 0.5))
qqline(trout$std_resids, col="steelblue", lwd=2)

#------------------------------------------------------------------------------#
# Equalized-Variance Transformation
# For each treatment, calculate the mean and variance of HEMO
ests <- aggregate(HEMO ~ factor(SULFA), data = trout, 
                  function(x) c(mean = mean(x), var = var(x)))
ests <- data.frame(ests$`factor(SULFA)`, ests$HEMO)
names(ests) <- c("SULFA", "y_mean", "y_var")
# Fit a simple linear regression model to check the relationship between group
# means and group variances
(y_bar_fit <- lm(log(y_var) ~ log(y_mean), data=ests))

# Create a scatter plot of group means vs. group variances
plot(log(ests$y_mean), log(ests$y_var), 
     xlab = expression(ln(bar(y)[i.])),
     ylab = expression(ln(s[i]^2)),
     pch = 19, col = rgb(0, 0, 0, alpha = 0.5))

# Add the fitted regression line from y_bar_fit to the plot
abline(y_bar_fit, lwd=2)

# set q equal to the slope of the fitted line
q <- coefficients(y_bar_fit)[2]
# apply the q transformation
trout$HEMO_trns <- trout$HEMO^(1-q/2)
# fit the model using the transformed y-values
trout_fit_trns <- lm(HEMO_trns ~ factor(SULFA), data=trout)

# output ANOVA table
anova(trout_fit_trns)

# compare variances 
(ests_trns <- aggregate(HEMO_trns ~ factor(SULFA), data = trout, var))

# calculate ratio of max(si^2) to min(si^2)
max(ests_trns$HEMO)/min(ests_trns$HEMO)

plot(trout_fit_trns)




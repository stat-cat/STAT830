library(tibble)

options(digits=6)

#------------------------------------------------------------------------------#
# Create the soap_data dataset 
# tribble() creates a tibble using a "row-wise" syntax for easy reading.
# Columns: Soap (treatment group), Cube (block/sample ID), Prewt (before drying),
#          Postwt (after drying), WtLoss (weight loss in grams).
soap_data <- tribble(~Soap, ~Cube, ~Prewt, ~Postwt, ~WtLoss,
1,    1,   13.14,  13.44,  -0.30,
1,    2,   13.17,  13.27,  -0.10,
1,    3,   13.17,  13.31,  -0.14,
1,    4,   13.17,  12.77,   0.40,
2,    5,   13.03,  10.40,   2.63,
2,    6,   13.18,  10.57,   2.61,
2,    7,   13.12,  10.71,   2.41,
2,    8,   13.19,  10.04,   3.15,
3,    9,   13.14,  11.28,   1.86,
3,   10,   13.19,  11.16,   2.03,
3,   11,   13.06,  10.80,   2.26,
3,   12,   13.00,  11.18,   1.82)

# Display first 5 lines of soap_data
head(soap_data, 5)  

#------------------------------------------------------------------------------#
# Create a factor variable for treatment 
# Convert numeric 'Soap' into a factor with descriptive labels.
# This is important for ANOVA because R treats factors differently than numbers.
soap_data$fSoap = factor(soap_data$Soap, levels=1:3, labels=c("Regular (1)", "Deodorant (2)", "Moisturing (3)"))

# Check the first 5 rows again to see the new factor variable
head(soap_data, 5)

# Confirm data types
class(soap_data$fSoap)
class(soap_data$Soap)


#------------------------------------------------------------------------------#
# Create a Scatter plot to view the data
# las=1 rotates y-axis labels horizontally.
# xaxt="n" suppresses the default x-axis so we can customize it.
plot(WtLoss ~ Soap, data=soap_data, ylab = "Weight Loss (grams)", las=1, xaxt = "n")

# Add a custom x-axis with tick marks at 1, 2, and 3
axis(1, at = seq(1, 3, 1)) 

#------------------------------------------------------------------------------#
# Summarize the data
# Show summary statistics for weight loss and the soap factor
summary(soap_data[,c("WtLoss", "fSoap")])

# Show means by soap factor
aggregate(WtLoss ~ fSoap, data = soap_data, mean)

#------------------------------------------------------------------------------#
# Fit a One-Way ANOVA Model
# install.packages("lsmeans")
model1 <- lm(WtLoss ~ fSoap, data=soap_data)
anova(model1)
summary(model1)

#------------------------------------------------------------------------------#
# Compute least-squares means for each soap type
# lsmeans (least-squares means) gives adjusted group means.
# This is useful for comparing means after ANOVA.
# install.packages("lsmeans") # Uncomment to install if not already installed
library(emmeans)

lsmeans(model1, "fSoap")

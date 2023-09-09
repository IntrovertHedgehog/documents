# Load the library
library(stats)

# Slide 8: Construct the Confidence Interval for the Example

# Confidence interval = point estimate +/- Critical value * Standard Error.
# Sample estimate is 8000
# Critical value is 1.96
# Standard error is 1500

8000 - 1.96 * 1500
8000 + 1.96 * 1500

## read in the datasets, the same ones used in earlier videos

df1 <- read.csv('data/math scores.csv')
# df1 <- read.csv('../data/math scores.csv')   # backup version
df2 <- read.csv('data/vaccination.csv')
# df2 <- read.csv('../data/vaccination.csv')   # backup version

# Slide 14:  Apply it to Example in Video 3-1

# mean, SD and sample size for group A
x1 <- mean(df1[df1$treatment == "a",2])
s1 <- sd(df1[df1$treatment == "a",2])
n1 <- 10

# mean, SD and sample size for group B
x2 <- mean(df1[df1$treatment == "b",2])
s2 <- sd(df1[df1$treatment == "b",2])
n2 <- 10

# point estimate = group A's mean score - group B's mean score
x1 - x2

# Slide 16: Standard Error

sp <- sqrt(((n1-1)*s1^2+(n2-1)*s2^2)/(n1+n2-2))
SE <- sp * sqrt(1/n1 + 1/n2)
SE

# Slide 18: t-distribution and Critical Value

# Critical value (for t-distribution)
qt(0.975,df=n1+n2-2)

# Slide 19: Construct the Confidence Interval for the Example 3-1

# Margin of error
moe <- qt(0.975,df=n1+n2-2) * SE
moe

# 95% Confidence interval = [point estimate - moe, point estimate + moe]
lowerCI <- (x1 - x2) - moe
upperCI <- (x1 - x2) + moe
c(lowerCI, upperCI) 

# t.test() also generates the confidence interval
# note that the restricition of t.test() is that it only works when the 
# test statistic equals sample mean, or difference of samples' mean. 
t.test(outcome~treatment, alternative = "two.sided", paired=FALSE, 
       var.equal=TRUE, data = df1)

# Slide 20: Construct the Confidence Interval for the Example 3-1 (Cont'd)

result1 <- t.test(outcome~treatment, alternative = "two.sided", 
                  paired=FALSE, var.equal=TRUE, data = df1)
result1$conf.int

# Slide 21: Calculate 95%CI for the Example in Video 3-3

# 2 by 2 contingency table of two categorical variables
table1 <- table(df2)
table1

# Sample size and sample proportion for the control group
n1 <- 24
p1 <- table1[1,1]/sum(table1[1,])
# Sample size and sample proportion for the vaccine group
n2 <- 24
p2 <- table1[2,1]/sum(table1[2,])

# Point estimate
p1 - p2

# Slide 22: Standard Error

SE <- sqrt(p1*(1-p1)/n1 + p2*(1-p2)/n2)
SE

# Slide 23: Normal Distribution and Critical Value

# Critical value (for normal distribution)
qnorm(0.975)

# Slide 24: Construct the Confidence Interval for the Example 3-3

# Margin of error
moe <- qnorm(0.975) * SE
moe

# 95% Confidence interval = [point estimate - moe, point estimate + moe]
lowerCI <- (p1 - p2) - moe
upperCI <- (p1 - p2) + moe
c(lowerCI, upperCI)

# In this example, we can either use chisq.test or use prop.test, which 
# return the same p-value.
# In particular, only the prop.test returns the confidence interval.
prop.test(table1, correct = FALSE)
chisq.test(table1, correct = FALSE)

# Slide 27: Check Assumptions

table1

# Continuity correction is recommended to be turned on, if 
# at least one number in the contingency table is less than 10. 
prop.test(table1, correct = TRUE)

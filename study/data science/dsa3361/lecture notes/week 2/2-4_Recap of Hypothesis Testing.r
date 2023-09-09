# Load the library
library(stats)

# Slide 7: Inspect the Dataset

## read in the dataset
df1 <- read.csv('data/math scores.csv')
# df1 <- read.csv('../data/math scores.csv')   # backup version

## If you encountered problems here, pls feel free to contact your instructors

str(df1)      ## check the data structure  

# Slide 8: Inspect the Dataset (Cont’d)

df1[,1]       ## the first column/variable of the data frame
df1[1:10,1]   ## the first 10 values of the first variable
df1[11:20,1]  ## the next 10 values of the first variable

# Slide 9: Inspect the Dataset (Cont’d)

df1[1:10,2]
mean(df1[1:10,2])                      ## mean score of group A
mean(df1[11:20,2])                     ## mean score of group B
mean(df1[11:20,2]) - mean(df1[1:10,2]) ## difference of two means

# Slide 10: Boxplot

boxplot(outcome~treatment, data = df1, ylab="scores", 
        xlab="Group",main="Scores of the two Groups")

# Slide 14: t-distribution

## pdf plot of t-distribution with df = 18
curve(dt(x, df=18), from=-4, to=4, lwd = 2)   
                                             
# Slide 15: t-distribution (Cont'd)

curve(dt(x, df=18), from=-4, to=4,
      main = "t-distribution with df = 18",
      xlab = "Test Statistic",
      ylab = "Probability",
      lwd = 2, 
      col = "steelblue",
      cex.lab = 1.5,
      cex.axis = 1.5,
      cex.main = 2)

# Slide 16: Calculate p-value in R

## the following calculates the p-value for the Independent 2-sample t-test
test1 <- t.test(outcome~treatment, alternative = "two.sided", paired=FALSE, 
       var.equal=TRUE, data = df1)      ## p-value = 0.07687
test1

# Slide 17: Test Statistic and p-value

## our test statistic is using group B minus group A
test_stat1 <- (-1) * test1$statistic
test_stat1

# Slide 22: Check Histograms

hist(df1[1:10,2], main="Histogram of Scores of Group A", xlab='Scores',
      cex.lab = 1.5,
      cex.axis = 1.5,
      cex.main = 2)

hist(df1[11:20,2], main="Histogram of Scores of Group B", xlab='Scores',
      cex.lab = 1.5,
      cex.axis = 1.5,
      cex.main = 2)

# Slide 23: Check Q-Q Plots

qqnorm(df1[1:10,2], pch = 1, cex = 2.5, main="Q-Q Plot of Group A",
       cex.lab = 1.5,
       cex.axis = 1.5,
       cex.main = 2)
qqline(df1[1:10,2], col = "steelblue", lwd = 2)

qqnorm(df1[11:20,2], pch = 1, cex = 2.5, main="Q-Q Plot of Group B",
        cex.lab = 1.5,
      cex.axis = 1.5,
      cex.main = 2)
qqline(df1[11:20,2], col = "steelblue", lwd = 2)


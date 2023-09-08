# Load the library
library(stats)

# Slide 9: Inspect the Dataset

## read in the dataset
df2 <- read.csv('data/vaccination.csv')
# df2 <- read.csv('../data/vaccination.csv')   # backup version

## If you encountered problems here, pls feel free to contact your instructors

head(df2)

# Slide 10: Inspect the Dataset (Cont'd)

str(df2)   # check the structure of the data frame

# prepare the variables
treatment <- df2$treatment
outcome <- df2$outcome

# Slide 11: "table()" Function

table1 <- table(df2)     # generate the contingency table of the two 
                         # categorical variables
table1

# test statistic = the difference of proportions of infections between the
# two groups = proportion of Control - proportion of Vaccine

# calculate the test statistic for the original sample
original <- table1[1,1]/sum(table1[1,]) - table1[2,1]/sum(table1[2,])
original 

# Slide 12: Barplot

# simplified version
barplot(t(table1), xlab="Treatment", legend=colnames(table1))

# colorful version        
barplot(t(table1), 
        main = "Number of Subjects by Treatment and Outcome Types",
        col=c("#0099CC", "#EF7C00"),
        border="white", 
        space=0.04, 
        font.axis=2, 
        cex.main = 1.6,
        cex.lab = 1.6,
        xlab="Treatment",
        legend=colnames(table1),
        args.legend = list(x = "right", inset = c(0.05, 0)))

# Slide 14: Define a Function

permutation.test2 <- function(treatment, outcome){
   # Generate a permutation sample
   treatment_p <- sample(treatment, size= length(treatment), replace=FALSE)
   # Calculate the test statistic for the permutation sample
   table_p <- table(treatment_p, outcome)
   table_p[1,1]/sum(table_p[1,]) - table_p[2,1]/sum(table_p[2,])
  }

# Slide 15: Use the "replicate()" Function to Run Multiple Simulations

# for reproducibility
set.seed(123) 
test2 <- replicate(10000, permutation.test2(treatment, outcome))

# Slide 16: Generate the Permutation Distribution

hist(test2, breaks = seq(-0.4, 0.5, by = 0.08),
     main="Permutation Distribution", xlab='Test Statistic')
abline(v=original, lty = 2, lwd = 3, col="red")
abline(v=-original, lty = 2, lwd = 3, col="red")

# Slide 19: Calculate the p-value

# two tailed p-value = 0.0492
pvalue <- mean(abs(test2) >= abs(original))
pvalue

# Slide 21: Calculate the p-value in a Chi-squared Test
chisq.test(df2$treatment, df2$outcome)   # p-value = 0.05132

# In our case, the Yates' continuity correction is needed as there is a 
# number 3 in the contingency table.

# In other cases, if you wish to turn off the continuity correction
chisq.test(df2$treatment, df2$outcome, correct = FALSE)

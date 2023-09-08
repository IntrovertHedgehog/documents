/*****************************************************************************************************
Title  : Tutorial 2
Purpose: Linear Regression with Binary Regressors; Assumming or not Assumming Heteroskedasticity
******************************************************************************************************/


*******************
****General Setup**
*******************

clear  /*This clears memory of all data*/
 
set mem 100m      /* Setting memory size - depending on your dataset you may need more or less*/

set matsize 500   /* Setting  number of RHS variables in a model */

/*set more on*/  /*This sets the 'more' at the bottom of the page on. I.e. if you have a model with lots of output, 
it pauses the execution after it reaches pagesize limit until you press any key for it to continue.*/

set more off  /*Turn the above thing off if you want it to do stuff continuously. Good if you're leaving the program to run 
for hours*/

pwd  /*shows us what directory Stata treats as working directory at the moment*/

cd "C:\Users\ecsskck\Desktop" /*change working directory*/

/* place the dataset caschool.dta, in the working directory at this point */


***************************
****Creating a log file****
***************************

* Sometimes, you want to keep a record of your STATA output. You can create a log file

log using Tutorial2.log, replace /*creates a new log file named Tutorial2 in your working directory*/

* Go ahead and run all of your commands. When you are done type "log close" and your STATA output will be saved in the log file


********************************
***Load and perform regression**
********************************

use caschool.dta, clear  /* Load data */

describe              /* description of data*/

summarize               /* summary statistics */

twoway (scatter testscr str) /*see the scatterplot of Test scores vs Student/Teacher Ratio*/

*A more complete command that adds x,y-axis labels and the figure title:
twoway (scatter testscr str), ytitle(Test Score) xtitle(STR) title(Scatterplot of Test Scores vs. STR)


reg testscr str, robust  /*simplest specification, heteroskedasticity-robust standard errors*/

*See what happens when you do not put the robust option - are the standard errors larger or smaller?

reg testscr str  /*simplest specification, homoskedasticity-only standard errors*/

*You can specify the confidence level you like. The default is 95% CI

reg testscr str, robust level(99) /*constructs 99% CI*/



****************************************
***REGRESSION WITH A BINARY VARIABLE****
**************************************** 

*create a variable which is equal to 1 if a district has a small class size and equal to 0 if it has a large class size:

gen smallstr = (str<20) /*create dummy smallstr, = 1 if str is less than 20*/

reg testscr smallstr, robust /*run regression with binary variable smallstr*/




*Now, we close the log-file so all the contents are saved

log close    /*results of all your commands will be saved in the log file named Tutorial2 in your working directory*/

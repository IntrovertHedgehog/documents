/*****************************************************************
Title  : Tutorial 1
Purpose: Stata setup, basic data manipulation and simple regression
******************************************************************/

/* This is how you do a comment in Stata. Open with /* and close with */  
You can also use just a star at the beginning of  the line, then the whole line will be ignored. 
The advantage of /* */ is that you can put it inside the line that contains the command*/

* E.g.: Comment


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

/* note to tutors: get students to place the datasets xyz_data.dta, xyz_data.csv, and cps08.dta in the working directory at this point */



********************************
***Load and manipulate data*****
********************************

*Now let's load a simple dataset containing variables X,Y,Z generated as in Question 2.23

use xyz_data.dta     /*Load data in Stata format*/

insheet using xyz_data.csv, clear /*Load data from the csv file, clear old data*/

preserve /*memorizes the present state of your dataset, can be recalled with 'restore'*/

rename x varx  /* example of renaming the variable*/

drop y /*drop a variable*/

keep if _n<=50 /*keep observations 1-50 for all variables*/

restore /*back to start after all the experiments*/



****************************
***A first look at the data
****************************

describe              /* description of data*/

summarize               /* summary statistics */


list y x in 20/30 /*Example of looking up specific observations*/

*you can also use "browse" command to look up data

browse

browse in 20/30

label variable z "Standard Normal variable" /*Example of labelling a variable*/



***********************
***Correlation puzzle**
***********************

correlate x y z /*compute the correlation coefficients.*/

twoway (scatter y x) /*let's see a scatterplot*/

*Let's see how can we make the correlation coefficient capture the relationship:

gen x2=x^2 /*construct a new variable x-squared*/

correlate x2 y

twoway (scatter y x2) /*shows you graphically what happened after the transformation*/



************************************************
***clear data in memory and load another dataset
************************************************

clear  /*This clears memory of all data*/
 

set mem 100m      /* Setting memory size - depending on your dataset you may need more or less*/

set matsize 500   /* Setting  number of RHS variables in a model */

/*set more on*/  /*This sets the 'more' at the bottom of the page on. I.e. if you have a model with lots of output, 
it pauses the execution after it reaches pagesize limit until you press any key for it to continue.*/

set more off  /*Turn the above thing off if you want it to do stuff continuously. Good if you're leaving the program to run 
for hours*/



**********************************************
***Load cps08 data and have a first look at it
***********************************************

use cps08.dta     /* Load data */

describe              /* description of data*/

summarize               /* summary statistics */

twoway (scatter ahe age) /*see the scatterplot of average hourly earnings vs age*/

*A more complete command that adds x,y-axis labels and the figure title:
twoway (scatter ahe age), ytitle(average hourly earnings) xtitle(age) title(Scatterplot of average hourly earnings vs. age)



/*****************************
* (1) Simple linear regression
*******************************/

reg ahe age  /*simplest specification, homoskedasticity-only errors*/


*Let's see how we can save u-hat (regression residuals) - by using predict command with option resid:

predict u, resid

*Syntax goes: predict 'varname', resid where 'varname' is the name you want to call your residual variable.


*We can use this command to get Y-hat as well, using option xb (easy way to remember: xb=x*beta)

predict yhat, xb


*An efficient way to plot both the scatter and the regression line:

twoway (scatter ahe age) (lfit ahe age), ytitle(average hourly earnings) xtitle(age) title(Scatterplot and OLS regression line of average hourly earnings vs. age)

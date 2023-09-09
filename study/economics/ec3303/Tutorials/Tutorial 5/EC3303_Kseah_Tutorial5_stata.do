/*************************************************************************
Title  : Stata Tutorial 5
Purpose: Fixed Effects Regression, Instrumental Variables Regression 
***********************************************************************/

clear  /*This clears memory of all data*/

set mem 100m      /* Setting memory size - depending on your dataset you may need more or less*/

set matsize 500   /* Setting  number of RHS variables in a model */

/*set more on*/  /*This sets the 'more' at the bottom of the page on. I.e. if you have a model with lots of output, 
it pauses the execution after it reaches pagesize limit until you press any key for it to continue.*/

set more off  /*Turn the above thing off if you want it to do stuff continuously. Good if you're leaving the program to run 
for hours*/

pwd  /*shows us what directory Stata treats as working directory at the moment*/

cd "C:\Users\ecsskck\Desktop" /*change working directory*/

/* place the dataset fatality.dta, in the working directory at this point */
 
use fatality.dta     /* Load data */



/*******************************************************
* (1) running first differenced regressions
*******************************************************/

* Regress fatality rate in 1982 on real beer tax in 1982, using OLS. What is the coefficient on real beer tax?

regress fatalityrate beertax if year==1982, robust

* Regress fatality rate in 1988 on real beer tax in 1988, using OLS. What is the coefficient on real beer tax?

regress fatalityrate beertax if year==1988, robust

* Here is how you create the first differenced variables using data from 1988 and 1982. 

preserve

gsort state -year /*Sort dataset by ascending values of state and descending values of year*/

keep if year==1988 | year==1982 /*keep only data from 1982 and 1988*/

bysort state: generate d_fatalityrate= fatalityrate[_n] - fatalityrate[_n-1]  /*create first differenced fatality rate variable*/

bysort state: generate d_beertax= beertax[_n] - beertax[_n-1]  /*create first differenced beer tax variable*/

regress d_fatalityrate d_beertax, cluster(state) /*run first differenced regression. We cluster standard errors by state so as to allow for correlation of regression errors within a state*/

restore


/*******************************************************
* (3) running fixed effects regressions
*******************************************************/

preserve

xtset state year /*declare the dataset to be a panel. xtset tells Stata to treat state as the entity variable & year as the time variable*/

xtreg fatalityrate beertax, fe cluster(state) /*fe tells STATA to run a fixed effects regression. cluster(state) tells Stata to cluster standard errors by state*/

restore



/*******************************************************
* (4) running IV regression analysis
*******************************************************/


use fertility.dta     /* Load a different dataset */

regress weeksworked morekids, robust /* run a simple naive regression of number of weeks worked on a binary variable indicating whether a woman has more than 2 children*/

ivregress 2sls weeksworked (morekids = samesex), robust /* use samesex as an instrument for morekids. The syntax is ivregress 2sls depvar [varlist1] (varlist2 = instrulist) [, options]*/

ivregress 2sls weeksworked (morekids = samesex), first robust /*to get the output showing the first-stage regression, add the option "first"*/

estat firststage /*the F-statistic from the first stage regression shows how relevant the instrument is. The rule of thumb is that the F-statistic should exceed 10. Otherwise, the instrument is "weak" and 2sls will lead to unreliable estimates. Here, the first stage F-statistic is 143.213. So we say that it passes the weak instrument test*/








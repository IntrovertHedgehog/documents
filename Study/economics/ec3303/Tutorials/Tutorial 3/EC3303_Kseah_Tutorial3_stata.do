/*****************************************************************************************************
Title  : Tutorial 3
Purpose: Linear regression with Multiple Regressors, Perfect Multicollinearity, Dummy Variable Trap
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



********************************
***Load and perform regression**
********************************

use caschool.dta, clear  /* Load data */

reg testscr str, robust  /* Run regression with a single regressor */

reg testscr str el_pct, robust /* See what happens when we include percentage english learners as a regressor */

*Now see what happens when we include yet another regressor - percentage of the students on free meal programme
reg testscr str el_pct meal_pct, robust


*********************************************
******* PERFECT MULTICOLLINEARITY************
*********************************************

*Let's create a variable that is a sum of el_pct and meal_pct
gen me_pct=el_pct+meal_pct

*See what happens when we include all three:
reg testscr str el_pct meal_pct me_pct, robust

*Why did it happen? Perfect linear relationship: me_pct=el_pct+meal_pct. Need to drop one to be able to compute OLS.


**************************
***DUMMY VARIABLE TRAP****
************************** 

*The most often-cited example of perfect multicollinearity is the so-called dummy variable trap:

gen hiel = (el_pct>=10) /*create dummy hiel, = 1 if el_pct is greater than or equal to 10*/

gen loel = (el_pct<10)  /*create dummy loel, = 1 if el_pct is less than 10*/

correlate hiel loel  /*check to see perfect correlation*/

reg testscr hiel loel, robust /*notice stata automatically drops one dummy*/




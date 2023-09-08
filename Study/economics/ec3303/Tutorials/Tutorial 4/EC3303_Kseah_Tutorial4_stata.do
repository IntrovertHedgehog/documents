/*************************************************************************
Title  : Stata Tutorial 4
Purpose: Non-linear regression analysis 
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

/* place the dataset caschool.dta, in the working directory at this point */
 
use caschool.dta     /* Load data */



/*******************************************************
* (1) testing hypothesis involving multiple coefficients
*******************************************************/

* Let's test if the coefficients on el_pct & meal_pct are jointly zero

reg testscr str el_pct meal_pct, robust

test el_pct meal_pct

* Let's test if the coefficients on el_pct & meal_pct are equal to each other

reg testscr str el_pct meal_pct, robust

test el_pct = meal_pct



/**************************************
* (2) Scatterplot of test score vs
district income against fitted OLS line 
***************************************/

*Let's try to replicate Figure 8.2 in the textbook

reg testscr avginc, robust /*run regression*/

predict yhat_lin  /*store predicted values*/

twoway (scatter testscr avginc) (line yhat_lin avginc), ytitle(Test Score) ///  /*Note three /// tell Stata that command continues on the next line*/
xtitle(District Income) title(Scatterplot and Linear fit of test score vs. income)

*another, shorter way to do it:

twoway (lfit testscr avginc) (scatter testscr avginc)

*You may save the graph in Stata format for future tweaking

graph save Fig8_2, replace



/****************************************
* (3) Graphing Nonlinear (Polynomial) Fit
*****************************************/

*Now examine quadratic fit:

twoway (qfit testscr avginc) (scatter testscr avginc)

*Again, that was the shortcut way, we can also do:

gen avginc2=avginc^2

reg testscr avginc avginc2, robust /*run quadratic regression*/

predict yh_quad   /*store predicted values*/

*Now plot the graph (note we sort on the X variable to have a nice smooth line):
twoway (scatter testscr avginc) (line yh_quad avginc, sort), ytitle(Test Score) ///
xtitle(Average Income) title(Scatterplot and Quadratic fit of test score vs. income)

graph save quad_fit, replace


* We can put graphs together by using combine:

graph combine Quad_fit.gph Fig8_2.gph /*Note file extensions have to be typed in. Graphs are put into one side-by-side*/

graph combine Quad_fit.gph Fig8_2.gph, col(1) /*Now we put them in a column - that looks better*/


*Now let's do the same graph as Figure 8.3:

twoway (scatter testscr avginc) (line yhat_lin avginc) (line yh_quad avginc, sort),  ytitle(Test Score) xtitle(Average Income) title(Replication of Figure 8.3)

graph save Fig8_3, replace


*Now examine cubic fit:

gen avginc3=avginc^3

reg testscr avginc avginc2 avginc3, robust

predict yh_cubic   /*store predicted values*/

twoway (scatter testscr avginc) (line yh_cubic avginc, sort)

graph save cube_fit, replace



/****************************************
* (4) Graphing Nonlinear (logarithmic) Fit
*****************************************/

* Let's examine a log-log fit

gen ltestscr =log(testscr)   /*this is how you log-transform a variable*/

gen lavginc = log(avginc)

reg ltestscr lavginc, robust   /*run log-log regression*/

predict yh_loglog   /*store predicted values*/  

twoway (scatter ltestscr avginc) (line yh_loglog avginc, sort), ytitle(log Test Score) xtitle(Average Income) title(log-log fit of Test Scores vs Income)


* You can also examine a linear-log and a log-linear fit

reg testscr lavginc, robust   /*run linear-log regression*/
reg ltestscr avginc, robust   /*run log-linear regression*/



/**************************
* (5) Function Graphs
**************************/ 
*Sometimes you'd like to see what a function looks like in a given range.
*E.g. log(x) between 0 and 100:

twoway function log(x), range(0 100) /*plots a log(x) function */

*Another example: high-order polynomial

twoway function 1+2*x+3*(x^2)+5*(x^3)+5*(x^4)+2*(x^5) , range(-50 50)  /*plots a polynomial function of degree 5*/



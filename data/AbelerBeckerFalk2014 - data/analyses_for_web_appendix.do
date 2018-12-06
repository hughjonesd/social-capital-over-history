


****************************************************************************************************************
*** Analysis for Abeler, Becker, Falk (2014) Representative Evidence on Lying Costs, Journal of Public Economics 
****************************************************************************************************************






{/* Description of data sets and variables

1coin_web_appendix.dta: data of 1-Coin-Telephone
4coin_web_appendix.dta: data of 4-Coin-Telephone, 4-Coin-Lab-Tel and 4-Coin-Lab-Click 


** Description of main variables


cn				Number of times tails was reported
rep0 .. rep4	Dummies for whether tails was reported 0..4 times
fieldtel		Treatment dummy for 4-Coin-Telephone
labtel			Treatment dummy for 4-Coin-Lab-Tel
labclick		Treatment dummy for 4-Coin-Lab-Click
lab				Dummy for lab treatments
payment_mode	How money was paid in telephone treatments (1: post, 2: gift code per email, 3: gift code per telephone, 4: refused payment)
age 			Age in years
female 			1 if female
income			Monthly household income (in 1000 euros)
protestant 		1 if protestant
catholic		1 if catholic
educ_1 			1 if professional education
educ_2			1 if academic education
risk_tolerance 	Self-reported risk tolerance (1: not willing to take risks, 7: very willing to take risks)
trust			Self-reported trust (1: one should be careful when dealing with other people,  7: one can trust other people)
religiousness 	Self-reported religiousness (1: not religious, 7: very religious)
religiousness_catholic 			= religiousness*catholic
religiousness_protestant		= religiousness*protestant
time_rl_experiment				Time spent flipping coins and deciding on report
previous_experiments			Numbers of previous participations in lab experiments
belief_share_maximal_report 	belief about overall share of overreporters reporting the maximal number
belief_number_maximal_report 	Belief about overall number of overreporters reporting the maximal number
belief_share_overreporting 		Belief about share of overreporters
belief_number_overreporting 	Belief about number of overreporters
belief_average_report			Belief about the average report implied by answers given and the model in appendix D
e0				= 1 - belief_share_overreporting
r4				= belief_share_maximal_report + 0.0625*e0


*/
}




{/* Section 4.1 Telephone Study */

* Figure 1 
use "1coin_web_appendix.dta", clear

capture drop truth
gen truth = 50
sort cn
histogram cn, discrete percent color(navy) addlabels addlabopts(yvarformat(%2.1f)) xtitle("") xlabel(0 "Heads" 1 "Tails") ylabel(0 10 20 30 40 50 60,nogrid) graphregion(color(white)) barwidth(0.4)  addplot(scatter truth cn, msymbol(O) mfcolor(white) mlcolor(cranberry) connect(l) lpattern(dash) lcolor(cranberry) ) legend(off)
graph export figure1.png, width(3000) replace
drop truth

tab cn
bitest cn==0.5




* Figure 2
use "4coin_web_appendix.dta", clear

capture drop truth
gen truth = cond(cn==0, 6.25, cond(cn==1, 25, cond(cn==2, 37.5, cond(cn==3, 25, 6.25 ))))
sort cn
histogram cn if fieldtel==1, discrete percent color(navy) addlabels addlabopts(yvarformat(%2.1f)) xtitle("Number of reported tails") xlabel(0 1 2 3 4) ylabel(0 10 20 30 40 50,nogrid) graphregion(color(white)) barwidth(0.8) addplot(scatter truth cn, msymbol(O) mfcolor(white) mlcolor(cranberry) lpattern(dash) connect(l) lcolor(cranberry) ) legend(off)
graph export figure2.png, width(3000) replace
drop truth



preserve
	keep if fieldtel==1 
	mgof cn = binomialp(4, cn, 0.5), ee ksmirnov
	bitest rep0 = 0.0625
	bitest rep1 = 0.25
	bitest rep2 = 0.375
	bitest rep3 = 0.25
	bitest rep4 = 0.0625
restore



forvalues multiple = 2/7 {
	preserve
		keep if fieldtel==1
		expand `multiple' 
		mgof cn = binomialp(4, cn, 0.5), mc ksmirnov  reps(1000000) 
	restore
}



count if payment_mode==3 & fieldtel==1
count if cn > 0 & fieldtel==1

use 1coin_web_appendix.dta, clear
count if payment_mode == 3
count if cn > 0

di (12+53)/(87+292)





* Table 2
use "1coin_web_appendix.dta", clear


local controls1 age female
local controls2 `controls1' protestant catholic
local controls3 `controls2' income educ_1 educ_2 inhabitants_current_city
local controls4 `controls3' religiousness religiousness_catholic religiousness_protestant
local controls5 `controls4' risk_tolerance trust belief_share_maximal_report


eststo clear
forvalues i = 1/5 {
	eststo: dprobit cn `controls`i'', vce(robust)
}

estout using table2.tex, replace  style(tex) substitute(_ \_) drop(_cons) stats(N , fmt(0 3 2) labels("N.Obs." "\(R^2\)")) margin nodiscrete varwidth(40)  cells(b(star fmt(3)) se(par fmt(3))) starlevels(* 0.1 ** 0.05 *** 0.01) ///
 varlabels(female "1 if Female" age "Age" protestant "1 if Protestant" catholic "1 if Catholic " income "Income " educ_1 "1 if Professional Education" educ_2 "1 if Academic Education" inhabitants_current_city  "City Size " religiousness  "Religiousness" religiousness_catholic  "Religiousness*Catholic" religiousness_protestant "Religiousness*Protestant" risk_tolerance "Risk Tolerance "  trust "Trust"  belief_share_maximal_report 	"Belief about other"  , ///
 elist( _cons " \\ \hline "))  mlabels(none ) collabels(none) eqlabels(none) 
 
 
dprobit cn belief_share_maximal_report, vce(robust)
 

forvalues i = 1/5 {
	reg cn `controls`i'', vce(robust)
	di "Adjusted R2 " `e(r2_a)' 
}





* Table 3
use "4coin_web_appendix.dta", clear

preserve
	keep if fieldtel==1

	local controls1 age female
	local controls2 `controls1' protestant catholic
	local controls3 `controls2' income educ_1 educ_2 inhabitants_current_city
	local controls4 `controls3' religiousness religiousness_catholic religiousness_protestant
	local controls5 `controls4' risk_tolerance trust belief_share_maximal_report

	eststo clear
	forvalues i = 1/5 {
		eststo: ologit cn `controls`i'', vce(robust)
	}


	estout using table3.tex, replace  style(tex) substitute(_ \_) drop(_cons) stats(N , fmt(0 3 2) labels("N.Obs." "\(R^2\)")) margin nodiscrete varwidth(40)  cells(b(star fmt(3)) se(par fmt(3))) starlevels(* 0.1 ** 0.05 *** 0.01) ///
	 varlabels(female "1 if Female" age "Age" protestant "1 if Protestant" catholic "1 if Catholic " income "Income " educ_1 "1 if Professional Education" educ_2 "1 if Academic Education" inhabitants_current_city  "City Size " religiousness  "Religiousness" religiousness_catholic  "Religiousness*Catholic" religiousness_protestant "Religiousness*Protestant" risk_tolerance "Risk Tolerance "  trust "Trust"  belief_share_maximal_report 	"Belief about other"  , ///
	 elist( _cons " \\ \hline "))  mlabels(none ) collabels(none) eqlabels(none) 
	  
	  
	ologit cn trust, vce(robust)
	ologit cn trust `controls1', vce(robust)
	ologit cn trust `controls2', vce(robust)
	ologit cn trust `controls3', vce(robust)
		
		
	forvalues i = 1/5 {
		reg cn `controls`i'' , vce(robust)
		di "Adjusted R2 " `e(r2_a)' 
	}
	
restore



* Additional covariates

use "1coin_web_appendix.dta", clear

char _dta[omit] "prevalent"
* citizenship
xi: dprobit cn i.cit_ship, vce(robust)
* country of birth
xi: dprobit cn i.state_of_birth, vce(robust)
* personal characteristics
dprobit cn blush_easily, vce(robust)
dprobit cn fool_others, vce(robust)
dprobit cn self_esteem, vce(robust)
dprobit cn be_exposed, vce(robust)
dprobit cn reputation_concern, vce(robust)
* current job situation
xi: dprobit cn i.curr_employ, vce(robust)
* current or latest position in job hierarchy
xi: dprobit cn i.empl_hier, vce(robust)
* educational situation
dprobit cn years_of_schooling, vce(robust)
* white lie score
dprobit cn white_lie_score, vce(robust)
* family status
xi: dprobit cn i.fam_stat, vce(robust)
* number of people in household
dprobit cn household_size, vce(robust)
* church attendance
dprobit cn church_attendance, vce(robust)
* party preference
xi: dprobit cn i.party_pref, vce(robust)
* opportunism
dprobit cn mach_score, vce(robust)
* opportunism (belief)
dprobit cn mb_score, vce(robust)




use "4coin_web_appendix.dta", clear

preserve
	keep if fieldtel==1
		
	char _dta[omit] "prevalent"
	* citizenship
	xi: ologit cn i.cit_ship, vce(robust)
	* country of birth
	xi: ologit cn i.state_of_birth, vce(robust)
	* personal characteristics
	ologit cn blush_easily, vce(robust)
	ologit cn fool_others, vce(robust)
	ologit cn self_esteem, vce(robust)
	ologit cn be_exposed, vce(robust)
	ologit cn reputation_concern, vce(robust)
	* current job situation
	xi: ologit cn i.curr_employ, vce(robust)
	* current or latest position in job hierarchy
	xi:ologit cn i.empl_hier, vce(robust)
	* educational situation
	ologit cn years_of_schooling, vce(robust)
	* white lie score
	ologit cn white_lie_score, vce(robust)
	* family status
	xi: ologit cn i.fam_stat, vce(robust)
	* number of people in household
	ologit cn household_size, vce(robust)
	* church attendance
	ologit cn church_attendance, vce(robust)
	* party preference
	xi: ologit cn i.party_pref, vce(robust)
	* opportunism
	ologit cn mach_score, vce(robust)
	* opportunism (belief)
	ologit cn mb_score, vce(robust)

restore




use "1coin_web_appendix.dta", clear
ksmirnov cn, by(current_student)
ksmirnov cn, by(current_or_former_student)



use "4coin_web_appendix.dta", clear
ksmirnov cn if fieldtel==1, by(current_student)
ksmirnov cn if fieldtel==1, by(current_or_former_student)







}


{/* Section 4.2 Laboratory Experiment */


use "4coin_web_appendix.dta", clear

* Figure 3

capture drop truth
gen truth = cond(cn==0, 6.25, cond(cn==1, 25, cond(cn==2, 37.5, cond(cn==3, 25, 6.25 ))))
sort cn
histogram cn if labtel==1 , discrete percent color(navy) addlabels addlabopts(yvarformat(%2.1f)) xtitle("Number of reported tails (4-Coin-Lab-Tel)") xlabel(0 1 2 3 4) ylabel(0 10 20 30 40 50,nogrid) graphregion(color(white)) barwidth(0.8) ///
 addplot(scatter truth cn, msymbol(O) mfcolor(white) mlcolor(cranberry) lpattern(dash) connect(l) lcolor(cranberry) ) legend(off)
graph export figure3a.png, width(3000) replace
drop truth

capture drop truth
gen truth = cond(cn==0, 6.25, cond(cn==1, 25, cond(cn==2, 37.5, cond(cn==3, 25, 6.25 ))))
sort cn
histogram cn if labclick==1, discrete percent color(navy) addlabels addlabopts(yvarformat(%2.1f)) xtitle("Number of reported tails (4-Coin-Lab-Click)") xlabel(0 1 2 3 4) ylabel(0 10 20 30 40 50,nogrid) graphregion(color(white)) barwidth(0.8) ///
 addplot(scatter truth cn, msymbol(O) mfcolor(white) mlcolor(cranberry) lpattern(dash) connect(l) lcolor(cranberry) ) legend(off)
graph export figure3b.png, width(3000) replace
drop truth




sum cn if labtel==1
di (4 - `r(mean)')*5



preserve
	keep if labtel==1 
	mgof cn = binomialp(4, cn, 0.5), mc ksmirnov
	bitest rep0 = 0.0625
	bitest rep1 = 0.25
	bitest rep2 = 0.375
	bitest rep3 = 0.25
	bitest rep4 = 0.0625
restore


* Table 1
eststo clear
foreach control_vars in "" "female age" "belief_share_maximal_report" "female age belief_share_maximal_report" {
	eststo: ologit cn lab labclick `control_vars', robust
	test lab labclick
}
foreach control_vars in "" "female age"  {
	eststo: tobit belief_share_maximal_report lab labclick `control_vars', robust ll ul 
}	

estout using "table1.tex", replace style(tex) keep(lab labclick  female  age belief_share_maximal_report )  substitute(_ \_) ///
 order( lab labtel labclick female lab_female age lab_age belief_number_overreporting belief_number_maximal_report elief_average_report) ///
 cells(b(star fmt(3)) se(par fmt(3))) starlevels(* 0.1 ** 0.05 *** 0.01) ///
 stats(N, fmt(0 3 2) labels("N.Obs." "Pseudo \(R^2\)")) ///
 varlabels(age "Age"  female "1 if Female"   lab "1 if Either Lab treatment" labtel "1 if 4-Coin-Lab-Tel" labclick "1 if 4-Coin-Lab-Click" belief_number_overreporting "Belief overr." belief_share_maximal_report "Belief about other participants" belief_average_report  "Beliefs ave." _cons "Constant", elist(  belief_share_maximal_report "  \hline ")) ///
 varwidth(35) extracols(5) mlabels(none ) collabels(none) eqlabels(none)  ///
 prehead("\begin{tabular}{lccccccc} \hline\hline  \\       \multicolumn{5}{l}{Dependent Variable:} \\ & \multicolumn{4}{l}{Number of Reported Tails (0--4)}  & \hspace*{1cm}& \multicolumn{2}{l}{Belief about other participants} \\    \\   & (1) & (2) & (3) & (4) & & (5) & (6) \\ \hline") ///
 postfoot("\hline\hline  \end{tabular}")

 
* Table 1 with OLS
foreach control_vars in "" "female age" "belief_share_maximal_report" "female age belief_share_maximal_report" {
	reg cn lab labclick `control_vars', robust
	test lab labclick
}
foreach control_vars in "" "female age"  {
	reg belief_share_maximal_report lab labclick `control_vars', robust 
}	
 
 
 
ksmirnov cn if fieldtel==1 | labtel==1, by(labtel)
 
 
mean cn if labclick==1
mean cn if labtel==1
 

 
preserve 
	keep if lab==1 
	ksmirnov cn, by(labtel)
	forvalues i = 0/4 {
		di "Testing reports of " `i'
		prtest rep`i', by(labtel)
	}
restore	

 
* Two subjects wanted to change their choice
preserve
	replace cn=4 if session=="110223_1224" & Subject==11
	replace cn=4 if session=="110225_1443" & Subject==19
	foreach control_vars in "" "female age" "belief_share_maximal_report" "female age belief_share_maximal_report" {
		ologit cn lab labclick `control_vars', robust
	}
	foreach control_vars in "" "female age"  {
		tobit belief_share_maximal_report lab labclick `control_vars', robust ll ul 
	}		
	
	keep if lab==1  

	ksmirnov cn, by(labtel)
	forvalues i = 0/4 {
		di "Testing reports of " `i'
		prtest rep`i', by(labtel)
	}
restore	
 
 
ksmirnov cn if fieldtel==1 | labclick==1, by(labclick)
 
ologit cn time_rl_experiment if labclick==1, robust
 
ologit cn previous_experiments if lab==1, robust
 
 
foreach control_vars in "female age" "female age belief_share_maximal_report" {
	ologit cn lab labclick `control_vars' if lab==1, robust
}
 
 
}
 
 
{/* Section 4.3 Beliefs about other Participants */
 
 
 
* Figure 4
 
preserve
	gen reported_max = cond(cn==4, 100, 0)
	gen r4_percent = 100*r4
 	set obs `=_N + 1'	/* fudge 1-coin data into graph without merging datasets */
	local last_obs = _N
	replace rltreat = 0 in `last_obs'
	replace reported_max = 44.4 in `last_obs'
	replace r4_percent = 73.4  in `last_obs'
	gen bar_order = rltreat
	replace bar_order = 10 if bar_order==2
	graph bar reported_max r4_percent, over(rltreat, relabel(1 "1-Coin-Telephone") sort(bar_order)) blabel(bar, format(%2.1f)) graphregion(color(white)) ylabel(, nogrid) ytitle("Share of maximal report (percent)") legend(lab(1 "Behavior") lab(2 "Belief")) bar(1, fcolor(navy)) bar(2, fcolor(navy) fintensity(inten20) lstyle(none))
	graph export "figure4.png", width(3000) replace	
restore


 
 	
forvalues t = 1/3 {
	quietly count if cn==4 & rltreat== `t'   /* average belief about share of reporting 4 */
	local r4_behavior = `r(N)'
	quietly count if rltreat== `t'
	local r4_behavior = `r4_behavior'/`r(N)'  
	ttest r4 == `r4_behavior' if rltreat==`t'	
	
	quietly su cn if rltreat== `t'      /* average belief about average report */
	ttest belief_average_report == `r(mean)' if rltreat==`t' 	
}
 
 
use "1coin_web_appendix.dta", clear
sum cn
ttest r1 == `r(mean)'


tobit belief_share_maximal_report female age, robust ll ul 


use "4coin_web_appendix.dta", clear

foreach control_vars in "" "female age"  {
	foreach belief_var in belief_number_maximal_report belief_share_overreporting belief_number_overreporting belief_average_report {
		eststo: tobit `belief_var' lab labclick `control_vars', robust ll ul 
	}
}	


foreach control_vars in "" "female age"  {
	foreach belief_var in belief_number_maximal_report belief_share_overreporting belief_number_overreporting belief_average_report {
			eststo: ologit cn lab labclick `control_vars' `belief_var', robust
	}
}	






}

{/* Appendix D: Model of Belief Formation */
 
 
* average belief about the average report...
* ... with e1==e2==e3
mean avg_belief_e123equal   
* ... with e1==e2, e3==0
mean avg_belief_12equal_e30 
* ... with e1==e3, e2==0
mean avg_belief_13equal_e20 
* ... with e2==e3, e1==0
mean avg_belief_23equal_e10
 
}












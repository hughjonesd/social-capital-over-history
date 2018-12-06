*Results reported in article and Extended Data of Gaechter and Schulz 'Intrinsic Honesty and the Prevalence of Rule Violations across Societies', Nature (2016), doi:10.1038/nature17160
*Documentation of analysis for Supplementary Information is in separate file
*Stata/SE 12.1 for Windows
*requires Stata package mgof (from http://fmwww.bc.edu/RePEc/bocode/m)
*February 3, 2016

use GaechterSchulzDATA, clear
set more off

************************************************************************************
*RESULTS

*_____________________________________
*Descriptive PRV
 preserve 
  collapse PRV2003 insample pol_xconst1990_2000  wgi_goveff2000 GDP hfs_idv, by(country)
	sum PRV2003
	sum PRV2003 if insample==1
 restore
 
*______________________________________
*Descriptive subject pool 
 sum age
 sum female
 
*__________________________________________________________________
*Analyses for Figure 1

 *___________________________________________________________________________________________
 *tests high vs. low PRV countries. PRV_low are those that are at or below the PRV mean of 0
 generate PRV_low = 0 if PRV2003!=.
 replace PRV_low = 1 if PRV2003<=0
 
 tabulate PRV_low payouts, chi
 
 *___________________
 *Discrete Kolmogorov-Smirnov tests
 *requires package mgof by Ben Jann (from http://fmwww.bc.edu/RePEc/bocode/m )
 
 *High PRV countries vs. Justified Dishonesty Benchmark
 
 preserve
 drop if PRV_low==0
 mgof payouts = (2/36)*payouts + 1/36, mc ksmirnov
 restore
 
 *Low PRV countries vs. Justified Dishonesty Benchmark
 preserve
 drop if PRV_low==1
 mgof payouts = (2/36)*payouts + 1/36, mc ksmirnov
 restore
 
 *__________________________________
 *Analyses Inset Figure to Fig 1
 ttest payouts, by(PRV_low)
 
 *Country Level
 preserve
 collapse PRV_low payouts, by(country)
 ranksum payouts, by(PRV_low)
 restore
 
 *test whether different from Justified Dishonesty Benchmark
 ttest payouts==3.47 if PRV_low==0
 ttest payouts==3.47 if PRV_low==1
 
*__________________________________________________________________
* Four different measures of intrinsic (dis)honesty and their relation to PRV  

 *__________________________________________________________________ 
 *Tests for subject pool differences 
 preserve
	drop if payouts==.
	kwallis payouts, by(country)
	tabulate high country, chi
	tabulate five country, chi
	tabulate six country, chi
   collapse payouts six five high PRV2003, by(country)
    sum payouts
	sum high
    generate incomemax = ((five-0.1667)*(6/5))*100
	sum incomemax
	generate honest = six*6*100
	sum honest
	table country, c(mean payouts mean high mean incomemax mean honest)
 *___________________________________________________________	
 *Correlations of the four measures with PRV (see Fig. 2a-2d)
   
    *Fig. 2a: Mean Claim and PRV (Prevalence of Rule Violations, 2003)
	spearman payouts PRV2003
	*Fig. 2b: High Claim and PRV (Prevalence of Rule Violations, 2003)
	spearman high PRV2003
	*Fig. 2c: Estimated percent Income Maximiser and PRV (Prevalence of Rule Violations, 2003)
	spearman incomemax PRV2003
	*Fig. 2d: Estimated percent Honest People and PRV (Prevalence of Rule Violations, 2003)
	spearman honest PRV2003
 restore
 
 
****************************Extended Data************************************************************
*************************************************************************************************************

*_________________________________________________
* Analysis of Extended Data Figure 2


 *___________________________________________________________________________
 *Discrete Kolmogorov-Smirnov test of difference to 'Justified Dishonesty Becnhmark' and 'Full Honesty Benchmark'

  generate countryII = .
  replace countryII = 1 if country==40 //Austria
  replace countryII = 2 if country==826 //UK
  replace countryII = 3 if country==528 //Netherlands
  replace countryII = 4 if country==752 //Sweden
  replace countryII = 5 if country==276 //Germany
  replace countryII = 6 if country==724 //Spain
  replace countryII = 7 if country==203 //Czech R.
  replace countryII = 8 if country==703 //Slovakia
  replace countryII = 9 if country==380 //Italy
  replace countryII = 10 if country==616 //Poland
  replace countryII = 11 if country==710 //South Africa
  replace countryII = 12 if country==440 //Lithuania
  replace countryII = 13 if country==360 //Indonesia
  replace countryII = 14 if country==458 //Malaysia
  replace countryII = 15 if country==792 //Turkey
  replace countryII = 16 if country==156 //China
  replace countryII = 17 if country==170 //Colombia
  replace countryII = 18 if country==704 //Vietnam
  replace countryII = 19 if country==504 //Morocco
  replace countryII = 20 if country==404 //Kenya
  replace countryII = 21 if country==320 //Guatemala  
  replace countryII = 22 if country==834 //Tanzania
  replace countryII = 23 if country==268 //Georgia
  
  *labels with number of observations
  la var countryII "City"
  # delimit ;
  label define countryII 

  1 "Vienna (n=66)"  
  2 "Nottingham (n=197)"
  3 "Amsterd./Gron. (n=84)"
  4 "Linkoping (n=82)"
  5 "Konstanz (n=69)"
  6 "Granada (n=54)"
  7 "Prague (n=77)"
  8 "Bratislava (n=87)"
  9 "Rome (n=82)"
  10 "Warsaw (n=110)"
  11 "Cape Town (n=92)"  
  12 "Vilnius (n=71)"
  13 "Yogyakarta (n=76)"
  14 "Semenyih (n=64)" 
  15 "Izmir (n=244)"
  16 "Shanghai (n=237)"
  17 "Bogota (n=104)"
  18 "Ho Chi Minh C. (n=112)"
  19 "Meknes (n=138)" 
  20 "Nairobi (n=92)"
  21 "Guatemala C. (n=193)" 
  22 "Dar Es Salaam (n=140)"
  23 "Tbilisi (n=97)"
  ;
  # delimit cr
  label values countryII countryII

 *_______________________________
 *Kolmogorov-Smirnov and 'Justified Dishonesty benchmark'
  *requires package mgof (from http://fmwww.bc.edu/RePEc/bocode/m)
 mgof payouts = (2/36)*payouts + 1/36, mc ksmirnov

 *For each country separately
 sort countryII
 sum countryII
 local N = r(max)
 local forlab: value label countryII
 
 forvalues x = 1(1)`N'{
 display "_________________________________________________________________________________"
 local label: label `forlab' `x'
 display "`label'"
 display "_________________________________________________________________________________"
 preserve
 keep if countryII==`x'
 mgof payouts = (2/36)*payouts + 1/36, mc ksmirnov
 restore
 }

 *_______________________________
 *Kolmogorov-Smirnov and 'Full Honesty benchmark'
 *requires package mgof (from http://fmwww.bc.edu/RePEc/bocode/m)
 mgof payouts = 1/6, mc ksmirnov

 *For each country separateöy
 sort countryII
 sum countryII
 local N = r(max)
 local forlab: value label countryII
 
 forvalues x = 1(1)`N'{
 display "_________________________________________________________________________________"
 local label: label `forlab' `x'
 display "`label'"
 display "_________________________________________________________________________________"
 preserve
 keep if countryII==`x'
 mgof payouts = 1/6, mc ksmirnov
 restore
 }

*_________________________________________________________
*Extended Data Figure 2
 preserve
 
 *binomial probability tests for each number in a country
 gen four = 0
 replace four = 1 if payouts==4
 gen three = 0
 replace three = 1 if payouts==3
 gen two = 0
 replace two = 1 if payouts==2
 gen one = 0
 replace one = 1 if payouts==1

 generate n=1
 egen N = sum(n), by(countryII)
 egen throw = sum(n), by(countryII number)
 gen freq = (throw/N)*100
 sort countryII freq

 gen p = -9999
 sum countryII
 local N = r(max)
 local forlab: value label countryII
 
 forvalues x = 1(1)`N'{
 display "_________________________________________________________________________________"
 local label: label `forlab' `x'
 display "`label'"
 display "_________________________________________________________________________________"
 bitest five =0.1666666667 if countryII == `x'
 replace p = `r(p)' if countryII== `x' & payouts==5
 bitest four =0.1666666667 if countryII == `x'
 replace p = `r(p)' if countryII== `x' & payouts==4
 bitest three =0.1666666667 if countryII == `x'
 replace p = `r(p)' if countryII== `x' & payouts==3
 bitest two =0.1666666667 if countryII == `x'
 replace p = `r(p)' if countryII== `x' & payouts==2
 bitest one =0.1666666667 if countryII == `x'
 replace p = `r(p)' if countryII== `x' & payouts==1
 bitest six =0.1666666667 if countryII == `x'
 replace p = `r(p)' if countryII== `x' & payouts==0
}
restore

*__________________________________________________
* Extended Data Figure 3

preserve
  drop if payouts==.
  collapse payouts six five high fh_polrights_2006woC wgi_goveff2000 hfs_idv iw_tradrat iw_survself pol_xconst1990_2000  pol_xconst1890_1900 , by(country)
   
 * EDF 3a: Mean Claim - Government Effectiveness
  spearman payouts wgi_goveff2000
 * EDF 3b: Mean Claim - Constraint on executive 1990 to 2000
  spearman payouts pol_xconst1990_2000 
 * EDF 3c: Mean Claim - Political Rights without C
  spearman payouts fh_polrights_2006woC
 * EDF 3d: Mean Claim - Constraint on executive 1890 to 1900
  spearman payouts pol_xconst1890_1900 
  
*__________________________________________________________
* Extended Data Figure 4
  
 *EDF 4a: Mean Claim - Individualism
  spearman payouts hfs_idv
 *EDF 4b: Mean Claim - Traditional vs. secular-rational values
  spearman payouts iw_tradrat
 *EDF 4c: Mean Claim - Survival vs. self-expression values
  spearman payouts iw_sur
restore  
  
*__________________________________________________________________
*Extended Data Table 1: Measures of prevalence of rule violations, economic and institutional variables, as well as cultural background of our subject pools 
 
preserve
   collapse number GDP** wgi_corrup2003 bs_SE2003 fh_polrights_s2003 PRV2003 pol_xconst1990_2000  wgi_goveff2000 hfs_idv iw_*, by(country)
   decode country, gen(country2)
   sort country2
   drop country2
   
   local N = _N + 5
   set obs `N'
   
   local N = _N +1
   replace country = 100000 in 248 // Sample Mean
   local N = _N + 2
   replace country = 100001 in 249
   local N = _N + 3
   replace country =  100002 in 250
   local N = _N + 4
   replace country =  100003 in 251
   local N = _N + 5
   replace country =  100004 in 252

   foreach v in wgi_corrup2003 bs_SE2003 fh_polrights_s2003 PRV2003 pol_xconst1990_2000  wgi_goveff2000 GDP_1990_2000 hfs_idv iw_tradrat iw_survself{
    sum `v' 
    replace `v' = `r(mean)' in 249 // World Mean
    replace `v' = `r(min)' in 250 // World Min
    replace `v' = `r(max)' in 251 // World Max
    replace `v' = `r(N)' in 252 // Number Obs
    sum `v' if number !=.
    replace `v' = `r(mean)' in 248 // Sample Mean
   }
   replace number = -99 in 248
   replace number = -99 in 249
   replace number = -99 in 250
   replace number = -99 in 251
   replace number = -99 in 252
   keep if number!=.
   drop number

   *la var weo_GDP_2003 "GDP per Capita (in $1000)"
   *la var wgi_ruleoflaw2003 "Rule of Law"

   label drop country
   la var countr "Country"
   label define country 100004 "N" 100003 "World Max" 100002 "World Min" 100001 "World Mean" 100000 "Sample Mean" 752 "Sweden" 156 "China" 276 "Germany" 703 "Slovakia" 616 "Poland" 440 "Lithuania" 504 "Morocco" 360 "Indonesia" 458 "Malaysia" 704 "Vietnam" 756 "Switzerland" 40 "Austria" 826 "United Kingdom" 724 "Spain" 203 "Czech Rep." 380 "Italy" 528 "Netherlands" 170 "Columbia" 320 "Guatemala" 404 "Kenya" 834 "Tanzania" 710 "South Africa" 792 "Turkey" 268 "Georgia"
   label values countr country

   order country wgi_corrup2003 bs_SE2003 fh_polrights_s2003 PRV2003 pol_xconst1990_2000  wgi_goveff2000 GDP_1990_2000 hfs_idv iw_tradrat iw_survself 
   outsheet using ExtendedData_Tab1.xls
  
 restore
 
 *____________________________________________
 * Extended Data Table 2
 
 eststo: reg payouts PRV2003 q_norm q_fair age female middleclass urban economics religious numknown , vce(bootstrap, reps(500) seed(1) cluster(country))
 test age female middleclass urban economics religious numknown 
 eststo: reg high    PRV2003 q_norm q_fair age female middleclass urban economics religious numknown , vce(bootstrap, reps(500) seed(1) cluster(country))
 test age female middleclass urban economics religious numknown
 eststo: reg five    PRV2003 q_norm q_fair age female middleclass urban economics religious numknown , vce(bootstrap, reps(500) seed(1) cluster(country))
 test age female middleclass urban economics religious numknown
 eststo: reg six     PRV2003 q_norm q_fair age female middleclass urban economics religious numknown , vce(bootstrap, reps(500) seed(1) cluster(country))
 test age female middleclass urban economics religious numknown 
 esttab using ExtendedData_Tab2.rtf, replace star(* 0.10 ** 0.05 *** 0.01) r2 pr2 se cells(b(star fmt(3)) se(par fmt(3)))
 eststo clear
 
 *______________________________________________
 * Extended Data Table 3
 preserve
 collapse PRV2003 pol_xconst1890_1900  pol_xconst1990_2000  hfs_idv tbl_prim_newbound_1930 GDP_1990_2000 wgi_goveff2000 p_elf85 lp_legor_uk lp_legor_ge lp_legor_sc tbl_lan ajr_logem4 sw_fst_distance_weighted ajr_baseco, by(country)
  
eststo: reg PRV2003 pol_xconst1990_2000  hfs_idv							lp_legor_uk lp_legor_ge lp_legor_sc, robust
eststo: reg PRV2003 pol_xconst1890_1900  hfs_idv 							lp_legor_uk lp_legor_ge lp_legor_sc, robust
eststo: reg PRV2003 pol_xconst1990_2000  hfs_idv tbl_prim_newbound_1930 		lp_legor_uk lp_legor_ge lp_legor_sc, robust
eststo: reg PRV2003 pol_xconst1990_2000  hfs_idv  GDP_1990_2000				lp_legor_uk lp_legor_ge lp_legor_sc, robust
eststo: reg PRV2003 pol_xconst1990_2000  hfs_idv  wgi_goveff2000				lp_legor_uk lp_legor_ge lp_legor_sc, robust
eststo: reg PRV2003 pol_xconst1990_2000  hfs_idv  p_elf85 					lp_legor_uk lp_legor_ge lp_legor_sc, robust
eststo: ivregress 2sls PRV2003 											lp_legor_uk lp_legor_ge lp_legor_sc (pol_xconst1990_2000  = ajr_logem4) if ajr_baseco==1, first robust
eststo: ivregress 2sls PRV2003 pol_xconst1990_2000  tbl_prim_newbound_1930 	lp_legor_uk lp_legor_ge lp_legor_sc (hfs_idv = tbl_lan), first robust
eststo: ivregress 2sls PRV2003 pol_xconst1990_2000  tbl_prim_newbound_1930 	lp_legor_uk lp_legor_ge lp_legor_sc (hfs_idv = sw_fst_distance_weighted), first robust
eststo: ivregress 2sls PRV2003 pol_xconst1990_2000  tbl_prim_newbound_1930 	lp_legor_uk lp_legor_ge lp_legor_sc (hfs_idv = tbl_lan sw_fst_distance_weighted), first robust
estat overid
esttab using ExtendedData_Tab3.rtf, replace star(* 0.10 ** 0.05 *** 0.01) r2 se cells(b(star fmt(2)) se(par fmt(2)))
eststo clear
restore

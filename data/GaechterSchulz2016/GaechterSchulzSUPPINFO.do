*SUPPLEMENTARY INFORMATION for Gaechter and Schulz 'Intrinsic Honesty and the Prevalence of Rule Violations across Societies' Nature (2016) doi:10.1038/nature17160
*Stata/SE Version 12.1
*requires Stata package tabout from http://fmwww.bc.edu/RePEc/bocode/t
*requires Stata package mgof (from http://fmwww.bc.edu/RePEc/bocode/m)
*February 3, 2016

use GaechterSchulzDATA.dta, clear
set more off


*___________________________________________
*1. Supplementary methods
 *____________________________________________________________________________________________________
 *1.1 Indicator of the prevalence of rule violations (and other institutional and cultural indicators)

  *___________________________________________________________________________
  *PRINCIPAL COMPONENT ANALYSIS
  preserve
	collapse bs_SE2003 wgi_corrup2003 fh_polrights_s2003 pol_xconst1990_2000 pol_xconst1890_1900 fh_polrights_2006woC wgi_goveff2000 GDP hfs_* iw_tradrat iw_survself insample sr_Belief_in_Hell sr_Belief_in_Heaven, by(country)

		sum wgi_corrup2003
		sum wgi_corrup2003 if insample==1
		sum bs_SE2003
		sum bs_SE2003 if insample==1
		sum fh_polrights_s2003
		sum fh_polrights_s2003 if insample==1
 
        spearman wgi_corrup2003 bs_SE2003 
	    spearman wgi_corrup2003 fh_polrights_s2003
	    spearman bs_SE2003 fh_polrights_s2003
				
 
   pca fh_polrights_s2003 bs_SE2003 wgi_corrup2003
		estat kmo 
		predict PRV2003
		replace PRV2003 = PRV2003*-1
		sum PRV2003
		sum PRV2003 if insample==1
		sum PRV2003 if PRV2003<=1.989387

  *____________________________________________________________________________
  *correlation of PRV with other indicators
   
   *Constraint on Executive 
	sum pol_xconst1990_2000 
    sum pol_xconst1990_2000 if insample==1
    spearman PRV2003 pol_xconst1990_2000
    sum pol_xconst1890_1900
    sum pol_xconst1890_1900 if insample==1
    spearman PRV2003 pol_xconst1890_1900
   
   *Political Rights without Part C
	sum fh_polrights_2006woC
    sum fh_polrights_2006woC if insample==1
    spearman PRV2003 fh_polrights_2006woC
  
  *Government Effectiveness   
	sum wgi_goveff2000
    sum wgi_goveff2000 if insample==1
    spearman PRV2003 wgi_goveff2000
	spearman GDP wgi_goveff2000
    
  *Individualism/Collectivism
	sum hfs_idv
    sum hfs_idv if insample==1
    spearman PRV2003 hfs_idv 
    
  *Traditional/Secular values
	sum iw_tradrat
    sum iw_tradrat if insample==1
    spearman PRV2003 iw_tradrat 
    spearman iw_tradrat sr_Belief_in_Heaven
	spearman iw_tradrat sr_Belief_in_Hell
	
  *Survival/Self-expression values
	sum iw_survself
    sum iw_survself if insample==1
    spearman PRV2003 iw_survself
    spearman wgi_goveff2000 iw_survself
  
  *GDP per capita
	sum GDP
    sum GDP if insample==1
    spearman PRV2003 GDP
    spearman PRV2003 wgi_corrup2003
    spearman PRV2003 bs_SE2003 
    spearman PRV2003 fh_polrights_s2003
	
  restore

 *______________________________________
 *1.3 Further methodological details of the cross-societal implementation
 *	 Stakes size in China (p. 17)
  preserve
	keep if country==156
	sort lowstakes
	by lowstakes: sum payouts
	ranksum payouts, by(lowstakes)
  restore
 
 *_____________________________________________ 
 *1.4 Subject pool details
  *_____________________________________________________________________
  * TABLE S1 | Subject pool details, socio-demographics, beliefs in fairness of other and personal norms of honesty
  preserve
	drop if number==.
	collapse number female age middleclass urban economics numknown q_fair q_norm religious (count)n=number, by(country)
	set obs 24
	replace country = 100000 in 24 

	foreach v in n age female middleclass urban numknown economics religious q_fair q_norm{
		sum `v' if number !=.
		replace `v' = `r(mean)' in 24 // Sample Mean
		replace `v' = `v'*100 if `v'<=1 
	}
	replace number = -99 in 24
	keep if number!=.
	drop number
  
	label drop country
	la var countr "Country"
	label define country 100000 "Sample Mean" 752 "Sweden" 156 "China" 276 "Germany" 703 "Slovakia" 616 "Poland" 440 "Lithuania" 504 "Morocco" 360 "Indonesia" 458 "Malaysia" 704 "Vietnam" 756 "Switzerland" 40 "Austria" 826 "United Kingdom" 724 "Spain" 203 "Czech Rep." 380 "Italy" 528 "Netherlands" 170 "Colombia" 320 "Guatemala" 404 "Kenya" 834 "Tanzania" 710 "South Africa" 792 "Turkey" 268 "Georgia"
	label values countr country

	order country n age female middleclass urban economics religious numknown q_fair q_norm
	outsheet using tableS1.xls, replace
  
  restore

*______________________________________
*______________________________________
* 2.Supplementary Analysis

 *__________________________________________________
 * 2.1 Supplementary Analysis to Fig. 1 and Extended Data Fig. 2
    
 generate PRV_low = 0 if PRV2003!=.
 replace PRV_low = 1 if PRV2003<=0
	
	generate one = 0 if payouts!=.
	replace one=1 if payouts==1
	generate two = 0 if payouts!=.
	replace two =1 if payouts==2
	generate three = 0 if payouts!=.
	replace three=1 if payouts==3
	generate four = 0 if payouts!=.
	replace four=1 if payouts==4
	
	tabulate payouts if PRV_low==1
	bitest six == 0.028 if PRV_low==1
	bitest one == 0.083 if PRV_low==1
	bitest two == 0.139 if PRV_low==1
	bitest three == 0.194 if PRV_low==1
	bitest four == 0.25 if PRV_low==1
	bitest five == 0.306 if PRV_low==1
	
	tabulate payouts if PRV_low==0
	bitest six == 0.028 if PRV_low==0
	bitest one == 0.083 if PRV_low==0
	bitest two == 0.139 if PRV_low==0
	bitest three == 0.194 if PRV_low==0
	bitest four == 0.25 if PRV_low==0
	bitest five == 0.306 if PRV_low==0
	
	*For Kolmogorov-Smirnov
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
	3 "Amstrd./Gron. (n=84)"
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


	*_________________________________
	*Kolmogorov-Smirnov signed d

	generate d = 0.137 if countryII==1
	replace d = 0.133 if countryII==2
	replace d = 0.145 if countryII==3
	replace d = 0.15 if countryII==4
	replace d = 0.121 if countryII==5
	replace d = 0.153 if countryII==6
	replace d = 0.077 if countryII==7
	replace d = 0.097 if countryII==8
	replace d = 0.056 if countryII==9
	replace d = 0.093 if countryII==10
	replace d = 0.091 if countryII==11
	replace d = 0.065 if countryII==12
	replace d = 0.11 if countryII==13
	replace d = 0.113 if countryII==14
	replace d = 0.073 if countryII==15
	replace d = -0.065 if countryII==16
	replace d = 0.041 if countryII==17
	replace d = 0.082 if countryII==18
	replace d = -0.081 if countryII==19
	replace d = 0.054 if countryII==20
	replace d = 0.039 if countryII==21
	replace d = -0.18 if countryII==22
	replace d = 0.166 if countryII==23

	preserve
	collapse d PRV_low PRV2003, by(country)
	ranksum d, by(PRV_low)
	ttest d, by(PRV_low)
	spearman d PRV2003
	restore
     
	
	*___________________________
	*Simpson's Index

	preserve 
	collapse six one two three four five PRV_low PRV2003, by(country)
	generate simpson = six^2+one^2 + two^2 + three^2 + four^2 + five^2
	sum simpson
	ttest simpson, by(PRV_low)
	ranksum simpson, by(PRV_low)
	spearman simpson PRV2003
	restore
	drop PRV_low countryII d one two three four
   
 *_________________________________________________
 * 2.2 Supplementary regression analyses to Extended Table 1
  *________________________
  *Specification tests
    *Hausman
	xtset country
	xtreg payouts PRV2003 q_fair q_norm age female middleclass urban economics numknown religious, fe
	estimates store fe
	xtreg payouts PRV2003 q_fair q_norm age female middleclass urban economics numknown religious, re
	hausman fe, sigmamore
   
	eststo: xtreg high PRV2003 q_fair q_norm age female middleclass urban economics numknown religious, fe
	estimates store fe
	eststo: xtreg high PRV2003 q_fair q_norm age female middleclass urban economics numknown religious, re
	hausman fe, sigmamore
    
	eststo: xtreg five PRV2003 q_fair q_norm age female middleclass urban economics numknown religious, fe 
	estimates store fe
	eststo: xtreg five PRV2003 q_fair q_norm age female middleclass urban economics numknown religious, re
	hausman fe, sigmamore
   
	eststo: xtreg six PRV2003 q_fair q_norm age female middleclass urban economics numknown religious, fe 
	estimates store fe
	eststo: xtreg six PRV2003 q_fair q_norm age female middleclass urban economics numknown religious, re
	hausman fe, sigmamore
	eststo clear
   
    *Breusch Pagan
	xtreg payouts PRV2003 q_norm q_fair age female middleclass urban economics numknown religious, cluster(country)
	xttest0
	xtreg high PRV2003 q_norm q_fair age female middleclass urban economics numknown religious, cluster(country)
	xttest0
	xtreg five PRV2003 q_norm q_fair age female middleclass urban economics numknown religious, cluster(country)
	xttest0
	xtreg six PRV2003 q_norm q_fair age female middleclass urban economics numknown religious, cluster(country)
	xttest0
   
   *________________________________________________________________________________
   *TABLE S2 | Probit regression analysis of societal and individual determinants of dishonesty
 
   eststo: oprobit payouts PRV2003 q_norm q_fair age female middleclass urban economics numknown religious,vce(bootstrap, reps(1000) seed(1) cluster(country))
   probit high PRV2003 q_norm q_fair age female middleclass urban economics numknown religious, vce(bootstrap, reps(1000) seed(1) cluster(country))
   eststo: mfx
   probit five PRV2003 q_norm q_fair age female middleclass urban economics numknown religious, vce(bootstrap, reps(1000) seed(1) cluster(country))
   eststo: mfx
   probit six PRV2003 q_norm q_fair age female middleclass urban economics numknown religious, vce(bootstrap, reps(1000) seed(1) cluster(country))
   eststo: mfx 
   esttab using tableS2.rtf, replace star(* 0.10 ** 0.05 *** 0.01) r2 pr2 margin se cells(b(star fmt(3)) se(par fmt(3)))
   eststo clear


 *____________________________
 * 2.3 Robustness checks: association between intrinisic honesty and PRV, institutional quality, and cultural indicators

 preserve
	collapse wgi_corrup* bs_SE* fh_* hfs_* iw_* GDP* pol_xconst1990_2000 payouts high six five, by(country) 
	 *Analysis by PRV sub-indicators	
		spearman wgi_corrup2003 payouts
		spearman fh_polrights_s2003 payouts
		spearman bs_SE2003 payouts

		spearman wgi_corrup2003 high
		spearman fh_polrights_s2003 high
		spearman bs_SE2003 high

		spearman wgi_corrup2003 five
		spearman fh_polrights_s2003 five
		spearman bs_SE2003 five

		spearman wgi_corrup2003 six
		spearman fh_polrights_s2003 six
		spearman bs_SE2003 six
	 
	 *Stablitity of sub-indicators over time
		spearman wgi_corrup2012 wgi_corrup1996
		spearman bs_SE1999 bs_SE2007
		spearman fh_polrights_s2003 fh_polrights_s2012
		
		spearman wgi_corrup1996 payouts
  restore  
   
   *________________________________________________________________________________
   *TABLE S3 | Regression analysis using Control of Corruption in 1996 instead of PRV
	eststo: reg payouts wgi_corrup1996 q_norm q_fair  age female middleclass urban economics numknown religious, vce(bootstrap, reps(500) seed(1) cluster(country))
	test age female middleclass urban economics numknown religious
	eststo: reg high    wgi_corrup1996 q_norm q_fair  age female middleclass urban economics numknown religious, vce(bootstrap, reps(500) seed(1) cluster(country))
	test age female middleclass urban economics numknown religious
	eststo: reg five    wgi_corrup1996 q_norm q_fair  age female middleclass urban economics numknown religious, vce(bootstrap, reps(500) seed(1) cluster(country))
	test age female middleclass urban economics numknown religious
	eststo: reg six     wgi_corrup1996 q_norm q_fair  age female middleclass urban economics numknown religious, vce(bootstrap, reps(500) seed(1) cluster(country))
	test age female middleclass urban economics numknown religious
	esttab using tableS3.rtf, replace star(* 0.10 ** 0.05 *** 0.01) r2 se cells(b(star fmt(3)) se(par fmt(3)))
	eststo clear

 
  *________________________________________________________________________________
  *TABLE S4 | Regression analysis of macro-level indicators and claims
   eststo: reg payouts wgi_corrup2003	  	  q_fair q_norm age female middleclass urban economics numknown religious,  vce(bootstrap, reps(500) seed(1) cluster(country))
	  test age female middleclass urban economics numknown religious
   eststo: reg payouts bs_SE2003			  q_fair q_norm age female middleclass urban economics numknown religious,  vce(bootstrap, reps(500) seed(1) cluster(country))
      test age female middleclass urban economics numknown religious
   eststo: reg payouts fh_polrights_s2003	  q_fair q_norm age female middleclass urban economics numknown religious,  vce(bootstrap, reps(500) seed(1) cluster(country))
     test age female middleclass urban economics numknown religious
   eststo: reg payouts pol_xconst1990_2000		  q_fair q_norm age female middleclass urban economics numknown religious, vce(bootstrap, reps(500) seed(1) cluster(country))
      test age female middleclass urban economics numknown religious
   eststo: reg payouts wgi_goveff2000	 	  q_fair q_norm age female middleclass urban economics numknown religious, vce(bootstrap, reps(500) seed(1) cluster(country))
      test age female middleclass urban economics numknown religious
   eststo: reg payouts GDP   			 	  q_fair q_norm age female middleclass urban economics numknown religious, vce(bootstrap, reps(500) seed(1) cluster(country))
     test age female middleclass urban economics numknown religious
   eststo: reg payouts hfs_idv			 	  q_fair q_norm age female middleclass urban economics numknown religious, vce(bootstrap, reps(500) seed(1) cluster(country))
     test age female middleclass urban economics numknown religious
   eststo: reg payouts iw_tradrat		  	  q_fair q_norm age female middleclass urban economics numknown religious, vce(bootstrap, reps(500) seed(1) cluster(country))
     test age female middleclass urban economics numknown religious
   eststo: reg payouts iw_survself		  	  q_fair q_norm age female middleclass urban economics numknown religious, vce(bootstrap, reps(500) seed(1) cluster(country))
     test age female middleclass urban economics numknown religious
   esttab using tableS4.rtf, replace star(* 0.10 ** 0.05 *** 0.01) r2 se cells(b(star fmt(3)) se(par fmt(3)))
   eststo clear
   
   
 *__________________________________________________________________________________
 * 2.4 Supplementary regression analyses to Extended Data Table 3 (Institutional and Cultural Determinants of PRV)

  *___________________________
  *TABLE S5 | Expropriation Risk and PRV following Acemoglu et al
  preserve
  collapse pol_xconst1990_2000 wgi_corrup2003 PRV2003 bs_SE2003 fh_polright* wgi_goveff2000, by(country)
  spearman pol_xconst1990_2000 wgi_corrup2003
  spearman pol_xconst1990_2000 bs_SE2003 
  spearman pol_xconst1990_2000 fh_polrights_s2003
  spearman pol_xconst1990_2000 PRV2003
  spearman wgi_goveff2000 wgi_corrup2003
  spearman wgi_goveff2000 bs_SE2003 
  spearman wgi_goveff2000 fh_polrights_s2003
  spearman wgi_goveff2000 PRV2003
  restore

  preserve
  collapse PRV2003 ajr_avexpr ajr_lat_abst ajr_africa ajr_asia ajr_logem4 ajr_baseco tbl_pc_tr_tol_all tbl_prim_newbound_1930 tbl_exconst tbl_lyp_m80_00 tbl_legor_uk tbl_legor_fr tbl_lan, by(country)
  gen other_cont=.
  replace other_cont=1 if (country==36 | country==470 | country==554)
  recode other_cont (.=0)
  tab other_cont

  eststo: reg PRV2003 ajr_avexpr ajr_lat_abst if ajr_baseco==1, robust
  eststo: reg PRV2003 ajr_avexpr ajr_lat_abst ajr_africa ajr_asia other_cont if ajr_baseco==1, robust
  eststo: ivregress 2sls PRV2003 ajr_lat_abst  (ajr_avexpr = ajr_logem4) if ajr_baseco==1, first robust
  eststo: ivregress 2sls PRV2003 ajr_lat_abst  ajr_africa ajr_asia other_cont (ajr_avexpr = ajr_logem4) if ajr_baseco==1, first robust
  esttab using tableS5.rtf, replace star(* 0.10 ** 0.05 *** 0.01) r2 se cells(b(star fmt(2)) se(par fmt(2)))
  eststo clear

  *____________________________
  *TABLE S6 | Trust & Respect and PRV following Tabellini
  eststo: reg PRV2003 tbl_pc_tr_tol_all tbl_prim_newbound_1930 				 tbl_legor_uk tbl_legor_fr, robust
  eststo: reg PRV2003 tbl_pc_tr_tol_all tbl_prim_newbound_1930 tbl_lyp_m80_00  tbl_legor_uk tbl_legor_fr, robust
  eststo: ivregress 2sls PRV2003 tbl_prim_newbound_1930 				 		 tbl_legor_uk tbl_legor_fr (tbl_pc_tr_tol_all = tbl_lan), first robust
  eststo: ivregress 2sls PRV2003 tbl_prim_newbound_1930 tbl_lyp_m80_00 		 tbl_legor_uk tbl_legor_fr (tbl_pc_tr_tol_all = tbl_lan), first robust
  eststo: ivregress 2sls PRV2003 tbl_prim_newbound_1930 tbl_exconst 			 tbl_legor_uk tbl_legor_fr (tbl_pc_tr_tol_all = tbl_lan), first robust
  esttab using tableS6.rtf, replace star(* 0.10 ** 0.05 *** 0.01) r2 se cells(b(star fmt(2)) se(par fmt(2)))
  eststo clear
  restore

 *__________________________________________________________________________________
 * 2.5 Testing for potential spillovers from preceding experiment

 ranksum payouts if country == 40, by(prevexp) //Austria
 ranksum payouts if country == 504, by(prevexp) //Morocco
 ranksum payouts if country == 616, by(prevexp) //Poland
 ranksum payouts if country == 156, by(prevexp) //China
 ranksum payouts if country == 752, by(prevexp) //Sweden

 ranksum payouts if country == 826 & prevexp==-1 | country == 826 & prevexp==0, by(prevexp) //UK: stand alone vs PG
 ranksum payouts if country == 792 & prevexp==-1 | country == 792 & prevexp==0, by(prevexp) //Turkey: stand alone vs PG
 ranksum payouts if country == 320 & prevexp==-1 | country == 320 & prevexp==0, by(prevexp) //Guatemala: stand alone vs PG
 kwallis payouts if country == 826, by(prevexp) //England
 kwallis payouts if country == 792, by(prevexp) //Turkey 
 
 tabulate prevexp payouts if country==40, exact //Austria 
 tabulate prevexp payouts if country==504, exact //Morocco
 tabulate prevexp payouts if country==616, exact //Poland 
 tabulate prevexp payouts if country==156, exact //China 
 tabulate prevexp payouts if country==752, exact //Sweden
 tabulate prevexp payouts if country == 826 & prevexp==-1 | country == 826 & prevexp==0, exact //UK 
 tabulate prevexp payouts if country == 792 & prevexp==-1 | country == 792 & prevexp==0, exact //Turkey
 tabulate prevexp payouts if country == 320 & prevexp==-1 | country == 320 & prevexp==0, exact //Guatemala

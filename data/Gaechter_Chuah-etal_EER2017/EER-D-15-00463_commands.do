* ==================================MAIN REGRESSIONS IN PAPER================================

* H1: Models 1-6 

eststo clear

eststo: xtreg belief hi sex mcreli type if trustee==0&task==5, i(subjectall)
eststo: xtreg belief hi sex mcreli type if trustee==0&task==5&raff==7, i(subjectall)
eststo: xtreg belief hi sex mcreli type if trustee==0&task==5&raff<7, i(subjectall)
eststo: xtreg belief hi sex mcreli type typebymcreli if trustee==0&task==5, i(subjectall)
eststo: xtreg wcoop hi sex mcreli type if trustee==0&task==5, i(subjectall)
eststo: xtreg wcoop belief hi sex mcreli type if trustee==0&task==5, i(subjectall)

esttab using "NoWTDRegs1.rtf", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace
esttab using "NoWTDRegs1.tex", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace


eststo clear

* H2: Models 7-10

eststo: xtreg wcoop belief hi sex mcreli ingp ingpbymcreli if trustee==0&task==4, i(subjectall)
eststo: xtreg wcoop belief hi sex mcreli ingp ingpbymcreli if trustee==0&task==4&raff==7, i(subjectall)
eststo: xtreg wcoop belief hi sex mcreli ingp ingpbymcreli if trustee==0&task==4&raff<7, i(subjectall)
***NEW MODELS 7'-9'***
eststo: xtreg wcoop belief hi sex mcreli ingp ingpbymcreli if trustee==0&task==6, i(subjectall)
eststo: xtreg wcoop belief hi sex mcreli ingp ingpbymcreli if trustee==0&task==6&raff==7, i(subjectall)
eststo: xtreg wcoop belief hi sex mcreli ingp ingpbymcreli if trustee==0&task==6&raff<7, i(subjectall)   
*******************************
eststo: xtreg wcoop belief hi sex mcreli ingp ingpbymcreli if trustee==1&task==4, i(subjectall)

esttab using "NoWTDRegs2.rtf", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace
esttab using "NoWTDRegs2.tex", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace

eststo clear

* H3: Models 11-16

eststo: xtreg belief hi sex mcreli ingp ingpbymcreli wearereli if trustee==0&task==4, i(subjectall)
eststo: xtreg wcoop belief hi sex mcreli ingp ingpbymcreli wearereli if trustee==0&task==4, i(subjectall)
eststo: xtreg belief hi sex mcreli ingp ingpbymcreli wearereli warbymcreli if trustee==0&task==4, i(subjectall)
eststo: xtreg belief hi sex mcreli ingp ingpbymcreli wearereli warbymcreli if trustee==0&task==4&raff==7, i(subjectall)
eststo: xtreg belief hi sex mcreli ingp ingpbymcreli wearereli warbymcreli if trustee==0&task==4&raff<7, i(subjectall)
eststo: xtreg wcoop hi sex mcreli ingp ingpbymcreli wearereli warbymcreli if trustee==0&task==4, i(subjectall)

esttab using "NoWTDRegs3.rtf", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace
esttab using "NoWTDRegs3.tex", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace


eststo clear


* H4: Models 17-19
eststo: xtreg wtd hi sex mcreli if nonrelcat==1&trustee==0&type==1&task<11, i(subjectall)
eststo: xtreg belief hi sex mcreli ingp ingpbymcreli if nonrelcat==1&trustee==0&task<11, i(subjectall)
eststo: xtreg wcoop belief hi sex mcreli ingp ingpbymcreli if nonrelcat==1&trustee==0&task<11, i(subjectall)

esttab using "NoWTDRegs4-religiosity.rtf", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace
esttab using "NoWTDRegs4-religiosity.tex", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace




*=============================PAPER APPENDIX========================================


*A0:

eststo clear

eststo: xtlogit act0 belief hi sex mcreli if trustee==0&task==0
eststo: xtlogit act0 belief hi sex mcreli if trustee==1&task==0

esttab using "LegitReliRegs.rtf", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace
esttab using "LegitReliRegs.tex", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace


*A1: 

mean wtd if task==0, over(place trustee)
mean wtd if task==1, over(place trustee)
mean wtd if task==2, over(place trustee)
mean wtd if task==3, over(place trustee)
mean wtd if task==4, over(place trustee)
mean wtd if task==5, over(place trustee)
mean wtd if task==6, over(place trustee)
mean wtd if task==7, over(place trustee)
mean wtd if task==8, over(place trustee)
mean wtd if task==9, over(place trustee)
mean wtd if task==10, over(place trustee)
mean wtd if task==11, over(place trustee)

mean belief if task==0, over(place trustee)
mean belief if task==1, over(place trustee type)
mean belief if task==2, over(place trustee type)
mean belief if task==3, over(place trustee type)
mean belief if task==4, over(place trustee type)
mean belief if task==5, over(place trustee type)
mean belief if task==6, over(place trustee type)
mean belief if task==7, over(place trustee type)
mean belief if task==8, over(place trustee type)
mean belief if task==9, over(place trustee type)
mean belief if task==10, over(place trustee type)
mean belief if task==11, over(place trustee type)

mean wcoop if task==0, over(place trustee)
mean wcoop if task==1, over(place trustee type)
mean wcoop if task==2, over(place trustee type)
mean wcoop if task==3, over(place trustee type)
mean wcoop if task==4, over(place trustee type)
mean wcoop if task==5, over(place trustee type)
mean wcoop if task==6, over(place trustee type)
mean wcoop if task==7, over(place trustee type)
mean wcoop if task==8, over(place trustee type)
mean wcoop if task==9, over(place trustee type)
mean wcoop if task==10, over(place trustee type)
mean wcoop if task==11, over(place trustee type)

*A2:

tabulate female place if task==1&type==1&hi==1
tabulate agegp place if task==1&type==1&hi==1
tabulate citizen place if task==1&type==1&hi==1
tabulate raff place if task==1&type==1&hi==1
tabulate rcat place if task==1&type==1&hi==1
tabulate race place if task==1&type==1&hi==1
tabulate edu place if task==1&type==1&hi==1
tabulate right place if task==1&type==1&hi==1
tabulate volun place if task==1&type==1&hi==1

*A3:

graph bar (mean) wcoop if trustee==0&task==4, over(ingp) over(raff)


*A5: 

eststo clear

eststo: xtreg wtd hi sex mcreli treatm1 treatm2 treatm3 treatm6 treatm7 treatm8 treatm9 treatm10 if nonrelcat==1&trustee==0&type==1&task<11, i(subjectall)
eststo: xtreg belief hi sex mcreli ingp ingpbymcreli treatm1 treatm2 treatm3 treatm6 treatm7 treatm8 treatm9 treatm10 if nonrelcat==1&trustee==0&task<11, i(subjectall)
eststo: xtreg wcoop belief hi sex mcreli ingp ingpbymcreli treatm1 treatm2 treatm3 treatm6 treatm7 treatm8 treatm9 treatm10 if nonrelcat==1&trustee==0&task<11, i(subjectall)

esttab using "NoWTDRegs5-2.rtf", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace
esttab using "NoWTDRegs5-2.tex", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace




*==================ONLINE APPENDIX===================

*OA1:

ttest wcoop == act0 if trustee==0&task==1
ttest wcoop == act0 if trustee==0&task==2
ttest wcoop == act0 if trustee==0&task==3
ttest wcoop == act0 if trustee==0&task==4
ttest wcoop == act0 if trustee==0&task==5
ttest wcoop == act0 if trustee==0&task==6
ttest wcoop == act0 if trustee==0&task==7
ttest wcoop == act0 if trustee==0&task==8
ttest wcoop == act0 if trustee==0&task==9
ttest wcoop == act0 if trustee==0&task==10
ttest wcoop == act0 if trustee==0&task==11
ttest wcoop == act0 if trustee==0&task==1&chn==0
ttest wcoop == act0 if trustee==0&task==2&chn==0
ttest wcoop == act0 if trustee==0&task==3&chn==0
ttest wcoop == act0 if trustee==0&task==4&chn==0
ttest wcoop == act0 if trustee==0&task==5&chn==0
ttest wcoop == act0 if trustee==0&task==6&chn==0
ttest wcoop == act0 if trustee==0&task==7&chn==0
ttest wcoop == act0 if trustee==0&task==8&chn==0
ttest wcoop == act0 if trustee==0&task==9&chn==0
ttest wcoop == act0 if trustee==0&task==10&chn==0
ttest wcoop == act0 if trustee==0&task==11&chn==0
ttest wcoop == act0 if trustee==0&task==1&chn==1
ttest wcoop == act0 if trustee==0&task==2&chn==1
ttest wcoop == act0 if trustee==0&task==3&chn==1
ttest wcoop == act0 if trustee==0&task==4&chn==1
ttest wcoop == act0 if trustee==0&task==5&chn==1
ttest wcoop == act0 if trustee==0&task==6&chn==1
ttest wcoop == act0 if trustee==0&task==7&chn==1
ttest wcoop == act0 if trustee==0&task==8&chn==1
ttest wcoop == act0 if trustee==0&task==9&chn==1
ttest wcoop == act0 if trustee==0&task==10&chn==1
ttest wcoop == act0 if trustee==0&task==11&chn==1



*OA2: 


* gender condition

eststo clear

eststo: xtreg wtd hi sex mcreli if task==2&trustee==0&type==1, i(subjectall)
eststo: xtreg belief hi sex mcreli ingp ingpbymcreli if task==2&trustee==0, i(subjectall)
eststo: xtreg wcoop belief hi sex mcreli ingp ingpbymcreli if task==2&trustee==0, i(subjectall)

eststo: xtreg wtd hi sex mcreli if place==1&task==2&trustee==0&type==1, i(subjectall)
eststo: xtreg belief hi sex mcreli ingp ingpbymcreli if place==1&task==2&trustee==0, i(subjectall)
eststo: xtreg wcoop belief hi sex mcreli ingp ingpbymcreli if place==1&task==2&trustee==0, i(subjectall)

eststo: xtreg wtd hi sex mcreli if place==2&task==2&trustee==0&type==1, i(subjectall)
eststo: xtreg belief hi sex mcreli ingp ingpbymcreli if place==2&task==2&trustee==0, i(subjectall)
eststo: xtreg wcoop belief hi sex mcreli ingp ingpbymcreli if place==2&task==2&trustee==0, i(subjectall)

eststo: xtreg wtd hi sex mcreli if place==3&task==2&trustee==0&type==1, i(subjectall)
eststo: xtreg belief hi sex mcreli ingp ingpbymcreli if place==3&task==2&trustee==0, i(subjectall)
eststo: xtreg wcoop belief hi sex mcreli ingp ingpbymcreli if place==3&task==2&trustee==0, i(subjectall)

esttab using "NoWTDRegsGENDER-religiosity.rtf", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace
esttab using "NoWTDRegsGENDER-religiosity.tex", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace


* campus and nationality conditions

eststo clear

eststo: xtreg wcoop belief hi sex mcreli ingp ingpbymcreli if trustee==0&task==3, i(subjectall)
eststo: xtreg wcoop belief hi sex mcreli ingp ingpbymcreli if trustee==0&task==3&raff==7, i(subjectall)
eststo: xtreg wcoop belief hi sex mcreli ingp ingpbymcreli if trustee==0&task==3&raff<7, i(subjectall)

eststo: xtreg wcoop belief hi sex mcreli ingp ingpbymcreli if trustee==0&task==7, i(subjectall)
eststo: xtreg wcoop belief hi sex mcreli ingp ingpbymcreli if trustee==0&task==7&raff==7, i(subjectall)
eststo: xtreg wcoop belief hi sex mcreli ingp ingpbymcreli if trustee==0&task==7&raff<7, i(subjectall)

esttab using "CampNatRegs.rtf", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace
esttab using "CampNatRegs.tex", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace




*OA3:


* MAIN REGRESSIONS with WTD controls

* H1: Models 1-6 

eststo clear

eststo: xtreg belief wtd hi sex mcreli type if trustee==0&task==5, i(subjectall)
eststo: xtreg belief wtd hi sex mcreli type if trustee==0&task==5&raff==7, i(subjectall)
eststo: xtreg belief wtd hi sex mcreli type if trustee==0&task==5&raff<7, i(subjectall)
eststo: xtreg belief wtd hi sex mcreli type typebymcreli if trustee==0&task==5, i(subjectall)
eststo: xtreg wcoop wtd hi sex mcreli type if trustee==0&task==5, i(subjectall)
eststo: xtreg wcoop wtd belief hi sex mcreli type if trustee==0&task==5, i(subjectall)

esttab using "WTDRegs1.rtf", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace
esttab using "WTDRegs1.tex", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace


eststo clear

* H2: Models 7-10

eststo: xtreg wcoop wtd belief hi sex mcreli ingp ingpbymcreli if trustee==0&task==4, i(subjectall)
eststo: xtreg wcoop wtd belief hi sex mcreli ingp ingpbymcreli if trustee==0&task==4&raff==7, i(subjectall)
eststo: xtreg wcoop wtd belief hi sex mcreli ingp ingpbymcreli if trustee==0&task==4&raff<7, i(subjectall)
***NEW MODELS 7'-9'***
eststo: xtreg wcoop wtd belief hi sex mcreli ingp ingpbymcreli if trustee==0&task==6, i(subjectall)
eststo: xtreg wcoop wtd belief hi sex mcreli ingp ingpbymcreli if trustee==0&task==6&raff==7, i(subjectall)
eststo: xtreg wcoop wtd belief hi sex mcreli ingp ingpbymcreli if trustee==0&task==6&raff<7, i(subjectall)   
*******************************
eststo: xtreg wcoop wtd belief hi sex mcreli ingp ingpbymcreli if trustee==1&task==4, i(subjectall)

esttab using "WTDRegs2.rtf", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace
esttab using "WTDRegs2.tex", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace

eststo clear

* H3: Models 11-16

eststo: xtreg belief wtd hi sex mcreli ingp ingpbymcreli wearereli if trustee==0&task==4, i(subjectall)
eststo: xtreg wcoop belief hi sex mcreli ingp ingpbymcreli wearereli if trustee==0&task==4, i(subjectall)
eststo: xtreg belief wtd hi sex mcreli ingp ingpbymcreli wearereli warbymcreli if trustee==0&task==4, i(subjectall)
eststo: xtreg belief wtd hi sex mcreli ingp ingpbymcreli wearereli warbymcreli if trustee==0&task==4&raff==7, i(subjectall)
eststo: xtreg belief wtd hi sex mcreli ingp ingpbymcreli wearereli warbymcreli if trustee==0&task==4&raff<7, i(subjectall)
eststo: xtreg wcoop wtd hi sex mcreli ingp ingpbymcreli wearereli warbymcreli if trustee==0&task==4, i(subjectall)

esttab using "WTDRegs3.rtf", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace
esttab using "WTDRegs3.tex", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace


eststo clear


* H4: Models 17-19
eststo: xtreg wtd hi sex mcreli if nonrelcat==1&trustee==0&type==1&task<11, i(subjectall)
eststo: xtreg belief wtd hi sex mcreli ingp ingpbymcreli if nonrelcat==1&trustee==0&task<11, i(subjectall)
eststo: xtreg wcoop wtd belief hi sex mcreli ingp ingpbymcreli if nonrelcat==1&trustee==0&task<11, i(subjectall)

esttab using "WTDRegs4-religiosity.rtf", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace
esttab using "WTDRegs4-religiosity.tex", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace


* COUNTRY REGRESSIONS

* H1: Models 1-6 

eststo clear

eststo: xtreg belief chn unmc hi sex mcreli type if trustee==0&task==5, i(subjectall)
eststo: xtreg belief chn unmc hi sex mcreli type if trustee==0&task==5&raff==7, i(subjectall)
eststo: xtreg belief chn unmc hi sex mcreli type if trustee==0&task==5&raff<7, i(subjectall)
eststo: xtreg belief chn unmc hi sex mcreli type typebymcreli if trustee==0&task==5, i(subjectall)
eststo: xtreg wcoop chn unmc hi sex mcreli type if trustee==0&task==5, i(subjectall)
eststo: xtreg wcoop chn unmc belief hi sex mcreli type if trustee==0&task==5, i(subjectall)

esttab using "CountryRegs1.rtf", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace
esttab using "CountryRegs1.tex", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace


eststo clear

* H2: Models 7-10

eststo: xtreg wcoop chn unmc belief hi sex mcreli ingp ingpbymcreli if trustee==0&task==4, i(subjectall)
eststo: xtreg wcoop chn unmc belief hi sex mcreli ingp ingpbymcreli if trustee==0&task==4&raff==7, i(subjectall)
eststo: xtreg wcoop chn unmc belief hi sex mcreli ingp ingpbymcreli if trustee==0&task==4&raff<7, i(subjectall)
***NEW MODELS 7'-9'***
eststo: xtreg wcoop chn unmc belief hi sex mcreli ingp ingpbymcreli if trustee==0&task==6, i(subjectall)
eststo: xtreg wcoop chn unmc belief hi sex mcreli ingp ingpbymcreli if trustee==0&task==6&raff==7, i(subjectall)
eststo: xtreg wcoop chn unmc belief hi sex mcreli ingp ingpbymcreli if trustee==0&task==6&raff<7, i(subjectall)   
*******************************
eststo: xtreg wcoop belief hi sex mcreli ingp ingpbymcreli if trustee==1&task==4, i(subjectall)

esttab using "CountryRegs2.rtf", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace
esttab using "CountryRegs2.tex", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace

eststo clear

* H3: Models 11-16

eststo: xtreg belief chn unmc hi sex mcreli ingp ingpbymcreli wearereli if trustee==0&task==4, i(subjectall)
eststo: xtreg wcoop chn unmc belief hi sex mcreli ingp ingpbymcreli wearereli if trustee==0&task==4, i(subjectall)
eststo: xtreg belief chn unmc hi sex mcreli ingp ingpbymcreli wearereli warbymcreli if trustee==0&task==4, i(subjectall)
eststo: xtreg belief chn unmc hi sex mcreli ingp ingpbymcreli wearereli warbymcreli if trustee==0&task==4&raff==7, i(subjectall)
eststo: xtreg belief chn unmc hi sex mcreli ingp ingpbymcreli wearereli warbymcreli if trustee==0&task==4&raff<7, i(subjectall)
eststo: xtreg wcoop chn unmc hi sex mcreli ingp ingpbymcreli wearereli warbymcreli if trustee==0&task==4, i(subjectall)

esttab using "CountryRegs3.rtf", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace
esttab using "CountryRegs3.tex", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace

eststo clear


* H4: Models 17-19

eststo: xtreg wtd chn unmc hi sex mcreli if nonrelcat==1&trustee==0&type==1&task<11, i(subjectall)
eststo: xtreg belief chn unmc hi sex mcreli ingp ingpbymcreli if nonrelcat==1&trustee==0&task<11, i(subjectall)
eststo: xtreg wcoop chn unmc belief hi sex mcreli ingp ingpbymcreli if nonrelcat==1&trustee==0&task<11, i(subjectall)

esttab using "CountryRegs4-religiosity.rtf", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace
esttab using "CountryRegs4-religiosity.tex", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace



*OA4: 

graph bar (mean) wcoop if trustee==0&task==4, over(ingp) over(majority) over(place)
graph bar (mean) wcoop if trustee==0&task==4, over(ingp) over(majority2) over(place)

eststo clear

eststo: xtreg wcoop belief hi sex mcreli majority ingp ingpbymcreli ingpbymajority if trustee==0&task==4, i(subjectall)
eststo: xtreg wcoop belief hi sex mcreli majority2 ingp ingpbymcreli ingpbymajority2 if trustee==0&task==4, i(subjectall)
eststo: xtreg wcoop belief hi sex mcreli hetero ingp ingpbymcreli ingpbyhetero if trustee==0&task==4, i(subjectall)

esttab using "MajorHetero1Regs.rtf", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace
esttab using "MajorHetero1Regs.tex", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace

eststo clear

eststo: xtreg wcoop belief hi sex mcreli unmc ingp ingpbymcreli ingpbyunmc if trustee==0&task==4&raff==2, i(subjectall)
eststo: xtreg wcoop belief hi sex mcreli chn ingp ingpbymcreli ingpbychn if trustee==0&task==4&raff==1, i(subjectall)

esttab using "MajorHetero2Regs.rtf", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace
esttab using "MajorHetero2Regs.tex", cells(b(star fmt(%9.3f)) se(par fmt(%9.3f))) stats(r2_o N, fmt(%9.3f %9.0g)) star(* 0.10 ** 0.05 *** 0.01) replace

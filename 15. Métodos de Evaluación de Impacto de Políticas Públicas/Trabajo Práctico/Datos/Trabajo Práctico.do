clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/15. Métodos de Evaluación de Impacto de Políticas Públicas/Trabajo Práctico/Datos"


*##############################################################################*
************************ DISEÑO DE REGRESIÓN DISCONTINUA ***********************
*##############################################################################*


use "CIT_2019_Cambridge_senate", clear

net install rdrobust, from(https://raw.githubusercontent.com/rdpackages/rdrobust/master/stata) replace
net install rddensity, from(https://raw.githubusercontent.com/rdpackages/rddensity/master/stata) replace


********************************************************************************
								* EJERCICIO 2 *
********************************************************************************


*Definir X= demmy e Y= demvoteshfor2*
rename demmv X
rename demvoteshfor2 Y

*Definir T (variable de tratamiento)*
generate T=.
replace T=1 if (X>=0 & X!=.)
replace T=0 if (X<0 & X!=.)
label var T "Demócratas ganaron la elección en el período t"


********************************************************************************
								* EJERCICIO 3 *
********************************************************************************


graph twoway scatter Y X, color(black) ytitle("Democratic vote share at t+2") xtitle("Democratic margin of victory at t") yline(50, lcolor(red)) xline(0, lcolor(red))


********************************************************************************
								* EJERCICIO 4 *
********************************************************************************


rdplot Y X, nbins(20 20)


********************************************************************************
								* EJERCICIO 5 *
********************************************************************************


*Estimación MCO - Lado izquierdo*
regress Y X if (X<0 & X>=-10)
matrix coef_left=e(b)
local intercept_left=coef_left[1,2]
display `intercept_left'

*Estimación MCO - Lado derecho*
regress Y X if (X>=0 & X<=10)
matrix coef_right=e(b)
local intercept_right=coef_right[1,2]
display `intercept_right'

*Estimador RD*
local difference=`intercept_right'-`intercept_left'
display `difference'


********************************************************************************
								* EJERCICIO 6 *
********************************************************************************


generate TX=T*X
regress Y T X TX if (X>=-10 & X<=10)


********************************************************************************
								* EJERCICIO 7 *
********************************************************************************


rdrobust Y X, p(1) h(10) kernel(uniform)
rdplot Y X if (abs(X)<=10), p(1) h(10) kernel(uniform)


********************************************************************************
								* EJERCICIO 8 *
********************************************************************************


rdrobust Y X, p(1) kernel(uniform)
local bandwidth=e(h_l)
rdplot Y X if (abs(X)<=`bandwidth'), p(1) h(`bandwidth') kernel(uniform)


********************************************************************************
								* EJERCICIO 9 *
********************************************************************************


*INCISO (a)*

*Con ancho de banda 10 y kernel uniforme*
rdrobust demvoteshlag1 X, p(1) h(10) kernel(uniform)
rdplot demvoteshlag1 X if (abs(X)<=10), p(1) h(10) kernel(uniform)

*Con ancho de banda óptimo y kernel triangular*
rdrobust demvoteshlag1 X, p(1) kernel(triangular)
local bandwidth=e(h_l)
rdplot demvoteshlag1 X if (abs(X)<=`bandwidth'), p(1) h(`bandwidth') kernel(triangular)

*INCISO (b)*

*Test de densidad de McCrary (2008)*
histogram X, ytitle("Número de observaciones") xtitle("Score") frequency
DCdensity X, breakpoint(0) generate(Xj Yj r0 fhat se_fhat)

/*
*Test de densidad de Cattaneo et al. (2017)*
rddensity X
local bandwidth_left=e(h_l)
local bandwidth_right=e(h_r)
graph twoway	(histogram X if (X>=-`bandwidth_left' & X<0), width(1) frequency) ///
				(histogram X if (X>=0 & X<=`bandwidth_right'), width(1) frequency), ///
				ytitle("Número de observaciones") xtitle("Score") legend(off)
rddensity X, plot plot_range(-`bandwidth_left' `bandwidth_right')
*/

*INCISO (c)*

rdrobust Y X if (X>=0), c(1) p(1) h(10) kernel(uniform)
rdplot Y X if (X>=0 & abs(X)<=10), c(1) p(1) h(10) kernel(uniform)


*##############################################################################*
************************** DIFERENCIAS EN DIFERENCIAS **************************
*##############################################################################*


use "minwage", clear
keep if (sample==1)


********************************************************************************
								* EJERCICIO 1 *
********************************************************************************


egen wage_stNJ1=mean(wage_st)  if (state==1)
egen wage_stNJ2=mean(wage_st2) if (state==1)
egen wage_stPA1=mean(wage_st)  if (state==0)
egen wage_stPA2=mean(wage_st2) if (state==0)
summarize wage_stNJ1 wage_stNJ2 wage_stPA1 wage_stPA2

*INCISO (a)*

generate dif_wage_stNJ=wage_stNJ2-wage_stNJ1
generate dif_wage_stPA=wage_stPA2-wage_stPA1
summarize dif_wage_stNJ dif_wage_stPA

*INCISO (b)*

preserve
collapse (mean) dif_wage_stNJ dif_wage_stPA
generate DD=dif_wage_stNJ-dif_wage_stPA
summarize DD
restore


********************************************************************************
								* EJERCICIO 2 *
********************************************************************************


egen fteNJ1=mean(fte)  if (state==1)
egen fteNJ2=mean(fte2) if (state==1)
egen ftePA1=mean(fte)  if (state==0)
egen ftePA2=mean(fte2) if (state==0)
summarize fteNJ1 fteNJ2 ftePA1 ftePA2

generate dif_fteNJ=fteNJ2-fteNJ1
generate dif_ftePA=ftePA2-ftePA1
summarize dif_fteNJ dif_ftePA

preserve
collapse (mean) dif_fteNJ dif_ftePA
generate DD=dif_fteNJ-dif_ftePA
summarize DD
restore


********************************************************************************
								* EJERCICIO 3 *
********************************************************************************


*INCISO (b)*

generate TREAT=.
replace TREAT=0 if (TREAT==.)
replace TREAT=1 if (state==1)

generate TREAT2=.
replace TREAT2=0 if (TREAT2==.)
replace TREAT2=1 if (wage_st<5)

foreach x in empft emppt wage_st fte {
	rename `x' `x'1
}

reshape long empft emppt wage_st fte, i(sheet chain) j(time)

generate POST=.
replace POST=0 if (POST==.)
replace POST=1 if (time==2)

regress wage_st TREAT##POST, robust
regress fte TREAT##POST, robust

generate TREAT_POST=TREAT*POST

regress wage_st TREAT POST TREAT_POST, robust
regress fte TREAT POST TREAT_POST, robust


********************************************************************************
								* EJERCICIO 4 *
********************************************************************************


regress wage_st TREAT2##POST if (state==1), robust
regress fte TREAT2##POST if (state==1), robust

generate TREAT2_POST=TREAT2*POST

regress wage_st TREAT2 POST TREAT2_POST if (state==1), robust
regress fte TREAT2 POST TREAT2_POST if (state==1), robust

*INCISO (a)*

regress wage_st TREAT2##POST if (state==0), robust
regress fte TREAT2##POST if (state==0), robust

regress wage_st TREAT2 POST TREAT2_POST if (state==0), robust
regress fte TREAT2 POST TREAT2_POST if (state==0), robust

*INCISO (b)*

regress wage_st TREAT##TREAT2##POST, robust
regress fte TREAT##TREAT2##POST, robust


*##############################################################################*
*************************** VARIABLES INSTRUMENTALES ***************************
*##############################################################################*


use "ajr-aer", clear
keep if (baseco==1)


********************************************************************************
								* EJERCICIO 3 *
********************************************************************************


*Mínimos Cuadrados en Dos Etapas (MC2E)*
ivregress 2sls logpgp95 lat_abst (avexpr=logem4), first
estimates store est_MC2E

*Mínimos Cuadrados Ordinarios (MCO)*
regress logpgp95 lat_abst avexpr
estimates store est_MCO

estimates table	est_MC2E est_MCO, stats(N r2) b(%5.3f) se(%5.3f) p(%5.3f)
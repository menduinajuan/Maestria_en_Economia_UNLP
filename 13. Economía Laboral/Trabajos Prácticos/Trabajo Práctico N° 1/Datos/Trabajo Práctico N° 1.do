clear all
set more off
version 16

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/13. Economía Laboral/Trabajos Prácticos/Trabajo Práctico N° 1/Datos"
use "ury-0509", clear


*##############################################################################*
								* EJERCICIO 2 *
*##############################################################################*


*INCISO (a)*

generate postpol=.
replace postpol=0 if (postpol==.)
replace postpol=1 if (year==2009)
label variable postpol "=1 si post-política"

generate children_postpol=children*postpol
label variable children_postpol "al menos 1 hijo en post-política"

matrix define   STATS = J(1,8,.)
matrix colnames STATS =	"Media (children=0 y postpol=0)" "SD (children=0 y postpol=0)" "Media (children=0 y postpol=1)" "SD (children=0 y postpol=1)" ///
						"Media (children=1 y postpol=0)" "SD (children=1 y postpol=0)" "Media (children=1 y postpol=1)" "SD (children=1 y postpol=1)"
matrix list STATS

foreach var of varlist informal children_tot age man married head yedu region_* fsize_* sector_* hswrp wage_m {

	summarize `var' [w=pondera] if (muestra==1 & children==0 & postpol==0)
	matrix define A=(r(mean),r(sd))
	summarize `var' [w=pondera] if (muestra==1 & children==0 & postpol==1)
	matrix define A=(A,r(mean),r(sd))
	summarize `var' [w=pondera] if (muestra==1 & children==1 & postpol==0)
	matrix define A=(A,r(mean),r(sd))
	summarize `var' [w=pondera] if (muestra==1 & children==1 & postpol==1)
	matrix define A=(A,r(mean),r(sd))
	matrix rownames A=`var'

	matrix define STATS=(STATS\A)

}

matrix list STATS

preserve
drop _all
svmat STATS
export excel "Tabla 1.xlsx", replace
restore

*INCISO (b)*

preserve

table year [w=pondera], contents(mean informal) row
table year children [w=pondera], contents(mean informal) replace

graph twoway	(connected table1 year if (children==1)) (connected table1 year if (children==0), lpattern(dash)), ///
				ytitle("Tasa de informalidad") xtitle("Año") xline(2008) ///
				legend(label(1 "Asalariados con hijos < 18") label(2 "Asalariados sin hijos"))

restore

*INCISO (c)*

preserve

local controles "age age2 man head married yedu yedu2 children_tot fsize_2-fsize_4 sector_2-sector_9"

foreach y of numlist 2005(1)2009 {

	matrix define beta=J(1,4,.)

	regress informal children `controles' [pw=pondera] if (year==`y'), robust
	lincom children

	matrix beta [1,2]=r(estimate)
	matrix beta [1,3]=r(estimate)-1.96*r(se)
	matrix beta [1,4]=r(estimate)+1.96*r(se)

	if "`y'"=="2005" matrix define beta_dif=(beta*100)
	if "`y'"!="2005" matrix define beta_dif=(beta_dif\beta*100)

	matrix beta_dif [`y'-2004,1]=`y'

}

matrix list beta_dif

drop _all
svmat double beta_dif

rename beta_dif1 year
rename beta_dif2 dif_informalidad
rename beta_dif3 limite_inferior
rename beta_dif4 limite_superior

graph twoway line	dif_informalidad limite_inferior limite_superior year, ///
					xtitle("Año") ylabel(-10(5)10) xlabel(2005(1)2009) yline(0) ///
					lwidth(thick medthick medthick) lpattern(solid dash dash)

restore


*##############################################################################*
								* EJERCICIO 3 *
*##############################################################################*


regress informal children children_postpol i.year i.dpto [pw=pondera] if (muestra==1), robust
estimates store est_sinctrl

regress informal children children_postpol `controles' i.year i.dpto [pw=pondera] if (muestra==1), robust
estimates store est_conctrl

estimates table	est_sinctrl est_conctrl, stats(N r2) keep(children_postpol) b(%10.4f) se(%10.4f) p(%10.4f)


*##############################################################################*
								* EJERCICIO 4 *
*##############################################################################*


generate postpol_f=.
replace postpol_f=1 if (year==2007)
replace postpol_f=0 if (postpol_f==.)

generate children_postpol_f=children*postpol_f

regress informal children children_postpol_f i.year i.dpto [pw=pondera] if (muestra==1 & year<=2007), robust
estimates store est_sinctrl_f

regress informal children children_postpol_f `controles' i.year i.dpto [pw=pondera] if (muestra==1 & year<=2007), robust
estimates store est_conctrl_f

estimates table	est_sinctrl est_conctrl est_sinctrl_f est_conctrl_f, stats(N r2) keep(children_postpol children_postpol_f) b(%10.4f) se(%10.4f) p(%10.4f)


*##############################################################################*
								* EJERCICIO 5 *
*##############################################################################*


xi i.year, noomit

forvalues i=5(1)9 {
	generate ty_`i'=children*_Iyear_200`i'
}

regress informal ty_9 ty_7 ty_6 ty_5 children i.year i.dpto [pw=pondera], robust
estimates store est_sinctrl_d

regress informal ty_9 ty_7 ty_6 ty_5 children `controles' i.year i.dpto [pw=pondera], robust
estimates store est_conctrl_d

estimates table	est_sinctrl est_conctrl est_sinctrl_f est_conctrl_f est_sinctrl_d est_conctrl_d, ///
				stats(N r2) keep(children_postpol children_postpol_f ty_9 ty_7 ty_6 ty_5) b(%10.4f) se(%10.4f) p(%10.4f)
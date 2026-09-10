clear all
set more off

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/19. Regresiones por Cuantiles/Examen/Datos"
use "EKC-data", clear


describe
set seed 12345


*##############################################################################*
								* EJERCICIO 1.a *
*##############################################################################*


generate lgdp2=lgdp^2

summarize lgdp
local lgdp_mean=r(mean)

*MCO*

regress polu lgdp lgdp2
display _b[lgdp]+2*_b[lgdp2]*`lgdp_mean'

*QR*

foreach i of numlist 10 25 50 75 90 {
	bsqreg polu lgdp lgdp2, quantile(`i') reps(100)
	generate polu1_q`i'=_b[_cons]+_b[lgdp]*lgdp+_b[lgdp2]*lgdp2
	display _b[lgdp]+2*_b[lgdp2]*`lgdp_mean'
}

sqreg polu lgdp lgdp2, quantile(10 25 50 75 90) reps(100)


*##############################################################################*
								* EJERCICIO 1.b *
*##############################################################################*


graph twoway 	(scatter polu lgdp) (scatter polu1_q10 lgdp) (scatter polu1_q25 lgdp) (scatter polu1_q50 lgdp) (scatter polu1_q75 lgdp) (scatter polu1_q90 lgdp), ///
				ytitle("Emisiones de CO2 (kg. per GDP del 2005)") xtitle("Logaritmo del GDP per cápita (PPP constante)")


*##############################################################################*
								* EJERCICIO 1.c *
*##############################################################################*


foreach i of varlist educ1 educ2 urbano {
	summarize `i'
	local `i'_mean=r(mean)
}

*MCO*

regress polu lgdp lgdp2 educ1 educ2 urbano
display _b[lgdp]+2*_b[lgdp2]*`lgdp_mean'

*QR*

foreach i of numlist 10 25 50 75 90 {
	bsqreg polu lgdp lgdp2 educ1 educ2 urbano, quantile(`i') reps(100)
	generate polu2_q`i'=_b[_cons]+_b[lgdp]*lgdp+_b[lgdp2]*lgdp2+_b[educ1]*`educ1_mean'+_b[educ2]*`educ2_mean'+_b[urbano]*`urbano_mean'
	display _b[lgdp]+2*_b[lgdp2]*`lgdp_mean'
}

sqreg polu lgdp lgdp2 educ1 educ2 urbano, quantile(10 25 50 75 90) reps(100)

test [q10=q25=q50=q75=q90]: lgdp lgdp2 educ1 educ2 urbano
test [q10=q25=q50=q75=q90]: lgdp lgdp2
test [q10=q25=q50=q75=q90]: educ1 educ2
test [q10=q25=q50=q75=q90]: urbano


*##############################################################################*
								* EJERCICIO 1.d *
*##############################################################################*


graph twoway 	(scatter polu2_q10 lgdp) (scatter polu2_q25 lgdp) (scatter polu2_q50 lgdp) (scatter polu2_q75 lgdp) (scatter polu2_q90 lgdp), ///
				ytitle("Emisiones de CO2 (kg. per GDP del 2005)") xtitle("Logaritmo del GDP per cápita (PPP constante)")


*##############################################################################*
								* EJERCICIO 1.e *
*##############################################################################*


sort region time
xtset region time
xtdescribe

*MCO con Efectos Fijos*

xtreg polu lgdp lgdp2 educ1 educ2 urbano, fe
display _b[lgdp]+2*_b[lgdp2]*`lgdp_mean'

forvalues i=1(1)6 {
	generate region_`i'=0
	replace region_`i'=1 if (region==`i')
}

regress polu lgdp lgdp2 educ1 educ2 urbano region_2-region_6
display _b[lgdp]+2*_b[lgdp2]*`lgdp_mean'

*QR con Efectos Fijos*

generate zeta=0
replace zeta=polu-region_1 if (region==1)
forvalues i=2(1)6 {
	replace zeta=polu-_b[region_`i'] if (region==`i')
}

foreach i of numlist 10 25 50 75 90 {
	bsqreg zeta lgdp lgdp2 educ1 educ2 urbano, quantile(`i') reps(100)
	generate polu3_q`i'=_b[_cons]+_b[lgdp]*lgdp+_b[lgdp2]*lgdp2+_b[educ1]*`educ1_mean'+_b[educ2]*`educ2_mean'+_b[urbano]*`urbano_mean'
	display _b[lgdp]+2*_b[lgdp2]*`lgdp_mean'
}

sqreg zeta lgdp lgdp2 educ1 educ2 urbano, quantile(10 25 50 75 90) reps(100)

test [q10=q25=q50=q75=q90]: lgdp lgdp2 educ1 educ2 urbano
test [q10=q25=q50=q75=q90]: lgdp lgdp2
test [q10=q25=q50=q75=q90]: educ1 educ2
test [q10=q25=q50=q75=q90]: urbano

*Gráfico*

graph twoway 	(scatter polu3_q10 lgdp) (scatter polu3_q25 lgdp) (scatter polu3_q50 lgdp) (scatter polu3_q75 lgdp) (scatter polu3_q90 lgdp), ///
				ytitle("Emisiones de CO2 (kg. per GDP del 2005)") xtitle("Logaritmo del GDP per cápita (PPP constante)")
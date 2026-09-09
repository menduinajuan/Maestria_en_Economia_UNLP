clear all
set more off
version 16

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/13. Economía Laboral/Trabajos Prácticos/Trabajo Práctico N° 2/Datos"
use "AK", clear


generate muestra=1 if (cohort>20.30 & cohort<30.40)


*##############################################################################*
								* EJERCICIO 1 *
*##############################################################################*


regress lw_sem educ yr20-yr28 if (muestra==1)
estimates store MCO_1

regress lw_sem educ yr20-yr28 edadq edadq2 if (muestra==1)
estimates store MCO_2

regress lw_sem educ yr20-yr28 edadq edadq2 raza casado region1-region8 smsa if (muestra==1)
estimates store MCO_3

estimates table	MCO_1 MCO_2 MCO_3, stats(N r2) b(%5.4f) se(%5.4f) p(%5.4f)


*##############################################################################*
								* EJERCICIO 2 *
*##############################################################################*


preserve

table yob if (yob>=30 & yob<=50 & CENSUS==80), contents(mean educ mean lw_sem) by(qob) replace

generate trim=30+0.25*_n

graph twoway connected table1 trim if (yob>=30 & yob<40) , ytitle("Años de educación promedio)") xtitle("Año-Trimestre") mlabel(qob)
graph twoway connected table1 trim if (yob>=40 & yob<=50), ytitle("Años de educación promedio") xtitle("Año-Trimestre") mlabel(qob)
graph twoway connected table1 trim if (yob>=30 & yob<=50), ytitle("Años de educación promedio") xtitle("Año-Trimestre") mlabel(qob)
graph twoway connected table2 trim if (yob>=30 & yob<=50), ytitle("Logaritmo del salario semanal promedio") xtitle("Año-Trimestre") mlabel(qob)

restore


*##############################################################################*
								* EJERCICIO 3 *
*##############################################################################*


ivregress 2sls lw_sem (educ = qob120-qob129 qob220-qob229 qob320-qob329 yr20-yr28) yr20-yr28 if (muestra==1)
estimates store MC2E_1

ivregress 2sls lw_sem (educ = qob120-qob129 qob220-qob229 qob320-qob329 yr20-yr28) yr20-yr28 edadq edadq2 if (muestra==1)
estimates store MC2E_2

ivregress 2sls lw_sem (educ = qob120-qob129 qob220-qob229 qob320-qob329 yr20-yr28) yr20-yr28 edadq edadq2 raza casado region1-region8 smsa if (muestra==1)
estimates store MC2E_3

estimates table	MC2E_1 MC2E_2 MC2E_3, stats(N r2) b(%5.4f) se(%5.4f) p(%5.4f)


*##############################################################################*
								* EJERCICIO 4 *
*##############################################################################*


*Estimador Wald*

mean lw_sem educ if (qob1==1 & muestra==1)
local lw_sem1=r(table)[1,1]
local educ1=r(table)[1,2]

mean lw_sem educ if (qob1==0 & muestra==1)
local lw_sem0=r(table)[1,1]
local educ0=r(table)[1,2]

display as text "El estimador de Wald es " as result (`lw_sem1'-`lw_sem0')/(`educ1'-`educ0')

recode qob (1 = 1 "1er Trimestre") (2 3 4 = 0 "2do, 3er o 4to Trimestre") (else=.), generate(z)

ttest lw_sem if (muestra==1), by(z)
ttest educ if (muestra==1), by(z)

sureg (lw_sem z) (educ z) if (muestra==1 & !missing(z))
nlcom [lw_sem]_b[z]/[educ]_b[z]

*Estimador MC2E*

ivregress 2sls lw_sem (educ=qob1) if (muestra==1)

*Estimador MCO*

regress lw_sem educ if (muestra==1)
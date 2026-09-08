clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/4. Econometría Avanzada/Trabajos Prácticos/Parte II/Trabajo Práctico N° 1/Datos"
use "nls8087", clear


*ssc install outreg2


*##############################################################################*
								* EJERCICIO 1 *
*##############################################################################*


sort id year
xtset id year
xtdescribe

generate lnsalario=ln(salario)

local y "lnsalario"
local x "educ exper casado sindicato afro hispano"

xtsum id year `y' `x'


*##############################################################################*
								* EJERCICIO 2 *
*##############################################################################*


regress `y' `x'
outreg2 using "Regresiones.xls", replace dec(3) ctitle("POLS")


*##############################################################################*
								* EJERCICIO 3 *
*##############################################################################*


*Between*

xtreg `y' `x', be
outreg2 using "Regresiones.xls", append dec(3) ctitle("Between")

*Within o Efectos Fijos*

xtreg `y' `x', fe
outreg2 using "Regresiones.xls", append dec(3) ctitle("Within")

*Primeras Diferencias*

regress D.(`y' `x'), noconstant
outreg2 using "Regresiones.xls", append dec(3) ctitle("Primeras Diferencias")

*Efectos Aleatorios*

xtreg `y' `x', re theta
outreg2 using "Regresiones.xls", append dec(3) ctitle("Efectos Aleatorios")


*##############################################################################*
								* EJERCICIO 4 *
*##############################################################################*


quietly xtreg `y' `x', fe
estimates store fe

quietly xtreg `y' `x', re
estimates store re

hausman fe re
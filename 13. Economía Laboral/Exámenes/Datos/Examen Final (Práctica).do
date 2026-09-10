clear all
set more off
version 16

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/13. Economía Laboral/Exámenes/Datos"
use "Examen Final (Práctica)", clear


describe


*##############################################################################*
								* EJERCICIO 1 *
*##############################################################################*


generate edad2=edad*edad
generate salarioh2=salarioh*salarioh

local controles "edad edad2 hombre salarioh salarioh2"

regress horas tratado `controles' i.empresa i.relab i.anio, robust
estimates store est_modelo1


*##############################################################################*
								* EJERCICIO 2 *
*##############################################################################*


generate postrat=.
replace postrat=1 if (anio==2019)
replace postrat=0 if (postrat==.)
label variable postrat "=1 si pos-tratamiento"

generate tratado_postrat=tratado*postrat

regress horas tratado tratado_postrat `controles' i.empresa i.relab i.anio, robust
estimates store est_modelo2

estimates table	est_modelo1 est_modelo2, stats(N r2) keep(tratado tratado_postrat) b(%10.4f) se(%10.4f) p(%10.4f)

preserve

table anio tratado, contents(mean horas) replace

graph twoway	(connected table1 anio if tratado==1) (connected table1 anio if tratado==0, lpattern(dash)), ///
				ytitle("Cantidad de Horas Trabajadas Semanales") xtitle("Año") xline(2017, lcolor(red)) ///
				legend(label(1 "Tratados") label(2 "No Tratados"))

restore
clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/3. Seminario de Stata/Material teórico/Clase 3/Datos/Unión bases"


*OPCIÓN 1: Unir las bases hogar e indiv y, luego, sumar hogar e indiv*


*Unión de bases hogar1 y indiv1*

use "eph2010_hogar1", clear
sort id
save "eph2010_hogar1", replace

use "eph2010_indiv1", clear
sort id
save "eph2010_indiv1", replace

merge m:1 id using eph2010_hogar1
tabulate _merge, nolabel
drop _merge

sort id
save "eph2010_resumida1", replace 

*Unión de bases hogar2 y indiv2*

use "eph2010_hogar2", clear
sort id
save "eph2010_hogar2", replace

use "eph2010_indiv2", clear
sort id
save "eph2010_indiv2", replace

merge m:1 id using eph2010_hogar2
tabulate _merge, nolabel
drop _merge

sort id
save "eph2010_resumida2", replace

*Suma de bases resumida1 y resumida2*

use "eph2010_resumida1", clear
append using eph2010_resumida2
save "eph2010_resumida", replace


*OPCIÓN 2: Sumar las bases hogar e indiv y, luego, unir hogar e indiv*


use "eph2010_hogar1", clear
append using eph2010_hogar2
save "eph2010_hogar", replace

use "eph2010_indiv1", clear
append using eph2010_indiv2
save "eph2010_indiv", replace

merge m:1 id using eph2010_hogar
tabulate _merge, nolabel
drop _merge

sort id
save "eph2010_resumida", replace
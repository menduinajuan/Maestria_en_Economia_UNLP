*##############################################################################*
* IMPORTACIÓN DE BASES *
*##############################################################################*


/*
foreach base of newlist Hogares Personas Ingresos Gastos {
	clear all
	import excel "ENGHo - `base'.xlsx", sheet("ENGHo - `base'") firstrow case(lower)
	destring _all, dpcomma replace
	save "ENGHo-`base'", replace
}

foreach base of newlist Hogares Personas Ingresos Gastos {
	import delimited using "ENGHo - `base'.txt", delimiters("|") clear
	destring _all, dpcomma replace
	save "ENGHo - `base'", replace
}
*/


*##############################################################################*
* UNIÓN DE BASES *
*##############################################################################*


use "ENGHo - Personas", clear
merge m:1 clave using "ENGHo - Hogares"
drop _merge
save "personas-hogares", replace

use "ENGHo - Gastos", clear
destring cantidad, replace dpcomma
destring monto, replace dpcomma
keep if (articulo==911101 | articulo==911102)
collapse (sum) monto, by(clave)
tempfile cigarrillo
save `cigarrillo', replace
use "personas-hogares", clear
merge m:1 clave using `cigarrillo'
drop _merge
save "personas-hogares-gastos", replace

use "personas-hogares-gastos", clear
merge m:1 clave miembro using "ENGHo - Ingresos"
drop _merge
save "personas-hogares-gastos-ingresos", replace

clonevar pondera=expan
clonevar ipcf=ingpch
generate cpcf=gastot/cantmiem

drop if (ipcf<=0)
drop if (cpcf<=0)

save "personas-hogares-gastos-ingresos", replace
clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/17. Macroeconomía con Agentes Heterogéneos/Trabajos Prácticos/Trabajo Práctico N° 2/Datos"


*##############################################################################*
								* EJERCICIO 2.2 *
*##############################################################################*


local n1=100
local n2=1000
local n3=10000
	
forvalues i=1(1)3 {
	clear all
	import delimited "dado_`i'.txt", encoding(Big5)
	generate id=_n
	rename v1 dado
	order id dado
	generate dado_p=dado/`n`i''*100
	graph bar (sum) dado_p, over(id) bargap(100) blabel(bar, format(%6.4g)) ylabel(0 "0%" 5 "5%" 10 "10%" 15 "15%" 20 "20%") ytitle("")
}
clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/17. Macroeconomía con Agentes Heterogéneos/Trabajos Prácticos/Trabajo Práctico N° 3/Datos"


*##############################################################################*
								* EJERCICIO 1.1 *
*##############################################################################*


import delimited "resultados_11.txt", encoding(Big5) clear

rename (v1 v2 v3 v4 v5 v6 v7) (k z y kpol cpol index_pol vf)

graph twoway 	(scatter vf k   if (z>0.91 & z<0.92)) (scatter vf k   if (z>0.95 & z<0.96)) (scatter vf k   if (z==1)) ///
				(scatter vf k   if (z>1.04 & z<1.05)) (scatter vf k   if (z>1.09 & z<1.10))

graph twoway 	(scatter kpol k if (z>0.91 & z<0.92)) (scatter kpol k if (z>0.95 & z<0.96)) (scatter kpol k if (z==1)) ///
				(scatter kpol k if (z>1.04 & z<1.05)) (scatter kpol k if (z>1.09 & z<1.10)) (line k k, lcolor(red))


*##############################################################################*
								* EJERCICIO 2.6 *
*##############################################################################*


import delimited "resultados_25.txt", encoding(Big5) clear

rename (v1 v2 v3 v4 v5 v6) (tsim k z c y kp)

foreach var of varlist k c y kp {
	graph twoway (line `var' tsim if (tsim>1000), lcolor(black)), ytitle("`var'") xtitle("Tiempo")
}

foreach var of varlist k c y {
	summarize `var' if (tsim>1000)
}


*##############################################################################*
								* EJERCICIO 3.1 *
*##############################################################################*


import delimited "resultados_31.txt", encoding(Big5) clear

rename (v1 v2 v3) (tsim media_y varianza_y)

graph twoway (line varianza_y tsim, lcolor(black)), ytitle("Varianza de y") xtitle("Tiempo")


*##############################################################################*
								* EJERCICIO 3.2 *
*##############################################################################*


import delimited "resultados_32.txt", encoding(Big5) clear

rename (v1 v2 v3) (tsim media_y varianza_y)

graph twoway (line varianza_y tsim, lcolor(black)), ytitle("Varianza de y") xtitle("Tiempo")
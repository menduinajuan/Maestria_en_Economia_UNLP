clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/14. Macroeconomía Dinámica/Trabajos Prácticos/Trabajo Práctico N° 3/Datos"
do "Ejercicio 1.e.do"


*##############################################################################*
								* INCISO (i) *
*##############################################################################*


generate ln_y=ln(y)
generate ln_y_nss=ln(y_nss)

tsfilter hp y_cycle=ln_y, smooth(1600) trend(y_trend)

graph twoway (line ln_y t, lcolor(black)) (line y_trend t, lcolor(blue)) (line ln_y_nss t, lcolor(red)), 	ytitle("ln Y") xtitle("Tiempo") ///
																											legend(label(1 "ln Y_t") label(2 "Y_trend") label(3 "ln Y_nss") )


*##############################################################################*
								* INCISO (ii) *
*##############################################################################*


generate desvio=ln_y-ln_y_nss

graph twoway (line desvio t, lcolor(black)), ytitle("Desvío (%)") xtitle("Tiempo") yline(0, lcolor(red))


*##############################################################################*
								* INCISO (iii) *
*##############################################################################*


graph twoway (line y_cycle t, lcolor(black)), ytitle("Componente cíclico de ln Y") xtitle("Tiempo") yline(0, lcolor(red))
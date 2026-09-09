clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/14. Macroeconomía Dinámica/Trabajos Prácticos/Trabajo Práctico N° 2/Datos"


set obs 101

*Serie de tiempo*

generate aux=_n
generate t=aux-1
drop aux
tsset t

*Parámetros*

local beta=0.9

*Variables*

generate x=10 if (t==0)

forvalues i=1(1)100 {
	replace x=`beta'*L1.x if (t==`i')
}

generate c=(1-`beta')*x

*Gráficos*

graph twoway	(line x t, lcolor(black)) (line c t, lcolor(red)),	title("Evolución temporal variable de control (c) y variable de estado (x)", color(black)) ///
																	xtitle("Tiempo") legend(label(1 "x") label(2 "c"))
clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/14. Macroeconomía Dinámica/Trabajos Prácticos/Trabajo Práctico N° 2/Datos"
use "Ejercicio 3", clear


*Parámetros*

local alpha=0.5
local beta=0.952
local rho=0.5

*Variables*

generate a=1 if (t==0)
generate ln_a=ln(a) if (t==0)
generate ln_a_1=`rho'*ln_a+e_1 if (t==0)

forvalues i=1(1)100 {
	replace ln_a=L1.ln_a_1 if (t==`i')
	replace ln_a_1=`rho'*ln_a+e_1 if (t==`i')
	replace a=exp(ln_a) if (t==`i')
}

generate k=(`alpha'*`beta')^(1/(1-`alpha')) if (t==0)
forvalues i=1(1)100 {
	replace k=`alpha'*`beta'*a*L1.k^`alpha' if (t==`i')
}
generate y=a*k^`alpha'
generate c=(1-`alpha'*`beta')*a*k^`alpha'

generate y_nss=y[1]

*Gráfico*

graph twoway (line y t, lcolor(black)) (line y_nss t, lcolor(red)), title("Evolución temporal de y (rho=0.5)", color(black)) ///
																	ytitle("y") xtitle("Tiempo") legend(label(1 "y_t") label(2 "y_nss"))
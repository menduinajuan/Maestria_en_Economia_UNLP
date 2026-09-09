clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/14. Macroeconomía Dinámica/Trabajos Prácticos/Trabajo Práctico N° 3/Datos"


*##############################################################################*
							* EVOLUCIONES TEMPORALES *
*##############################################################################*


use "Ejercicio 1", clear

*Parámetros*

local alpha=0.36
local beta=0.99
local gamma=1.7
local delta=0.0012
local lambda=`delta'^(-`delta')
local rho=0.95

*Variables*

generate a=1 if (t==0)
generate ln_a=ln(a) if (t==0)
generate ln_a_1=`rho'*ln_a+e_1 if (t==0)

forvalues i=1(1)200 {
	replace ln_a=L1.ln_a_1 if (t==`i')
	replace ln_a_1=`rho'*ln_a+e_1 if (t==`i')
	replace a=exp(ln_a) if (t==`i')
}

generate l=((1-`beta'*(1-`delta'))*(1-`alpha'))/(((1-`beta'*(1-`delta'))*(1-`alpha'))*`gamma'+(1-`beta'*(1-`delta'))*(1-`alpha'))
generate k=(((l^(1-`alpha')*((`beta'*`alpha'*`delta')/(1-`beta'*(1-`alpha'))))^`delta')*`lambda')^(1/(`delta'*(1-`alpha'))) if (t==0)
forvalues i=1(1)200 {
	replace k=((a*L1.k^`alpha'*l^(1-`alpha')*((`beta'*`alpha'*`delta')/(1-`beta'*(1-`alpha'))))^`delta')*(`lambda'*L1.k^(1-`delta')) if (t==`i')
}
generate y=a*k^`alpha'*l^(1-`alpha')
generate c=a*k^`alpha'*l^(1-`alpha')*((1-`beta'*(1-`delta'*(1-`alpha')))/(1-`beta'*(1-`delta')))
generate i=a*k^`alpha'*l^(1-`alpha')*((`beta'*`alpha'*`delta')/(1-`beta'*(1-`alpha')))

generate l_nss=l[1]
generate k_nss=k[1]
generate y_nss=y[1]
generate c_nss=c[1]
generate i_nss=i[1]

*Gráficos*

graph twoway (line l t, lcolor(black)) (line l_nss t, lcolor(red)), title("Evolución temporal de L", color(black)) ytitle("L") xtitle("Tiempo") ///
																	legend(label(1 "L_t") label(2 "L_nss"))
graph twoway (line k t, lcolor(black)) (line k_nss t, lcolor(red)), title("Evolución temporal de K", color(black)) ytitle("K") xtitle("Tiempo") ///
																	legend(label(1 "K_t") label(2 "K_nss"))
graph twoway (line y t, lcolor(black)) (line y_nss t, lcolor(red)), title("Evolución temporal de Y", color(black)) ytitle("Y") xtitle("Tiempo") ///
																	legend(label(1 "Y_t") label(2 "Y_nss"))
graph twoway (line c t, lcolor(black)) (line c_nss t, lcolor(red)), title("Evolución temporal de C", color(black)) ytitle("C") xtitle("Tiempo") ///
																	legend(label(1 "C_t") label(2 "C_nss"))
graph twoway (line i t, lcolor(black)) (line i_nss t, lcolor(red)), title("Evolución temporal de I", color(black)) ytitle("I") xtitle("Tiempo") ///
																	legend(label(1 "I_t") label(2 "I_nss"))


*##############################################################################*
						* FUNCIONES IMPULSO-RESPUESTA *
*##############################################################################*


use "Ejercicio 1", clear

*Parámetros*

local alpha=0.36
local beta=0.99
local gamma=1.7
local delta=0.0012
local lambda=`delta'^(-`delta')
local rho=0.95

*Variables*

generate a=1 if (t==0)
generate ln_a=ln(a) if (t==0)
generate ln_a_1=`rho'*ln_a+e_2 if (t==0)

forvalues i=1(1)200 {
	replace ln_a=L1.ln_a_1 if (t==`i')
	replace ln_a_1=`rho'*ln_a+e_2 if (t==`i')
	replace a=exp(ln_a) if (t==`i')
}

generate l=((1-`beta'*(1-`delta'))*(1-`alpha'))/(((1-`beta'*(1-`delta'))*(1-`alpha'))*`gamma'+(1-`beta'*(1-`delta'))*(1-`alpha'))
generate k=(((l^(1-`alpha')*((`beta'*`alpha'*`delta')/(1-`beta'*(1-`alpha'))))^`delta')*`lambda')^(1/(`delta'*(1-`alpha'))) if (t==0)
forvalues i=1(1)200 {
	replace k=((a*L1.k^`alpha'*l^(1-`alpha')*((`beta'*`alpha'*`delta')/(1-`beta'*(1-`alpha'))))^`delta')*(`lambda'*L1.k^(1-`delta')) if (t==`i')
}
generate y=a*k^`alpha'*l^(1-`alpha')
generate c=a*k^`alpha'*l^(1-`alpha')*((1-`beta'*(1-`delta'*(1-`alpha')))/(1-`beta'*(1-`delta')))
generate i=a*k^`alpha'*l^(1-`alpha')*((`beta'*`alpha'*`delta')/(1-`beta'*(1-`alpha')))

generate l_nss=l[1]
generate k_nss=k[1]
generate y_nss=y[1]
generate c_nss=c[1]
generate i_nss=i[1]

*Gráficos*

graph twoway (line l t, lcolor(black)) (line l_nss t, lcolor(red)), title("Función impulso-respuesta de L", color(black)) ytitle("L") xtitle("Tiempo") ///
																	legend(label(1 "L_t") label(2 "L_nss"))
graph twoway (line k t, lcolor(black)) (line k_nss t, lcolor(red)), title("Función impulso-respuesta de K", color(black)) ytitle("K") xtitle("Tiempo") ///
																	legend(label(1 "K_t") label(2 "K_nss"))
graph twoway (line y t, lcolor(black)) (line y_nss t, lcolor(red)), title("Función impulso-respuesta de Y", color(black)) ytitle("Y") xtitle("Tiempo") ///
																	legend(label(1 "Y_t") label(2 "Y_nss"))
graph twoway (line c t, lcolor(black)) (line c_nss t, lcolor(red)), title("Función impulso-respuesta de C", color(black)) ytitle("C") xtitle("Tiempo") ///
																	legend(label(1 "C_t") label(2 "C_nss"))
graph twoway (line i t, lcolor(black)) (line i_nss t, lcolor(red)), title("Función impulso-respuesta de I", color(black)) ytitle("I") xtitle("Tiempo") ///
																	legend(label(1 "I_t") label(2 "I_nss"))
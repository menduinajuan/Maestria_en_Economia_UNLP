clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/8. Economía de la Distribución/Trabajos Prácticos/Trabajo Práctico N° 7/Datos"
*do "prepara_bases"


*##############################################################################*
								* EJERCICIO 1 *
*##############################################################################*


use "personas-hogares-gastos-ingresos", clear
quietly include "comando_gcuan"

sort ipcf
generate sumpop=sum(pondera)
local ppdecil=sumpop[_N]/10

gcuan ipcf [w=pondera], ncuantiles(10) generate(decilipcf)

*Inciso (a)*

forvalues i=1(1)10 {
	tabstat ipcf [w=pondera] if (decilipcf==`i')
}

*Inciso (b)*

summarize ipcf [w=pondera] if (decilipcf==1)
local mean_d1=r(mean)
summarize ipcf [w=pondera] if (decilipcf==10)
local mean_d10=r(mean)

display as text "Cociente de Deciles Extremos = " as result `mean_d10'/`mean_d1'

*Inciso (c)*

forvalues i=1(1)10 {
	egen decil_ing`i'=sum(ipcf*pondera) if (decilipcf==`i')
	summarize decil_ing`i'
	local tot_ing`i'=r(mean)
}

macro list

egen tot_ing=sum(ipcf*pondera)
summarize tot_ing
local tot_ing=r(mean)

forvalues i=1(1)10 {
	display as text "Ingreso Decil `i' sobre Total = " as result (`tot_ing`i''/`tot_ing')*100
}


*##############################################################################*
								* EJERCICIO 2 *
*##############################################################################*


use "personas-hogares-gastos-ingresos", clear
quietly include "comando_gcuan"

sort cpcf
generate sumpop=sum(pondera)
local ppdecil=sumpop[_N]/10

gcuan cpcf [w=pondera], ncuantiles(10) generate(decilcpcf)

*Inciso (a)*

forvalues i=1(1)10 {
	tabstat cpcf [w=pondera] if (decilcpcf==`i')
}

*Inciso (b)*

summarize cpcf [w=pondera] if (decilcpcf==1)
local mean_d1=r(mean)
sum cpcf [w=pondera] if (decilcpcf==10)
local mean_d10=r(mean)

display as text "Cociente de Deciles Extremos = " as result `mean_d10'/`mean_d1'

*Inciso (c)*

forvalues i=1(1)10 {
	egen decil_cons`i'=sum(cpcf*pondera) if (decilcpcf==`i')
	summarize decil_cons`i'
	local tot_cons`i'=r(mean)
}

macro list

egen tot_cons=sum(cpcf*pondera)
summarize tot_cons
local tot_cons=r(mean)

forvalues i=1(1)10 {
	display as text "Consumo Decil `i' sobre Total = " as result (`tot_cons`i''/`tot_cons')*100
}


*##############################################################################*
								* EJERCICIO 3 *
*##############################################################################*


use "personas-hogares-gastos-ingresos", clear
quietly include "comando_gcuan"

gcuan ipcf [w=pondera], ncuantiles(100) generate(percipcf)
gcuan cpcf [w=pondera], ncuantiles(100) generate(perccpcf)

generate shr_food=gc_1/gastot
egen aux=tag(clave)

table percipcf [w=pondera] if aux==1, statistic(mean shr_food)
table perccpcf [w=pondera] if aux==1, statistic(mean shr_food)

/*
graph twoway	(line shr_food_ing percipcf, lcolor(black)) (line shr_food_cons perccpcf, lcolor(red)), ///
				title("Curva de Engel") ytitle("Share Food") xtitle("Percentiles") legend(label(1 "IPCF") label(2 "CPCF"))
*/


*##############################################################################*
								* EJERCICIO 4 *
*##############################################################################*


use "personas-hogares-gastos-ingresos", clear
quietly include "comando_gini"

rename monto cigar
replace cigar=0 if (cigar==.)
generate cigarpcf=cigar/cantmiem
generate taxpcf=0.15*cigarpcf

sort ipcf

*Población acumulada*
generate shrpop=sum(pondera)
replace shrpop=shrpop/shrpop[_N]

*Ingreso acumulado*
generate shrinc=sum(ipcf*pondera)
replace shrinc=shrinc/shrinc[_N]

*Recaudación total*
generate shrtax=sum(taxpcf*pondera)
replace shrtax=shrtax/shrtax[_N]

*Índice de Concentración de la Carga Impositiva*
summarize taxpcf [w=pondera]
local media=r(mean)
local obs=r(sum_w)
generate aux=sum(pondera)
generate i=(2*aux-pondera+1)/2
generate tmp=taxpcf*(`obs'-i+1)
summarize tmp [w=pondera] 
local icci=1-(1/`obs')-(2/(`media'*`obs'^2))*r(sum)
display as text "ICCI = " as result `icci'

*Índice de Kakwani*
gini ipcf [w=pondera]
local gini=r(gini)
local kakwani=`icci'-`gini'
display as text "Kakwani = " as result `kakwani'

*Curva de Concentración de Impuestos*
graph twoway	(line shrinc shrpop, lcolor(black)) (line shrtax shrpop, lcolor(red) lpat(dash)), ///
				title("Curva de Concentración de un Impuesto a los Cigarrillos") ytitle("L(p)") xtitle("p") ///
				legend(label(1 "Curva de Lorenz") label(2 "Curva de concentración del impuesto"))


*##############################################################################*
								* EJERCICIO 5 *
*##############################################################################*


use "personas-hogares-gastos-ingresos", clear
quietly include "comando_gini"

generate ingasalfor_pc=inglabt if (catocup==1 & cp30==1)
bysort clave: egen ingasalfor_hogar=sum(ingasalfor_pc)
generate ingasalfor_pcf=ingasalfor_hogar/cantmiem
generate taxpcf=0.25*ingasalfor_pcf

sort ipcf

*Población acumulada*
generate shrpop=sum(pondera)
replace shrpop=shrpop/shrpop[_N]

*Ingreso acumulado*
generate shrinc=sum(ipcf*pondera)
replace shrinc=shrinc/shrinc[_N]

*Recaudación total*
generate shrtax=sum(taxpcf*pondera)
replace shrtax=shrtax/shrtax[_N]

*Índice de Concentración de la Carga Impositiva*
summarize taxpcf [w=pondera]
local media=r(mean)
local obs=r(sum_w)
generate aux=sum(pondera)
generate i=(2*aux-pondera+1)/2
generate tmp=taxpcf*(`obs'-i+1)
summarize tmp [w=pondera] 
local icci=1-(1/`obs')-(2/(`media'*`obs'^2))*r(sum)
display as text "ICCI = " as result `icci'

*Índice de Kakwani*
gini ipcf [w=pondera]
local gini=r(gini)
local kakwani=`icci'-`gini'
display as text "Kakwani = " as result `kakwani'

*Curva de Concentración de Impuestos*
graph twoway	(line shrinc shrpop, lcolor(black)) (line shrtax shrpop, lcolor(red) lpat(dash)), ///
				title("Curva de Concentración de un Impuesto al Trabajo Asalariado") ytitle("L(p)") xtitle("p") ///
				legend(label(1 "Curva de Lorenz") label(2 "Curva de concentración del impuesto"))
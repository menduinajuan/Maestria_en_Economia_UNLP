clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/8. Economía de la Distribución/Trabajos Prácticos/Trabajo Práctico N° 6/Datos"


*##############################################################################*
								* EJERCICIO 1.a *
*##############################################################################*


set obs 1000

generate ing_t0=1000
generate ling_t0=ln(ing_t0)

matrix define   A = J(10,3,.)
matrix rownames A = "1" "2" "3" "4" "5" "6" "7" "8" "9" "10"
matrix colnames A = "Media" "Desvío Estándar" "P-valor"

forvalues i=1(1)10 {
	local j=`i'-1
	generate ling_t`i'=ling_t`j'+runiform()*10-5
	kdensity ling_t`i', normal lcolor(black) normopts(lcolor(red)) title("Período `i'", color(black)) ///
						ytitle("Densidad") xtitle("Logaritmo del ingreso") name("Período_`i'", replace)
	summarize ling_t`i'
	display as text "Media en t=`i' = " as result r(mean)
	display as text "Desvío Estándar en t=`i' = " as result r(sd)
	matrix A [`i',1]=r(mean)
	matrix A [`i',2]=r(sd)
	sktest ling_t`i'
	matrix A [`i',3]=r(P_chi2)
}

matrix list A

graph combine Período_1 Período_5 Período_10
graph twoway	(kdensity ling_t1, lcolor(black)) (kdensity ling_t5, lcolor(red)) (kdensity ling_t10, lcolor(blue)), ///
				ytitle("Densidad") xtitle("Logaritmo del ingreso") legend(label(1 "Período 1") label(2 "Período 5") label(3 "Período 10"))


*##############################################################################*
								* EJERCICIO 1.b *
*##############################################################################*


matrix define   B = J(10,3,.)
matrix rownames B = "11" "12" "13" "14" "15" "16" "17" "18" "19" "20"
matrix colnames B = "Media" "Desvío Estándar" "P-valor"

forvalues i=11(1)20 {
	local j=`i'-1
	local k=`i'-10
	generate ling_t`i'=0.2*ling_t`j'+runiform()*10-5
	kdensity ling_t`i', normal lcolor(black) normopts(lcolor(red)) title("Período `i'", color(black)) ///
						ytitle("Densidad") xtitle("Logaritmo del ingreso") name("Período_`i'", replace)
	summarize ling_t`i'
	display as text "Media en t=`i' = " as result r(mean)
	display as text "Desvío Estándar en t=`i' = " as result r(sd)
	matrix B [`k',1]=r(mean)
	matrix B [`k',2]=r(sd)
	sktest ling_t`i'
	matrix B [`k',3]=r(P_chi2)
}

matrix list B

graph combine Período_11 Período_15 Período_20
graph twoway	(kdensity ling_t11, lcolor(black)) (kdensity ling_t15, lcolor(red)) (kdensity ling_t20, lcolor(blue)), ///
				ytitle("Densidad") xtitle("Logaritmo del ingreso") legend(label(1 "Período 11") label(2 "Período 15") label(3 "Período 20"))


*##############################################################################*
								* EJERCICIO 1.c *
*##############################################################################*


forvalues i=11(1)20 {
	drop ling_t`i'
}

matrix define   C = J(10,3,.)
matrix rownames C = "11" "12" "13" "14" "15" "16" "17" "18" "19" "20"
matrix colnames C = "Media" "Desvío Estándar" "P-valor"

forvalues i=11(1)20 {
	local j=`i'-1
	local k=`i'-10
	generate ling_t`i'=1.5*ling_t`j'+runiform()*10-5
	kdensity ling_t`i', normal lcolor(black) normopts(lcolor(red)) title("Período `i'", color(black)) ///
						ytitle("Densidad") xtitle("Logaritmo del ingreso") name("Período_`i'", replace)
	summarize ling_t`i'
	display as text "Media en t=`i' = " as result r(mean)
	display as text "Desvío Estándar en t=`i' = " as result r(sd)
	matrix C [`k',1]=r(mean)
	matrix C [`k',2]=r(sd)
	sktest ling_t`i'
	matrix C [`k',3]=r(P_chi2)
}

matrix list C

graph combine Período_11 Período_15 Período_20
graph twoway	(kdensity ling_t11, lcolor(black)) (kdensity ling_t15, lcolor(red)) (kdensity ling_t20, lcolor(blue)), ///
				ytitle("Densidad") xtitle("Logaritmo del Ingreso") legend(label(1 "Período 11") label(2 "Período 15") label(3 "Período 20"))


*##############################################################################*
								* EJERCICIO 2 *
*##############################################################################*


clear all
quietly include "comando_roy"

roy 500 0.1 2 0 1
roy 500 0.1 2 0.8 2
roy 500 0.1 2 -0.8 3
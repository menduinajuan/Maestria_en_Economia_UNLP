clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/8. Economía de la Distribución/Trabajos Prácticos/Trabajo Práctico N° 3/Datos"
use "usu_individual_t119", clear
*import excel "usu_individual_t119.xls", sheet("Sheet 1") firstrow case(lower)
*save "usu_individual_t119", replace


destring deccfr, replace
drop if (deccfr<1 | deccfr>10)
drop if (nro_hogar==51 | nro_hogar==71)


*##############################################################################*
								* EJERCICIO 1 *
*##############################################################################*


generate edad=ch06

generate hombre=.
replace hombre=0 if (ch04==2)
replace hombre=1 if (ch04==1)

generate ae=.

label variable ae "Adulto Equivalente"

replace ae=0.315 if (edad<1)
replace ae=0.37 if (edad==1)
replace ae=0.46 if (edad==2)
replace ae=0.51 if (edad==3)
replace ae=0.55 if (edad==4)
replace ae=0.60 if (edad==5)
replace ae=0.64 if (edad==6)
replace ae=0.66 if (edad==7)
replace ae=0.68 if (edad==8)
replace ae=0.69 if (edad==9)

replace ae=0.79 if (edad==10 & hombre==1)
replace ae=0.82 if (edad==11 & hombre==1)
replace ae=0.85 if (edad==12 & hombre==1)
replace ae=0.90 if (edad==13 & hombre==1)
replace ae=0.96 if (edad==14 & hombre==1)
replace ae=1.00 if (edad==15 & hombre==1)
replace ae=1.03 if (edad==16 & hombre==1)
replace ae=1.04 if (edad==17 & hombre==1)

replace ae=0.70 if (edad==10 & hombre==0)
replace ae=0.72 if (edad==11 & hombre==0)
replace ae=0.74 if (edad==12 & hombre==0)
replace ae=0.76 if (edad==13 & hombre==0)
replace ae=0.76 if (edad==14 & hombre==0)
replace ae=0.77 if (edad==15 & hombre==0)
replace ae=0.77 if (edad==16 & hombre==0)
replace ae=0.77 if (edad==17 & hombre==0)

replace ae=1.02 if (edad>=18 & edad<=29 & hombre==1)
replace ae=1.00 if (edad>=30 & edad<=45 & hombre==1)
replace ae=1.00 if (edad>=46 & edad<=60 & hombre==1)
replace ae=0.83 if (edad>=61 & edad<=75 & hombre==1)
replace ae=0.74 if (edad>75 & hombre==1)

replace ae=0.76 if (edad>=18 & edad<=29 & hombre==0)
replace ae=0.77 if (edad>=30 & edad<=45 & hombre==0)
replace ae=0.76 if (edad>=46 & edad<=60 & hombre==0)
replace ae=0.67 if (edad>=61 & edad<=75 & hombre==0)
replace ae=0.63 if (edad>75 & hombre==0)

bysort codusu nro_hogar: egen aes=total(ae)

label variable aes "Adulto Equivalente Suma"

generate ife00=itf/(aes^0)
generate ife08=itf/(aes^0.8)
generate ife10=itf/(aes^1)

quietly include "comando_gini"

gini ipcf  [w=pondih]
gini itf   [w=pondih]
gini ife00 [w=pondih]
gini ife08 [w=pondih]
gini ife10 [w=pondih]


*##############################################################################*
								* EJERCICIO 2 *
*##############################################################################*


set seed 12345

bootstrap r(gini), reps(200) seed(12345): gini ipcf
bootstrap r(gini), reps(200) seed(12345): gini itf
bootstrap r(gini), reps(200) seed(12345): gini ife00
bootstrap r(gini), reps(200) seed(12345): gini ife08
bootstrap r(gini), reps(200) seed(12345): gini ife10


*##############################################################################*
								* EJERCICIO 3 *
*##############################################################################*


sort aglomerado ipcf

by aglomerado: generate shrpop=sum(pondih)
by aglomerado: replace shrpop=shrpop/shrpop[_N]
by aglomerado: generate shrinc=sum(ipcf*pondih)
by aglomerado: replace shrinc=shrinc/shrinc[_N]

graph twoway	(line shrinc shrpop if (aglomerado==7), lcolor(red)) (line shrinc shrpop if (aglomerado==31), lcolor(blue) lpat(dash)) ///
				(line shrinc shrinc, lcolor(black)), title("Curva de Lorenz") ytitle("L(p)") xtitle("p") legend(label(1 "Posadas") label(2 "Ushuaia") label(3 "LPI"))

generate dom=.
generate shr=.
local puntos=100
local temp=`puntos'-1

forvalues i=1(1)`temp' {

	display as text "iter/`puntos' = " as result `i'/`puntos'

	summarize shrinc if (shrpop<=`i'/`puntos' & aglomerado==7)
	local shrinc1=r(max)

	summarize shrinc if (shrpop<=`i'/`puntos' & aglomerado==31)
	local shrinc2=r(max)

	replace shr=`i'/`puntos' if (_n==`i')
	replace dom=1 if (`shrinc1'>`shrinc2' & _n==`i')
	replace dom=2 if (`shrinc1'<`shrinc2' & _n==`i')
	replace dom=0 if (`shrinc1'==`shrinc2' & _n==`i')

	tabdisp shr, cellvar(dom)
	summarize dom

}

drop dom shr
drop shrpop shrinc


*##############################################################################*
								* EJERCICIO 4 *
*##############################################################################*


generate inglab=p21
generate hrtrb=pp3e_tot*4
generate ilabhr=inglab/hrtrb
drop if (ilabhr==. | ilabhr==0)

sort hombre ilabhr, stable

by hombre: generate shrpop=sum(pondiio)
by hombre: replace shrpop=shrpop/shrpop[_N]
by hombre: generate shrinc=sum(ilabhr*pondiio)
by hombre: replace shrinc=shrinc/shrinc[_N]

graph twoway	(line shrinc shrpop if (hombre==1), lcolor(red)) (line shrinc shrpop if (hombre==0), lcolor(blue) lpat(dash)) (line shrinc shrinc, lcolor(black)), ///
				title("Curva de Lorenz") ytitle("L(p)") xtitle("p") legend(label(1 "Hombres") label(2 "Mujeres") label(3 "LPI"))

generate dom=.
generate shr=.
local puntos=100
local temp=`puntos'-1

forvalues i=1(1)`temp' {

	display as text "iter/`puntos' = " as result `i'/`puntos'

	summarize shrinc if (shrpop<=`i'/`puntos' & hombre==1)
	local shrinc1=r(max)

	summarize shrinc if (shrpop<=`i'/`puntos' & hombre==0)
	local shrinc2=r(max)

	replace shr=`i'/`puntos' if (_n==`i')
	replace dom=1 if (`shrinc1'>`shrinc2' & _n==`i')
	replace dom=2 if (`shrinc1'<`shrinc2' & _n==`i')
	replace dom=0 if (`shrinc1'==`shrinc2' & _n==`i')

	tabdisp shr, cellvar(dom)
	summarize dom

}

drop dom shr
drop shrpop shrinc
drop inglab hrtrb ilabhr


*##############################################################################*
								* EJERCICIO 5 *
*##############################################################################*


generate inglab=pp08d1
generate hrtrb=pp3e_tot*4
generate ilabhr=inglab/hrtrb
drop if (ilabhr==. | ilabhr==0)

sort pp07h ilabhr, stable

by pp07h: generate shrpop=sum(pondiio)
by pp07h: replace shrpop=shrpop/shrpop[_N]
by pp07h: generate shrinc=sum(ilabhr*pondiio)
by pp07h: replace shrinc=shrinc/shrinc[_N]

graph twoway	(line shrinc shrpop if (pp07h==1), lcolor(red)) (line shrinc shrpop if (pp07h==2), lcolor(blue) lpat(dash)) (line shrinc shrinc, lcolor(black)), ///
				title("Curva de Lorenz") ytitle("L(p)") xtitle("p") legend(label(1 "Formales") label(2 "Informales") label(3 "LPI"))

generate dom=.
generate shr=.
local puntos=100
local temp=`puntos'-1

forvalues i=1(1)`temp' {

	display as text "iter/`puntos' = " as result `i'/`puntos'

	summarize shrinc if (shrpop<=`i'/`puntos' & pp07h==1)
	local shrinc1=r(max)

	summarize shrinc if (shrpop<=`i'/`puntos' & pp07h==2)
	local shrinc2=r(max)

	replace shr=`i'/`puntos' if (_n==`i')
	replace dom=1 if (`shrinc1'>`shrinc2' & _n==`i')
	replace dom=2 if (`shrinc1'<`shrinc2' & _n==`i')
	replace dom=0 if (`shrinc1'==`shrinc2' & _n==`i')

	tabdisp shr, cellvar(dom)
	summarize dom

}

drop dom shr
drop shrpop shrinc
drop inglab hrtrb ilabhr
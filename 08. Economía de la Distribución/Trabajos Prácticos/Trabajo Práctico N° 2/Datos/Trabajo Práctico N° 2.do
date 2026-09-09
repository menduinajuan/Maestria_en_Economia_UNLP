clear all
set more off
version 16

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/8. Economía de la Distribución/Trabajos Prácticos/Trabajo Práctico N° 2/Datos"
use "usu_individual_t119", clear
*import excel "usu_individual_t119.xls", sheet("Sheet 1") firstrow case(lower)
*save "usu_individual_t119", replace


destring deccfr, replace
drop if (deccfr<1 | deccfr>10)
drop if (nro_hogar==51 | nro_hogar==71)


*##############################################################################*
								* EJERCICIO 1 *
*##############################################################################*


sort ipcf

generate sumpop=sum(pondih)
local ppdecil=sumpop[_N]/10

generate decil=0
forvalues i=1(1)10 {
	replace decil=`i' if (sumpop>`ppdecil'*(`i'-1) & sumpop<=`ppdecil'*`i')
}

drop sumpop

sort codusu nro_hogar
by codusu nro_hogar: egen p47tot=total(p47t)
by codusu nro_hogar: egen p21tot=total(p21)
by codusu nro_hogar: egen tot_p12tot=total(tot_p12)
by codusu nro_hogar: egen t_vitot=total(t_vi)
by codusu nro_hogar: generate miembros=_N

generate p47tpc=p47tot/miembros
generate p21pc=p21tot/miembros
generate tot_p12pc=tot_p12tot/miembros
generate t_vipc=t_vitot/miembros

foreach var of varlist p47t p21 tot_p12 t_vi {
	preserve
	table decil [w=pondih], contents(freq mean ipcf sum ipcf sum `var'pc) row replace
	generate shr=(table3/table3[1])*100
	generate rat`var'=(table4/table3)*100
	tabdisp decil, cellvar(table2 shr rat`var')
	restore
}


*##############################################################################*
								* EJERCICIO 2 *
*##############################################################################*
 

*Curva de Lorenz (Total País)*

sort ipcf

generate sumpop=sum(pondih)
generate shrpop=sumpop/sumpop[_N]
generate suminc=sum(ipcf*pondih)
generate shrinc=suminc/suminc[_N]

graph twoway	(line shrinc shrpop, lcolor(red)) (line shrinc shrinc, lcolor(black)), ///
				title("Curva de Lorenz") ytitle("L(p)") xtitle("p") legend(label(1 "Curva de Lorenz") label(2 "LPI"))

*Función de Distribución (Total País)*

generate lipcf=log(ipcf)

graph twoway line shrpop ipcf, title("Función de Distribución (niv)") ytitle("Share de la población") xtitle("IPCF (Miles de pesos)") xline(11500, lcolor(red))
graph twoway line shrpop lipcf, title("Función de Distribución (log)") ytitle("Share de la población") xtitle("Log del IPCF") xline(9.35, lcolor(red))

*Curva de Pen (Total País)*

graph twoway line ipcf sumpop, title("Curva de Pen (niv)") ytitle("IPCF (Miles de pesos)") xtitle("Millones de habitantes")
graph twoway line lipcf sumpop, title("Curva de Pen (log)") ytitle("Logaritmo del IPCF") xtitle("Millones de habitantes")

drop shrpop shrinc

*Curva de Lorenz (CABA+Formosa)*

sort aglomerado ipcf

by aglomerado: generate shrpop=sum(pondih)
by aglomerado: replace shrpop=shrpop/shrpop[_N]
by aglomerado: generate shrinc=sum(ipcf*pondih)
by aglomerado: replace shrinc=shrinc/shrinc[_N]

graph twoway	(line shrinc shrpop if (aglomerado==32), lcolor(red)) (line shrinc shrpop if (aglomerado==15), lcolor(blue) lpat(dash)) ///
				(line shrinc shrinc, lcolor(black)), ///
				title("Curva de Lorenz") ytitle("L(p)") xtitle("p") ///
				legend(label(1 "Ciudad Autónoma de Buenos Aires") label(2 "Formosa") label(3 "LPI"))

*Función de Distribución (CABA+Formosa)*

graph twoway	(line shrpop ipcf if (aglomerado==32), lcolor(black)) (line shrpop ipcf if (aglomerado==15), lcolor(red)), ///
				title("Función de Distribución") ytitle("Share de la población") xtitle("IPCF (Miles pesos)") xline(11500) ///
				legend(label(1 "Ciudad Autónoma de Buenos Aires") label(2 "Formosa"))

*Curva de Pen (CABA+Formosa)*

graph twoway	(line ipcf sumpop if (aglomerado==32), lcolor(black)) (line ipcf sumpop if (aglomerado==15), lcolor(red)), ///
				title("Curva de Pen") ytitle("IPCF (Miles de pesos)") xtitle("Millones de habitantes") ///
				legend(label(1 "Ciudad Autónoma de Buenos Aires") label(2 "Formosa"))

drop sumpop shrpop shrinc


*##############################################################################*
								* EJERCICIO 3 *
*##############################################################################*


bysort codusu nro_hogar: egen trnsfr=total(v5_m)
generate trnsfrpc=trnsfr/miembros
generate ipcf2=ipcf-trnsfrpc

*Curva de Lorenz (Total País)*

sort ipcf

generate sumpop=sum(pondih)
generate shrpop=sumpop/sumpop[_N]
generate suminc1=sum(ipcf*pondih)
generate shrinc1=suminc1/suminc1[_N]
generate suminc2=sum(ipcf2*pondih)
generate shrinc2=suminc2/suminc2[_N]

graph twoway	(line shrinc1 shrpop, lcolor(red)) (line shrinc2 shrpop, lcolor(blue) lpat(dash)) (line shrinc1 shrinc1, lcolor(black)), ///
				title("Curva de Lorenz") ytitle("L(p)") xtitle("p") legend(label(1 "IPCF") label(2 "IPCF (sin transf.)") label(3 "LPI"))

*Función de Distribución (Total País)*

sort ipcf2

generate sumpop2=sum(pondih)
generate shrpop2=sumpop2/sumpop2[_N]

graph twoway	(line shrpop ipcf, lcolor(black)) (line shrpop2 ipcf2, lcolor(red)), ///
				title("Función de Distribución") ytitle("Share de la población") xtitle("Miles de pesos") xline(11500) legend(label(1 "IPCF") label(2 "IPCF (sin transf.)"))

*Curva de Pen (Total País)*

graph twoway	(line ipcf sumpop) (line ipcf2 sumpop2), ///
				title("Curva de Pen") ytitle("Miles de pesos") xtitle("Millones de habitantes") legend(label(1 "IPCF") label(2 "IPCF (sin transf.)"))


*##############################################################################*
								* EJERCICIO 4 *
*##############################################################################*


do "sort_ipcf"
quietly include "comando_gini"

gini ipcf [w=pondih]
gini itf [w=pondih]

generate hombre=.
replace hombre=0 if (ch04==2)
replace hombre=1 if (ch04==1)
 
forvalues i=0(1)1 {
	gini p21 [w=pondiio] if (hombre==`i')
}

forvalues i=1(1)10 {

	forvalues j=0(1)1 {
		gini p21 [w=pondiio] if (decil==`i' & hombre==`j')
	}

}


*##############################################################################*
								* EJERCICIO 5 *
*##############################################################################*


*Ingreso Per Cápita Familiar (IPCF)*

do "sort_ipcf"
quietly include "comando_atk"

foreach i of numlist 0 0.5 1 2 {
	atk ipcf [w=pondera], epsilon(`i')
}

forvalues i=1(1)10 {

	foreach j of numlist 0 0.5 1 2 {
		atk ipcf [w=pondera] if (decil==`i'), epsilon(`j')
	}

}

*Ingreso Total Familiar (ITF)*

do "sort_itf"
quietly include "comando_atk"

foreach i in 0 0.5 1 2 {
	atk itf [w=pondera], epsilon(`i')
}

forvalues i=1(1)10 {

	foreach j in 0 0.5 1 2 {
		atk itf [w=pondera] if (decil==`i'), epsilon(`j')
	}

}


*##############################################################################*
								* EJERCICIO 6 *
*##############################################################################*


generate imp=0.25*ipcf
generate ipcf_imp=ipcf-imp
summarize imp

generate nueing=ipcf_imp+r(mean)
summarize nueing

*Curva de Lorenz*

sort ipcf

generate sumpop=sum(pondih)
generate shrpop=sumpop/sumpop[_N]
generate suminc=sum(ipcf*pondih)
generate shrinc=suminc/suminc[_N]

sort nueing

generate sumpop_nueing=sum(pondih)
generate shrpop_nueing=sumpop_nueing/sumpop_nueing[_N]
generate suminc_nueing=sum(nueing*pondih)
generate shrinc_nueing=suminc_nueing/suminc_nueing[_N]

graph twoway	(line shrinc shrpop, lcolor(red)) (line shrinc_nueing shrpop_nueing, lcolor(blue) lpat(dash)) (line shrinc shrinc, lcolor(black)), ///
				title("Curva de Lorenz") ytitle("L(p)") xtitle("p") legend(label(1 "Antes de transferencia") label(2 "Después de transferencia") label(3 "LPI"))

*Gini*

quietly include "comando_gini"

gini nueing [w=pondih]

forvalues i=1(1)10 {
	gini nueing [w=pondih] if (decil==`i')
}

*Atkinson*

quietly include "comando_atk"

atk nueing [w=pondera], epsilon(0.5)

forvalues i=1(1)10 {
	atk nueing [w=pondera] if (decil==`i'), epsilon(0.5)
}
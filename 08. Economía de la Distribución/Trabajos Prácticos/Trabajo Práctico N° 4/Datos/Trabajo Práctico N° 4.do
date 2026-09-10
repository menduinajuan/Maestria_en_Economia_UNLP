clear all
set more off
version 16

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/8. Economía de la Distribución/Trabajos Prácticos/Trabajo Práctico N° 4/Datos"
use "usu_individual_t119", clear
*import excel "usu_individual_t119.xls", sheet("Sheet 1") firstrow case(lower)
*save "usu_individual_t119", replace


*search povdeco5


destring deccfr, replace
drop if (deccfr>10)
drop if (nro_hogar==51 | nro_hogar==71)


*##############################################################################*
								* EJERCICIO 1 *
*##############################################################################*


local lp=4006.098
local alpha=0

generate each=(1-ipcf/`lp')^(`alpha') if (ipcf<`lp')
replace each=0 if (each==. & ipcf!=.)

summarize each [w=pondih]
local fgt=(r(sum)/r(sum_w))*100
local fgt=r(mean)*100
display as text "FGT (alpha=`alpha', LP=`lp') = " as result %4.2f `fgt'

povdeco5 ipcf [w=pondih], pline(`lp')

generate edad=ch06
replace edad=0 if (edad==-1)

generate gedad=.
replace gedad=1 if (edad<=12)
replace gedad=2 if (edad>=13 & edad<=24)
replace gedad=3 if (edad>=25 & edad<=40)
replace gedad=4 if (edad>=41 & edad<=64)
replace gedad=5 if (edad>=65 & edad!=.)

povdeco5 ipcf [w=pondih], bygroup(gedad) pline(`lp')

quietly include "comando_fgt"

matrix define   FGT_E = J(6,3,.)
matrix rownames FGT_E = "0-12 años" "13-24 años" "25-40 años" "41-64 años" ">65 años" "Total País"
matrix colnames FGT_E = "FGT0" "FGT1" "FGT2"

forvalues alpha=0(1)2 {

	fgt ipcf [w=pondih], alpha(`alpha') zeta(`lp')
	matrix FGT_E [6,`alpha'+1]=r(fgt)

	forvalues e=1(1)5 {
		fgt ipcf [w=pondih] if (gedad==`e'), alpha(`alpha') zeta(`lp')
		matrix FGT_E [`e',`alpha'+1]=r(fgt)
	}

}

matrix list FGT_E


*##############################################################################*
								* EJERCICIO 2 *
*##############################################################################*


sort ipcf
generate sumpop=sum(pondih)
generate shrpop=sumpop/sumpop[_N]

local lp1=4006.0980
local lp2=4406.7078
local lp3=3605.4882

forvalues i=1(1)3 {
	fgt ipcf [w=pondih], alpha(0) zeta(`lp`i'')
}

forvalues i=1(1)3 {
	summarize shrpop if (ipcf<`lp`i'')
	local fgt=r(max)*100
	display as text "Tasa de Incidencia con LP = $`lp`i'' = " as result %4.2f `fgt'
}

summarize ipcf if (shrpop<0.25)
display as text "LP que genera Tasa de Incidencia de 25% = " as result %4.2f `r(max)'

local lp4=5333.33

fgt ipcf [w=pondih], alpha(0) zeta(`lp4')

summarize shrpop if (ipcf<`lp4')
local fgt=r(max)*100
display as text "Tasa de Incidencia con LP = `lp4' = " as result %4.2f `fgt'

graph twoway	(line ipcf shrpop, lcolor(black)), title("Curva de Pen") ytitle("IPCF (Miles de pesos)") xtitle("Share de la población") ///
				yline(`lp1', lcolor(red)) yline(`lp2', lcolor(blue)) yline(`lp3', lcolor(red) lpat(dash)) yline(`lp4', lcolor(blue) lpat(dash)) ///
				xline(0.1613, lcolor(red)) xline(0.25, lcolor(blue))

graph twoway	(line ipcf shrpop if (shrpop<=0.85), lcolor(black)), title("Curva de Pen") ytitle("IPCF (Miles de pesos)") xtitle("Share de la población") ///
				yline(`lp1', lcolor(red)) yline(`lp2', lcolor(blue)) yline(`lp3', lcolor(red) lpat(dash)) yline(`lp4', lcolor(blue) lpat(dash)) ///
				xline(0.1613, lcolor(red)) xline(0.25, lcolor(blue))

drop shrpop


*##############################################################################*
								* EJERCICIO 3 *
*##############################################################################*


generate region2=region
replace region2=32 if (aglomerado==32)
replace region2=33 if (aglomerado==33)

summarize ipcf [w=pondih]
local tot=r(sum_w)
display `tot'

egen aux=group(region2)
tabulate aux [w=pondih]

povdeco5 ipcf [w=pondih], bygroup(aux) pline(`lp1')

matrix define   FGT_R = J(7,3,.)
matrix rownames FGT_R = "CABA" "GBA" "NOA" "NEA" "Cuyo" "Pampeana" "Patagónica"
matrix colnames FGT_R = "FGT0" "FGT1" "FGT2"

forvalues alpha=0(1)2 {

	forvalues r=1(1)7 {
		fgt ipcf [w=pondih] if (aux==`r'), alpha(`alpha') zeta(`lp')
		matrix FGT_R [`r',`alpha'+1]=r(fgt)
	}

}

matrix list FGT_R

matrix define   R = J(7,3,.)
matrix rownames R = "CABA" "GBA" "NOA" "NEA" "Cuyo" "Pampeana" "Patagónica"
matrix colnames R = "Participación en FGT0" "Participación en FGT1" "Participación en FGT2"

forvalues j=0(1)2 {

	fgt ipcf [w=pondih], alpha(`j') zeta(`lp1')
	local p`j'=r(fgt)

	forvalues i=1(1)7 {
		fgt ipcf [w=pondih] if (aux==`i'), alpha(`j') zeta(`lp1')
		local fgt=r(fgt)
		summarize ipcf [w=pondih] if (aux==`i')
		local pob=r(sum_w)
		matrix R [`i',`j'+1]=(`pob'/`tot')*(`fgt'/`p`j'')
	}

}

matrix list R


*##############################################################################*
								* EJERCICIO 4 *
*##############################################################################*


clear all
use "usu_hogar_t119", clear
*import excel "usu_hogar_t119.xls", sheet("Sheet 1") firstrow case(lower)

destring deccfr, replace
drop if (deccfr>10)
drop if (nro_hogar==51 | nro_hogar==71)

table iv1 
table iv8 
table iv10
table iv12_3
table ii2
table ix_tot

drop if (iv1==9 | iv8==9 | iv10==0 | iv10==9 | iv12_3==9)
keep codusu nro_hogar iv1 iv8 iv10 iv12_3 ii2 ix_tot

rename iv1 tipo_vivienda
rename iv8 dum_banio
rename iv10 tipo_banio
rename iv12 dum_villa
rename ii2 nro_cuartos
rename ix_tot cant_miembros

tempfile temporal
save `temporal', replace

clear all
use "usu_individual_t119", clear
*import excel "usu_individual_t119.xls", sheet("Sheet 1") firstrow case(lower)

destring deccfr, replace
drop if (deccfr<1 | deccfr>10)
drop if (nro_hogar==51 | nro_hogar==71)

merge m:1 codusu nro_hogar using `temporal'
drop if (_merge!=3)

*Indicador 1*

bysort codusu nro_hogar: generate miembros=_N
generate ratioaux=miembros/nro_cuartos

generate indic1=0 if (ratioaux!=.)
replace indic1=1 if (ratioaux>3 & ratioaux!=.)

drop ratioaux

*Indicador 2*

generate indic2=0
replace indic2=1 if (tipo_vivienda==3 | tipo_vivienda==5 | tipo_vivienda==6 | dum_villa==1)

*Indicador 3*

generate indic3=0
replace indic3=1 if (dum_banio==2 | tipo_banio==2 | tipo_banio==3)

*Indicador 4*

generate edad=ch06
replace edad=0 if (edad==-1)

generate aux=0
replace aux=1 if (edad>=6 & edad<=12 & ch10!=1 & ch10!=.)
bysort codusu nro_hogar: egen escolares=total(aux)

generate indic4=0
replace indic4=1 if (escolares>=1)

drop aux

*Indicador 5*

generate aux=1 if (estado==1)
bysort codusu nro_hogar: egen ocupados=sum(aux)
generate ratioaux=miembros/ocupados
capture drop aux

generate aux=0
replace aux=1 if (ch03==1 & (nivel_ed==1 | nivel_ed==7))
bysort codusu nro_hogar: egen edu_jefe=sum(aux)

generate indic5=0
replace indic5=1 if (ratioaux>=4 & edu_jefe>0)

drop ratioaux aux

*Resultados (País)*

tabulate indic1 [w=pondera]
tabulate indic2 [w=pondera]
tabulate indic3 [w=pondera]
tabulate indic4 [w=pondera]
tabulate indic5 [w=pondera]

*Resultados (Región)*

clonevar region2=region
replace region2=32 if (aglomerado==32)
replace region2=33 if (aglomerado==33)

egen aux=group(region2)
tabulate aux [w=pondera]

matrix define   R = J(8,5,.)
matrix rownames R = "CABA" "GBA" "NOA" "NEA" "Cuyo" "Pampeana" "Patagónica" "Total País"
matrix colnames R = "Hacinamiento" "Vivienda" "Sanidad" "Escolaridad" "Subsistencia"

forvalues i=1(1)7 {

	forvalues j=1(1)5 {
		summarize indic`j' [w=pondera] if (aux==`i')
		matrix R [`i',`j']=r(mean)*100
	}

}

forvalues j=1(1)5 {
	summarize indic`j' [w=pondera]
	matrix R [8,`j']=r(mean)*100
}

matrix list R

drop aux

*Pobreza s/Ingreso y Pobreza s/NBI*

generate pobre_ingreso=0
replace pobre_ingreso=1 if (ipcf<`lp1')
tabulate pobre_ingreso [w=pondera]

generate pobre_nbi=0
replace pobre_nbi=1 if (indic1>0 | indic2>0 | indic3>0 | indic4>0 | indic5>0)
tabulate pobre_nbi [w=pondera]

tabulate pobre_ingreso pobre_nbi [w=pondera]

*Pobreza por Región*

egen aux=group(region2)
tabulate aux [w=pondih]

matrix define   P = J(7,2,.)
matrix rownames P = "CABA" "GBA" "NOA" "NEA" "Cuyo" "Pampeana" "Patagónica"
matrix colnames P = "Pobreza s/Ingreso" "Pobreza s/NBI"

forvalues i=1(1)7 {
	summarize pobre_ingreso [w=pondera] if (aux==`i')
	matrix P [`i',1]=r(mean)*100
	summarize pobre_nbi [w=pondera] if (aux==`i')
	matrix P [`i',2]=r(mean)*100
}

matrix list P

drop aux


*##############################################################################*
								* EJERCICIO 5 *
*##############################################################################*


*Base 2017*

clear all
use "usu_individual_t117", clear
*import excel "usu_individual_t117.xls", sheet("Sheet 1") firstrow case(lower)

destring deccfr, replace
drop if (deccfr<1 | deccfr>10)
drop if (nro_hogar==51 | nro_hogar==71)

keep ipcf pondih
tempfile arg17
save `arg17', replace

*Base 2019*

clear all
use "usu_individual_t119", clear
*import excel "usu_individual_t119.xls", sheet("Sheet 1") firstrow case(lower)

destring deccfr, replace
drop if (deccfr<1 | deccfr>10)
drop if (nro_hogar==51 | nro_hogar==71)

keep ipcf pondih
tempfile arg19
save `arg19', replace

*Homogeneización de Bases*

local ipc17=103.80
local ipc19=197.10

foreach i of numlist 17 19 {

	drop _all
	use `arg`i'', clear

	if "`i'" == "17" {
		replace ipcf=ipcf*(`ipc19'/`ipc17')
	}

	sort ipcf

	generate sumpop=sum(pondih)
	generate shrpop=sumpop/sumpop[_N]

	generate percentil=.

	forvalues j=1(1)100 {
		replace percentil=`j' if (shrpop>(`j'-1)*0.01 & shrpop<=`j'*0.01)
	}

	table percentil [w=pondih], contents(mean ipcf) replace
	rename table1 ipcf`i'
	sort percentil
	tempfile percentil_arg`i'
	save `percentil_arg`i'', replace

}

*Unión de bases*

merge 1:1 percentil using `percentil_arg17'
drop _merge

*Gráficos*

generate chg=(ipcf19/ipcf17-1)*100

graph twoway	(line chg percentil, lcolor(black)), title("Curva de Incidencia del Crecimiento 2017-t1 - 2019-t1") ///
				ytitle("Variación % promedio del IPCF") xtitle("Percentiles del IPCF") yline(0, lcolor(red)) xlabel(#10)
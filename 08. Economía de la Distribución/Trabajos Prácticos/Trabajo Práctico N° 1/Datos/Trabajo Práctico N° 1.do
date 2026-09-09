clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/8. Economía de la Distribución/Trabajos Prácticos/Trabajo Práctico N° 1/Datos"
use "usu_individual_t119", clear
*import excel "usu_individual_t119.xls", sheet("Sheet 1") firstrow case(lower)
*save "usu_individual_t119", replace


destring deccfr, replace
drop if (deccfr<1 | deccfr>10)
drop if (nro_hogar==51 | nro_hogar==71)


*##############################################################################*
								* EJERCICIO 1 *
*##############################################################################*


*Opción 1*

generate region2=region
replace region2=32 if (aglomerado==32)
replace region2=33 if (aglomerado==33)

sort region2

egen aux=group(region2)
tabulate aux [w=pondih]

matrix define   R = J(8,8,.)
matrix rownames R = "CABA" "GBA" "NOA" "NEA" "Cuyo" "Pampeana" "Patagónica" "Total País"
matrix colnames R = "Observaciones" "Media" "Desvío estándar" "CV" "p25" "Mediana" "p75" "Moda"

forvalues i=1(1)7 {
	summarize ipcf [w=pondih] if (aux==`i'), detail
	matrix R [`i',1]=r(sum_w)
	matrix R [`i',2]=r(mean)
	matrix R [`i',3]=r(sd)
	matrix R [`i',4]=r(sd)/r(mean)
	matrix R [`i',5]=r(p25)
	matrix R [`i',6]=r(p50)
	matrix R [`i',7]=r(p75)
}

forvalues i=1(1)7 {
	preserve
	keep if (aux==`i')
	bysort ipcf: egen aux_freq=total(pondih)
	gsort -aux_freq
	display as text "Moda_`i' = " as result ipcf[1]
	drop aux_freq
	matrix R [`i',8]=ipcf[1]
	restore
}

summarize ipcf [w=pondih], detail

matrix R [8,1]=r(sum_w)
matrix R [8,2]=r(mean)
matrix R [8,3]=r(sd)
matrix R [8,4]=r(sd)/r(mean)
matrix R [8,5]=r(p25)
matrix R [8,6]=r(p50)
matrix R [8,7]=r(p75)

bysort ipcf: egen aux_freq=total(pondih)
gsort -aux_freq
display as text "Moda = " as result ipcf[1]
drop aux_freq

matrix R [8,8]=ipcf[1]

matrix list R

drop region2 aux

*Opción 2*

table region
codebook region
table aglomerado
codebook aglomerado

generate region2=region
replace region2=32 if (aglomerado==32)
replace region2=33 if (aglomerado==33)
sort region2

by region2: summarize ipcf [w=pondih], detail

levelsof region2, local(levels)

foreach i of local levels {
	generate ipcf`i'=ipcf if (region2==`i')
	tabstat ipcf`i', statistics(mean sd cv)
	egen ipcfmoda`i'=mode(ipcf`i'), maxmode
	display ipcfmoda`i'
}

summarize ipcf [w=pondih], detail

bysort ipcf: egen aux_freq=total(pondih)
gsort -aux_freq
display as text "Moda = " as result ipcf[1]
drop aux_freq


*##############################################################################*
								* EJERCICIO 2 *
*##############################################################################*


generate prii=1 if (nivel_ed==1 | nivel_ed==7)
generate pric=1 if (nivel_ed==2)
generate seci=1 if (nivel_ed==3)
generate secc=1 if (nivel_ed==4)
generate supi=1 if (nivel_ed==5)
generate supc=1 if (nivel_ed==6)

egen aux=rsum(prii pric seci secc supi supc)

replace prii=0 if (prii!=1 & aux==1)
replace pric=0 if (pric!=1 & aux==1)
replace seci=0 if (seci!=1 & aux==1)
replace secc=0 if (secc!=1 & aux==1)
replace supi=0 if (supi!=1 & aux==1)
replace supc=0 if (supc!=1 & aux==1)

drop if (aux!=1)
drop aux

generate hombre=.
replace hombre=0 if (ch04==2)
replace hombre=1 if (ch04==1)

generate income=p47t
generate lincome=log(income)

histogram income [w=pondii] if (income>0 & estado==1), fraction ytitle("Fracción") xtitle("Ingreso total individual ocupados")
sktest income [w=pondii] if (income>0 & estado==1), noadjust

histogram lincome [w=pondii] if (estado==1), fraction ytitle("Fracción") xtitle("Logaritmo del ingreso total individual ocupados")
sktest lincome [w=pondii] if (estado==1), noadjust

histogram lincome [w=pondii] if (estado==1 & hombre==1), fraction ytitle("Fracción") xtitle("Logaritmo del ingreso total individual ocupados (Hombres)")
sktest lincome [w=pondii] if (estado==1 & hombre==1), noadjust

histogram lincome [w=pondii] if (estado==1 & hombre==0), fraction ytitle("Fracción") xtitle("Logaritmo del ingreso total individual ocupados (Mujeres)")
sktest lincome [w=pondii] if (estado==1 & hombre==0), noadjust

kdensity lincome [w=pondii] if (estado==1 & hombre==1), title("Hombres") ytitle("Densidad") xtitle("Logaritmo del ingreso total individual")
kdensity lincome [w=pondii] if (estado==1 & hombre==0), title("Mujeres") ytitle("Densidad") xtitle("Logaritmo del ingreso total individual")

graph twoway	(kdensity lincome [w=pondii] if (estado==1 & hombre==1)) (kdensity lincome [w=pondii] if (estado==1 & hombre==0)), ///
				ytitle("Densidad") xtitle("Logaritmo del ingreso total individual ocupados") legend(label(1 "Hombres") label(2 "Mujeres"))


*##############################################################################*
								* EJERCICIO 3 *
*##############################################################################*


generate educ=.
replace educ=1 if (nivel_ed==1 | nivel_ed==2 | nivel_ed==3 | nivel_ed==7)
replace educ=2 if (nivel_ed==4 | nivel_ed==5)
replace educ=3 if (nivel_ed==6)

kdensity lincome [w=pondii] if (estado==1 & educ==1), title("Educación menor a secundaria completa") ytitle("Densidad") xtitle("Logaritmo del ingreso total individual")
kdensity lincome [w=pondii] if (estado==1 & educ==2), title("Educación menor a superior completa") ytitle("Densidad") xtitle("Logaritmo del ingreso total individual")
kdensity lincome [w=pondii] if (estado==1 & educ==3), title("Educación superior completa") ytitle("Densidad") xtitle("Logaritmo del ingreso total individual")

graph twoway	(kdensity lincome [w=pondii] if (estado==1 & educ==1)) (kdensity lincome [w=pondii] if (estado==1 & educ==2)) ///
				(kdensity lincome [w=pondii] if (estado==1 & educ==3)), ytitle("Densidad") xtitle("Logaritmo del ingreso total individual ocupados") ///
				legend(label(1 "prii | pric | seci") label(2 "secc | supi") label(3 "supc"))


*##############################################################################*
								* EJERCICIO 4 *
*##############################################################################*


*Opción 1*

tostring pp04b_cod, replace

generate len=length(pp04b_cod)
generate aux1=substr(pp04b_cod,1,2) if (len==4)
generate aux2=substr(pp04b_cod,1,1) if (len==3)
generate aux3=aux1+aux2

destring aux3, replace

generate sector=.
replace sector=1 if (aux3>=1 & aux3<=9)
replace sector=2 if (aux3>=10 & aux3<=33)
replace sector=3 if (aux3>=35 & aux3<=99)

sort pp04b_cod
generate lp21_1=log(p21)

graph twoway	(kdensity lp21 [w=pondiio] if (sector==1)) (kdensity lp21_1 [w=pondiio] if (sector==2)) (kdensity lp21_1 [w=pondiio] if (sector==3)), ///
				ytitle("Densidad") xtitle("Logaritmo del ingreso ocupación principal") ///
				legend(label(1 "Actividades primarias") label(2 "Manufacturas") label(3 "Servicios"))

graph twoway	(kdensity lp21 [w=pondiio] if (sector==1 & hombre==1)) (kdensity lp21_1 [w=pondiio] if (sector==2 & hombre==1)) ///
				(kdensity lp21 [w=pondiio] if (sector==3 & hombre==1)), ytitle("Densidad") xtitle("Logaritmo del ingreso ocupación principal") ///
				legend(label(1 "Actividades primarias") label(2 "Manufacturas") label(3 "Servicios"))
graph twoway	(kdensity lp21 [w=pondiio] if (sector==1 & hombre==0)) (kdensity lp21_1 [w=pondiio] if (sector==2 & hombre==0)) ///
				(kdensity lp21 [w=pondiio] if (sector==3 & hombre==0)), ytitle("Densidad") xtitle("Logaritmo del ingreso ocupación principal") ///
				legend(label(1 "Actividades primarias") label(2 "Manufacturas") label(3 "Servicios"))

graph twoway	(kdensity lp21 [w=pondiio] if (sector==1 & educ==1)) (kdensity lp21_1 [w=pondiio] if (sector==2 & educ==1)) ///
				(kdensity lp21 [w=pondiio] if (sector==3 & educ==1)), ytitle("Densidad") xtitle("Logaritmo del ingreso ocupación principal") ///
				legend(label(1 "Actividades primarias") label(2 "Manufacturas") label(3 "Servicios"))
graph twoway	(kdensity lp21 [w=pondiio] if (sector==1 & educ==2)) (kdensity lp21_1 [w=pondiio] if (sector==2 & educ==2)) ///
				(kdensity lp21 [w=pondiio] if (sector==3 & educ==2)), ytitle("Densidad") xtitle("Logaritmo del ingreso ocupación principal") ///
				legend(label(1 "Actividades primarias") label(2 "Manufacturas") label(3 "Servicios"))
graph twoway	(kdensity lp21 [w=pondiio] if (sector==1 & educ==3)) (kdensity lp21_1 [w=pondiio] if (sector==2 & educ==3)) ///
				(kdensity lp21 [w=pondiio] if (sector==3 & educ==3)), ytitle("Densidad") xtitle("Logaritmo del ingreso ocupación principal") ///
				legend(label(1 "Actividades primarias") label(2 "Manufacturas") label(3 "Servicios"))

drop aux* sector lp21

*Opción 2*

destring pp04b_cod, replace

generate aux1=strofreal(pp04b_cod)
generate aux2=strlen(aux1)

generate ciiu2d=strofreal(pp04b_cod, "%04.0f") if (aux2==3 | aux2==4)
replace ciiu2d=substr(ciiu2d,1,2) if (aux2==3 | aux2==4)
replace ciiu2d=strofreal(pp04b_cod, "%02.0f") if (aux2==1 | aux2==2)

generate ciiu2d_alt=real(ciiu2d)
sort ciiu2d_alt

generate sector=.
replace sector=1 if (ciiu2d_alt>=1 & ciiu2d_alt<=9)
replace sector=2 if (ciiu2d_alt>=10 & ciiu2d_alt<=33)
replace sector=3 if (ciiu2d_alt>=35 & ciiu2d_alt<=99)

generate lp21=log(p21)

graph twoway	(kdensity lp21 [w=pondiio] if (sector==1)) (kdensity lp21 [w=pondiio] if (sector==2)) (kdensity lp21 [w=pondiio] if (sector==3)), ///
				ytitle("Densidad") xtitle("Logaritmo del ingreso ocupación principal") ///
				legend(label(1 "Actividades primarias") label(2 "Manufacturas") label(3 "Servicios"))

graph twoway	(kdensity lp21 [w=pondiio] if (sector==1 & hombre==1)) (kdensity lp21 [w=pondiio] if (sector==2 & hombre==1)) ///
				(kdensity lp21 [w=pondiio] if (sector==3 & hombre==1)), ytitle("Densidad") xtitle("Logaritmo del ingreso ocupación principal") ///
				legend(label(1 "Actividades primarias") label(2 "Manufacturas") label(3 "Servicios"))
graph twoway	(kdensity lp21 [w=pondiio] if (sector==1 & hombre==0)) (kdensity lp21 [w=pondiio] if (sector==2 & hombre==0)) ///
				(kdensity lp21 [w=pondiio] if (sector==3 & hombre==0)), ytitle("Densidad") xtitle("Logaritmo del ingreso ocupación principal") ///
				legend(label(1 "Actividades primarias") label(2 "Manufacturas") label(3 "Servicios"))

graph twoway	(kdensity lp21 [w=pondiio] if (sector==1 & educ==1)) (kdensity lp21 [w=pondiio] if (sector==2 & educ==1)) ///
				(kdensity lp21 [w=pondiio] if (sector==3 & educ==1)), ytitle("Densidad") xtitle("Logaritmo del ingreso ocupación principal") ///
				legend(label(1 "Actividades primarias") label(2 "Manufacturas") label(3 "Servicios"))
graph twoway	(kdensity lp21 [w=pondiio] if (sector==1 & educ==2)) (kdensity lp21 [w=pondiio] if (sector==2 & educ==2)) ///
				(kdensity lp21 [w=pondiio] if (sector==3 & educ==2)), ytitle("Densidad") xtitle("Logaritmo del ingreso ocupación principal") ///
				legend(label(1 "Actividades primarias") label(2 "Manufacturas") label(3 "Servicios"))
graph twoway	(kdensity lp21 [w=pondiio] if (sector==1 & educ==3)) (kdensity lp21 [w=pondiio] if (sector==2 & educ==3)) ///
				(kdensity lp21 [w=pondiio] if (sector==3 & educ==3)), ytitle("Densidad") xtitle("Logaritmo del ingreso ocupación principal") ///
				legend(label(1 "Actividades primarias") label(2 "Manufacturas") label(3 "Servicios"))

drop aux*


*##############################################################################*
								* EJERCICIO 5 *
*##############################################################################*


summarize ipcf [w=pondih], detail

generate indic=.
replace indic=0 if (ipcf>=0.5*r(p50) & ipcf!=.)
replace indic=1 if (ipcf<0.5*r(p50))

summarize indic [w=pondih]
display as text "Proporción de individuos con ingreso per cápita menor a 50% del ingreso mediano = " as result r(mean)


*##############################################################################*
								* EJERCICIO 6 *
*##############################################################################*


*Opción 1*

generate yjefe=income if (ch03==1)
replace yjefe=0 if (yjefe==. & ch03==1)

generate yconyuge=income if (ch03==2)
replace yconyuge=0 if (yconyuge==. & ch03==2)

bysort codusu nro_hogar: egen yjefe_aux=total(yjefe)
bysort codusu nro_hogar: egen yconyuge_aux=total(yconyuge)

generate sh_jefe=yjefe_aux/itf if (ch03==1)
generate sh_conyuge=yconyuge_aux/itf if (ch03==1)

summarize sh_jefe [w=pondii]
display as text "Share Jefe = " as result r(mean)
summarize sh_conyuge [w=pondii]
display as text "Share Cónyuge = " as result r(mean)

*Opción 2*

summarize income [w=pondii]
local i_total=r(sum)
summarize income [w=pondii] if (ch03==1)
local i_jefe=r(sum)
summarize income [w=pondii] if (ch03==2)
local i_conyuge=r(sum)

display as text "Share Jefe = " as result (`i_jefe'/`i_total')*100
display as text "Share Cónyuge = " as result (`i_conyuge'/`i_total')*100


*##############################################################################*
								* EJERCICIO 7 *
*##############################################################################*


*Opción 1*

generate yhombre=income if (ch04==1)
replace yhombre=0 if (yhombre==. & ch04==1)

generate ymujer=income if (ch04==2)
replace ymujer=0 if (ymujer==. & ch04==2)

bysort codusu nro_hogar: egen yhombre_aux=total(yhombre)
bysort codusu nro_hogar: egen ymujer_aux=total(ymujer)
by codusu nro_hogar: generate aux_n=_n

generate sh_hombre=yhombre_aux/itf if (aux_n==1)
generate sh_mujer=ymujer_aux/itf if (aux_n==1)

summarize sh_hombre [w=pondii]
display as text "Share Hombre = " as result r(mean)
summarize sh_mujer [w=pondii]
display as text "Share Mujer = " as result r(mean)

drop aux_n

*Opción 2*

summarize income [w=pondii]
local i_total=r(sum)
summarize income [w=pondii] if (ch04==1)
local i_hombre=r(sum)
summarize income [w=pondii] if (ch04==2)
local i_mujer=r(sum)

display as text "Share Hombre = " as result (`i_hombre'/`i_total')*100
display as text "Share Mujer = " as result (`i_mujer'/`i_total')*100
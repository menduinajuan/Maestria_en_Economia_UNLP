clear all
set more off
version 16

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/8. Economía de la Distribución/Trabajos Prácticos/Trabajo Práctico N° 5/Datos"


*##############################################################################*
								* EJERCICIO 1 *
*##############################################################################*


do "curvincid"


*##############################################################################*
								* EJERCICIO 2 *
*##############################################################################*


*Año 2017*

do "arg17"
do "region"
quietly include "comando_gini"
quietly include "comando_atk"

summarize ipcf [w=pondih]
local media=r(mean)
gini ipcf [w=pondih]

*Función de bienestar tipo Sen*
local welfare=`media'*(1-r(gini))
display as text "W según Sen es " as result `welfare'

*Función de bienestar tipo Kakwani*
local welfare=`media'/(1+r(gini))
display as text "W según Kakwani es " as result `welfare'

*Función de bienestar tipo Atkinson e(1)*
atk ipcf [w=pondih], epsilon(1)
local welfare=`media'*(1-r(atk))
display as text "W según Atkinson con epsilon=1 es " as result `welfare'

*Función de bienestar tipo Atkinson con e(2)*
atk ipcf [w=pondih], epsilon(2)
local welfare=-`media'*(1-r(atk))
display as text "W según Atkinson con epsilon=2 es " as result `welfare'

levelsof region2, local(levels)

foreach i of local levels {

	preserve
	keep if (region2==`i')

	summarize ipcf [w=pondih]
	local media=r(mean)
	gini ipcf [w=pondih]

	*Función de bienestar tipo Sen*
	local welfare=`media'*(1-r(gini))
	display as text "W según Sen es " as result `welfare'

	*Función de bienestar tipo Kakwani*
	local welfare=`media'/(1+r(gini))
	display as text "W según Kakwani es " as result `welfare'

	*Función de bienestar tipo Atkinson con e(1)*
	atk ipcf [w=pondih], epsilon(1)
	local welfare=`media'*(1-r(atk))
	display as text "W según Atkinson con epsilon=1 es " as result `welfare'

	*Función de bienestar tipo Atkinson con e(2)*
	atk ipcf [w=pondih], epsilon(2)
	local welfare=-`media'*(1-r(atk))
	display as text "W según Atkinson con epsilon=2 es " as result `welfare'

	restore

}

*Año 2019*

do "arg19"
do "region"
quietly include "comando_gini"
quietly include "comando_atk"

summarize ipcf [w=pondih]
local media=r(mean)
gini ipcf [w=pondih]

*Función de bienestar tipo Sen*
local welfare=`media'*(1-r(gini))
display as text "W según Sen es " as result `welfare'

*Función de bienestar tipo Kakwani*
local welfare=`media'/(1+r(gini))
display as text "W según Kakwani es " as result `welfare'

*Función de bienestar tipo Atkinson e(1)*
atk ipcf [w=pondih], epsilon(1)
local welfare=`media'*(1-r(atk))
display as text "W según Atkinson con epsilon=1 es " as result `welfare'

*Función de bienestar tipo Atkinson con e(2)*
atk ipcf [w=pondih], epsilon(2)
local welfare=-`media'*(1-r(atk))
display as text "W según Atkinson con epsilon=2 es " as result `welfare'

levelsof region2, local(levels)

foreach i of local levels {

	preserve
	keep if (region2==`i')

	summarize ipcf [w=pondih]
	local media=r(mean)
	gini ipcf [w=pondih]

	*Función de bienestar tipo Sen*
	local welfare=`media'*(1-r(gini))
	display as text "W según Sen es " as result `welfare'

	*Función de bienestar tipo Kakwani*
	local welfare=`media'/(1+r(gini))
	display as text "W según Kakwani es " as result `welfare'

	*Función de bienestar tipo Atkinson con e(1)*
	atk ipcf [w=pondih], epsilon(1)
	local welfare=`media'*(1-r(atk))
	display as text "W según Atkinson con epsilon=1 es " as result `welfare'

	*Función de bienestar tipo Atkinson con e(2)*
	atk ipcf [w=pondih], epsilon(2)
	local welfare=-`media'*(1-r(atk))
	display as text "W según Atkinson con epsilon=2 es " as result `welfare'

	restore

}


*##############################################################################*
								* EJERCICIO 3 *
*##############################################################################*


*Año 2017*

do "arg17"
do "region"

local ipc17=103.80
local ipc19=197.10

replace ipcf=ipcf*(`ipc19'/`ipc17')

sort region2 ipcf, stable

by region2: generate sumpop=sum(pondih)
by region2: generate shrpop=sumpop/sumpop[_N]
by region2: generate suminc=sum(ipcf*pondih)
by region2: replace suminc=suminc/sumpop[_N]

graph twoway	(line suminc shrpop if (region2==32), lcolor(black)) (line suminc shrpop if (region2==33), lcolor(red) lpat(dash)), ///
				title("Curva de Lorenz") ytitle("GL(p)") xtitle("p") legend(label(1 "CABA") label(2 "Partidos GBA"))

graph twoway	(line suminc shrpop if (region2==41), lcolor(black)) (line suminc shrpop if (region2==44), lcolor(red) lpat(dash)), ///
				title("Curva de Lorenz") ytitle("GL(p)") xtitle("p") legend(label(1 "NEA") label(2 "Patagónica"))

*Año 2019*

do "arg19"
do "region"

sort region2 ipcf, stable

by region2: generate sumpop=sum(pondih)
by region2: generate shrpop=sumpop/sumpop[_N]
by region2: generate suminc=sum(ipcf*pondih)
by region2: replace suminc=suminc/sumpop[_N]

graph twoway	(line suminc shrpop if (region2==32), lcolor(black)) (line suminc shrpop if (region2==33), lcolor(red) lpat(dash)), ///
				title("Curva de Lorenz") ytitle("GL(p)") xtitle("p") legend(label(1 "CABA") label(2 "Partidos GBA"))

graph twoway	(line suminc shrpop if (region2==41), lcolor(black)) (line suminc shrpop if (region2==44), lcolor(red) lpat(dash)), ///
				title("Curva de Lorenz") ytitle("GL(p)") xtitle("p") legend(label(1 "NEA") label(2 "Patagónica"))


*##############################################################################*
								* EJERCICIO 4 *
*##############################################################################*


*Año 2017*

do "arg17"
do "educ"
do "ilabhr17"

generate edad=ch06
keep if (edad>=18 & edad<=60)

forvalues i=1(1)6 {
	summarize ilabhr [w=pondiio] if (edulevel==`i')
	display as text "`i' = " as result r(mean)
}

*Año 2019*

do "arg19"
do "educ"
do "ilabhr19"

generate edad=ch06
keep if (edad>=18 & edad<=60)

forvalues i=1(1)6 {
	summarize ilabhr [w=pondiio] if (edulevel==`i')
	display as text "`i' = " as result r(mean)
}


*##############################################################################*
								* EJERCICIO 5 *
*##############################################################################*


*Año 2017*

do "arg17"
do "educ"
do "ilabhr17"
quietly include "comando_theil"

theil ilabhr [w=pondiio]
local theil=r(theil)

summarize ilabhr [w=pondiio]
local obs_t=r(sum_w)
local media_t=r(mean)

generate hombre=.
replace hombre=0 if (ch04==2)
replace hombre=1 if (ch04==1)

*theildeco ilabhr [w=pondiio], byg(hombre)
*theildeco ilabhr [w=pondiio], byg(edulevel)

foreach var of varlist hombre edulevel {

	generate grupo=`var'
	levelsof grupo, local(nn)

	local inter_g=0
	local intra_g=0

	foreach i of local nn {

		display as text "i = " as result `i'

		theil ilabhr [w=pondiio] if (`var'==`i')
		local theil_g=r(theil)

		summarize ilabhr [w=pondiio] if (`var'==`i')
		local obs_g=r(sum_w)
		local media_g=r(mean)

		local inter_g=`inter_g'+(`obs_g'/`obs_t')*(`media_g'/`media_t')*ln(`media_g'/`media_t')
		local intra_g=`intra_g'+(`obs_g'/`obs_t')*(`media_g'/`media_t')*`theil_g'
		local theil_t=`inter_g'+`intra_g'

	}

	display as text "Intergrupal = " as result `inter_g'
	display as text "Intragrupal = " as result `intra_g'
	display	as text "Total       = " as result `theil_t'
	display as text "Theil       = " as result `theil'

	drop grupo

}

*Año 2019*

do "arg19"
do "educ"
do "ilabhr19"
quietly include "comando_theil"

theil ilabhr [w=pondiio]
local theil=r(theil)

summarize ilabhr [w=pondiio]
local obs_t=r(sum_w)
local media_t=r(mean)

generate hombre=.
replace hombre=0 if (ch04==2)
replace hombre=1 if (ch04==1)

*theildeco ilabhr [w=pondiio], byg(hombre)
*theildeco ilabhr [w=pondiio], byg(edulevel)

foreach var of varlist hombre edulevel {

	generate grupo=`var'
	levelsof grupo, local(nn)

	local inter_g=0
	local intra_g=0

	foreach i of local nn {

		display as text "i = " as result `i'

		theil ilabhr [w=pondiio] if (`var'==`i')
		local theil_g=r(theil)

		summarize ilabhr [w=pondiio] if (`var'==`i')
		local obs_g=r(sum_w)
		local media_g=r(mean)

		local inter_g=`inter_g'+(`obs_g'/`obs_t')*(`media_g'/`media_t')*ln(`media_g'/`media_t')
		local intra_g=`intra_g'+(`obs_g'/`obs_t')*(`media_g'/`media_t')*`theil_g'
		local theil_t=`inter_g'+`intra_g'

	}

	display as text "Intergrupal = " as result `inter_g'
	display as text "Intragrupal = " as result `intra_g'
	display	as text "Total       = " as result `theil_t'
	display as text "Theil       = " as result `theil'

	drop grupo

}


*##############################################################################*
								* EJERCICIO 6 *
*##############################################################################*


*Año 2017*

do "arg17"
do "educ"
do "ilabhr17"

generate edad=ch06
generate edad2=edad*edad

generate hombre=.
replace hombre=0 if (ch04==2)
replace hombre=1 if (ch04==1)

regress lilabhr pric seci secc supi supc edad edad2 hombre [pw=pondiio]
predict yhat
regress lilabhr pric seci secc supi supc [pw=pondiio] if (edad==40 & hombre==1)

matrix define   ILH_17 = J(6,2,.)
matrix rownames ILH_17 = "prii" "pric" "seci" "secc" "supi" "supc"
matrix colnames ILH_17 = "pro_agen_17" "agen_pro_17"

levelsof edulevel, local(levels)

*Promedio Agente*
local count=1
foreach i of local levels {
	preserve 
	keep if (edulevel==`i')
	summarize yhat [w=pondiio]
	matrix ILH_17 [`count',1]=r(mean)
	local count=`count'+1
	restore
}

*Agente Promedio*
local count=1
foreach i of local levels {
	preserve
	keep if (edulevel==`i' & edad==40 & hombre==1)
	summarize yhat [w=pondiio]
	matrix ILH_17 [`count',2]=r(mean)
	local count=`count'+1
	restore
}

matrix list ILH_17
svmat ILH_17, names(col)
generate niv_educ=_n
keep if (niv_educ<7)
keep pro_agen_17 agen_pro_17 niv_educ

save "ilabhr_17", replace

*Año 2019*

do "arg19"
do "educ"
do "ilabhr19"

generate edad=ch06
generate edad2=edad*edad

generate hombre=.
replace hombre=0 if (ch04==2)
replace hombre=1 if (ch04==1)

regress lilabhr pric seci secc supi supc edad edad2 hombre [pw=pondiio]
predict yhat
regress lilabhr pric seci secc supi supc [pw=pondiio] if (edad==40 & hombre==1)

matrix define   ILH_19 = J(6,2,.)
matrix rownames ILH_19 = "prii" "pric" "seci" "secc" "supi" "supc"
matrix colnames ILH_19 = "pro_agen_19" "agen_pro_19"

levelsof edulevel, local(levels)

*Promedio Agente*

local count=1

foreach i of local levels {
	preserve 
	keep if (edulevel==`i')
	summarize yhat [w=pondiio]
	matrix ILH_19 [`count',1]=r(mean)
	local count=`count'+1
	restore
}

*Agente Promedio*

local count=1

foreach i of local levels {
	preserve
	keep if (edulevel==`i' & edad==40 & hombre==1)
	summarize yhat [w=pondiio]
	matrix ILH_19 [`count',2]=r(mean)
	local count=`count'+1
	restore
}

matrix list ILH_19
svmat ILH_19, names(col)
generate niv_educ=_n
keep if (niv_educ<7)
keep pro_agen_19 agen_pro_19 niv_educ

save "ilabhr_19", replace

*Unión de bases*

merge using "ilabhr_17"
drop _merge

*Gráficos*

graph twoway	(line pro_agen_17 niv_educ, lcolor(black)) (line pro_agen_19 niv_educ, lcolor(red)), title("Retornos a la Educación") ///
				ytitle("Logaritmo del ingreso horario promedio predicho") xtitle("Nivel educativo") legend(label(1 "2017") label(2 "2019"))

graph twoway	(line agen_pro_17 niv_educ, lcolor(black)) (line agen_pro_19 niv_educ, lcolor(red)), title("Retornos a la Educación") ///
				ytitle("Logaritmo del ingreso horario promedio predicho") xtitle("Nivel educativo") legend(label(1 "2017") label(2 "2019"))


*##############################################################################*
								* EJERCICIO 7 *
*##############################################################################*


*Año 2017*

do "arg17"
do "educ"
do "ilabhr17"
quietly include "comando_gini"
quietly include "comando_gcuan"

generate edad=ch06
generate edad2=edad*edad

generate hombre=.
replace hombre=0 if (ch04==2)
replace hombre=1 if (ch04==1)

regress lilabhr pric seci secc supi supc edad edad2 hombre [pw=pondiio]
keep if e(sample)

matrix define mat_beta_t0=e(b)
matrix list mat_beta_t0

predict residuos_t0, resid
gcuan residuos_t0 [w=pondiio], ncuantiles(10) generate(decil_t0)

tabulate edulevel [w=pondiio]

gini ilabhr [w=pondiio]
local gini_t0=r(gini)

preserve
table decil_t0 [w=pondiio], contents(mean residuos_t0) replace
mkmat table1, matrix(a_t0)
matrix list a_t0
restore

save "temp_t0", replace

*Año 2019*

do "arg19"
do "educ"
do "ilabhr19"
quietly include "comando_gini"
quietly include "comando_gcuan"

generate edad=ch06
generate edad2=edad*edad

generate hombre=.
replace hombre=0 if (ch04==2)
replace hombre=1 if (ch04==1)

regress lilabhr pric seci secc supi supc edad edad2 hombre [pw=pondiio]
keep if e(sample)

matrix define mat_beta_t1=e(b)
matrix list mat_beta_t1

predict residuos_t1, resid
gcuan residuos_t1 [w=pondiio], ncuantiles(10) generate(decil_t1)

tabulate edulevel [w=pondiio]

gini ilabhr [w=pondiio]
local gini_t1=r(gini)

preserve
table decil_t1 [w=pondiio], contents(mean residuos_t1) replace
mkmat table1, matrix(a_t1)
matrix list a_t1
restore

save "temp_t1", replace

*Descomposición*

*Características t=0; Parámetros t=1; Residuos promedios t=0*
use "temp_t0", clear
matrix score ys=mat_beta_t1
replace ys=ys+a_t0[decil_t0,1]
replace ys=exp(ys)
gini ys [w=pondiio]
local gini_ys=r(gini)

*Características t=0; Parámetros t=1; Residuos promedios t=1*
use "temp_t1", clear
matrix score ysp=mat_beta_t1
replace ysp=ysp+a_t1[decil_t1,1]
replace ysp=exp(ysp)
gini ysp [w=pondiio]
local gini_ysp=r(gini)

local EC=`gini_t1'-`gini_ysp'
display as text "Efecto Características = " as result `EC'
local EP=`gini_ys'-`gini_t0'
display as text "Efecto Parámetros = " as result `EP'
local EI=`gini_ysp'-`gini_ys'
display as text "Efecto Inobservabales = " as result `EI'
local ET=`EC'+`EP'+`EI'
display as text "Efecto Total = " as result `ET'
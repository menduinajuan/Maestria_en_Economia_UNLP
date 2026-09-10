clear all
set more off
set graphics off
version 16
timer clear


*ssc install skdecomp


*##############################################################################*
* CONFIGURACIÓN *
*##############################################################################*


*local disco="C:/"
local disco="G:/Mi unidad"
global dir     "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/21. Tesis/Datos"
global data    "$dir/.dta"
global dofiles "$dir/.do"
global results "$dir/.res"
global figures "$dir/.fig"


*##############################################################################*
* PREPARACIÓN DE BASE *
*##############################################################################*


*do "$dofiles/prepara_base/prepara_base_1"
*do "$dofiles/prepara_base/prepara_base_2"


*##############################################################################*
* COMANDOS *
*##############################################################################*


quietly include "$dofiles/comandos/comandos"


*##############################################################################*
* INDIGENCIA NACIONAL 2018 SEGÚN LIP (1,9 USD PPA DE 2011 -1 USD PPA 2011 = COP 1.168,24-) *
*##############################################################################*


use "$data/prepara_base/Base_2018_n", clear

local lip=1.9*1168.24*30
fgt ingpcug [w=fex_c], alpha(0) zeta(`lip')


*##############################################################################*
* CURVAS DE INCIDENCIA DEL CRECIMIENTO (CIC) *
*##############################################################################*


use "$data/Base", clear
keep if (year==2002 | year==2018)

foreach i of numlist 2002 2018 {
	summarize lp [w=fex_c] if (year==`i' & ciudad!=.)
	local lp_urb_`i'=r(mean)
	summarize lp [w=fex_c] if (year==`i' & dominio!="RURAL" & ciudad==.)
	local lp_resturb_`i'=r(mean)
	summarize lp [w=fex_c] if (year==`i' & dominio=="RURAL")
	local lp_rur_`i'=r(mean)
}

foreach area of newlist urb resturb rur {
	local lp_`area'_02_18=`lp_`area'_2018'/`lp_`area'_2002'
}

generate ipcug_real=ipcug
replace ipcug_real=ipcug*`lp_urb_02_18'     if (year==2002 & ciudad!=.)
replace ipcug_real=ipcug*`lp_resturb_02_18' if (year==2002 & dominio!="RURAL" & ciudad==.)
replace ipcug_real=ipcug*`lp_rur_02_18'     if (year==2002 & dominio=="RURAL")

generate ipcug_2002=.
replace ipcug_2002=ipcug_real if (year==2002)
generate ipcug_2018=.
replace ipcug_2018=ipcug_real if (year==2018)

preserve
replace fex_c=round(fex_c)
table pipcug [w=fex_c], statistic(mean ipcug_2002 ipcug_2018) replace
generate cambio_nac=(table2/table1-1)*100
keep pipcug cambio_nac
save "$data/cic/cic_nac", replace
graph twoway	(line cambio_nac pipcug if (pipcug>1), lcolor(black)), title("Total nacional", color(black))
				ytitle("Variación % promedio del IPCUG") xtitle("Percentiles del IPCUG") yline(0, lcolor(red)) xlabel(#10)
restore

preserve
keep if (ciudad!=.)
replace fex_c=round(fex_c)
table pipcug [w=fex_c], statistic(mean ipcug_2002 ipcug_2018) replace
generate cambio_urb=(table2/table1-1)*100
keep pipcug cambio_urb
save "$data/cic/cic_urb", replace
graph twoway	(line cambio_urb pipcug if (pipcug>1), lcolor(black)), title("Principales ciudades", color(black))
				ytitle("Variación % promedio del IPCUG") xtitle("Percentiles del IPCUG") yline(0, lcolor(red)) xlabel(#10)
restore

preserve
keep if (dominio!="RURAL" & ciudad==.)
replace fex_c=round(fex_c)
table pipcug [w=fex_c], statistic(mean ipcug_2002 ipcug_2018) replace
generate cambio_resturb=(table2/table1-1)*100
keep pipcug cambio_resturb
save "$data/cic/cic_resturb", replace
graph twoway	(line cambio_resturb pipcug if (pipcug>1 & pipcug<100), lcolor(black)), title("Resto urbano", color(black))
				ytitle("Variación % promedio del IPCUG") xtitle("Percentiles del IPCUG") yline(0, lcolor(red)) xlabel(#10)
restore

preserve
keep if (dominio=="RURAL")
replace fex_c=round(fex_c)
table pipcug [w=fex_c], statistic(mean ipcug_2002 ipcug_2018) replace
generate cambio_rur=(table2/table1-1)*100
keep pipcug cambio_rur
save "$data/cic/cic_rur", replace
graph twoway	(line cambio_rur pipcug if (pipcug>1), lcolor(black)), title("Rural", color(black))
				ytitle("Variación % promedio del IPCUG") xtitle("Percentiles del IPCUG") yline(0, lcolor(red)) xlabel(#10)
restore

use "$data/cic/cic_nac", clear
foreach i of newlist urb resturb rur {
	merge 1:1 pipcug using "$data/cic/cic_`i'"
	drop _merge
}
save "$data/cic/cic", replace

graph twoway	(line cambio_nac pipcug if (pipcug>1), lcolor(black)) (line cambio_urb pipcug if (pipcug>1), lcolor(red)) ///
				(line cambio_resturb pipcug if (pipcug>1 & pipcug<100), lcolor(blue)) (line cambio_rur pipcug if (pipcug>1), lcolor(green)), ///
				ytitle("Variación % promedio del IPCUG") xtitle("Percentiles del IPCUG") yline(0, lcolor(red)) xlabel(#10) ///
				legend(label(1 "Total nacional") label(2 "Principales ciudades") label(3 "Resto urbano") label(4 "Rural"))


*##############################################################################*
* PARTICIPACIÓN LABORAL FEMENINA (PLF) E INFORMALIDAD LABORAL (IL) *
*##############################################################################*


foreach i of newlist PLF IL {
	matrix define   `i' = J(4,17,.)
	matrix rownames `i' = "Total nacional" "Principales ciudades" "Resto urbano" "Rural"
	matrix colnames `i' = "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018"
}

foreach i of numlist 2002 2003 2004 2005 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 {
	use "$data/prepara_base/Base_`i'_n", clear
	keep if (mujer==1)
	summarize activo [w=fex_c]
	matrix PLF [1,`i'-2001]=r(mean)
	summarize activo [w=fex_c] if (ciudad!=.)
	matrix PLF [2,`i'-2001]=r(mean)
	summarize activo [w=fex_c] if (dominio!="RURAL" & ciudad==.)
	matrix PLF [3,`i'-2001]=r(mean)
	summarize activo [w=fex_c] if (dominio=="RURAL")
	matrix PLF [4,`i'-2001]=r(mean)
}

foreach i of numlist 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 {
	use "$data/prepara_base/Base_`i'_n", clear
	summarize informal [w=fex_c]
	matrix IL [1,`i'-2001]=r(mean)
	summarize informal [w=fex_c] if (ciudad!=.)
	matrix IL [2,`i'-2001]=r(mean)
	summarize informal [w=fex_c] if (dominio!="RURAL" & ciudad==.)
	matrix IL [3,`i'-2001]=r(mean)
	summarize informal [w=fex_c] if (dominio=="RURAL")
	matrix IL [4,`i'-2001]=r(mean)
}

foreach i of newlist PLF IL {
	preserve
	drop _all
	svmat `i'
	export excel using "$results/Características/Características_`i'.xlsx", sheet("`i'", modify) firstrow(variables)
	restore
}


*##############################################################################*
* ECUACIONES DE MINCER *
*##############################################################################*


use "$data/Base", clear
keep if (year==2008 | year==2015 | year==2018)

regress ling_lab_hor hombre edad edad2 pric seci secc supi supc jefe informal [w=fex_c] if (year==2008)
local b_2008=exp(_b[informal])-1
regress ling_lab_hor hombre edad edad2 pric seci secc supi supc jefe informal [w=fex_c] if (year==2015)
local b_2015=exp(_b[informal])-1
regress ling_lab_hor hombre edad edad2 pric seci secc supi supc jefe informal [w=fex_c] if (year==2018)
local b_2018=exp(_b[informal])-1

foreach i in 08 15 18 {
	display `b_20`i''
}


*##############################################################################*
* CARACTERIZACIÓN ECONÓMICA Y SOCIODEMOGRÁFICA DE LOS HOGARES *
*##############################################################################*


use "$data/Base", clear

foreach i of numlist 2002 2005 2008 2015 2018 {
	summarize lp [w=fex_c] if (year==`i' & ciudad!=.)
	local lp_urb_`i'=r(mean)
	summarize lp [w=fex_c] if (year==`i' & dominio!="RURAL" & ciudad==.)
	local lp_resturb_`i'=r(mean)
	summarize lp [w=fex_c] if (year==`i' & dominio=="RURAL")
	local lp_rur_`i'=r(mean)
}

foreach area of newlist urb resturb rur {

	foreach i in 02 05 08 15 {
		local lp_`area'_`i'_18=`lp_`area'_2018'/`lp_`area'_20`i''
	}

}

generate ipcug_real=ipcug
foreach i in 02 05 08 15 {
	replace ipcug_real=ipcug*`lp_urb_`i'_18'     if (year==20`i' & ciudad!=.)
	replace ipcug_real=ipcug*`lp_resturb_`i'_18' if (year==20`i' & dominio!="RURAL" & ciudad==.)
	replace ipcug_real=ipcug*`lp_rur_`i'_18'     if (year==20`i' & dominio=="RURAL")
}

generate ing_nolab_hog_real=ing_nolab_hog
foreach i in 02 05 08 15 {
	replace ing_nolab_hog_real=ing_nolab_hog*`lp_urb_`i'_18'     if (year==20`i' & ciudad!=.)
	replace ing_nolab_hog_real=ing_nolab_hog*`lp_resturb_`i'_18' if (year==20`i' & dominio!="RURAL" & ciudad==.)
	replace ing_nolab_hog_real=ing_nolab_hog*`lp_rur_`i'_18'     if (year==20`i' & dominio=="RURAL")
}

foreach area of newlist tn urb resturb rur {
	matrix define   caract_`area' = J(26,17,.)
	matrix rownames caract_`area' =	"ipcug_real_m" "ipcug_real_sd" "ing_nolab_hog_real_m" "ing_nolab_hog_real_sd" "miembros_h_m" "miembros_h_sd" "p_muj_m" "p_muj_sd" ///
									"niños_hog_m" "niños_hog_sd" "educ_hog_m" "educ_hog_sd" "jefe_mujer_m" "jefe_mujer_sd" "jefe_edad_m" "jefe_edad_sd" ///
									"jefe_cp_m" "jefe_cp_sd" "t_plf_m" "t_plf_sd" "t_des_m" "t_des_sd" "t_inf_m" "t_inf_sd" "ayudas_hog_m" "ayudas_hog_sd"
	matrix colnames caract_`area' = "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018"
}

*TOTAL NACIONAL*

foreach i of numlist 2002 2005 2008 2015 2018 {

	local j=1
	foreach var of varlist ipcug_real ing_nolab_hog_real miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des t_inf ayudas_hog {
		summarize `var' [w=fex_c] if (year==`i' & orden==1)
		matrix caract_tn [`j',`i'-2001]=r(mean)
		matrix caract_tn [`j'+1,`i'-2001]=r(sd)
		local j=`j'+2
	}

}

*13 CIUDADES PRINCIPALES Y ÁREAS METROPOLITANAS*

foreach i of numlist 2002 2005 2008 2015 2018 {

	local j=1
	foreach var of varlist ipcug_real ing_nolab_hog_real miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des t_inf ayudas_hog {
		summarize `var' [w=fex_c] if (year==`i' & orden==1 & ciudad!=.)
		matrix caract_urb [`j',`i'-2001]=r(mean)
		matrix caract_urb [`j'+1,`i'-2001]=r(sd)
		local j=`j'+2
	}

}

*RESTO URBANO*

foreach i of numlist 2002 2005 2008 2015 2018 {

	local j=1
	foreach var of varlist ipcug_real ing_nolab_hog_real miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des t_inf ayudas_hog {
		summarize `var' [w=fex_c] if (year==`i' & orden==1 & dominio!="RURAL" & ciudad==.)
		matrix caract_resturb [`j',`i'-2001]=r(mean)
		matrix caract_resturb [`j'+1,`i'-2001]=r(sd)
		local j=`j'+2
	}

}

*RURAL*

foreach i of numlist 2002 2005 2008 2015 2018 {

	local j=1
	foreach var of varlist ipcug_real ing_nolab_hog_real miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des t_inf ayudas_hog {
		summarize `var' [w=fex_c] if (year==`i' & orden==1 & dominio=="RURAL")
		matrix caract_rur [`j',`i'-2001]=r(mean)
		matrix caract_rur [`j'+1,`i'-2001]=r(sd)
		local j=`j'+2
	}

}

foreach area of newlist tn urb resturb rur {
	preserve
	drop _all
	svmat caract_`area'
	export excel using "$results/Características/Características_`area'.xlsx", sheet("Características_`area'", modify) firstrow(variables)
	restore
}


*##############################################################################*
* SERIES DE POBREZA E INDIGENCIA *
*##############################################################################*


foreach area of newlist tn urb resturb rur {
	matrix define   pob_`area' = J(6,17,.)
	matrix rownames pob_`area' = "FGT0_p" "FGT1_p" "FGT2_p" "FGT0_i" "FGT1_i" "FGT2_i"
	matrix colnames pob_`area' = "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018"
}

foreach i of numlist 2002 2003 2004 2005 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 {

	use "$data/prepara_base/Base_`i'_n", clear

	*TOTAL NACIONAL*

	local j=1
	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			fgt ingpcug [w=fex_c], alpha(`alpha') zeta(l`linea')
			matrix pob_tn [`j'+`alpha',`i'-2001]=r(fgt)
		}

		local j=`j'+3

	}

	*13 CIUDADES PRINCIPALES Y ÁREAS METROPOLITANAS*

	local j=1
	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			fgt ingpcug [w=fex_c] if (ciudad!=.), alpha(`alpha') zeta(l`linea')
			matrix pob_tn [`j'+`alpha',`i'-2001]=r(fgt)
		}

		local j=`j'+3
	
	}


	*RESTO URBANO*

	local j=1
	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			fgt ingpcug [w=fex_c] if (dominio!="RURAL" & ciudad==.), alpha(`alpha') zeta(l`linea')
			matrix pob_tn [`j'+`alpha',`i'-2001]=r(fgt)
		}

		local j=`j'+3

	}

	*RURAL*

	local j=1
	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			fgt ingpcug [w=fex_c] if (dominio=="RURAL"), alpha(`alpha') zeta(l`linea')
			matrix pob_tn [`j'+`alpha',`i'-2001]=r(fgt)
		}

		local j=`j'+3
	
	}

}

foreach area of newlist tn urb resturb rur {
	preserve
	drop _all
	svmat pob_`area'
	export excel using "$results/FGT/FGT_`area'.xlsx", sheet("FGT_`area'", modify) firstrow(variables)
	restore
}


*##############################################################################*
* SIGNIFICATIVIDAD ESTADÍSTICA DE LOS CAMBIOS EN LA POBREZA E INDIGENCIA *
*##############################################################################*


use "$data/Base", clear
set seed 12345

*TOTAL NACIONAL*

forvalues alpha=0(1)2 {

	foreach linea of newlist p i {

		foreach i of numlist 2002 2005 2008 2015 2018 {
			preserve
			keep if (year==`i')
			bootstrap r(fgt), reps(500) seed(12345): fgt_bs ipcug, alpha(`alpha') zeta(l`linea') weight(fex_c)
			restore
		}

	}

}

*13 CIUDADES PRINCIPALES Y ÁREAS METROPOLITANAS*

forvalues alpha=0(1)2 {

	foreach linea of newlist p i {

		foreach i of numlist 2002 2005 2008 2015 2018 {
			preserve
			keep if (year==`i' & ciudad!=.)
			bootstrap r(fgt), reps(500) seed(12345): fgt_bs ipcug, alpha(`alpha') zeta(l`linea') weight(fex_c)
			restore
		}

	}

}

*RESTO URBANO*

forvalues alpha=0(1)2 {

	foreach linea of newlist p i {

		foreach i of numlist 2002 2005 2008 2015 2018 {
			preserve
			keep if (year==`i' & dominio!="RURAL" & ciudad==.)
			bootstrap r(fgt), reps(500) seed(12345): fgt_bs ipcug, alpha(`alpha') zeta(l`linea') weight(fex_c)
			restore
		}

	}

}

*RURAL*

forvalues alpha=0(1)2 {

	foreach linea of newlist p i {

		foreach i of numlist 2002 2005 2008 2015 2018 {
			preserve
			keep if (year==`i' & dominio=="RURAL")
			bootstrap r(fgt), reps(500) seed(12345): fgt_bs ipcug, alpha(`alpha') zeta(l`linea') weight(fex_c)
			restore
		}

	}

}


*##############################################################################*
* PARTICIPACIÓN DE CADA ÁREA EN LA POBREZA E INDIGENCIA *
*##############################################################################*


matrix define   poblacion = J(4,17,.)
matrix rownames poblacion = "tn" "urb" "resturb" "rur"
matrix colnames poblacion = "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018"

foreach i of numlist 2002 2003 2004 2005 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 {

	use "$data/prepara_base/Base_`i'_n", clear

	*TOTAL NACIONAL*

	summarize id [w=fex_c] if (year==`i')
	matrix poblacion [1,`i'-2001]=r(sum_w)

	*13 CIUDADES PRINCIPALES Y ÁREAS METROPOLITANAS*

	summarize id [w=fex_c] if (year==`i' & ciudad!=.)
	matrix poblacion [2,`i'-2001]=r(sum_w)

	*RESTO URBANO*

	summarize id [w=fex_c] if (year==`i' & dominio!="RURAL" & ciudad==.)
	matrix poblacion [3,`i'-2001]=r(sum_w)

	*RURAL*

	summarize id [w=fex_c] if (year==`i' & dominio=="RURAL")
	matrix poblacion [4,`i'-2001]=r(sum_w)

}

preserve
drop _all
svmat poblacion
export excel using "$results/FGT/Población.xlsx", sheet("Población", modify) firstrow(variables)
restore


*##############################################################################*
* DESIGUALDAD *
*##############################################################################*


matrix define   gini = J(4,17,.)
matrix rownames gini = "tn" "urb" "resturb" "rur"
matrix colnames gini = "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018"

foreach i of numlist 2002 2003 2004 2005 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 {

	use "$data/prepara_base/Base_`i'_n", clear

	*TOTAL NACIONAL*

	gini ingpcug [w=fex_c]
	matrix gini [1,`i'-2001]=r(gini)

	*13 CIUDADES PRINCIPALES Y ÁREAS METROPOLITANAS*

	gini ingpcug [w=fex_c] if (ciudad!=.)
	matrix gini [2,`i'-2001]=r(gini)

	*RESTO URBANO*

	gini ingpcug [w=fex_c] if (dominio!="RURAL" & ciudad==.)
	matrix gini [3,`i'-2001]=r(gini)

	*RURAL*

	gini ingpcug [w=fex_c] if (dominio=="RURAL")
	matrix gini [4,`i'-2001]=r(gini)

}

preserve
drop _all
svmat gini
export excel using "$results/Gini/Gini.xlsx", sheet("Gini", modify) firstrow(variables)
restore


*##############################################################################*
* DISTRIBUCIONES DEL INGRESO PER CÁPITA DE LA UNIDAD DE GASTO (ipcug) *
*##############################################################################*


use "$data/Base", clear

foreach i of numlist 2002 2018 {
	summarize lp [w=fex_c] if (year==`i')
	local lp_tn_`i'=r(mean)
	local log_lp_tn_`i'=log(`lp_tn_`i'')
	summarize lp [w=fex_c] if (year==`i' & ciudad!=.)
	local lp_urb_`i'=r(mean)
	local log_lp_urb_`i'=log(`lp_urb_`i'')
	summarize lp [w=fex_c] if (year==`i' & dominio!="RURAL" & ciudad==.)
	local lp_resturb_`i'=r(mean)
	local log_lp_resturb_`i'=log(`lp_resturb_`i'')
	summarize lp [w=fex_c] if (year==`i' & dominio=="RURAL")
	local lp_rur_`i'=r(mean)
	local log_lp_rur_`i'=log(`lp_rur_`i'')
}

foreach area of newlist tn urb resturb rur {
	local lp_`area'_02_18=`lp_`area'_2018'/`lp_`area'_2002'
}

generate ipcug_real=ipcug
replace ipcug_real=ipcug*`lp_urb_02_18'     if (year==2002 & ciudad!=.)
replace ipcug_real=ipcug*`lp_resturb_02_18' if (year==2002 & dominio!="RURAL" & ciudad==.)
replace ipcug_real=ipcug*`lp_rur_02_18'     if (year==2002 & dominio=="RURAL")

generate lipcug_real=log(ipcug_real)

graph twoway	(kdensity lipcug_real if (year==2002), lcolor(black)) ///
				(kdensity lipcug_real if (year==2018), lcolor(black)), ///
				title("Total nacional", color(black)) ytitle("Densidad") xtitle("Logaritmo del IPCUG") xline(`log_lp_tn_2018', lcolor(red)) ///
				legend(label(1 "2002") label(2 "2018"))

graph twoway	(kdensity lipcug_real if (year==2002 & ciudad!=.), lcolor(black)) ///
				(kdensity lipcug_real if (year==2018 & ciudad!=.), lcolor(black)), ///
				title("Principales ciudades", color(black)) ytitle("Densidad") xtitle("Logaritmo del IPCUG") xline(`log_lp_urb_2018', lcolor(red)) ///
				legend(label(1 "2002") label(2 "2018"))

graph twoway	(kdensity lipcug_real if (year==2002 & dominio!="RURAL" & ciudad==.), lcolor(black)) ///
				(kdensity lipcug_real if (year==2018 & dominio!="RURAL" & ciudad==.), lcolor(black)), ///
				title("Resto urbano", color(black)) ytitle("Densidad") xtitle("Logaritmo del IPCUG") xline(`log_lp_resturb_2018', lcolor(red)) ///
				legend(label(1 "2002") label(2 "2018"))

graph twoway	(kdensity lipcug_real if (year==2002 & dominio=="RURAL"), lcolor(black)) ///
				(kdensity lipcug_real if (year==2018 & dominio=="RURAL"), lcolor(black)), ///
				title("Rural", color(black)) ytitle("Densidad") xtitle("Logaritmo del IPCUG") xline(`log_lp_rur_2018', lcolor(red)) ///
				legend(label(1 "2002") label(2 "2018"))


*##############################################################################*
* COMBINACIÓN ENTRE KOLENIKOV Y SHORROCKS (2005) Y DINARDO et al. (1996) *
*##############################################################################*


*AÑOS 2002-2018*

	*TOTAL NACIONAL*

	use "$data/Base", clear
	keep if (year==2002 | year==2018)
	keep year fex_c dominio ipcug lp li miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ayudas_hog

	do "$dofiles/KS-DN/KS-DN" "2002" "2018"

	foreach fgt of newlist fgt0 fgt1 fgt2 {

		foreach linea of newlist p i {
			preserve
			drop _all
			svmat KS_DN_`fgt'_`linea'
			rename (KS_DN_`fgt'_`linea'1 KS_DN_`fgt'_`linea'2 KS_DN_`fgt'_`linea'3 KS_DN_`fgt'_`linea'4) (Crecimiento Redistribución Línea Total)
			export excel using "$results/KS-DN/KS-DN_`fgt'_`linea'_tn_2002-2018.xlsx", sheet("KS-DN_`fgt'_`linea'_tn_2002-2018", modify) firstrow(variables)
			save "$results/KS-DN/KS-DN_`fgt'_`linea'_tn_2002-2018", replace
			restore
		}

	}

	foreach fgt of newlist fgt0 fgt1 fgt2 {

		foreach linea of newlist p i {

			foreach i of newlist ob EC EE {
				matrix define   BKS_`fgt'_`linea'_`i' = J(500,4,.)
				matrix colnames BKS_`fgt'_`linea'_`i' = "Crecimiento" "Redistribución" "Línea" "Total"
			}

		}

	}

	forvalues i=1(1)500 {

		timer on 1
		preserve
		bsample, strata(year) weight(fex_c)
		quietly do "$dofiles/KS-DN/KS-DN" "2002" "2018"
		display "`i' " _continue

		foreach fgt of newlist fgt0 fgt1 fgt2 {

			foreach linea of newlist p i {

				forvalues j=1(1)4 {
					matrix BKS_`fgt'_`linea'_ob [`i',`j']=KS_`fgt'_`linea'_ob[1,`j']
					matrix BKS_`fgt'_`linea'_EC [`i',`j']=KS_`fgt'_`linea'_EC[1,`j']
					matrix BKS_`fgt'_`linea'_EE [`i',`j']=KS_`fgt'_`linea'_EE[1,`j']
				}

			}

		}

		restore
		timer off 1

	}

	foreach fgt of newlist fgt0 fgt1 fgt2 {

		foreach linea of newlist p i {

			foreach i of newlist ob EC EE {
				preserve
				drop _all
				svmat BKS_`fgt'_`linea'_`i'
				rename (BKS_`fgt'_`linea'_`i'1 BKS_`fgt'_`linea'_`i'2 BKS_`fgt'_`linea'_`i'3 BKS_`fgt'_`linea'_`i'4) (Crecimiento Redistribución Línea Total)
				export excel using "$results/KS-DN/BKS_`fgt'_`linea'_tn_`i'_2002-2018.xlsx", sheet("BKS_`fgt'_`linea'_tn_`i'_2002-2018", modify) firstrow(variables)
				save "$results/KS-DN/BKS_`fgt'_`linea'_tn_`i'_2002-2018", replace
				restore
			}

		}

	}

	*13 CIUDADES PRINCIPALES Y ÁREAS METROPOLITANAS*

	use "$data/Base", clear
	keep if ((year==2002 | year==2018) & ciudad!=.)
	keep year fex_c dominio ipcug lp li miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ayudas_hog

	do "$dofiles/KS-DN/KS-DN" "2002" "2018"

	foreach fgt of newlist fgt0 fgt1 fgt2 {

		foreach linea of newlist p i {
			preserve
			drop _all
			svmat KS_DN_`fgt'_`linea'
			rename (KS_DN_`fgt'_`linea'1 KS_DN_`fgt'_`linea'2 KS_DN_`fgt'_`linea'3 KS_DN_`fgt'_`linea'4) (Crecimiento Redistribución Línea Total)
			export excel using "$results/KS-DN/KS-DN_`fgt'_`linea'_urb_2002-2018.xlsx", sheet("KS-DN_`fgt'_`linea'_urb_2002-2018", modify) firstrow(variables)
			save "$results/KS-DN/KS-DN_`fgt'_`linea'_urb_2002-2018", replace
			restore
		}

	}

	foreach fgt of newlist fgt0 fgt1 fgt2 {

		foreach linea of newlist p i {

			foreach i of newlist ob EC EE {
				matrix define   BKS_`fgt'_`linea'_`i' = J(500,4,.)
				matrix colnames BKS_`fgt'_`linea'_`i' = "Crecimiento" "Redistribución" "Línea" "Total"
			}

		}

	}

	forvalues i=1(1)500 {

		timer on 2
		preserve
		bsample, strata(year) weight(fex_c)
		quietly do "$dofiles/KS-DN/KS-DN" "2002" "2018"
		display "`i' " _continue

		foreach fgt of newlist fgt0 fgt1 fgt2 {

			foreach linea of newlist p i {

				forvalues j=1(1)4 {
					matrix BKS_`fgt'_`linea'_ob [`i',`j']=KS_`fgt'_`linea'_ob[1,`j']
					matrix BKS_`fgt'_`linea'_EC [`i',`j']=KS_`fgt'_`linea'_EC[1,`j']
					matrix BKS_`fgt'_`linea'_EE [`i',`j']=KS_`fgt'_`linea'_EE[1,`j']
				}

			}

		}

		restore
		timer off 2

	}

	foreach fgt of newlist fgt0 fgt1 fgt2 {

		foreach linea of newlist p i {

			foreach i of newlist ob EC EE {
				preserve
				drop _all
				svmat BKS_`fgt'_`linea'_`i'
				rename (BKS_`fgt'_`linea'_`i'1 BKS_`fgt'_`linea'_`i'2 BKS_`fgt'_`linea'_`i'3 BKS_`fgt'_`linea'_`i'4) (Crecimiento Redistribución Línea Total)
				export excel using "$results/KS-DN/BKS_`fgt'_`linea'_urb_`i'_2002-2018.xlsx", sheet("BKS_`fgt'_`linea'_urb_`i'_2002-2018", modify) firstrow(variables)
				save "$results/KS-DN/BKS_`fgt'_`linea'_urb_`i'_2002-2018", replace
				restore
			}

		}

	}

	*RESTO URBANO*

	use "$data/Base", clear
	keep if ((year==2002 | year==2018) & (dominio!="RURAL" & ciudad==.))
	keep year fex_c dominio ipcug lp li miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ayudas_hog

	do "$dofiles/KS-DN/KS-DN" "2002" "2018"

	foreach fgt of newlist fgt0 fgt1 fgt2 {

		foreach linea of newlist p i {
			preserve
			drop _all
			svmat KS_DN_`fgt'_`linea'
			rename (KS_DN_`fgt'_`linea'1 KS_DN_`fgt'_`linea'2 KS_DN_`fgt'_`linea'3 KS_DN_`fgt'_`linea'4) (Crecimiento Redistribución Línea Total)
			export excel using "$results/KS-DN/KS-DN_`fgt'_`linea'_resturb_2002-2018.xlsx", sheet("KS-DN_`fgt'_`linea'_resturb_2002-2018", modify) firstrow(variables)
			save "$results/KS-DN/KS-DN_`fgt'_`linea'_resturb_2002-2018", replace
			restore
		}

	}

	foreach fgt of newlist fgt0 fgt1 fgt2 {

		foreach linea of newlist p i {

			foreach i of newlist ob EC EE {
				matrix define   BKS_`fgt'_`linea'_`i' = J(500,4,.)
				matrix colnames BKS_`fgt'_`linea'_`i' = "Crecimiento" "Redistribución" "Línea" "Total"
			}

		}

	}

	forvalues i=1(1)500 {

		timer on 3
		preserve
		bsample, strata(year) weight(fex_c)
		quietly do "$dofiles/KS-DN/KS-DN" "2002" "2018"
		display "`i' " _continue

		foreach fgt of newlist fgt0 fgt1 fgt2 {

			foreach linea of newlist p i {

				forvalues j=1(1)4 {
					matrix BKS_`fgt'_`linea'_ob [`i',`j']=KS_`fgt'_`linea'_ob[1,`j']
					matrix BKS_`fgt'_`linea'_EC [`i',`j']=KS_`fgt'_`linea'_EC[1,`j']
					matrix BKS_`fgt'_`linea'_EE [`i',`j']=KS_`fgt'_`linea'_EE[1,`j']
				}

			}

		}

		restore
		timer off 3

	}

	foreach fgt of newlist fgt0 fgt1 fgt2 {

		foreach linea of newlist p i {

			foreach i of newlist ob EC EE {
				preserve
				drop _all
				svmat BKS_`fgt'_`linea'_`i'
				rename (BKS_`fgt'_`linea'_`i'1 BKS_`fgt'_`linea'_`i'2 BKS_`fgt'_`linea'_`i'3 BKS_`fgt'_`linea'_`i'4) (Crecimiento Redistribución Línea Total)
				export excel using "$results/KS-DN/BKS_`fgt'_`linea'_resturb_`i'_2002-2018.xlsx", sheet("BKS_`fgt'_`linea'_resturb_`i'_2002-2018", modify) firstrow(variables)
				save "$results/KS-DN/BKS_`fgt'_`linea'_resturb_`i'_2002-2018", replace
				restore
			}

		}

	}

	*RURAL*

	use "$data/Base", clear
	keep if ((year==2002 | year==2018) & dominio=="RURAL")
	keep year fex_c dominio ipcug lp li miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ayudas_hog

	do "$dofiles/KS-DN/KS-DN" "2002" "2018"

	foreach fgt of newlist fgt0 fgt1 fgt2 {

		foreach linea of newlist p i {
			preserve
			drop _all
			svmat KS_DN_`fgt'_`linea'
			rename (KS_DN_`fgt'_`linea'1 KS_DN_`fgt'_`linea'2 KS_DN_`fgt'_`linea'3 KS_DN_`fgt'_`linea'4) (Crecimiento Redistribución Línea Total)
			export excel using "$results/KS-DN/KS-DN_`fgt'_`linea'_rur_2002-2018.xlsx", sheet("KS-DN_`fgt'_`linea'_rur_2002-2018", modify) firstrow(variables)
			save "$results/KS-DN/KS-DN_`fgt'_`linea'_rur_2002-2018", replace
			restore
		}

	}

	foreach fgt of newlist fgt0 fgt1 fgt2 {

		foreach linea of newlist p i {

			foreach i of newlist ob EC EE {
				matrix define   BKS_`fgt'_`linea'_`i' = J(500,4,.)
				matrix colnames BKS_`fgt'_`linea'_`i' = "Crecimiento" "Redistribución" "Línea" "Total"
			}

		}

	}

	forvalues i=1(1)500 {

		timer on 4
		preserve
		bsample, strata(year) weight(fex_c)
		quietly do "$dofiles/KS-DN/KS-DN" "2002" "2018"
		display "`i' " _continue

		foreach fgt of newlist fgt0 fgt1 fgt2 {

			foreach linea of newlist p i {

				forvalues j=1(1)4 {
					matrix BKS_`fgt'_`linea'_ob [`i',`j']=KS_`fgt'_`linea'_ob[1,`j']
					matrix BKS_`fgt'_`linea'_EC [`i',`j']=KS_`fgt'_`linea'_EC[1,`j']
					matrix BKS_`fgt'_`linea'_EE [`i',`j']=KS_`fgt'_`linea'_EE[1,`j']
				}

			}

		}

		restore
		timer off 4

	}

	foreach fgt of newlist fgt0 fgt1 fgt2 {

		foreach linea of newlist p i {

			foreach i of newlist ob EC EE {
				preserve
				drop _all
				svmat BKS_`fgt'_`linea'_`i'
				rename (BKS_`fgt'_`linea'_`i'1 BKS_`fgt'_`linea'_`i'2 BKS_`fgt'_`linea'_`i'3 BKS_`fgt'_`linea'_`i'4) (Crecimiento Redistribución Línea Total)
				export excel using "$results/KS-DN/BKS_`fgt'_`linea'_rur_`i'_2002-2018.xlsx", sheet("BKS_`fgt'_`linea'_rur_`i'_2002-2018", modify) firstrow(variables)
				save "$results/KS-DN/BKS_`fgt'_`linea'_rur_`i'_2002-2018", replace
				restore
			}

		}

	}

*AÑOS 2005-2015*

	*TOTAL NACIONAL*

	use "$data/Base", clear
	keep if (year==2005 | year==2015)
	keep year fex_c dominio ipcug lp li miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ayudas_hog

	do "$dofiles/KS-DN/KS-DN" "2005" "2015"

	foreach fgt of newlist fgt0 fgt1 fgt2 {

		foreach linea of newlist p i {
			preserve
			drop _all
			svmat KS_DN_`fgt'_`linea'
			rename (KS_DN_`fgt'_`linea'1 KS_DN_`fgt'_`linea'2 KS_DN_`fgt'_`linea'3 KS_DN_`fgt'_`linea'4) (Crecimiento Redistribución Línea Total)
			export excel using "$results/KS-DN/KS-DN_`fgt'_`linea'_tn_2005-2015.xlsx", sheet("KS-DN_`fgt'_`linea'_tn_2005-2015", modify) firstrow(variables)
			save "$results/KS-DN/KS-DN_`fgt'_`linea'_tn_2005-2015", replace
			restore
		}

	}

	foreach fgt of newlist fgt0 fgt1 fgt2 {

		foreach linea of newlist p i {

			foreach i of newlist ob EC EE {
				matrix define   BKS_`fgt'_`linea'_`i' = J(500,4,.)
				matrix colnames BKS_`fgt'_`linea'_`i' = "Crecimiento" "Redistribución" "Línea" "Total"
			}

		}

	}

	forvalues i=1(1)500 {

		timer on 5
		preserve
		bsample, strata(year) weight(fex_c)
		quietly do "$dofiles/KS-DN/KS-DN" "2005" "2015"
		display "`i' " _continue

		foreach fgt of newlist fgt0 fgt1 fgt2 {

			foreach linea of newlist p i {

				forvalues j=1(1)4 {
					matrix BKS_`fgt'_`linea'_ob [`i',`j']=KS_`fgt'_`linea'_ob[1,`j']
					matrix BKS_`fgt'_`linea'_EC [`i',`j']=KS_`fgt'_`linea'_EC[1,`j']
					matrix BKS_`fgt'_`linea'_EE [`i',`j']=KS_`fgt'_`linea'_EE[1,`j']
				}

			}

		}

		restore
		timer off 5

	}

	foreach fgt of newlist fgt0 fgt1 fgt2 {

		foreach linea of newlist p i {

			foreach i of newlist ob EC EE {
				preserve
				drop _all
				svmat BKS_`fgt'_`linea'_`i'
				rename (BKS_`fgt'_`linea'_`i'1 BKS_`fgt'_`linea'_`i'2 BKS_`fgt'_`linea'_`i'3 BKS_`fgt'_`linea'_`i'4) (Crecimiento Redistribución Línea Total)
				export excel using "$results/KS-DN/BKS_`fgt'_`linea'_tn_`i'_2005-2015.xlsx", sheet("BKS_`fgt'_`linea'_tn_`i'_2005-2015", modify) firstrow(variables)
				save "$results/KS-DN/BKS_`fgt'_`linea'_tn_`i'_2005-2015", replace
				restore
			}

		}

	}

	*13 CIUDADES PRINCIPALES Y ÁREAS METROPOLITANAS*

	use "$data/Base", clear
	keep if ((year==2005 | year==2015) & ciudad!=.)
	keep year fex_c dominio ipcug lp li miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ayudas_hog

	do "$dofiles/KS-DN/KS-DN" "2005" "2015"

	foreach fgt of newlist fgt0 fgt1 fgt2 {

		foreach linea of newlist p i {
			preserve
			drop _all
			svmat KS_DN_`fgt'_`linea'
			rename (KS_DN_`fgt'_`linea'1 KS_DN_`fgt'_`linea'2 KS_DN_`fgt'_`linea'3 KS_DN_`fgt'_`linea'4) (Crecimiento Redistribución Línea Total)
			export excel using "$results/KS-DN/KS-DN_`fgt'_`linea'_urb_2005-2015.xlsx", sheet("KS-DN_`fgt'_`linea'_urb_2005-2015", modify) firstrow(variables)
			save "$results/KS-DN/KS-DN_`fgt'_`linea'_urb_2005-2015", replace
			restore
		}

	}

	foreach fgt of newlist fgt0 fgt1 fgt2 {

		foreach linea of newlist p i {

			foreach i of newlist ob EC EE {
				matrix define   BKS_`fgt'_`linea'_`i' = J(500,4,.)
				matrix colnames BKS_`fgt'_`linea'_`i' = "Crecimiento" "Redistribución" "Línea" "Total"
			}

		}

	}

	forvalues i=1(1)500 {

		timer on 6
		preserve
		bsample, strata(year) weight(fex_c)
		quietly do "$dofiles/KS-DN/KS-DN" "2005" "2015"
		display "`i' " _continue

		foreach fgt of newlist fgt0 fgt1 fgt2 {

			foreach linea of newlist p i {

				forvalues j=1(1)4 {
					matrix BKS_`fgt'_`linea'_ob [`i',`j']=KS_`fgt'_`linea'_ob[1,`j']
					matrix BKS_`fgt'_`linea'_EC [`i',`j']=KS_`fgt'_`linea'_EC[1,`j']
					matrix BKS_`fgt'_`linea'_EE [`i',`j']=KS_`fgt'_`linea'_EE[1,`j']
				}

			}

		}

		restore
		timer off 6

	}

	foreach fgt of newlist fgt0 fgt1 fgt2 {

		foreach linea of newlist p i {

			foreach i of newlist ob EC EE {
				preserve
				drop _all
				svmat BKS_`fgt'_`linea'_`i'
				rename (BKS_`fgt'_`linea'_`i'1 BKS_`fgt'_`linea'_`i'2 BKS_`fgt'_`linea'_`i'3 BKS_`fgt'_`linea'_`i'4) (Crecimiento Redistribución Línea Total)
				export excel using "$results/KS-DN/BKS_`fgt'_`linea'_urb_`i'_2005-2015.xlsx", sheet("BKS_`fgt'_`linea'_urb_`i'_2005-2015", modify) firstrow(variables)
				save "$results/KS-DN/BKS_`fgt'_`linea'_urb_`i'_2005-2015", replace
				restore
			}

		}

	}

	*RESTO URBANO*

	use "$data/Base", clear
	keep if ((year==2005 | year==2015) & (dominio!="RURAL" & ciudad==.))
	keep year fex_c dominio ipcug lp li miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ayudas_hog

	do "$dofiles/KS-DN/KS-DN" "2005" "2015"

	foreach fgt of newlist fgt0 fgt1 fgt2 {

		foreach linea of newlist p i {
			preserve
			drop _all
			svmat KS_DN_`fgt'_`linea'
			rename (KS_DN_`fgt'_`linea'1 KS_DN_`fgt'_`linea'2 KS_DN_`fgt'_`linea'3 KS_DN_`fgt'_`linea'4) (Crecimiento Redistribución Línea Total)
			export excel using "$results/KS-DN/KS-DN_`fgt'_`linea'_resturb_2005-2015.xlsx", sheet("KS-DN_`fgt'_`linea'_resturb_2005-2015", modify) firstrow(variables)
			save "$results/KS-DN/KS-DN_`fgt'_`linea'_resturb_2005-2015", replace
			restore
		}

	}

	foreach fgt of newlist fgt0 fgt1 fgt2 {

		foreach linea of newlist p i {

			foreach i of newlist ob EC EE {
				matrix define   BKS_`fgt'_`linea'_`i' = J(500,4,.)
				matrix colnames BKS_`fgt'_`linea'_`i' = "Crecimiento" "Redistribución" "Línea" "Total"
			}

		}

	}

	forvalues i=1(1)500 {

		timer on 7
		preserve
		bsample, strata(year) weight(fex_c)
		quietly do "$dofiles/KS-DN/KS-DN" "2005" "2015"
		display "`i' " _continue

		foreach fgt of newlist fgt0 fgt1 fgt2 {

			foreach linea of newlist p i {

				forvalues j=1(1)4 {
					matrix BKS_`fgt'_`linea'_ob [`i',`j']=KS_`fgt'_`linea'_ob[1,`j']
					matrix BKS_`fgt'_`linea'_EC [`i',`j']=KS_`fgt'_`linea'_EC[1,`j']
					matrix BKS_`fgt'_`linea'_EE [`i',`j']=KS_`fgt'_`linea'_EE[1,`j']
				}

			}

		}

		restore
		timer off 7

	}

	foreach fgt of newlist fgt0 fgt1 fgt2 {

		foreach linea of newlist p i {

			foreach i of newlist ob EC EE {
				preserve
				drop _all
				svmat BKS_`fgt'_`linea'_`i'
				rename (BKS_`fgt'_`linea'_`i'1 BKS_`fgt'_`linea'_`i'2 BKS_`fgt'_`linea'_`i'3 BKS_`fgt'_`linea'_`i'4) (Crecimiento Redistribución Línea Total)
				export excel using "$results/KS-DN/BKS_`fgt'_`linea'_resturb_`i'_2005-2015.xlsx", sheet("BKS_`fgt'_`linea'_resturb_`i'_2005-2015", modify) firstrow(variables)
				save "$results/KS-DN/BKS_`fgt'_`linea'_resturb_`i'_2005-2015", replace
				restore
			}

		}

	}

	*RURAL*

	use "$data/Base", clear
	keep if ((year==2005 | year==2015) & dominio=="RURAL")
	keep year fex_c dominio ipcug lp li miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ayudas_hog

	do "$dofiles/KS-DN/KS-DN" "2005" "2015"

	foreach fgt of newlist fgt0 fgt1 fgt2 {

		foreach linea of newlist p i {
			preserve
			drop _all
			svmat KS_DN_`fgt'_`linea'
			rename (KS_DN_`fgt'_`linea'1 KS_DN_`fgt'_`linea'2 KS_DN_`fgt'_`linea'3 KS_DN_`fgt'_`linea'4) (Crecimiento Redistribución Línea Total)
			export excel using "$results/KS-DN/KS-DN_`fgt'_`linea'_rur_2005-2015.xlsx", sheet("KS-DN_`fgt'_`linea'_rur_2005-2015", modify) firstrow(variables)
			save "$results/KS-DN/KS-DN_`fgt'_`linea'_rur_2005-2015", replace
			restore
		}

	}

	foreach fgt of newlist fgt0 fgt1 fgt2 {

		foreach linea of newlist p i {

			foreach i of newlist ob EC EE {
				matrix define   BKS_`fgt'_`linea'_`i' = J(500,4,.)
				matrix colnames BKS_`fgt'_`linea'_`i' = "Crecimiento" "Redistribución" "Línea" "Total"
			}

		}

	}

	forvalues i=1(1)500 {

		timer on 8
		preserve
		bsample, strata(year) weight(fex_c)
		quietly do "$dofiles/KS-DN/KS-DN" "2005" "2015"
		display "`i' " _continue

		foreach fgt of newlist fgt0 fgt1 fgt2 {

			foreach linea of newlist p i {

				forvalues j=1(1)4 {
					matrix BKS_`fgt'_`linea'_ob [`i',`j']=KS_`fgt'_`linea'_ob[1,`j']
					matrix BKS_`fgt'_`linea'_EC [`i',`j']=KS_`fgt'_`linea'_EC[1,`j']
					matrix BKS_`fgt'_`linea'_EE [`i',`j']=KS_`fgt'_`linea'_EE[1,`j']
				}

			}

		}

		restore
		timer off 8

	}

	foreach fgt of newlist fgt0 fgt1 fgt2 {

		foreach linea of newlist p i {

			foreach i of newlist ob EC EE {
				preserve
				drop _all
				svmat BKS_`fgt'_`linea'_`i'
				rename (BKS_`fgt'_`linea'_`i'1 BKS_`fgt'_`linea'_`i'2 BKS_`fgt'_`linea'_`i'3 BKS_`fgt'_`linea'_`i'4) (Crecimiento Redistribución Línea Total)
				export excel using "$results/KS-DN/BKS_`fgt'_`linea'_rur_`i'_2005-2015.xlsx", sheet("BKS_`fgt'_`linea'_rur_`i'_2005-2015", modify) firstrow(variables)
				save "$results/KS-DN/BKS_`fgt'_`linea'_rur_`i'_2005-2015", replace
				restore
			}

		}

	}

timer list


*##############################################################################*
* DESCOMPOSICIÓN RIF *
*##############################################################################*


*ssc install rif    , replace
*ssc install oaxaca , replace
*ssc install reghdfe, replace

use "$data/Base", clear
keep if (year==2002 | year==2018)

generate year_d=.
replace year_d=0 if (year==2018)
replace year_d=1 if (year==2002)

*Contrafactual X1*B2, entonces, DX=(X1-X2)*B2 (efecto composición) y DB=X1*(B1-B2) (efecto estructura)*

	*TOTAL NACIONAL*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			oaxaca_rif	ipcug 	miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ing_nolab_hog ayudas_hog [pw=fex_c], ///
						rwlogit(miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ing_nolab_hog ayudas_hog) ///
						by(year_d) rif(pov(`alpha') pline(l`linea')) wgt(0)
			outreg2 using "$results/RIF/RIF_FGT`alpha'_`linea'_tn_wgt0.xls", replace dec(3)
		}

	}

	*13 CIUDADES PRINCIPALES Y ÁREAS METROPOLITANAS*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			oaxaca_rif	ipcug 	miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ing_nolab_hog ayudas_hog [pw=fex_c] ///
						if (ciudad!=.), ///
						rwlogit(miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ing_nolab_hog ayudas_hog) ///
						by(year_d) rif(pov(`alpha') pline(l`linea')) wgt(0)
			outreg2 using "$results/RIF/RIF_FGT`alpha'_`linea'_urb_wgt0.xls", replace dec(3)
		}

	}

	*RESTO URBANO*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			oaxaca_rif	ipcug 	miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ing_nolab_hog ayudas_hog [pw=fex_c] ///
						if (dominio!="RURAL" & ciudad==.), ///
						rwlogit(miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ing_nolab_hog ayudas_hog) ///
						by(year_d) rif(pov(`alpha') pline(l`linea')) wgt(0)
			outreg2 using "$results/RIF/RIF_FGT`alpha'_`linea'_resturb_wgt0.xls", replace dec(3)
		}

	}

	*RURAL*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			oaxaca_rif	ipcug 	miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ing_nolab_hog ayudas_hog [pw=fex_c] ///
						if (dominio=="RURAL"), ///
						rwlogit(miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ing_nolab_hog ayudas_hog) ///
						by(year_d) rif(pov(`alpha') pline(l`linea')) wgt(0)
			outreg2 using "$results/RIF/RIF_FGT`alpha'_`linea'_rur_wgt0.xls", replace dec(3)
		}

	}

*Contrafactual X2*B1, entonces, DX=(X1-X2)*B1 (efecto composición) y DB=X2*(B1-B2) (efecto estructura)*

	*TOTAL NACIONAL*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			oaxaca_rif	ipcug 	miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ing_nolab_hog ayudas_hog [pw=fex_c], ///
						rwlogit(miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ing_nolab_hog ayudas_hog) ///
						by(year_d) rif(pov(`alpha') pline(l`linea')) wgt(1)
			outreg2 using "$results/RIF/RIF_FGT`alpha'_`linea'_tn_wgt1.xls", replace dec(3)
		}

	}

	*13 CIUDADES PRINCIPALES Y ÁREAS METROPOLITANAS*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			oaxaca_rif	ipcug 	miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ing_nolab_hog ayudas_hog [pw=fex_c] ///
						if (ciudad!=.), ///
						rwlogit(miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ing_nolab_hog ayudas_hog) ///
						by(year_d) rif(pov(`alpha') pline(l`linea')) wgt(1)
			outreg2 using "$results/RIF/RIF_FGT`alpha'_`linea'_urb_wgt1.xls", replace dec(3)
		}

	}

	*RESTO URBANO*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			oaxaca_rif	ipcug 	miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ing_nolab_hog ayudas_hog [pw=fex_c] ///
						if (dominio!="RURAL" & ciudad==.), ///
						rwlogit(miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ing_nolab_hog ayudas_hog) ///
						by(year_d) rif(pov(`alpha') pline(l`linea')) wgt(1)
			outreg2 using "$results/RIF/RIF_FGT`alpha'_`linea'_resturb_wgt1.xls", replace dec(3)
		}

	}

	*RURAL*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			oaxaca_rif	ipcug 	miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ing_nolab_hog ayudas_hog [pw=fex_c] ///
						if (dominio=="RURAL"), ///
						rwlogit(miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ing_nolab_hog ayudas_hog) ///
						by(year_d) rif(pov(`alpha') pline(l`linea')) wgt(1)
			outreg2 using "$results/RIF/RIF_FGT`alpha'_`linea'_rur_wgt1.xls", replace dec(3)
		}

	}
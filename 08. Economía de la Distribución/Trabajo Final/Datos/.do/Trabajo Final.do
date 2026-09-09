clear all
set more off
set graphics off
version 16


*##############################################################################*
* CONFIGURACIÓN *
*##############################################################################*


*local disco="C:/"
local disco="G:/Mi unidad"
global dir     "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/8. Economía de la Distribución/Trabajo Final/Datos"
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
* INDIGENCIA NACIONAL 2018 SEGÚN LIP (1,9 USD PPA DE 2011, CON USD PPA 2011 IGUAL A COP 1.168,24) *
*##############################################################################*


use "$data/prepara_base/Base_2018_n", clear

local lip=1.9*1168.24*30
fgt ingpcug [w=fex_c], alpha(0) zeta(`lip')


*##############################################################################*
* CARACTERIZACIÓN ECONÓMICA Y SOCIODEMOGRÁFICA DE LOS HOGARES (COLOMBIA 2002-2018) *
*##############################################################################*


use "$data/Base", clear
keep if (year==2002 | year==2005 | year==2008 | year==2018)

foreach i of numlist 2002 2005 2008 2018 {
	summarize lp [w=fex_c] if (year==`i' & ciudad!=.)
	local lp_urb_`i'=r(mean)
	summarize lp [w=fex_c] if (year==`i' & dominio!="RURAL" & ciudad==.)
	local lp_resturb_`i'=r(mean)
	summarize lp [w=fex_c] if (year==`i' & dominio=="RURAL")
	local lp_rur_`i'=r(mean)
}

foreach area of newlist urb resturb rur {

	foreach i of numlist 2 5 8 {
		local lp_`area'_0`i'_18=`lp_`area'_2018'/`lp_`area'_200`i''
	}

}

generate ipcug_real=ipcug
foreach i of numlist 2 5 8 {
	replace ipcug_real=ipcug*`lp_urb_0`i'_18'     if (year==200`i' & ciudad!=.)
	replace ipcug_real=ipcug*`lp_resturb_0`i'_18' if (year==200`i' & dominio!="RURAL" & ciudad==.)
	replace ipcug_real=ipcug*`lp_rur_0`i'_18'     if (year==200`i' & dominio=="RURAL")
}

generate ing_nolab_hog_real=ing_nolab_hog
foreach i of numlist 2 5 8 {
	replace ing_nolab_hog_real=ing_nolab_hog*`lp_urb_0`i'_18'     if (year==200`i' & ciudad!=.)
	replace ing_nolab_hog_real=ing_nolab_hog*`lp_resturb_0`i'_18' if (year==200`i' & dominio!="RURAL" & ciudad==.)
	replace ing_nolab_hog_real=ing_nolab_hog*`lp_rur_0`i'_18'     if (year==200`i' & dominio=="RURAL")
}

foreach area of newlist tn urb resturb rur {
	matrix define   caract_`area' = J(26,17,.)
	matrix rownames caract_`area' =	"ipcug_real_m" "ipcug_real_sd" "ing_nolab_hog_real_m" "ing_nolab_hog_real_sd" "miembros_h_m" "miembros_h_sd" "p_muj_m" "p_muj_sd" ///
									"niños_hog_m" "niños_hog_sd" "educ_hog_m" "educ_hog_sd" "jefe_mujer_m" "jefe_mujer_sd" "jefe_edad_m" "jefe_edad_sd" ///
									"jefe_cp_m" "jefe_cp_sd" "t_plf_m" "t_plf_sd" "t_des_m" "t_des_sd" "t_inf_m" "t_inf_sd" "ayudas_hog_m" "ayudas_hog_sd"
	matrix colnames caract_`area' = "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018"
}

*TOTAL NACIONAL*

foreach i of numlist 2002 2005 2008 2018 {

	local j=1
	foreach var of varlist ipcug_real ing_nolab_hog_real miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des t_inf ayudas_hog {
		summarize `var' [w=fex_c] if (year==`i' & orden==1)
		matrix caract_tn [`j',`i'-2001]=r(mean)
		matrix caract_tn [`j'+1,`i'-2001]=r(sd)
		local j=`j'+2
	}

}

*13 CIUDADES PRINCIPALES Y ÁREAS METROPOLITANAS*

foreach i of numlist 2002 2005 2008 2018 {

	local j=1
	foreach var of varlist ipcug_real ing_nolab_hog_real miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des t_inf ayudas_hog {
		summarize `var' [w=fex_c] if (year==`i' & orden==1 & ciudad!=.)
		matrix caract_urb [`j',`i'-2001]=r(mean)
		matrix caract_urb [`j'+1,`i'-2001]=r(sd)
		local j=`j'+2
	}

}

*RESTO URBANO*

foreach i of numlist 2002 2005 2008 2018 {

	local j=1
	foreach var of varlist ipcug_real ing_nolab_hog_real miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des t_inf ayudas_hog {
		summarize `var' [w=fex_c] if (year==`i' & orden==1 & dominio!="RURAL" & ciudad==.)
		matrix caract_resturb [`j',`i'-2001]=r(mean)
		matrix caract_resturb [`j'+1,`i'-2001]=r(sd)
		local j=`j'+2
	}

}

*RURAL*

foreach i of numlist 2002 2005 2008 2018 {

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
* SERIES DE POBREZA E INDIGENCIA (COLOMBIA 2002-2018) *
*##############################################################################*


*POR ÁREA*

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

*POR CIUDAD*

foreach linea of newlist p i {

	foreach i of numlist 2002 2003 2004 2005 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 {

		use "$data/prepara_base/Base_`i'_n"

		forvalues j=1(1)13 {
			preserve
			keep if (ciudad==`j')
			povdeco5 ingpcug [w=fex_c], varpl(l`linea')
			generate FGT0_`i'=100*$S_FGT0
			generate FGT1_`i'=100*$S_FGT1
			generate FGT2_`i'=100*$S_FGT2
			keep FGT0_`i' FGT1_`i' FGT2_`i'
			collapse (median) FGT0_`i' FGT1_`i' FGT2_`i'
			save "$results/FGT/FGT_`linea'_c`j'_`i'", replace
			restore
		}

	}

}

foreach linea of newlist p i {

	foreach i of numlist 2002 2003 2004 2005 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 {

		use "$results/FGT/FGT_`linea'_c1_`i'", clear

		forvalues j=2(1)13 {
			append using "$results/FGT/FGT_`linea'_c`j'_`i'"
		}

		save "$results/FGT/FGT_`linea'_c_`i'", replace
		export excel using "$results/FGT/FGT_`linea'_c_`i'.xlsx", sheet("FGT_`linea'_c_`i'", modify) firstrow(variables)

	}

}


*##############################################################################*
* SIGNIFICATIVIDAD ESTADÍSTICA DE LOS CAMBIOS EN LA POBREZA E INDIGENCIA (COLOMBIA 2002-2018) *
*##############################################################################*


use "$data/Base", clear
set seed 12345

*POR ÁREA*

	*TOTAL NACIONAL*

	forvalues alpha=0(1)2 {

		foreach linea of newlist p i {

			foreach i of numlist 2002 2005 2008 2018 {
				preserve
				keep if (year==`i')
				bootstrap r(fgt), reps(100) seed(12345): fgt_bs ipcug, alpha(`alpha') zeta(l`linea') weight(fex_c)
				restore
			}

		}

	}

	*13 CIUDADES PRINCIPALES Y ÁREAS METROPOLITANAS*

	forvalues alpha=0(1)2 {

		foreach linea of newlist p i {

			foreach i of numlist 2002 2005 2008 2018 {
				preserve
				keep if (year==`i' & ciudad!=.)
				bootstrap r(fgt), reps(100) seed(12345): fgt_bs ipcug, alpha(`alpha') zeta(l`linea') weight(fex_c)
				restore
			}

		}

	}

	*RESTO URBANO*

	forvalues alpha=0(1)2 {

		foreach linea of newlist p i {

			foreach i of numlist 2002 2005 2008 2018 {
				preserve
				keep if (year==`i' & dominio!="RURAL" & ciudad==.)
				bootstrap r(fgt), reps(100) seed(12345): fgt_bs ipcug, alpha(`alpha') zeta(l`linea') weight(fex_c)
				restore
			}

		}

	}


	*RURAL*

	forvalues alpha=0(1)2 {

		foreach linea of newlist p i {

			foreach i of numlist 2002 2005 2008 2018 {
				preserve
				keep if (year==`i' & dominio=="RURAL")
				bootstrap r(fgt), reps(100) seed(12345): fgt_bs ipcug, alpha(`alpha') zeta(l`linea') weight(fex_c)
				restore
			}

		}

	}

*POR CIUDAD*

	forvalues j=1(1)13 {

		forvalues alpha=0(1)2 {

			foreach linea of newlist p i {

				foreach i of numlist 2002 2005 2008 2018 {
					preserve
					keep if (year==`i' & ciudad==`j')
					bootstrap r(fgt), reps(100) seed(12345): fgt_bs ipcug, alpha(`alpha') zeta(l`linea') weight(fex_c)
					restore
				}

			}

		}

	}


*##############################################################################*
* PARTICIPACIÓN DE CADA ÁREA EN LA POBREZA E INDIGENCIA (COLOMBIA 2002-2018) *
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
* POBREZA E INDIGENCIA SEGÚN CARACTERÍSTICAS DEL JEFE DE HOGAR (COLOMBIA 2002-2018) *
*##############################################################################*


foreach linea of newlist p i {

	foreach area of newlist tn urb resturb rur {
		matrix define   `linea'_cjh_`area' = J(19,17,.)
		matrix rownames `linea'_cjh_`area' =	"Hombre" "Mujer" "[0,25]" "[26,35]" "[36,45]" "[46,55]" "[56,64]" "[65+]" ///
												"Prim. incomp." "Prim. comp." "Sec. incomp." "Sec. comp." "Sup. incomp." "Sup. comp." ///
												"Ocupado" "Desocupado" "Inactivo" "Asalariados" "Patrones y cuenta propia"
		matrix colnames `linea'_cjh_`area' = "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018"
	}

}

*TOTAL NACIONAL*

foreach linea of newlist p i {

	foreach i of numlist 2002 2018 {

		use "$data/prepara_base/Base_`i'_n", clear

		forvalues j=0(1)1 {
			fgt ingpcug [w=fex_c] if (jefe_mujer==`j'), alpha(0) zeta(l`linea')
			matrix `linea'_cjh_tn [1+`j',`i'-2001]=r(fgt)
		}

		forvalues j=1(1)6 {
			fgt ingpcug [w=fex_c] if (jefe_gedad==`j'), alpha(0) zeta(l`linea')
			matrix `linea'_cjh_tn [2+`j',`i'-2001]=r(fgt)
		}

		forvalues j=1(1)6 {
			fgt ingpcug [w=fex_c] if (jefe_neduc==`j'), alpha(0) zeta(l`linea')
			matrix `linea'_cjh_tn [8+`j',`i'-2001]=r(fgt)
		}

		forvalues j=1(1)3 {
			fgt ingpcug [w=fex_c] if (jefe_estado==`j'), alpha(0) zeta(l`linea')
			matrix `linea'_cjh_tn [14+`j',`i'-2001]=r(fgt)
		}

			fgt ingpcug [w=fex_c] if (jefe_cocup==1 | jefe_cocup==2), alpha(0) zeta(l`linea')
			matrix `linea'_cjh_tn [18,`i'-2001]=r(fgt)

			fgt ingpcug [w=fex_c] if (jefe_cocup==4 | jefe_cocup==5), alpha(0) zeta(l`linea')
			matrix `linea'_cjh_tn [19,`i'-2001]=r(fgt)

	}

}

*13 CIUDADES PRINCIPALES Y ÁREAS METROPOLITANAS*

foreach linea of newlist p i {

	foreach i of numlist 2002 2018 {

		use "$data/prepara_base/Base_`i'_n", clear

		forvalues j=0(1)1 {
			fgt ingpcug [w=fex_c] if (jefe_mujer==`j' & ciudad!=.), alpha(0) zeta(l`linea')
			matrix `linea'_cjh_urb [1+`j',`i'-2001]=r(fgt)
		}

		forvalues j=1(1)6 {
			fgt ingpcug [w=fex_c] if (jefe_gedad==`j' & ciudad!=.), alpha(0) zeta(l`linea')
			matrix `linea'_cjh_urb [2+`j',`i'-2001]=r(fgt)
		}

		forvalues j=1(1)6 {
			fgt ingpcug [w=fex_c] if (jefe_neduc==`j' & ciudad!=.), alpha(0) zeta(l`linea')
			matrix `linea'_cjh_urb [8+`j',`i'-2001]=r(fgt)
		}

		forvalues j=1(1)3 {
			fgt ingpcug [w=fex_c] if (jefe_estado==`j' & ciudad!=.), alpha(0) zeta(l`linea')
			matrix `linea'_cjh_urb [14+`j',`i'-2001]=r(fgt)
		}

			fgt ingpcug [w=fex_c] if ((jefe_cocup==1 | jefe_cocup==2) & ciudad!=.), alpha(0) zeta(l`linea')
			matrix `linea'_cjh_urb [18,`i'-2001]=r(fgt)

			fgt ingpcug [w=fex_c] if ((jefe_cocup==4 | jefe_cocup==5) & ciudad!=.), alpha(0) zeta(l`linea')
			matrix `linea'_cjh_urb [19,`i'-2001]=r(fgt)

	}

}

*RESTO URBANO*

foreach linea of newlist p i {

	foreach i of numlist 2002 2018 {

		use "$data/prepara_base/Base_`i'_n", clear

		forvalues j=0(1)1 {
			fgt ingpcug [w=fex_c] if (jefe_mujer==`j' & dominio!="RURAL" & ciudad==.), alpha(0) zeta(l`linea')
			matrix `linea'_cjh_resturb [1+`j',`i'-2001]=r(fgt)
		}

		forvalues j=1(1)6 {
			fgt ingpcug [w=fex_c] if (jefe_gedad==`j' & dominio!="RURAL" & ciudad==.), alpha(0) zeta(l`linea')
			matrix `linea'_cjh_resturb [2+`j',`i'-2001]=r(fgt)
		}

		forvalues j=1(1)6 {
			fgt ingpcug [w=fex_c] if (jefe_neduc==`j' & dominio!="RURAL" & ciudad==.), alpha(0) zeta(l`linea')
			matrix `linea'_cjh_resturb [8+`j',`i'-2001]=r(fgt)
		}

		forvalues j=1(1)3 {
			fgt ingpcug [w=fex_c] if (jefe_estado==`j' & dominio!="RURAL" & ciudad==.), alpha(0) zeta(l`linea')
			matrix `linea'_cjh_resturb [14+`j',`i'-2001]=r(fgt)
		}

			fgt ingpcug [w=fex_c] if ((jefe_cocup==1 | jefe_cocup==2) & dominio!="RURAL" & ciudad==.), alpha(0) zeta(l`linea')
			matrix `linea'_cjh_resturb [18,`i'-2001]=r(fgt)

			fgt ingpcug [w=fex_c] if ((jefe_cocup==4 | jefe_cocup==5) & dominio!="RURAL" & ciudad==.), alpha(0) zeta(l`linea')
			matrix `linea'_cjh_resturb [19,`i'-2001]=r(fgt)

	}

}

*RURAL*

foreach linea of newlist p i {

	foreach i of numlist 2002 2018 {

		use "$data/prepara_base/Base_`i'_n", clear

		forvalues j=0(1)1 {
			fgt ingpcug [w=fex_c] if (jefe_mujer==`j' & dominio=="RURAL"), alpha(0) zeta(l`linea')
			matrix `linea'_cjh_rur [1+`j',`i'-2001]=r(fgt)
		}

		forvalues j=1(1)6 {
			fgt ingpcug [w=fex_c] if (jefe_gedad==`j' & dominio=="RURAL"), alpha(0) zeta(l`linea')
			matrix `linea'_cjh_rur [2+`j',`i'-2001]=r(fgt)
		}

		forvalues j=1(1)6 {
			fgt ingpcug [w=fex_c] if (jefe_neduc==`j' & dominio=="RURAL"), alpha(0) zeta(l`linea')
			matrix `linea'_cjh_rur [8+`j',`i'-2001]=r(fgt)
		}

		forvalues j=1(1)3 {
			fgt ingpcug [w=fex_c] if (jefe_estado==`j' & dominio=="RURAL"), alpha(0) zeta(l`linea')
			matrix `linea'_cjh_rur [14+`j',`i'-2001]=r(fgt)
		}

			fgt ingpcug [w=fex_c] if ((jefe_cocup==1 | jefe_cocup==2) & dominio=="RURAL"), alpha(0) zeta(l`linea')
			matrix `linea'_cjh_rur [18,`i'-2001]=r(fgt)

			fgt ingpcug [w=fex_c] if ((jefe_cocup==4 | jefe_cocup==5) & dominio=="RURAL"), alpha(0) zeta(l`linea')
			matrix `linea'_cjh_rur [19,`i'-2001]=r(fgt)

	}

}

foreach linea of newlist p i {

	foreach area of newlist tn urb resturb rur {
		preserve
		drop _all
		svmat `linea'_cjh_`area'
		export excel using "$results/FGT/FGT_`linea'_cjh_`area'.xlsx", sheet("FGT_`linea'_cjh_`area'", modify) firstrow(variables)
		restore
	}

}


*##############################################################################*
* POBREZA E INDIGENCIA SEGÚN CARACTERÍSTICAS DEL HOGAR (COLOMBIA 2002-2018) *
*##############################################################################*


foreach linea of newlist p i {

	foreach area of newlist tn urb resturb rur {
		matrix define   `linea'_ch_`area' = J(11,17,.)
		matrix rownames `linea'_ch_`area' =	"Ningún niño" "Un niño" "Dos niños" "Tres o más niños" "Ningún ocupado" "Un ocupado" "Dos o más ocupados" ///
											"Una persona" "Dos personas" "Tres personas" "Cuatro o más personas"
		matrix colnames `linea'_ch_`area' = "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018"
	}

}

*TOTAL NACIONAL*

foreach linea of newlist p i {

	foreach i of numlist 2002 2018 {

		use "$data/prepara_base/Base_`i'_n", clear

		forvalues j=0(1)2 {
			fgt ingpcug [w=fex_c] if (n_niños==`j'), alpha(0) zeta(l`linea')
			matrix `linea'_ch_tn [1+`j',`i'-2001]=r(fgt)
		}

			fgt ingpcug [w=fex_c] if (n_niños>=3), alpha(0) zeta(l`linea')
			matrix `linea'_ch_tn [4,`i'-2001]=r(fgt)

		forvalues j=0(1)1 {
			fgt ingpcug [w=fex_c] if (n_oc==`j'), alpha(0) zeta(l`linea')
			matrix `linea'_ch_tn [5+`j',`i'-2001]=r(fgt)
		}

			fgt ingpcug [w=fex_c] if (n_oc>=2), alpha(0) zeta(l`linea')
			matrix `linea'_ch_tn [7,`i'-2001]=r(fgt)

		forvalues j=1(1)3 {
			fgt ingpcug [w=fex_c] if (miembros_h==`j'), alpha(0) zeta(l`linea')
			matrix `linea'_ch_tn [7+`j',`i'-2001]=r(fgt)
		}

			fgt ingpcug [w=fex_c] if (miembros_h>=4), alpha(0) zeta(l`linea')
			matrix `linea'_ch_tn [11,`i'-2001]=r(fgt)

	}

}

*13 CIUDADES PRINCIPALES Y ÁREAS METROPOLITANAS*

foreach linea of newlist p i {

	foreach i of numlist 2002 2018 {

		use "$data/prepara_base/Base_`i'_n", clear

		forvalues j=0(1)2 {
			fgt ingpcug [w=fex_c] if (n_niños==`j' & ciudad!=.), alpha(0) zeta(l`linea')
			matrix `linea'_ch_urb [1+`j',`i'-2001]=r(fgt)
		}

			fgt ingpcug [w=fex_c] if (n_niños>=3 & ciudad!=.), alpha(0) zeta(l`linea')
			matrix `linea'_ch_urb [4,`i'-2001]=r(fgt)

		forvalues j=0(1)1 {
			fgt ingpcug [w=fex_c] if (n_oc==`j' & ciudad!=.), alpha(0) zeta(l`linea')
			matrix `linea'_ch_urb [5+`j',`i'-2001]=r(fgt)
		}

			fgt ingpcug [w=fex_c] if (n_oc>=2 & ciudad!=.), alpha(0) zeta(l`linea')
			matrix `linea'_ch_urb [7,`i'-2001]=r(fgt)

		forvalues j=1(1)3 {
			fgt ingpcug [w=fex_c] if (miembros_h==`j' & ciudad!=.), alpha(0) zeta(l`linea')
			matrix `linea'_ch_urb [7+`j',`i'-2001]=r(fgt)
		}

			fgt ingpcug [w=fex_c] if (miembros_h>=4 & ciudad!=.), alpha(0) zeta(l`linea')
			matrix `linea'_ch_urb [11,`i'-2001]=r(fgt)

	}

}

*RESTO URBANO*

foreach linea of newlist p i {

	foreach i of numlist 2002 2018 {

		use "$data/prepara_base/Base_`i'_n", clear

		forvalues j=0(1)2 {
			fgt ingpcug [w=fex_c] if (n_niños==`j' & dominio!="RURAL" & ciudad==.), alpha(0) zeta(l`linea')
			matrix `linea'_ch_resturb [1+`j',`i'-2001]=r(fgt)
		}

			fgt ingpcug [w=fex_c] if (n_niños>=3 & dominio!="RURAL" & ciudad==.), alpha(0) zeta(l`linea')
			matrix `linea'_ch_resturb [4,`i'-2001]=r(fgt)

		forvalues j=0(1)1 {
			fgt ingpcug [w=fex_c] if (n_oc==`j' & dominio!="RURAL" & ciudad==.), alpha(0) zeta(l`linea')
			matrix `linea'_ch_resturb [5+`j',`i'-2001]=r(fgt)
		}

			fgt ingpcug [w=fex_c] if (n_oc>=2 & dominio!="RURAL" & ciudad==.), alpha(0) zeta(l`linea')
			matrix `linea'_ch_resturb [7,`i'-2001]=r(fgt)

		forvalues j=1(1)3 {
			fgt ingpcug [w=fex_c] if (miembros_h==`j' & dominio!="RURAL" & ciudad==.), alpha(0) zeta(l`linea')
			matrix `linea'_ch_resturb [7+`j',`i'-2001]=r(fgt)
		}

			fgt ingpcug [w=fex_c] if (miembros_h>=4 & dominio!="RURAL" & ciudad==.), alpha(0) zeta(l`linea')
			matrix `linea'_ch_resturb [11,`i'-2001]=r(fgt)

	}

}

*RURAL*

foreach linea of newlist p i {

	foreach i of numlist 2002 2018 {

		use "$data/prepara_base/Base_`i'_n", clear

		forvalues j=0(1)2 {
			fgt ingpcug [w=fex_c] if (n_niños==`j' & dominio=="RURAL"), alpha(0) zeta(l`linea')
			matrix `linea'_ch_rur [1+`j',`i'-2001]=r(fgt)
		}

			fgt ingpcug [w=fex_c] if (n_niños>=3 & dominio=="RURAL"), alpha(0) zeta(l`linea')
			matrix `linea'_ch_rur [4,`i'-2001]=r(fgt)

		forvalues j=0(1)1 {
			fgt ingpcug [w=fex_c] if (n_oc==`j' & dominio=="RURAL"), alpha(0) zeta(l`linea')
			matrix `linea'_ch_rur [5+`j',`i'-2001]=r(fgt)
		}

			fgt ingpcug [w=fex_c] if (n_oc>=2 & dominio=="RURAL"), alpha(0) zeta(l`linea')
			matrix `linea'_ch_rur [7,`i'-2001]=r(fgt)

		forvalues j=1(1)3 {
			fgt ingpcug [w=fex_c] if (miembros_h==`j' & dominio=="RURAL"), alpha(0) zeta(l`linea')
			matrix `linea'_ch_rur [7+`j',`i'-2001]=r(fgt)
		}

			fgt ingpcug [w=fex_c] if (miembros_h>=4 & dominio=="RURAL"), alpha(0) zeta(l`linea')
			matrix `linea'_ch_rur [11,`i'-2001]=r(fgt)

	}

}

foreach linea of newlist p i {

	foreach area of newlist tn urb resturb rur {
		preserve
		drop _all
		svmat `linea'_ch_`area'
		export excel using "$results/FGT/FGT_`linea'_ch_`area'.xlsx", sheet("FGT_`linea'_ch_`area'", modify) firstrow(variables)
		restore
	}

}


*##############################################################################*
* DESIGUALDAD (COLOMBIA 2002-2018) *
*##############################################################################*


*POR ÁREA*

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
* DISTRIBUCIONES DEL INGRESO PER CÁPITA DE LA UNIDAD DE GASTO -ipcug- (COLOMBIA 2002-2018) *
*##############################################################################*


*POR ÁREA*

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

*POR CIUDAD*

use "$data/Base", clear

foreach i of numlist 2002 2018 {

	forvalues j=1(1)13 {
		summarize lp [w=fex_c] if (year==`i' & ciudad==`j')
		local lp_`j'_`i'=r(mean)
		local log_lp_`j'_`i'=log(`lp_`j'_`i'')
	}

}

forvalues i=1(1)13 {
	local lp_`i'_02_18=`lp_`i'_2018'/`lp_`i'_2002'
}

generate ipcug_real=ipcug
forvalues i=1(1)13 {
	replace ipcug_real=ipcug*`lp_`i'_02_18' if (year==2002 & ciudad==`i')
}

generate lipcug_real=log(ipcug_real)

forvalues i=1(1)13 {
	graph twoway	(kdensity lipcug_real if (year==2002 & ciudad==`i'), lcolor(black)) ///
					(kdensity lipcug_real if (year==2018 & ciudad==`i'), lcolor(black)), ///
					title("Nombre de la ciudad", color(black)) ytitle("Densidad") xtitle("Logaritmo del IPCUG") xline(`log_lp_`i'_2018', lcolor(red)) ///
					legend(label(1 "2002") label(2 "2018"))
}


*##############################################################################*
* DESCOMPOSICIÓN DE KOLENIKOV Y SHORROCKS (2005) (COLOMBIA 2002-2018) *
*##############################################################################*


use "$data/Base", clear

*POR ÁREA*

	*AÑOS 2002-2005*

		*TOTAL NACIONAL*

		foreach linea of newlist p i {

			forvalues alpha=0(1)2 {
				preserve
				skdecomp ipcug [w=fex_c] if (year==2002 | year==2005), by(year) varpl(l`linea') indicator(fgt`alpha') idpl(dominio)
				matrix define beta=r(b)'
				drop _all
				svmat beta
				keep if (_n==3)
				save "$results/KS/KS_FGT`alpha'_`linea'_tn_2002-2005", replace
				export excel using "$results/KS/KS_FGT`alpha'_`linea'_tn_2002-2005.xlsx", sheet("KS_FGT`alpha'_`linea'_tn_2002-2005", modify) firstrow(variables)
				restore
			}

		}

		*13 CIUDADES PRINCIPALES Y ÁREAS METROPOLITANAS*

		foreach linea of newlist p i {

			forvalues alpha=0(1)2 {
				preserve
				skdecomp ipcug [w=fex_c] if ((year==2002 | year==2005) & ciudad!=.), by(year) varpl(l`linea') indicator(fgt`alpha') idpl(dominio)
				matrix define beta=r(b)'
				drop _all
				svmat beta
				keep if (_n==3)
				save "$results/KS/KS_FGT`alpha'_`linea'_urb_2002-2005", replace
				export excel using "$results/KS/KS_FGT`alpha'_`linea'_urb_2002-2005.xlsx", sheet("KS_FGT`alpha'_`linea'_urb_2002-2005", modify) firstrow(variables)
				restore
			}

		}

		*RESTO URBANO*

		foreach linea of newlist p i {

			forvalues alpha=0(1)2 {
				preserve
				skdecomp ipcug [w=fex_c] if ((year==2002 | year==2005) & dominio!="RURAL" & ciudad==.), by(year) varpl(l`linea') indicator(fgt`alpha') idpl(dominio)
				matrix define beta=r(b)'
				drop _all
				svmat beta
				keep if (_n==3)
				save "$results/KS/KS_FGT`alpha'_`linea'_resturb_2002-2005", replace
				export excel using "$results/KS/KS_FGT`alpha'_`linea'_resturb_2002-2005.xlsx", sheet("KS_FGT`alpha'_`linea'_resturb_2002-2005", modify) firstrow(variables)
				restore
			}

		}

		*RURAL*

		foreach linea of newlist p i {

			forvalues alpha=0(1)2 {
				preserve
				skdecomp ipcug [w=fex_c] if ((year==2002 | year==2005) & dominio=="RURAL"), by(year) varpl(l`linea') indicator(fgt`alpha') idpl(dominio)
				matrix define beta=r(b)'
				drop _all
				svmat beta
				keep if (_n==3)
				save "$results/KS/KS_FGT`alpha'_`linea'_rur_2002-2005", replace
				export excel using "$results/KS/KS_FGT`alpha'_`linea'_rur_2002-2005.xlsx", sheet("KS_FGT`alpha'_`linea'_rur_2002-2005", modify) firstrow(variables)
				restore
			}

		}

	*AÑOS 2008-2018*

		*TOTAL NACIONAL*

		foreach linea of newlist p i {

			forvalues alpha=0(1)2 {
				preserve
				skdecomp ipcug [w=fex_c] if (year==2008 | year==2018), by(year) varpl(l`linea') indicator(fgt`alpha') idpl(dominio)
				matrix define beta=r(b)'
				drop _all
				svmat beta
				keep if (_n==3)
				save "$results/KS/KS_FGT`alpha'_`linea'_tn_2008-2018", replace
				export excel using "$results/KS/KS_FGT`alpha'_`linea'_tn_2008-2018.xlsx", sheet("KS_FGT`alpha'_`linea'_tn_2008-2018", modify) firstrow(variables)
				restore
			}

		}

		*13 CIUDADES PRINCIPALES Y ÁREAS METROPOLITANAS*

		foreach linea of newlist p i {

			forvalues alpha=0(1)2 {
				preserve
				skdecomp ipcug [w=fex_c] if ((year==2008 | year==2018) & ciudad!=.), by(year) varpl(l`linea') indicator(fgt`alpha') idpl(dominio)
				matrix define beta=r(b)'
				drop _all
				svmat beta
				keep if (_n==3)
				save "$results/KS/KS_FGT`alpha'_`linea'_urb_2008-2018", replace
				export excel using "$results/KS/KS_FGT`alpha'_`linea'_urb_2008-2018.xlsx", sheet("KS_FGT`alpha'_`linea'_urb_2008-2018", modify) firstrow(variables)
				restore
			}

		}

		*RESTO URBANO*

		foreach linea of newlist p i {

			forvalues alpha=0(1)2 {
				preserve
				skdecomp ipcug [w=fex_c] if ((year==2008 | year==2018) & dominio!="RURAL" & ciudad==.), by(year) varpl(l`linea') indicator(fgt`alpha') idpl(dominio)
				matrix define beta=r(b)'
				drop _all
				svmat beta
				keep if (_n==3)
				save "$results/KS/KS_FGT`alpha'_`linea'_resturb_2008-2018", replace
				export excel using "$results/KS/KS_FGT`alpha'_`linea'_resturb_2008-2018.xlsx", sheet("KS_FGT`alpha'_`linea'_resturb_2008-2018", modify) firstrow(variables)
				restore
			}

		}

		*RURAL*

		foreach linea of newlist p i {

			forvalues alpha=0(1)2 {
				preserve
				skdecomp ipcug [w=fex_c] if ((year==2008 | year==2018) & dominio=="RURAL"), by(year) varpl(l`linea') indicator(fgt`alpha') idpl(dominio)
				matrix define beta=r(b)'
				drop _all
				svmat beta
				keep if (_n==3)
				save "$results/KS/KS_FGT`alpha'_`linea'_rur_2008-2018", replace
				export excel using "$results/KS/KS_FGT`alpha'_`linea'_rur_2008-2018.xlsx", sheet("KS_FGT`alpha'_`linea'_rur_2008-2018", modify) firstrow(variables)
				restore
			}

		}

	*AÑOS 2002-2018*

		*TOTAL NACIONAL*

		foreach linea of newlist p i {

			forvalues alpha=0(1)2 {
				preserve
				skdecomp ipcug [w=fex_c] if (year==2002 | year==2018), by(year) varpl(l`linea') indicator(fgt`alpha') idpl(dominio)
				matrix define beta=r(b)'
				drop _all
				svmat beta
				keep if (_n==3)
				save "$results/KS/KS_FGT`alpha'_`linea'_tn_2002-2018", replace
				export excel using "$results/KS/KS_FGT`alpha'_`linea'_tn_2002-2018.xlsx", sheet("KS_FGT`alpha'_`linea'_tn_2002-2018", modify) firstrow(variables)
				restore
			}

		}

		*13 CIUDADES PRINCIPALES Y ÁREAS METROPOLITANAS*

		foreach linea of newlist p i {

			forvalues alpha=0(1)2 {
				preserve
				skdecomp ipcug [w=fex_c] if ((year==2002 | year==2018) & ciudad!=.), by(year) varpl(l`linea') indicator(fgt`alpha') idpl(dominio)
				matrix define beta=r(b)'
				drop _all
				svmat beta
				keep if (_n==3)
				save "$results/KS/KS_FGT`alpha'_`linea'_urb_2002-2018", replace
				export excel using "$results/KS/KS_FGT`alpha'_`linea'_urb_2002-2018.xlsx", sheet("KS_FGT`alpha'_`linea'_urb_2002-2018", modify) firstrow(variables)
				restore
			}

		}

		*RESTO URBANO*

		foreach linea of newlist p i {

			forvalues alpha=0(1)2 {
				preserve
				skdecomp ipcug [w=fex_c] if ((year==2002 | year==2018) & dominio!="RURAL" & ciudad==.), by(year) varpl(l`linea') indicator(fgt`alpha') idpl(dominio)
				matrix define beta=r(b)'
				drop _all
				svmat beta
				keep if (_n==3)
				save "$results/KS/KS_FGT`alpha'_`linea'_resturb_2002-2018", replace
				export excel using "$results/KS/KS_FGT`alpha'_`linea'_resturb_2002-2018.xlsx", sheet("KS_FGT`alpha'_`linea'_resturb_2002-2018", modify) firstrow(variables)
				restore
			}

		}

		*RURAL*

		foreach linea of newlist p i {

			forvalues alpha=0(1)2 {
				preserve
				skdecomp ipcug [w=fex_c] if ((year==2002 | year==2018) & dominio=="RURAL"), by(year) varpl(l`linea') indicator(fgt`alpha') idpl(dominio)
				matrix define beta=r(b)'
				drop _all
				svmat beta
				keep if (_n==3)
				save "$results/KS/KS_FGT`alpha'_`linea'_rur_2002-2018", replace
				export excel using "$results/KS/KS_FGT`alpha'_`linea'_rur_2002-2018.xlsx", sheet("KS_FGT`alpha'_`linea'_rur_2002-2018", modify) firstrow(variables)
				restore
			}

		}

*POR CIUDAD*

	*AÑOS 2002-2005*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {

			forvalues i=1(1)13 {
				preserve
				keep if (ciudad==`i')
				skdecomp ipcug [w=fex_c] if (year==2002 | year==2005), by(year) varpl(l`linea') indicator(fgt`alpha') idpl(ciudad)
				matrix define beta=r(b)'
				drop _all
				svmat beta
				keep if (_n==3)
				save "$results/KS/KS_FGT`alpha'_`linea'_c`i'_2002-2005", replace
				restore
			}

		}

	}

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {

			preserve
			use "$results/KS/KS_FGT`alpha'_`linea'_c1_2002-2005", clear

			forvalues i=2(1)13 {
				append using "$results/KS/KS_FGT`alpha'_`linea'_c`i'_2002-2005"
			}

			save "$results/KS/KS_FGT`alpha'_`linea'_c_2002-2005", replace
			export excel using "$results/KS/KS_FGT`alpha'_`linea'_c_2002-2005.xlsx", sheet("KS_FGT`alpha'_`linea'_c_2002-2005", modify) firstrow(variables)
			restore

		}

	}

	*AÑOS 2008-2018*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {

			forvalues i=1(1)13 {
				preserve
				keep if (ciudad==`i')
				skdecomp ipcug [w=fex_c] if (year==2008 | year==2018), by(year) varpl(l`linea') indicator(fgt`alpha') idpl(ciudad)
				matrix define beta=r(b)'
				drop _all
				svmat beta
				keep if (_n==3)
				save "$results/KS/KS_FGT`alpha'_`linea'_c`i'_2008-2018", replace
				restore
			}

		}

	}

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {

			preserve
			use "$results/KS/KS_FGT`alpha'_`linea'_c1_2008-2018", clear

			forvalues i=2(1)13 {
				append using "$results/KS/KS_FGT`alpha'_`linea'_c`i'_2008-2018"
			}

			save "$results/KS/KS_FGT`alpha'_`linea'_c_2008-2018", replace
			export excel using "$results/KS/KS_FGT`alpha'_`linea'_c_2008-2018.xlsx", sheet("KS_FGT`alpha'_`linea'_c_2008-2018", modify) firstrow(variables)
			restore

		}

	}

	*AÑOS 2002-2018*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {

			forvalues i=1(1)13 {
				preserve
				keep if (ciudad==`i')
				skdecomp ipcug [w=fex_c] if (year==2002 | year==2018), by(year) varpl(l`linea') indicator(fgt`alpha') idpl(ciudad)
				matrix define beta=r(b)'
				drop _all
				svmat beta
				keep if (_n==3)
				save "$results/KS/KS_FGT`alpha'_`linea'_c`i'_2002-2018", replace
				restore
			}

		}

	}

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {

			preserve
			use "$results/KS/KS_FGT`alpha'_`linea'_c1_2002-2018", clear

			forvalues i=2(1)13 {
				append using "$results/KS/KS_FGT`alpha'_`linea'_c`i'_2002-2018"
			}

			save "$results/KS/KS_FGT`alpha'_`linea'_c_2002-2018", replace
			export excel using "$results/KS/KS_FGT`alpha'_`linea'_c_2002-2018.xlsx", sheet("KS_FGT`alpha'_`linea'_c_2002-2018", modify) firstrow(variables)
			restore

		}

	}


*##############################################################################*
* DESCOMPOSICIÓN RIF (COLOMBIA 2002-2018) *
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
			oaxaca_rif	ipcug 	miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_des ing_nolab_hog ayudas_hog [pw=fex_c], ///
						rwlogit(miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_des ing_nolab_hog ayudas_hog) ///
						by(year_d) rif(pov(`alpha') pline(l`linea')) wgt(0)
			outreg2 using "$results/RIF/RIF_FGT`alpha'_`linea'_tn_wgt0.xls", replace dec(3)
		}

	}

	*13 CIUDADES PRINCIPALES Y ÁREAS METROPOLITANAS*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			oaxaca_rif	ipcug 	miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_des ing_nolab_hog ayudas_hog [pw=fex_c] ///
						if (ciudad!=.), ///
						rwlogit(miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_des ing_nolab_hog ayudas_hog) ///
						by(year_d) rif(pov(`alpha') pline(l`linea')) wgt(0)
			outreg2 using "$results/RIF/RIF_FGT`alpha'_`linea'_urb_wgt0.xls", replace dec(3)
		}

	}

	*RESTO URBANO*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			oaxaca_rif	ipcug 	miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_des ing_nolab_hog ayudas_hog [pw=fex_c] ///
						if (dominio!="RURAL" & ciudad==.), ///
						rwlogit(miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_des ing_nolab_hog ayudas_hog) ///
						by(year_d) rif(pov(`alpha') pline(l`linea')) wgt(0)
			outreg2 using "$results/RIF/RIF_FGT`alpha'_`linea'_resturb_wgt0.xls", replace dec(3)
		}

	}

	*RURAL*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			oaxaca_rif	ipcug 	miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_des ing_nolab_hog ayudas_hog [pw=fex_c] ///
						if (dominio=="RURAL"), ///
						rwlogit(miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_des ing_nolab_hog ayudas_hog) ///
						by(year_d) rif(pov(`alpha') pline(l`linea')) wgt(0)
			outreg2 using "$results/RIF/RIF_FGT`alpha'_`linea'_rur_wgt0.xls", replace dec(3)
		}

	}

	*CIUDAD*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {

			forvalues i=1(1)13 {
				oaxaca_rif	ipcug 	miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_des ing_nolab_hog ayudas_hog [pw=fex_c] ///
							if (ciudad==`i'), ///
							rwlogit(miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_des ing_nolab_hog ayudas_hog) ///
							by(year_d) rif(pov(`alpha') pline(l`linea')) wgt(0)
				outreg2 using "$results/RIF/RIF_FGT`alpha'_`linea'_c`i'_wgt0.xls", replace dec(3)
			}

		}

	}

*Contrafactual X2*B1, entonces, DX=(X1-X2)*B1 (efecto composición) y DB=X2*(B1-B2) (efecto estructura)*

	*TOTAL NACIONAL*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			oaxaca_rif	ipcug 	miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_des ing_nolab_hog ayudas_hog [pw=fex_c], ///
						rwlogit(miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_des ing_nolab_hog ayudas_hog) ///
						by(year_d) rif(pov(`alpha') pline(l`linea')) wgt(1)
			outreg2 using "$results/RIF/RIF_FGT`alpha'_`linea'_tn_wgt1.xls", replace dec(3)
		}

	}

	*13 CIUDADES PRINCIPALES Y ÁREAS METROPOLITANAS*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			oaxaca_rif	ipcug 	miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_des ing_nolab_hog ayudas_hog [pw=fex_c] ///
						if (ciudad!=.), ///
						rwlogit(miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_des ing_nolab_hog ayudas_hog) ///
						by(year_d) rif(pov(`alpha') pline(l`linea')) wgt(1)
			outreg2 using "$results/RIF/RIF_FGT`alpha'_`linea'_urb_wgt1.xls", replace dec(3)
		}

	}

	*RESTO URBANO*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			oaxaca_rif	ipcug 	miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_des ing_nolab_hog ayudas_hog [pw=fex_c] ///
						if (dominio!="RURAL" & ciudad==.), ///
						rwlogit(miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_des ing_nolab_hog ayudas_hog) ///
						by(year_d) rif(pov(`alpha') pline(l`linea')) wgt(1)
			outreg2 using "$results/RIF/RIF_FGT`alpha'_`linea'_resturb_wgt1.xls", replace dec(3)
		}

	}

	*RURAL*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			oaxaca_rif	ipcug 	miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_des ing_nolab_hog ayudas_hog [pw=fex_c] ///
						if (dominio=="RURAL"), ///
						rwlogit(miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_des ing_nolab_hog ayudas_hog) ///
						by(year_d) rif(pov(`alpha') pline(l`linea')) wgt(1)
			outreg2 using "$results/RIF/RIF_FGT`alpha'_`linea'_rur_wgt1.xls", replace dec(3)
		}

	}

	*CIUDAD*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {

			forvalues i=1(1)13 {
				oaxaca_rif	ipcug 	miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_des ing_nolab_hog ayudas_hog [pw=fex_c] ///
							if (ciudad==`i'), ///
							rwlogit(miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_des ing_nolab_hog ayudas_hog) ///
							by(year_d) rif(pov(`alpha') pline(l`linea')) wgt(1)
				outreg2 using "$results/RIF/RIF_FGT`alpha'_`linea'_c`i'_wgt1.xls", replace dec(3)
			}

		}

	}


*##############################################################################*
* MICROSIMULACIONES (COLOMBIA 2018) *
*##############################################################################*


*SIMULACIÓN 1 (sim-secc): Secundario completo para todos los individuos entre 18 y 40 años de edad*

	use "$data/Base", clear

	*Prepara base / Estimación de Mincer / Modelo de Elección Ocupacional
	do "$dofiles/simulaciones/prepara_base_sim"
	do "$dofiles/simulaciones/estimate-mincer"
	do "$dofiles/simulaciones/estimate-occup"
	do "$dofiles/simulaciones/desc-data"

	*Simulación
	do "$dofiles/simulaciones/sim-secc" "secc" "40"

	*Indicadores
	do "$dofiles/simulaciones/indicadores" "ipcug" "ipcug_secc"

*SIMULACIÓN 2 (sim-desemp): Disminución de la tasa de desempleo en 5 puntos porcentuales*

	use "$data/Base", clear

	*Prepara base / Estimación de Mincer / Modelo de Elección Ocupacional
	do "$dofiles/simulaciones/prepara_base_sim"
	do "$dofiles/simulaciones/estimate-mincer"
	do "$dofiles/simulaciones/estimate-occup"
	do "$dofiles/simulaciones/desc-data"

	*Simulación
	*do "$dofiles/simulaciones/scen-defn-blank"
	*do "$dofiles/simulaciones/sim-part" "blank" "shk_part" "15" "999"
	do "$dofiles/simulaciones/scen-defn-desemp"
	do "$dofiles/simulaciones/sim-part" "desemp" "shk_part" "15" "999"

	*Indicadores
	do "$dofiles/simulaciones/indicadores" "ipcug" "ipcug_desemp"

*SIMULACIÓN 3 (sim-trnsfr): Transferencia de individuos ricos hacia individuos mayores a 60 años de edad con ingreso laboral individual menor a la línea de pobreza*

	use "$data/Base", clear

	*Prepara base
	do "$dofiles/simulaciones/prepara_base_sim"

	*Simulación
	do "$dofiles/simulaciones/sim-trnsfr" "trnsfr"

	*Indicadores
	do "$dofiles/simulaciones/indicadores" "ipcug" "ipcug_trnsfr"
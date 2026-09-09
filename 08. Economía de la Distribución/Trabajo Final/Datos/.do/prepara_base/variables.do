*HOGARES*


use "$data/prepara_base/Bases_2008/Hogares_2008", clear
rename fex_c_a fex_c
save "$data/prepara_base/Hogares_2008", replace

forvalues i=2010(1)2011 {
	use "$data/prepara_base/Bases_`i'/Hogares_`i'", clear
	rename fex_c_a fex_c
	save "$data/prepara_base/Hogares_`i'", replace
}

forvalues i=2015(1)2016 {
	use "$data/prepara_base/Bases_`i'/Hogares_`i'", clear
	order directorio secuencia_p mes clase dpto
	rename fex_dpto fex_dpto_c
	save "$data/prepara_base/Hogares_`i'", replace
}

foreach i of numlist 2009 2017 2018 {
	use "$data/prepara_base/Bases_`i'/Hogares_`i'", clear
	do "$dofiles/prepara_base/var_hogares_`i'"
	save "$data/prepara_base/Hogares_`i'", replace
}

foreach i of numlist 2012 2013 {
	use "$data/prepara_base/Bases_`i'/Hogares_`i'", clear
	save "$data/prepara_base/Hogares_`i'", replace
}

forvalues i=2002(1)2005 {
	use "$data/prepara_base/Bases_`i'/Hogares_`i'", clear
	save "$data/prepara_base/Hogares_`i'", replace
}


*PERSONAS*


use "$data/prepara_base/Bases_2003/Personas_2003", clear
order llave_viv llave_hog orden clase dpto dominio capital mes estrato1 p3 p4 p5 p6 p10 p10u p12 p24 p27 valor28 p29 valor29 p30
save "$data/prepara_base/Personas_2003", replace

foreach i of numlist 2005 2008 2011 {
	use "$data/prepara_base/Bases_`i'/Personas_`i'", clear
	rename fex_c_a fex_c
	save "$data/prepara_base/Personas_`i'", replace
}

foreach i of numlist 2012 2016 {
	use "$data/prepara_base/Bases_`i'/Personas_`i'", clear
	order directorio secuencia_p orden clase dpto
	save "$data/prepara_base/Personas_`i'", replace
}

foreach i of numlist 2009 2017 2018 {
	use "$data/prepara_base/Bases_`i'/Personas_`i'", clear
	do "$dofiles/prepara_base/var_personas_`i'"
	save "$data/prepara_base/Personas_`i'", replace
}

foreach i of numlist 2002 2004 2010 2013 2014 2015 {
	use "$data/prepara_base/Bases_`i'/Personas_`i'", clear
	save "$data/prepara_base/Personas_`i'", replace
}
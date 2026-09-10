*##############################################################################*
* IMPORTACIÓN DE BASES *
*##############################################################################*


*AÑOS 2002-2016*

/*
foreach base of newlist Personas Hogares {
	foreach i of numlist 2002 2003 2004 2005 2008 2009 2010 2011 2012 2013 2014 2015 2016 {
		clear all
		import delimited "$data/prepara_base/Bases_`i'/`base'_`i'.txt"
		save "$data/prepara_base/Bases_`i'/`base'_`i'", replace
	}
}
*/

*AÑOS 2017-2018*

*Ya se encuentran en formato .dta


*##############################################################################*
* UNIÓN DE BASES *
*##############################################################################*


do "$dofiles/prepara_base/variables"

*AÑOS 2002-2005*

forvalues i=2002(1)2005 {

	clear all
	use "$data/prepara_base/Personas_`i'", clear
	destring, replace
	sort llave_viv llave_hog orden dominio
	save "$data/prepara_base/Personas_`i'_aux", replace

	use "$data/prepara_base/Hogares_`i'", clear
	destring, replace
	sort llave_viv llave_hog dominio
	merge 1:m llave_viv llave_hog using "$data/prepara_base/Personas_`i'"
	erase "$data/prepara_base/Personas_`i'_aux.dta"

	tabulate _merge
	drop if (_merge==1)
	drop _merge
	duplicates report
	duplicates drop
	compress

	format %15.0f llave_viv
	format %15.0f llave_hog
	egen id=group(llave_hog)
	sort id orden dominio
	order id, first

	save "$data/prepara_base/Base_`i'", replace

}

*AÑOS 2008-2018*

forvalues i=2008(1)2018 {

	clear all
	use "$data/prepara_base/Personas_`i'", clear
	destring, replace
	sort directorio secuencia_p orden dominio
	save "$data/prepara_base/Personas_`i'_aux", replace

	use "$data/prepara_base/Hogares_`i'", clear
	destring, replace
	sort directorio secuencia_p dominio
	merge 1:m directorio secuencia_p using "$data/prepara_base/Personas_`i'_aux"
	erase "$data/prepara_base/Personas_`i'_aux.dta"

	tabulate _merge
	drop if (_merge==1)
	drop _merge
	duplicates report
	duplicates drop
	compress

	egen id=group(directorio secuencia_p)
	destring id, replace
	sort id orden dominio
	order id, first

	save "$data/prepara_base/Base_`i'", replace

}
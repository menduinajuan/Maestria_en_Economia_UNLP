*##############################################################################*
* INDIGENCIA NACIONAL 2018 SEGÚN LIP (1,9 USD PPA DE 2011, CON USD PPA 2011 IGUAL A COP 1.168,24) *
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
graph twoway	(line cambio_nac pipcug if (pipcug>1), lcolor(black)), title("Total nacional", color(black))
				ytitle("Variación % promedio del IPCUG") xtitle("Percentiles del IPCUG") yline(0, lcolor(red)) xlabel(#10)
restore

preserve
keep if (ciudad!=.)
replace fex_c=round(fex_c)
table pipcug [w=fex_c], statistic(mean ipcug_2002 ipcug_2018) replace
generate cambio_urb=(table2/table1-1)*100
graph twoway	(line cambio_urb pipcug if (pipcug>1), lcolor(black)), title("Principales ciudades", color(black))
				ytitle("Variación % promedio del IPCUG") xtitle("Percentiles del IPCUG") yline(0, lcolor(red)) xlabel(#10)
restore

preserve
keep if (dominio!="RURAL" & ciudad==.)
replace fex_c=round(fex_c)
table pipcug [w=fex_c], statistic(mean ipcug_2002 ipcug_2018) replace
generate cambio_resturb=(table2/table1-1)*100
graph twoway	(line cambio_resturb pipcug if (pipcug>1 & pipcug<100), lcolor(black)), title("Resto urbano", color(black))
				ytitle("Variación % promedio del IPCUG") xtitle("Percentiles del IPCUG") yline(0, lcolor(red)) xlabel(#10)
restore

preserve
keep if (dominio=="RURAL")
replace fex_c=round(fex_c)
table pipcug [w=fex_c], statistic(mean ipcug_2002 ipcug_2018) replace
generate cambio_rur=(table2/table1-1)*100
graph twoway	(line cambio_rur pipcug if (pipcug>1), lcolor(black)), title("Rural", color(black))
				ytitle("Variación % promedio del IPCUG") xtitle("Percentiles del IPCUG") yline(0, lcolor(red)) xlabel(#10)
restore


*##############################################################################*
* DESCOMPOSICIÓN KS - ROBUSTEZ *
*##############################################################################*


*AÑOS 2003-2015*

use "$data/Base", clear
keep if (year==2003 | year==2015)

	*TOTAL NACIONAL*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			preserve
			skdecomp ipcug [w=fex_c], by(year) varpl(l`linea') indicator(fgt`alpha') idpl(dominio)
			matrix define beta=r(b)'
			drop _all
			svmat beta
			keep if (_n==3)
			save "$results/Seminario/KS/KS_FGT`alpha'_`linea'_tn_2003-2015", replace
			export excel using "$results/Seminario/KS/KS_FGT`alpha'_`linea'_tn_2003-2015.xlsx", sheet("KS_FGT`alpha'_`linea'_tn_2003-2015", modify) firstrow(variables)
			restore
		}

	}

	*13 CIUDADES PRINCIPALES Y ÁREAS METROPOLITANAS*

	foreach linea of newlist p i {
	
		forvalues alpha=0(1)2 {
			preserve
			skdecomp ipcug [w=fex_c] if (ciudad!=.), by(year) varpl(l`linea') indicator(fgt`alpha') idpl(dominio)
			matrix define beta=r(b)'
			drop _all
			svmat beta
			keep if (_n==3)
			save "$results/Seminario/KS/KS_FGT`alpha'_`linea'_urb_2003-2015", replace
			export excel using "$results/Seminario/KS/KS_FGT`alpha'_`linea'_urb_2003-2015.xlsx", sheet("KS_FGT`alpha'_`linea'_urb_2003-2015", modify) firstrow(variables)
			restore
		}

	}

	*RESTO URBANO*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			preserve
			skdecomp ipcug [w=fex_c] if (dominio!="RURAL" & ciudad==.), by(year) varpl(l`linea') indicator(fgt`alpha') idpl(dominio)
			matrix define beta=r(b)'
			drop _all
			svmat beta
			keep if (_n==3)
			save "$results/Seminario/KS/KS_FGT`alpha'_`linea'_resturb_2003-2015", replace
			export excel using "$results/Seminario/KS/KS_FGT`alpha'_`linea'_resturb_2003-2015.xlsx", sheet("KS_FGT`alpha'_`linea'_resturb_2003-2015", modify) firstrow(variables)
			restore
		}

	}

	*RURAL*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			preserve
			skdecomp ipcug [w=fex_c] if (dominio=="RURAL"), by(year) varpl(l`linea') indicator(fgt`alpha') idpl(dominio)
			matrix define beta=r(b)'
			drop _all
			svmat beta
			keep if (_n==3)
			save "$results/Seminario/KS/KS_FGT`alpha'_`linea'_rur_2003-2015", replace
			export excel using "$results/Seminario/KS/KS_FGT`alpha'_`linea'_rur_2003-2015.xlsx", sheet("KS_FGT`alpha'_`linea'_rur_2003-2015", modify) firstrow(variables)
			restore
		}

	}

*AÑOS 2004-2014*

use "$data/Base", clear
keep if (year==2004 | year==2014)

	*TOTAL NACIONAL*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			preserve
			skdecomp ipcug [w=fex_c], by(year) varpl(l`linea') indicator(fgt`alpha') idpl(dominio)
			matrix define beta=r(b)'
			drop _all
			svmat beta
			keep if (_n==3)
			save "$results/Seminario/KS/KS_FGT`alpha'_`linea'_tn_2004-2014", replace
			export excel using "$results/Seminario/KS/KS_FGT`alpha'_`linea'_tn_2004-2014.xlsx", sheet("KS_FGT`alpha'_`linea'_tn_2004-2014", modify) firstrow(variables)
			restore
		}

	}

	*13 CIUDADES PRINCIPALES Y ÁREAS METROPOLITANAS*

	foreach linea of newlist p i {
	
		forvalues alpha=0(1)2 {
			preserve
			skdecomp ipcug [w=fex_c] if (ciudad!=.), by(year) varpl(l`linea') indicator(fgt`alpha') idpl(dominio)
			matrix define beta=r(b)'
			drop _all
			svmat beta
			keep if (_n==3)
			save "$results/Seminario/KS/KS_FGT`alpha'_`linea'_urb_2004-2014", replace
			export excel using "$results/Seminario/KS/KS_FGT`alpha'_`linea'_urb_2004-2014.xlsx", sheet("KS_FGT`alpha'_`linea'_urb_2004-2014", modify) firstrow(variables)
			restore
		}

	}

	*RESTO URBANO*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			preserve
			skdecomp ipcug [w=fex_c] if (dominio!="RURAL" & ciudad==.), by(year) varpl(l`linea') indicator(fgt`alpha') idpl(dominio)
			matrix define beta=r(b)'
			drop _all
			svmat beta
			keep if (_n==3)
			save "$results/Seminario/KS/KS_FGT`alpha'_`linea'_resturb_2004-2014", replace
			export excel using "$results/Seminario/KS/KS_FGT`alpha'_`linea'_resturb_2004-2014.xlsx", sheet("KS_FGT`alpha'_`linea'_resturb_2004-2014", modify) firstrow(variables)
			restore
		}

	}

	*RURAL*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			preserve
			skdecomp ipcug [w=fex_c] if (dominio=="RURAL"), by(year) varpl(l`linea') indicator(fgt`alpha') idpl(dominio)
			matrix define beta=r(b)'
			drop _all
			svmat beta
			keep if (_n==3)
			save "$results/Seminario/KS/KS_FGT`alpha'_`linea'_rur_2004-2014", replace
			export excel using "$results/Seminario/KS/KS_FGT`alpha'_`linea'_rur_2004-2014.xlsx", sheet("KS_FGT`alpha'_`linea'_rur_2004-2014", modify) firstrow(variables)
			restore
		}

	}

*AÑOS 2005-2015*

use "$data/Base", clear
keep if (year==2005 | year==2015)

	*TOTAL NACIONAL*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			preserve
			skdecomp ipcug [w=fex_c], by(year) varpl(l`linea') indicator(fgt`alpha') idpl(dominio)
			matrix define beta=r(b)'
			drop _all
			svmat beta
			keep if (_n==3)
			save "$results/Seminario/KS/KS_FGT`alpha'_`linea'_tn_2005-2015", replace
			export excel using "$results/Seminario/KS/KS_FGT`alpha'_`linea'_tn_2005-2015.xlsx", sheet("KS_FGT`alpha'_`linea'_tn_2005-2015", modify) firstrow(variables)
			restore
		}

	}

	*13 CIUDADES PRINCIPALES Y ÁREAS METROPOLITANAS*

	foreach linea of newlist p i {
	
		forvalues alpha=0(1)2 {
			preserve
			skdecomp ipcug [w=fex_c] if (ciudad!=.), by(year) varpl(l`linea') indicator(fgt`alpha') idpl(dominio)
			matrix define beta=r(b)'
			drop _all
			svmat beta
			keep if (_n==3)
			save "$results/Seminario/KS/KS_FGT`alpha'_`linea'_urb_2005-2015", replace
			export excel using "$results/Seminario/KS/KS_FGT`alpha'_`linea'_urb_2005-2015.xlsx", sheet("KS_FGT`alpha'_`linea'_urb_2005-2015", modify) firstrow(variables)
			restore
		}

	}

	*RESTO URBANO*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			preserve
			skdecomp ipcug [w=fex_c] if (dominio!="RURAL" & ciudad==.), by(year) varpl(l`linea') indicator(fgt`alpha') idpl(dominio)
			matrix define beta=r(b)'
			drop _all
			svmat beta
			keep if (_n==3)
			save "$results/Seminario/KS/KS_FGT`alpha'_`linea'_resturb_2005-2015", replace
			export excel using "$results/Seminario/KS/KS_FGT`alpha'_`linea'_resturb_2005-2015.xlsx", sheet("KS_FGT`alpha'_`linea'_resturb_2005-2015", modify) firstrow(variables)
			restore
		}

	}

	*RURAL*

	foreach linea of newlist p i {

		forvalues alpha=0(1)2 {
			preserve
			skdecomp ipcug [w=fex_c] if (dominio=="RURAL"), by(year) varpl(l`linea') indicator(fgt`alpha') idpl(dominio)
			matrix define beta=r(b)'
			drop _all
			svmat beta
			keep if (_n==3)
			save "$results/Seminario/KS/KS_FGT`alpha'_`linea'_rur_2005-2015", replace
			export excel using "$results/Seminario/KS/KS_FGT`alpha'_`linea'_rur_2005-2015.xlsx", sheet("KS_FGT`alpha'_`linea'_rur_2005-2015", modify) firstrow(variables)
			restore
		}

	}


*##############################################################################*
* INFORMALIDAD LABORAL (IL) *
*##############################################################################*


matrix define   IL = J(4,17,.)
matrix rownames IL = "Total nacional" "Principales ciudades" "Resto urbano" "Rural"
matrix colnames IL = "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018"

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

preserve
drop _all
svmat IL
export excel using "$results/Seminario/IL/IL.xlsx", sheet("IL", modify) firstrow(variables)
restore


*##############################################################################*
* PARTICIPACIÓN LABORAL FEMENINA (PLF) *
*##############################################################################*


matrix define   PLF = J(4,17,.)
matrix rownames PLF = "Total nacional" "Principales ciudades" "Resto urbano" "Rural"
matrix colnames PLF = "2002" "2003" "2004" "2005" "2006" "2007" "2008" "2009" "2010" "2011" "2012" "2013" "2014" "2015" "2016" "2017" "2018"

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

preserve
drop _all
svmat PLF
export excel using "$results/Seminario/PLF/PLF.xlsx", sheet("PLF", modify) firstrow(variables)
restore
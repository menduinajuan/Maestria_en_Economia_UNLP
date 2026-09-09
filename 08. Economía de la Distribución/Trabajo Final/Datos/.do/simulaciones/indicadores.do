args v0 v1


*##############################################################################*
* INDICADORES DE POBREZA E INDIGENCIA *
*##############################################################################*


foreach area of newlist tn urb resturb rur {
	matrix define   pob_`area' = J(6,2,.)
	matrix rownames pob_`area' = "FGT0_p" "FGT1_p" "FGT2_p" "FGT0_i" "FGT1_i" "FGT2_i"
	matrix colnames pob_`area' = "`v0'" "`v1'"
}

*TOTAL NACIONAL*

local i=1
foreach linea of newlist p i {

	forvalues alpha=0(1)2 {

		local j=1

		foreach var of varlist `v0' `v1' {
			fgt `var' [w=fex_c], alpha(`alpha') zeta(l`linea')
			matrix pob_tn [`i'+`alpha',`j']=r(fgt)
			local j=`j'+1
		}

	}

	local i=`i'+3

}

*13 CIUDADES PRINCIPALES Y ÁREAS METROPOLITANAS*

local i=1
foreach linea of newlist p i {

	forvalues alpha=0(1)2 {

		local j=1

		foreach var of varlist `v0' `v1' {
			fgt `var' [w=fex_c] if (ciudad!=.), alpha(`alpha') zeta(l`linea')
			matrix pob_urb [`i'+`alpha',`j']=r(fgt)
			local j=`j'+1
		}

	}

	local i=`i'+3

}

*RESTO URBANO*

local i=1
foreach linea of newlist p i {

	forvalues alpha=0(1)2 {

		local j=1

		foreach var of varlist `v0' `v1' {
			fgt `var' [w=fex_c] if (dominio!="RURAL" & ciudad==.), alpha(`alpha') zeta(l`linea')
			matrix pob_resturb [`i'+`alpha',`j']=r(fgt)
			local j=`j'+1
		}

	}

	local i=`i'+3

}

*RURAL*

local i=1
foreach linea of newlist p i {

	forvalues alpha=0(1)2 {

		local j=1

		foreach var of varlist `v0' `v1' {
			fgt `var' [w=fex_c] if (dominio=="RURAL"), alpha(`alpha') zeta(l`linea')
			matrix pob_rur [`i'+`alpha',`j']=r(fgt)
			local j=`j'+1
		}

	}

	local i=`i'+3

}

/*
foreach area of newlist tn urb resturb rur {
	preserve
	drop _all
	svmat pob_`area'
	export excel using "$results\Simulaciones\sim-`v1'_`area'.xlsx", sheet("sim-`v1'_`area'", modify) firstrow(variables)
	restore
}
*/


*##############################################################################*
* FUNCIONES DE DISTRIBUCIÓN *
*##############################################################################*


sort `v0'
generate sumpop=sum(fex_c)
generate shrpop=sumpop/sumpop[_N]
generate suminc=sum(`v0'*fex_c)
generate shrinc=suminc/suminc[_N]
generate n_suminc=sum(`v1'*fex_c)
generate n_shrinc=n_suminc/n_suminc[_N]

generate l`v1'=log(`v1')

graph twoway	(line shrpop `v0', lcolor(black)), title("Función de Distribución (niv)", color(black)) ///
				ytitle("Share de la población") xtitle("`v0'") xline(257432.5, lcolor(red))
graph twoway	(line shrpop l`v0', lcolor(black)), title("Función de Distribución (log)", color(black)) ///
				ytitle("Share de la población") xtitle("Logaritmo del `v0'") xline(12.458513, lcolor(red))

sort `v1'
generate n_sumpop=sum(fex_c)
generate n_shrpop=n_sumpop/n_sumpop[_N]

graph twoway	(line n_shrpop `v1', lcolor(black)), title("Función de Distribución (niv)", color(black)) ///
				ytitle("Share de la población") xtitle("`v1'") xline(257432.5, lcolor(red))
graph twoway	(line n_shrpop l`v1', lcolor(black)), title("Función de Distribución (log)", color(black)) ///
				ytitle("Share de la población") xtitle("Logaritmo del `v1'") xline(12.458513, lcolor(red))


*drop sumpop shrpop suminc shrinc n_sumpop n_shrpop n_suminc n_shrinc l`v0' l`v1'


*##############################################################################*
* CURVA DE INCIDENCIA DEL CRECIMIENTO (CIC) *
*##############################################################################*


preserve

replace fex_c=round(fex_c)

cuantiles `v0' [w=fex_c], ncuantiles(100) generate(percentil)

table percentil [w=fex_c], contents(mean `v0' mean `v1') replace

generate cambio=(table2/table1-1)*100

graph twoway	(line cambio percentil if (percentil>1), lcolor(black)), title("Curva de Incidencia del Crecimiento", color(black)) ///
				ytitle("Variación % promedio del IPCUG") xtitle("Percentiles del IPCUG") yline(0, lcolor(red)) xlabel(#10)

restore
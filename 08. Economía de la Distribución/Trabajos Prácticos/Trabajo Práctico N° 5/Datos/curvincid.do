*Año 2017*

do "arg17"

keep ipcf pondih
tempfile arg17
save `arg17', replace

*Año 2019*

do "arg19"

keep ipcf pondih
tempfile arg19
save `arg19', replace

*Homogeneización de Bases*

local ipc17=103.80
local ipc19=197.10

foreach i in 17 19 {

	drop _all
	use `arg`i'', clear

	if "`i'" == "17" {
		replace ipcf=ipcf*`ipc19'/`ipc17'
	}

	sort ipcf

	generate shrpop=sum(pondih)
	replace shrpop=shrpop/shrpop[_N]

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

*Gráfico*

generate chg=(ipcf19/ipcf17-1)*100

graph twoway	(line chg percentil, lcolor(black)), title("Curva de Incidencia del Crecimiento 2017-t1 - 2019-t1") ///
				ytitle("Variación % promedio del IPCF") xtitle("Percentiles del IPCF") yline(0, lcolor(red)) xlabel(#10)
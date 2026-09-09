args v0 v1

generate welf0=`v0'
generate welf1=`v1'

preserve

gcuan welf0 [w=pondiio], ncuantiles(100) generate(percentil)

table percentil [w=pondiio], contents(mean welf0 mean welf1) replace

generate cambio=(table2/table1-1)*100

graph twoway 	(line cambio percentil if (percentil>1), lcolor(black)), title("Curva de Incidencia del Crecimiento", color(black)) ///
				ytitle("Variación % promedio del IPCF") xtitle("Percentiles del IPCF") yline(0, lcolor(red)) xlabel(#10)

restore

drop welf0 welf1
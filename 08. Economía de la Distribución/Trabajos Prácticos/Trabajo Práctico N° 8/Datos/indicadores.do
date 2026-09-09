args nombre

local lp=4006.098

*Índices de Desigualdad*

gini ipcf [w=pondih]
gini ipcf_`nombre' [w=pondih]

theil ipcf [w=pondih]
theil ipcf_`nombre' [w=pondih]

foreach i of numlist 0 0.5 1 2 {
	atk ipcf [w=pondih], epsilon(`i')
	atk ipcf_`nombre' [w=pondih], epsilon(`i')
}

*Índices de Pobreza*

povdeco5 ipcf [w=pondih], pline(`lp')
povdeco5 ipcf_`nombre' [w=pondih], pline(`lp')

matrix define   FGT = J(2,3,.)
matrix rownames FGT = "IPCF" "IPCF_`nombre'"
matrix colnames FGT = "FGT0" "FGT1" "FGT2"

forvalues alpha=0(1)2 {
	fgt ipcf [w=pondih], alpha(`alpha') zeta(`lp')
	matrix FGT [1,`alpha'+1]=r(fgt)
	fgt ipcf_`nombre' [w=pondih], alpha(`alpha') zeta(`lp')
	matrix FGT [2,`alpha'+1]=r(fgt)
}

matrix list FGT

*Curvas de Lorenz*

sort ipcf
generate sumpop=sum(pondih)
generate shrpop=sumpop/sumpop[_N]
generate suminc=sum(ipcf*pondih)
generate shrinc=suminc/suminc[_N]
generate n_suminc=sum(ipcf_`nombre'*pondih)
generate n_shrinc=n_suminc/n_suminc[_N]

graph twoway	(line shrinc shrpop, lcolor(red)) (line shrinc shrinc, lcolor(black)), ///
				title("Curva de Lorenz", color(black)) ytitle("L(p)") xtitle("p") legend(label(1 "Curva de Lorenz") label(2 "LPI"))
graph twoway	(line n_shrinc shrpop, lcolor(red)) (line n_shrinc n_shrinc, lcolor(black)), ///
				title("Curva de Lorenz", color(black)) ytitle("L(p)") xtitle("p") legend(label(1 "Curva de Lorenz") label(2 "LPI"))

graph twoway	(line shrinc shrpop, lcolor(red)) (line n_shrinc shrpop, lcolor(blue) lpat(dash)) (line shrinc shrinc, lcolor(black)), ///
				title("Curva de Lorenz"v) ytitle("L(p)") xtitle("p") legend(label(1 "Original") label(2 "Contrafáctico") label(3 "LPI"))

*Funciones de Distribución*

generate lipcf=log(ipcf)
generate lipcf_`nombre'=log(ipcf_`nombre')

graph twoway	(line shrpop ipcf, lcolor(black)), title("Función de Distribución (niv)", color(black)) ///
				ytitle("Share de la población") xtitle("IPCF") xline(4006.098, lcolor(red))
graph twoway	(line shrpop lipcf, lcolor(black)), title("Función de Distribución (log)", color(black)) ///
				ytitle("Share de la población") xtitle("Logaritmo del IPCF") xline(8.296, lcolor(red))

sort ipcf_`nombre'
generate n_sumpop=sum(pondih)
generate n_shrpop=n_sumpop/n_sumpop[_N]

graph twoway	(line n_shrpop ipcf_`nombre', lcolor(black)), title("Función de Distribución (niv)", color(black)) ///
				ytitle("Share de la población") xtitle("IPCF_`nombre'") xline(4006.098, lcolor(red))
graph twoway	(line n_shrpop lipcf_`nombre', lcolor(black)), title("Función de Distribución (log)", color(black)) ///
				ytitle("Share de la población") xtitle("Logaritmo del IPCF_`nombre'") xline(8.296, lcolor(red))


drop sumpop shrpop suminc shrinc n_sumpop n_shrpop n_suminc n_shrinc lipcf lipcf_`nombre'
clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/4. Econometría Avanzada/Trabajos Prácticos/Parte II/Trabajo Práctico N° 3/Datos"
use "base_Bosch&Manacorda", clear


*##############################################################################*
									* PARTE I *
*##############################################################################*


*INCISO (a)*

kdensity wage_std_04s2, lcolor(black) title("Ancho de banda: Óptimo", color(black)) ytitle("Densidad") xtitle("Logaritmo del salario") name("Óptimo", replace)

return list

local banda=r(bwidth)
local banda_2=`banda'/2
local banda2=`banda'*2

kdensity wage_std_04s2, bwidth(`banda_2') lcolor(black) title("Ancho de banda: Óptimo/2", color(black)) ///
						ytitle("Densidad") xtitle("Logaritmo del salario") name("Óptimo_2", replace)

kdensity wage_std_04s2, bwidth(`banda2') lcolor(black) title("Ancho de banda: Óptimo*2", color(black)) ///
						ytitle("Densidad") xtitle("Logaritmo del salario") name("Óptimo2", replace)

graph combine Óptimo Óptimo_2 Óptimo2, name("Ancho_de_banda_Óptimo_Combinado", replace)

*INCISO (b)*

kdensity wage_std_04s2, lcolor(black) title("Kernel Epanechnikov", color(black)) ///
						ytitle("Densidad") xtitle("Logaritmo del salario") name("Kernel_Epanechnikov", replace)

kdensity wage_std_04s2, lcolor(black) title("Kernel Epanechnikov Modificado", color(black)) kernel(epan2) ///
						ytitle("Densidad") xtitle("Logaritmo del salario") name("Kernel_Epanechnikov_Modificado", replace)

kdensity wage_std_04s2, lcolor(black) title("Kernel Gaussiano", color(black)) kernel(gaussian) ///
						ytitle("Densidad") xtitle("Logaritmo del salario") name("Kernel_Gaussiano", replace)

kdensity wage_std_04s2, lcolor(black) title("Kernel Triangular", color(black)) kernel(triangle) ///
						ytitle("Densidad") xtitle("Logaritmo del salario") name("Kernel_Triangular", replace)

graph combine Kernel_Epanechnikov Kernel_Epanechnikov_Modificado Kernel_Gaussiano Kernel_Triangular, name("Kernel_Combinado", replace)

*INCISO (c)*

summarize min_wage_std_93
local s_minimo_93=r(mean)
summarize min_wage_std_04s2
local s_minimo_04s2=r(mean)

graph twoway	(kdensity wage_std_93, lcolor(black)) (kdensity wage_std_04s2, lcolor(black)), ///
				title("Argentina: 1993 vs. 2004", color(black)) ytitle("Densidad") xtitle("Logaritmo del salario") ///
				xline(`s_minimo_93', lcolor(red)) xline(`s_minimo_04s2', lcolor(red)) name("Argentina_1993_2004", replace)

graph twoway	(kdensity wage_std_93 if (formal_93==1), lcolor(black)) (kdensity wage_std_93 if (formal_93==0), lcolor(black)), ///
				title("Argentina 1993", color(black)) ytitle("Densidad") xtitle("Logaritmo del salario") ///
				xline(`s_minimo_93', lcolor(red)) name("Argentina_1993", replace)

graph twoway	(kdensity wage_std_04s2 if (formal_04s2==1), lcolor(black)) (kdensity wage_std_04s2 if (formal_04s2==0), lcolor(black)), ///
				title("Argentina 2004", color(black)) ytitle("Densidad") xtitle("Logaritmo del salario") ///
				xline(`s_minimo_04s2', lcolor(red)) name("Argentina_2004", replace)

summarize min_wage_std_89
local s_minimo_89=r(mean)
summarize min_wage_std_01
local s_minimo_01=r(mean)

graph twoway	(kdensity wage_std_89 if (zona_89==2), lcolor(black)) (kdensity wage_std_01 if (zona_01==2), lcolor(black)), ///
				title("México: 1989 vs. 2001", color(black)) ytitle("Densidad") xtitle("Logaritmo del salario") ///
				xline(`s_minimo_89', lcolor(red)) xline(`s_minimo_01', lcolor(red)) name("México_1989_2001", replace)

graph twoway	(kdensity wage_std_89 if (zona_89==2 & formal_89==1), lcolor(black)) (kdensity wage_std_89 if (zona_89==2 & formal_89==0), lcolor(black)), ///
				title("México 1989", color(black)) ytitle("Densidad") xtitle("Logaritmo del salario") ///
				xline(`s_minimo_89', lcolor(red)) name("México_1989", replace)

graph twoway	(kdensity wage_std_01 if (zona_01==2 & formal_01==1), lcolor(black)) (kdensity wage_std_01 if (zona_01==2 & formal_01==0), lcolor(black)), ///
				title("México 2001", color(black)) ytitle("Densidad") xtitle("Logaritmo del salario") ///
				xline(`s_minimo_01', lcolor(red)) name("México_2001", replace)

graph combine Argentina_1993_2004 México_1989_2001, name("Argentina_México_Combinado_1", replace)
graph combine Argentina_1993 Argentina_2004 México_1989 México_2001, name("Argentina_México_Combinado_2", replace)


*##############################################################################*
									* PARTE II *
*##############################################################################*


use "ENGH0405_Engel", clear

*INCISO (a)*

regress sh_g_alim lgastot, robust
predict yhat_1a
predict se_1a, stdp

regress sh_g_alim lgastot lgastot2, robust
predict yhat_2a
predict se_2a, stdp

*INCISO (b)*

lpoly sh_g_alim lgastot, color(black) degree(0) kernel(gaussian) bwidth(0.18) title("Estimación No Paramétrica")

*INCISO (c)*

generate lim_sup_a=yhat_1a+se_1a*1.96
generate lim_inf_a=yhat_1a-se_1a*1.96

lpoly	sh_g_alim lgastot, noscatter ci degree(0) kernel(gaussian) bwidth(0.18) ///
		addplot(qfit yhat_1a lgastot || qfit yhat_2a lgastot || line lim_sup_a lgastot || line lim_inf_a lgastot) ///
		title("Estimación Paramétrica vs. No Paramétrica", color(black)) ytitle("Share del gasto en alimentos") xtitle("Logaritmo del gasto total familiar")

*Inciso (d)*

regress sh_g_transp lgastot, robust
predict yhat_1t
predict se_1t, stdp

regress sh_g_transp lgastot lgastot2, robust
predict yhat_2t
predict se_2t, stdp

lpoly sh_g_transp lgastot, color(black) degree(0) kernel(gaussian) bwidth(0.18) title("Estimación No Paramétrica")

generate lim_sup_t=yhat_1t+se_1t*1.96
generate lim_inf_t=yhat_1t-se_1t*1.96

lpoly	sh_g_transp lgastot, noscatter ci degree(0) kernel(gaussian) bwidth(0.18) ///
		addplot(qfit yhat_1t lgastot || qfit yhat_2t lgastot || line lim_sup_t lgastot || line lim_inf_t lgastot) ///
		title("Estimación Paramétrica vs. No Paramétrica", color(black)) ytitle("Share del gasto en transporte") xtitle("Logaritmo del gasto total familiar")

*INCISO (e)*

quietly include "zheng"

/*
zheng sh_g_alim lgastot
zheng sh_g_alim lgastot lgastot2

zheng sh_g_transp lgastot
zheng sh_g_transp lgastot lgastot2
*/


*##############################################################################*
									* PARTE III *
*##############################################################################*


use "ENGH0405_Engel_semipar", clear

*INCISO (a)*

*ssc install semipar

semipar sh_g_alim nhijos, nonpar(lgastot) degree(0) kernel(gaussian)

*INCISO (b)*			

local b=_b[nhijos]
generate sh_g_alim_hijo=sh_g_alim-nhijos*`b'
lpoly sh_g_alim_hijo lgastot, color(black) scatter kernel(gaussian) bwidth(0.22) title("Estimación No Paramétrica", color(black))

*INCISO (c)*

lpoly	sh_g_alim_hijo lgastot, noscatter ci degree(0) kernel(gaussian) bwidth(0.22) addplot(lpoly sh_g_alim lgastot, degree(0) kernel(gaussian) bwidth(0.22)) ///
		title("Estimación Semiparamétrica vs. No Paramétrica", color(black)) ytitle("Share del gasto en alimentos") xtitle("Logaritmo del gasto total familiar") ///
		legend(label(1 "95% CI") label(2 "Semiparamétrica") label(3 "No Paramétrica"))
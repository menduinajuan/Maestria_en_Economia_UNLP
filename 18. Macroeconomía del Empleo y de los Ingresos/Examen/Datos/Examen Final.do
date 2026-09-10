clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/18. Macroeconomía del Empleo y de los Ingresos/Examen/Datos"
*do "prepara_base_1"


*ssc install oaxaca


*##############################################################################*
								* EJERCICIO 1.1.b *
*##############################################################################*


use "Base", clear

keep if (pp04b_cod!=9700)														// Se excluye al servicio doméstico
keep if (cat_ocup==3)															// Se incluye sólo al conjunto de asalariados
keep if (ch06>=15 & ch06<=60)													// Se incluye sólo al conjunto de asalariados entre 15 y 60 años de edad
drop if (pp08d1<0)																// Se excluye no respuesta de ingresos de la ocupación principal de los asalariados

do "prepara_base_2"

*Ecuación de Mincer*

*Estimación MCO*
regress lilaho hombre edad edad2 pric seci secc supi supc jefe informal ///
		agricultura minas construccion comercio transporte financiero otros_sectores est_mediano est_grande est_muygrande ///
		gba noa nea cuyo pampeana patagonica [w=pondiio], robust

*Estimación Heckman en dos etapas*
heckman lilaho hombre edad edad2 pric seci secc supi supc jefe informal ///
		agricultura minas construccion comercio transporte financiero otros_sectores est_mediano est_grande est_muygrande ///
		gba noa nea cuyo pampeana patagonica, select(ocupado = edad edad2 pric seci secc supi supc) twostep

*Estimación Heckman por máxima verosimilitud*
heckman lilaho hombre edad edad2 pric seci secc supi supc jefe informal ///
		agricultura minas construccion comercio transporte financiero otros_sectores est_mediano est_grande est_muygrande ///
		gba noa nea cuyo pampeana patagonica, select(ocupado = edad edad2 pric seci secc supi supc) vce(robust)


*##############################################################################*
								* EJERCICIO 1.2 *
*##############################################################################*


*Three-fold*

oaxaca	lilaho edad edad2 pric seci secc supi supc jefe informal  ///
		agricultura minas construccion comercio transporte financiero otros_sectores est_mediano est_grande est_muygrande ///
		gba noa nea cuyo pampeana patagonica [w=pondiio], by(mujer) nodetail

*Three-fold Heckman*

oaxaca	lilaho edad edad2 pric seci secc supi supc jefe informal ///
		agricultura minas construccion comercio transporte financiero otros_sectores est_mediano est_grande est_muygrande ///
		gba noa nea cuyo pampeana patagonica, by(mujer) nodetail ///
		model1(heckman, select(ocupado = edad edad2 pric seci secc supi supc) twostep) model2(heckman, select(ocupado = edad edad2 pric seci secc supi supc) twostep)

*Two-fold pooled*

oaxaca	lilaho edad edad2 pric seci secc supi supc jefe informal  ///
		agricultura minas construccion comercio transporte financiero otros_sectores est_mediano est_grande est_muygrande ///
		gba noa nea cuyo pampeana patagonica [w=pondiio], by(mujer) nodetail pooled

*Two-fold discrimination*

oaxaca	lilaho edad edad2 pric seci secc supi supc jefe informal ///
		agricultura minas construccion comercio transporte financiero otros_sectores est_mediano est_grande est_muygrande ///
		gba noa nea cuyo pampeana patagonica, by(mujer) nodetail weight(1) ///
		model1(heckman, select(ocupado = edad edad2 pric seci secc supi supc) twostep) model2(heckman, select(ocupado = edad edad2 pric seci secc supi supc) twostep)


*##############################################################################*
								* EJERCICIO 2.3 *
*##############################################################################*


use "Base", clear

drop if (nro_hogar==51 | nro_hogar==71)											// Se excluye "Servicio doméstico en hogares" y "Pensionistas en hogares"
drop if (estado==0)																// Se excluye "Entrevista individual no realizada"

do "prepara_base_3"

*Estadísticas*

tabulate activo [w=pondera]

foreach var of varlist hombre edad prii pric seci secc supi supc no_conyuge conyuge_desocupado conyuge_inactivo menor_1 de_1_a_2 de_3_a_17 hijos adultos {
	tabstat  `var' [w=pondera], by(activo) statistics(mean sd)
}

tabstat itf_neto [w=pondih], by(activo) statistics(mean sd)
tabstat transf   [w=pondii], by(activo) statistics(mean sd)

*Modelo Probit*

probit	activo i.hombre i.edad_15_34 i.edad_45_60 i.pric i.seci i.secc i.supi i.supc i.no_conyuge i.conyuge_desocupado i.conyuge_inactivo ///
		i.menor_1 i.de_1_a_2 i.de_3_a_17 c.hijos i.adultos c.itf_neto c.transf [w=pondiio], robust

*Efectos marginales*

margins, dydx(*)


*##############################################################################*
								* EJERCICIO 3.2 *
*##############################################################################*


use "Bosch&Manacorda", clear

*FIGURA 1*

kdensity wage_std_04s2, title("Ancho de banda: Óptimo") ytitle("Densidad") xtitle("Log del Salario") name("Óptimo", replace)

return list

local banda=r(bwidth)
local banda_2=`banda'/2
local banda2=`banda'*2

kdensity wage_std_04s2, bwidth(`banda_2') title("Ancho de banda: Óptimo/2") ytitle("Densidad") xtitle("Log del Salario") name("Óptimo_2", replace)
kdensity wage_std_04s2, bwidth(`banda2') title("Ancho de banda: Óptimo*2") ytitle("Densidad") xtitle("Log del Salario") name("Óptimo2", replace)

graph combine Óptimo Óptimo_2 Óptimo2, name("Ancho_de_banda_Óptimo_Combinado", replace)

*FIGURA 2*

kdensity wage_std_04s2, title("Kernel Epanechnikov") ytitle("Densidad") xtitle("Log del Salario") name("Kernel_Epanechnikov", replace)
kdensity wage_std_04s2, title("Kernel Epanechnikov Modificado") kernel(epan2) ytitle("Densidad") xtitle("Log del Salario") name("Kernel_Epanechnikov_Modificado", replace)
kdensity wage_std_04s2, title("Kernel Gaussiano") kernel(gaussian) ytitle("Densidad") xtitle("Log del Salario") name("Kernel_Gaussiano", replace)
kdensity wage_std_04s2, title("Kernel Triangular") kernel(triangle) ytitle("Densidad") xtitle("Log del Salario") name("Kernel_Triangular", replace)

graph combine Kernel_Epanechnikov Kernel_Epanechnikov_Modificado Kernel_Gaussiano Kernel_Triangular, name("Kernel_Combinado", replace)

*FIGURA 3 Y 4*

summarize min_wage_std_93
local s_minimo_93=r(mean)
summarize min_wage_std_04s2
local s_minimo_04s2=r(mean)

graph twoway	(kdensity wage_std_93, lcolor(black)) (kdensity wage_std_04s2, lcolor(black)), title("Argentina: 1993 vs. 2004") ///
				ytitle("Densidad") xtitle("Log del Salario") xline(`s_minimo_93', lcolor(red)) xline(`s_minimo_04s2', lcolor(red)) name("Argentina_1993_2004", replace)

graph twoway	(kdensity wage_std_93 if (formal_93==1), lcolor(black)) (kdensity wage_std_93 if (formal_93==0), lcolor(black)), ///
				title("Argentina 1993") ytitle("Densidad") xtitle("Log del Salario") xline(`s_minimo_93', lcolor(red)) name("Argentina_1993", replace)

graph twoway	(kdensity wage_std_04s2 if (formal_04s2==1), lcolor(black)) (kdensity wage_std_04s2 if (formal_04s2==0), lcolor(black)), ///
				title("Argentina 2004") ytitle("Densidad") xtitle("Log del Salario") xline(`s_minimo_04s2', lcolor(red)) name("Argentina_2004", replace)

summarize min_wage_std_89
local s_minimo_89=r(mean)
summarize min_wage_std_01
local s_minimo_01=r(mean)

graph twoway	(kdensity wage_std_89 if (zona_89==2), lcolor(black)) (kdensity wage_std_01 if (zona_01==2), lcolor(black)), ///
				title("México: 1989 vs. 2001") ytitle("Densidad") xtitle("Log del Salario") xline(`s_minimo_89', lcolor(red)) xline(`s_minimo_01', lcolor(red)) ///
				name("México_1989_2001", replace)

graph twoway	(kdensity wage_std_89 if (zona_89==2 & formal_89==1), lcolor(black)) (kdensity wage_std_89 if (zona_89==2 & formal_89==0), lcolor(black)), ///
				title("México 1989") ytitle("Densidad") xtitle("Log del Salario") xline(`s_minimo_89', lcolor(red)) name("México_1989", replace)

graph twoway	(kdensity wage_std_01 if (zona_01==2 & formal_01==1), lcolor(black)) (kdensity wage_std_01 if (zona_01==2 & formal_01==0), lcolor(black)), ///
				title("México 2001") ytitle("Densidad") xtitle("Log del Salario") xline(`s_minimo_01', lcolor(red)) name("México_2001", replace)

graph combine Argentina_1993_2004 México_1989_2001, name("Argentina_México_Combinado_1", replace)
graph combine Argentina_1993 Argentina_2004 México_1989 México_2001, name("Argentina_México_Combinado_2", replace)
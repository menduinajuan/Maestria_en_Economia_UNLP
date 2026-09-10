clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/13. Economía Laboral/Trabajos Prácticos/Trabajo Práctico N° 4/Datos"
use "panel-arg", clear
do "prepara_base"


*search renvars


*##############################################################################*
								* EJERCICIO 1 *
*##############################################################################*


preserve

keep if (edad4>=25 & edad4<=54)

*Condición de Actividad*
tabulate cond_act4 cond_act9 [w=pondera9] if (idp_p==4), row

*Informalidad*
tabulate informal4 informal9 [w=pondera9] if (idp_p==4), row

*Relación Ocupacional*
tabulate rel_ocup4 rel_ocup9 [w=pondera9] if (idp_p==4), row

*Quintiles del IPCF*
tabulate qipcf4 qipcf9 [w=pondera9] if (idp_p==4), row

restore


*##############################################################################*
								* EJERCICIO 2 *
*##############################################################################*


*INCISO (a)*

forvalues p=1(1)7 {
	preserve
	keep if (edad`p'>=25 & edad`p'<=54)
	local t=`p'+5
	tabulate cond_act`t' [w=pondera`t'] if (cond_act`p'==2 & idp_p==`p'), matcell(P`p')
	restore
}

matrix define A=(P1,P2,P3,P4,P5,P6,P7)
matrix list A

matrix define A=A'
matrix list A

matrix define aux1=(1\2\3\4\5\6\7)
matrix list aux1

matrix define   A = (aux1,A)
matrix rownames A = "P1" "P2" "P3" "P4" "P5" "P6" "P7"
matrix colnames A = "Panel" "Ocupado" "Desocupado" "Inactivo"
matrix list A

preserve
svmat A
renvars A1 A2 A3 A4 \ panel ocupado desocupado inactivo
graph bar	ocupado desocupado inactivo, title("Transición de Desocupados por Condición de Actividad") ytitle("Porcentaje") ///
			legend(label(1 "Ocupado") label(2 "Desocupado") label(3 "Inactivo") row(1)) ///
			over(panel) stack percentages blabel(bar, position(center) format(%10.0f))
restore

*INCISO (b)*

forvalues p=1(1)7 {
	preserve
	keep if (edad`p'>=25 & edad`p'<=54)
	local t=`p'+5
	tabulate rel_ocup`t' [w=pondera`t'] if (rel_ocup`p'==4 & idp_p==`p'), matcell(P`p')
	restore
}

matrix define B=(P1,P2,P3,P4,P5,P6,P7)
matrix list B

matrix define B=B'
matrix list B

matrix define aux2=(1\2\3\4\5\6\7)
matrix list aux2

matrix define   B = (aux2,B)
matrix rownames B = "P1" "P2" "P3" "P4" "P5" "P6" "P7"
matrix colnames B = "Panel" "Cuentapropista" "Asalariado Formal" "Asalariado Informal" "Desocupado" "Inactivo"
matrix list B

preserve
svmat B
renvars B1 B2 B3 B4 B5 B6 \ panel cuenta_propista asal_formal asal_informal desocupado inactivo
graph bar	cuenta_propista asal_formal asal_informal desocupado inactivo, title("Transición de Desocupados por Relación Ocupacional") ytitle("Porcentaje") ///
			legend(label(1 "Cuentapropista") label(2 "Asal. Formal") label(3 "Asal. Informal") label(4 "Desocupado") label(5 "Inactivo") row(2)) ///
			over(panel) percentages stack blabel(bar, position(center) format(%10.0f))
restore


*##############################################################################*
								* EJERCICIO 3 *
*##############################################################################*


clear all
use "panel-arg", clear

keep if (edad>=25 & edad<=54)

generate informal=1-djubila
generate edad2=edad*edad

regress informal hombre edad edad2 i.empresa i.qipcf i.ano, robust
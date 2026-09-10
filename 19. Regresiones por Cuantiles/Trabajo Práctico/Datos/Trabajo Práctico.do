clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/19. Regresiones por Cuantiles/Trabajo Práctico/Datos"
use "eph14s2_mincer", clear


*ssc install grqreg


describe
set seed 12345


*##############################################################################*
								* EJERCICIO 1 *
*##############################################################################*


*Generación de variables*

generate lilaho=log(salario)
generate edad2=edad^2
generate educ2=educ^2

*Generación de etiquetas*

label variable pais			"País"	
label variable ano			"Año de la encuesta"
label variable id			"Identificación única del hogar"
label variable componente	"Identificación del componente"
label variable edad			"Edad"
label variable gedad1		"Grupos de edad: 2=[18,24], 3=[25,40], 4=[41,64], 5=[65]"
label variable sexo			"Sexo"
label variable jefe			"Dummy de jefe de hogar"
label variable conyuge		"Dummy de cónyuge del jefe de hogar"
label variable hijo			"Dummy de hijo del jefe de hogar"
label variable casado		"Dummy de estado civil: casado o unido"
label variable soltero		"Dummy de estado civil: soltero"
label variable educ			"Años de educación aprobados"
label variable nivel		"Máximo nivel educativo alcanzado"
label variable salario		"Ingreso horario en la ocupación principal"
label variable caba			"CABA"

label variable lilaho		"Logaritmo del ingreso horario en la ocupación principal"
label variable edad2		"Edad al cuadrado"
label variable educ2		"Años de educación aprobados al cuadrado"

*Estadísticas descriptivas*

forvalues i=2(1)5 {
	tabstat lilaho if (gedad1==`i'), statistics(mean p10 median p90 min max)
}

forvalues i=0(1)6 {
	tabstat lilaho if (nivel==`i'), statistics(mean p10 median p90 min max)
}

forvalues i=0(1)1 {
	tabstat lilaho if (sexo==`i'), statistics(mean p10 median p90 min max)
}

forvalues i=0(1)1 {
	tabstat lilaho if (caba==`i'), statistics(mean p10 median p90 min max)
}

*Ecuación de Mincer*

regress lilaho edad edad2 educ educ2 sexo caba

*Efectos marginales*

display "Efecto marginal de la variable edad: " (_b[edad]+2*_b[edad2]*30)*100
display "Efecto marginal de la variable educ: " (_b[educ]+2*_b[educ2]*12)*100
display "Efecto marginal de la variable sexo: " (exp(_b[sexo])-1)*100
display "Efecto marginal de la variable caba: " (exp(_b[caba])-1)*100


*##############################################################################*
								* EJERCICIO 2 *
*##############################################################################*


*Sin Bootstrap (como primera aproximación)*

foreach i of numlist 5 25 50 75 95 {
	qreg lilaho edad edad2 educ educ2 sexo caba, quantile(`i') nolog
}

*Con Bootstrap (estimación de manera individual)*

foreach i of numlist 5 25 50 75 95 {
	bsqreg lilaho edad edad2 educ educ2 sexo caba, quantile(`i') reps(500)
	display "Efecto marginal de la variable educ (estimación cuantil `i'): " (_b[educ]+2*_b[educ2]*12)*100
	test educ educ2
}

*Con Bootstrap (estimación de manera conjunta)*

sqreg lilaho edad edad2 educ educ2 sexo caba, quantile(5 25 50 75 95) reps(500)


*##############################################################################*
								* EJERCICIO 3 *
*##############################################################################*


*¿El efecto parcial de los años de educación sobre el salario es el mismo para los cuantiles condicionales 0.05 y 0.95?*

test [q05=q95]: educ educ2

*¿El conjunto de coeficientes del modelo (a excepción de la ordenada al origen) no difieren entre cuantiles condicionales?*

test [q05=q25=q50=q75=q95]: edad edad2 educ educ2 sexo caba


*##############################################################################*
								* EJERCICIO 4 *
*##############################################################################*


*Tests para chequear si existen efectos marginales heterogéneos entre los cuantiles condicionales estimados (complementario a lo solicitado)*

test [q05=q25=q50=q75=q95]: edad edad2
test [q05=q25=q50=q75=q95]: educ educ2
test [q05=q25=q50=q75=q95]: sexo
test [q05=q25=q50=q75=q95]: caba

*Gráfico del valor de los coeficientes de cada regresión (eje vertical) en función de tau (eje horizontal) - utilizando los cuantiles estimados en el punto 2*

grqreg edad edad2 educ educ2 sexo caba, quantile(5 25 50 75 95) ci ols


*##############################################################################*
								* EJERCICIO 5 *
*##############################################################################*


*Cuantil 25*

qreg lilaho edad edad2 educ educ2 sexo caba, quantile(0.25) nolog
predict xb_1

generate signo_residuo_1 = ""
replace  signo_residuo_1 = "Negativo" if (lilaho-xb_1<0)
replace  signo_residuo_1 = "Nulo"	  if (lilaho-xb_1==0)
replace  signo_residuo_1 = "Positivo" if (lilaho-xb_1>0)
tabulate signo_residuo_1 if (e(sample))

*Cuantil 50*

qreg lilaho edad edad2 educ educ2 sexo caba, quantile(0.50) nolog
predict xb_2

generate signo_residuo_2 = ""
replace  signo_residuo_2 = "Negativo" if (lilaho-xb_2<0)
replace  signo_residuo_2 = "Nulo"     if (lilaho-xb_2==0)
replace  signo_residuo_2 = "Positivo" if (lilaho-xb_2>0)
tabulate signo_residuo_2 if (e(sample))

*Cuantil 75*

qreg lilaho edad edad2 educ educ2 sexo caba, quantile(0.75) nolog
predict xb_3

generate signo_residuo_3 = ""
replace  signo_residuo_3 = "Negativo" if (lilaho-xb_3<0)
replace  signo_residuo_3 = "Nulo"     if (lilaho-xb_3==0)
replace  signo_residuo_3 = "Positivo" if (lilaho-xb_3>0)
tabulate signo_residuo_3 if (e(sample))
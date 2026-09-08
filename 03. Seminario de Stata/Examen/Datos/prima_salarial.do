*##############################################################################*
								* EJERCICIO 4.a *
*##############################################################################*


use "arg2015t2_resumida", clear


*##############################################################################*
								* EJERCICIO 4.b *
*##############################################################################*


generate grupo_c=.
replace grupo_c=1 if (ocupado==1 & nivel_educ<=3)
replace grupo_c=2 if (ocupado==1 & nivel_educ==4)
replace grupo_c=3 if (ocupado==1 & nivel_educ>=5)

label variable grupo_c "Grupos de calificación"
label define grupo_c 1 "No Calificados" 2 "Semi Calificados" 3 "Calificados"
label values grupo_c grupo_c


*##############################################################################*
								* EJERCICIO 4.c *
*##############################################################################*


table grupo_c [weight=pondera], statistic(mean salario)


*##############################################################################*
								* EJERCICIO 4.d *
*##############################################################################*


summarize salario [weight=pondera] if (grupo_c==3)
local w_c=r(mean)

summarize salario [weight=pondera] if (grupo_c==2)
local w_sc=r(mean)

summarize salario [weight=pondera] if (grupo_c==1)
local w_nc=r(mean)


*##############################################################################*
								* EJERCICIO 4.e *
*##############################################################################*


matrix define   Prima1 = J(1,3,.)
matrix rownames Prima1 = "Prima Salarial Promedio"
matrix colnames Prima1 = "Calificados/No Calificados" "Calificados/Semi Calificados" "Semi Calificados/No Calificados"

matrix Prima1 [1,1]=`w_c'/`w_nc'
matrix Prima1 [1,2]=`w_c'/`w_sc'
matrix Prima1 [1,3]=`w_sc'/`w_nc'

matrix list Prima1, title("Primas Salariales Promedio")


*##############################################################################*
								* EJERCICIO 4.f *
*##############################################################################*


matrix define   Prima2 = J(3,3,.)
matrix rownames Prima2 = "[25,35]" "[36,45]" "[46,55]"
matrix colnames Prima2 = "Calificados/No Calificados" "Calificados/Semi Calificados" "Semi Calificados/No Calificados"

forvalues i=1(1)3 {
	summarize salario [weight=pondera] if (grupo_c==3 & gedad==`i')
	local w_c`i'=r(mean)
	summarize salario [weight=pondera] if (grupo_c==2 & gedad==`i')
	local w_sc`i'=r(mean)
	summarize salario [weight=pondera] if (grupo_c==1 & gedad==`i')
	local w_nc`i'=r(mean)
	matrix Prima2 [`i',1]=`w_c`i''/`w_nc`i''
	matrix Prima2 [`i',2]=`w_c`i''/`w_sc`i''
	matrix Prima2 [`i',3]=`w_sc`i''/`w_nc`i''
}

matrix list Prima2, title("Primas Salariales Promedio por Grupo de Edad")


*##############################################################################*
								* EJERCICIO 4.g *
*##############################################################################*


matrix define   Prima3 = J(6,3,.)
matrix rownames Prima3 = "GBA" "NOA" "NEA" "Cuyo" "Pampeana" "Patagónica"
matrix colnames Prima3 = "Calificados/No Calificados" "Calificados/Semi Calificados" "Semi Calificados/No Calificados"

forvalues i=2(1)6 {
	replace region=`i' if (region==`i'+38)	
}

forvalues i=1(1)6 {
	summarize salario [weight=pondera] if (grupo_c==3 & region==`i')
	local w_c`i'=r(mean)
	summarize salario [weight=pondera] if (grupo_c==2 & region==`i')
	local w_sc`i'=r(mean)
	summarize salario [weight=pondera] if (grupo_c==1 & region==`i')
	local w_nc`i'=r(mean)
	matrix Prima3 [`i',1]=`w_c`i''/`w_nc`i''
	matrix Prima3 [`i',2]=`w_c`i''/`w_sc`i''
	matrix Prima3 [`i',3]=`w_sc`i''/`w_nc`i''
}

matrix list Prima3, title("Primas Salariales Promedio por Región")
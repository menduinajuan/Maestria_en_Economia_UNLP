*##############################################################################*
								* EJERCICIO 3.a *
*##############################################################################*


use "arg2015t2", clear


*##############################################################################*
								* EJERCICIO 3.b *
*##############################################################################*


keep if (ch06>=25 | ch06<=55)


*##############################################################################*
								* EJERCICIO 3.c *
*##############################################################################*


generate gedad=.
replace gedad=1 if (ch06>=25 & ch06<=35)
replace gedad=2 if (ch06>=36 & ch06<=45)
replace gedad=3 if (ch06>=46 & ch06<=55)

label variable gedad "Grupos de edad"
label define gedad 1 "[25,35]" 2 "[36,45]" 3 "[46,55]"
label values gedad gedad


*##############################################################################*
								* EJERCICIO 3.d *
*##############################################################################*


generate ocupado=.
replace ocupado=0 if (estado!=1)
replace ocupado=1 if (estado==1)

label variable ocupado "=1 si ocupado"
label define ocupado 0 "No Ocupado" 1 "Ocupado"
label values ocupado ocupado


*##############################################################################*
								* EJERCICIO 3.e *
*##############################################################################*


generate salario=p21/(pp3e_tot*4)

label variable salario "Salario horario en la ocupación principal"


*##############################################################################*
								* EJERCICIO 3.f *
*##############################################################################*


generate nivel_educ=nivel_ed
replace nivel_educ=1 if (nivel_educ==7)

label variable nivel_educ	"Nivel educativo"
label define nivel_educ		1 "Primario Incompleto / Sin Instrucción" 2 "Primario Completo" 3 "Secundario Incompleto" ///
							4 "Secundario Completo" 5 "Superior Universitario Incompleto" 6 "Superior Universitario Completo"
label values nivel_educ nivel_educ

table nivel_educ, statistic(mean salario)


*##############################################################################*
								* EJERCICIO 3.g *
*##############################################################################*


table nivel_educ [weight=pondera], statistic(mean ocupado)


*##############################################################################*
								* EJERCICIO 3.h *
*##############################################################################*


save "arg2015t2_resumida", replace
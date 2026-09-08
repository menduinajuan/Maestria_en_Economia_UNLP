*##############################################################################*
								* EJERCICIO 2.a *
*##############################################################################*


use "Individual_t215", clear
sort CODUSU nro_hogar
merge m:1 CODUSU nro_hogar using "Hogar_t215"
tabulate _merge, nolabel
drop _merge


*##############################################################################*
								* EJERCICIO 2.b *
*##############################################################################*


keep CODUSU nro_hogar componente region pondera ch04 ch06 nivel_ed estado pp3e_tot p21

label variable CODUSU		"Código para distinguir viviendas"
label variable nro_hogar	"Código para distinguir hogares"
label variable componente	"Número de componente"
label variable region		"Código de región"
label variable pondera		"Ponderación"
label variable ch04			"Sexo"
label variable ch06			"Edad en años cumplidos"
label variable nivel_ed		"Nivel educativo"
label variable estado		"Condición de actividad"
label variable pp3e_tot		"Total de horas que trabajó en la semana en la ocupación principal"
label variable p21			"Monto de ingreso de la ocupación principal percibido en ese mes"


*##############################################################################*
								* EJERCICIO 2.c *
*##############################################################################*


drop if (nro_hogar==51 | nro_hogar==71)


*##############################################################################*
								* EJERCICIO 2.d *
*##############################################################################*


egen id=group(CODUSU nro_hogar)

label variable id "Identificador del hogar"


*##############################################################################*
								* EJERCICIO 2.e *
*##############################################################################*


egen miembros=count(componente), by(id)

label variable miembros "Número de miembros del hogar"


*##############################################################################*
								* EJERCICIO 2.f *
*##############################################################################*


order id CODUSU nro_hogar componente miembros pondera ch04 ch06 region nivel_ed estado p21 pp3e_tot
sort id componente
describe
save "arg2015t2", replace
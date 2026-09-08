clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/4. Econometría Avanzada/Trabajos Prácticos/Parte II/Trabajo Práctico N° 2/Datos"
use "ech-laboral-mujeres", clear


*##############################################################################*
								* EJERCICIO 1 *
*##############################################################################*


local vars="edad edad2 pric seci secc supi supc"

regress lilaho `vars', robust


*##############################################################################*
								* EJERCICIO 2 Y 3 *
*##############################################################################*


heckman lilaho `vars', select(trabaja = `vars' asiste hijos12) twostep


*##############################################################################*
								* EJERCICIO 4 *
*##############################################################################*


heckman lilaho `vars', select(trabaja = `vars' asiste hijos12)


*##############################################################################*
								* EJERCICIO 5 *
*##############################################################################*


regress hstrt `vars' asiste hijos12, robust
tobit hstrt `vars' asiste hijos12, ll(0)


*##############################################################################*
								* EJERCICIO 6 *
*##############################################################################*


*Variable Censurada*

margins, predict(ystar(0,.)) dydx(edad hijos12) at((mean) edad pric=0 seci=0 secc=1 supi=0 supc=0 asiste=0 hijos12=2)

*Variable Truncada*

margins, predict(e(0,.)) dydx(edad hijos12) at((mean) edad pric=0 seci=0 secc=1 supi=0 supc=0 asiste=0 hijos12=2)
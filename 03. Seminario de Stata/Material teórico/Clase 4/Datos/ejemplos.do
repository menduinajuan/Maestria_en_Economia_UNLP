clear all
set more off

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/3. Seminario de Stata/Material teórico/Clase 4/Datos"


*Ejercicio A*


clear

use "nic98_cedlas-resumida", clear

matrix define resultados=J(4,1,.)

forvalues i=1(1)4 {
	display "region=" `i'
	summarize ila [w=pondera] if (region==`i')
	matrix resultados[`i',1]=r(mean)
}

matrix list resultados

table region [w=pondera], contents(mean ila)


*Ejercicio B*


clear

matrix define mat=(1,2,3\4,5,6)
matrix dir
matrix list mat

*Mostrar celda [2,3] de matriz mat*
display mat[2,3]

*Mostrar celda [i,j] de matriz mat*

*iterar por filas
forvalues i=1(1)2 {
	*iterar por columnas
	forvalues j=1(1)3 {
		display mat[`i',`j']
	}
}
clear all
set more off
version 17


*##############################################################################*
								* EJERCICIO 1.a *
*##############################################################################*


*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/3. Seminario de Stata/Examen/Datos"


*##############################################################################*
								* EJERCICIO 1.b *
*##############################################################################*


do "prepara_base"
do "educacion_salario"
do "prima_salarial"
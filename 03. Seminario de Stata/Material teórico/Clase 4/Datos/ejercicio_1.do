clear all
set more off

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/3. Seminario de Stata/Material teórico/Clase 4/Datos"


set obs 100
set seed 12345

generate x=runiform()
generate y=runiform()

*¿Cómo genero z?*

*Opción 1*

summarize x
generate mu_x=r(mean)
summarize y
generate z_alt=(x+y)/(mu_x+r(mean))

*Opción 2: Generar z utilizando macros locales*

summarize x
local mu_x=r(mean)
summarize y
local mu_y=r(mean)

display `mu_x'
display `mu_y'

*La macro local se guarda en el momento que se corre el .do*

generate z=(x+y)/(`mu_x'+`mu_y')
clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/3. Seminario de Stata/Material teórico/Clase 3/Datos/Gestión bases"


*Preparar base*
do "prepara_base"

*Gestionar base*
do "gestion_bases"
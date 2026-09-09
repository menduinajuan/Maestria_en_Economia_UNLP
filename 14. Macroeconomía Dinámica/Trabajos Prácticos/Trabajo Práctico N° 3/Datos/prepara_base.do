clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/14. Macroeconomía Dinámica/Trabajos Prácticos/Trabajo Práctico N° 3/Datos"


set obs 201

*Serie de tiempo*

generate aux=_n
generate t=aux-1
drop aux
tsset t

*Shock tecnológico*

local sigma=0.01

generate e_1=rnormal(0,`sigma')

generate e_2=.
replace e_2=2*`sigma' if (t==0)
replace e_2=0 if (t!=0)
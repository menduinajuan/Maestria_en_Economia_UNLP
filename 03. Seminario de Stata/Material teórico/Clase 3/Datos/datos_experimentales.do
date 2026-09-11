clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/3. Seminario de Stata/Material teórico/Clase 3/Datos"


set obs 150

generate fecha=date("18/05/1983","DMY")

generate aux1=1
generate aux2=sum(aux)
generate fecha1=date("18/05/1983","DMY")+aux2-1
drop aux*

generate fecha2=date("18/05/1983","DMY")+_n-1

format fecha2 %dD/N/CY
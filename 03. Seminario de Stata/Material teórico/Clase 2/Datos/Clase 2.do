clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/3. Seminario de Stata/Material teórico/Clase 2/Datos"
use "eph2010_resumida", clear


describe
summarize edad
display r(mean)

generate str auxiliar=""
replace auxiliar="hola"
replace auxiliar="8"

encode pais, gen(npais)

destring auxiliar, replace

generate reg_str=string(region)
generate reg_num=real(reg_str)
encode reg_str, gen(reg_num1)

generate sdate=date(fecha,"DMY")
generate sdate1=date(fecha,"DM19Y")
generate sdate2=date(fecha,"DMY",2030)

format sdate2 %d
format sdate2 %dD_m_CY
format sdate2 %dD/m/Y
format sdate2 %dD/M/Y
format sdate2 %dD/n/Y
format sdate2 %dD/N/Y

generate anio=year(sdate1)
generate mes=month(sdate1)
generate dia=day(sdate1)
generate medio_anio=halfyear(sdate1)
generate trimestre=quarter(sdate1)
generate semana=week(sdate1)
generate dia_semana=dow(sdate1)
generate dia_anio=doy(sdate1)

generate elapdate=mdy(mes,dia,anio)
generate elapdate1=mdy(mes,dia,1900+anio)
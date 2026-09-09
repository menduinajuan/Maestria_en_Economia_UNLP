clear all
set more off

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/8. Economía de la Distribución/Trabajos Prácticos/Trabajo Práctico N° 2/Datos"
use "usu_individual_t119", clear
*import excel "usu_individual_t119.xls", sheet("Sheet 1") firstrow case(lower)

destring deccfr, replace
drop if (deccfr<1 | deccfr>10)
drop if (nro_hogar==51 | nro_hogar==71)


sort itf
generate sumpop=sum(pondih)
local ppdecil=sumpop[_N]/10

generate decil=0
forvalues i=1(1)10 {
	replace decil=`i' if (sumpop>`ppdecil'*(`i'-1) & sumpop<=`ppdecil'*`i')
}

drop sumpop
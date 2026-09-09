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


sort ipcf
generate sumpop=sum(pondih)
local ppdecil=sumpop[_N]/10

generate decil=0
replace decil=1 if (sumpop>0*`ppdecil' & sumpop<=1*`ppdecil')
replace decil=2 if (sumpop>1*`ppdecil' & sumpop<=2*`ppdecil')
replace decil=3 if (sumpop>2*`ppdecil' & sumpop<=3*`ppdecil')
replace decil=4 if (sumpop>3*`ppdecil' & sumpop<=4*`ppdecil')
replace decil=5 if (sumpop>4*`ppdecil' & sumpop<=5*`ppdecil')
replace decil=6 if (sumpop>5*`ppdecil' & sumpop<=6*`ppdecil')
replace decil=7 if (sumpop>6*`ppdecil' & sumpop<=7*`ppdecil')
replace decil=8 if (sumpop>7*`ppdecil' & sumpop<=8*`ppdecil')
replace decil=9 if (sumpop>8*`ppdecil' & sumpop<=9*`ppdecil')
replace decil=10 if (sumpop>9*`ppdecil' & sumpop<=10*`ppdecil')

drop sumpop

generate imp=0.25*ipcf
generate ipcf_imp=ipcf-imp
summarize imp
generate nueing=ipcf_imp+r(mean)
summarize nueing
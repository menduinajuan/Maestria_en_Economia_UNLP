clear all
use "usu_individual_t117", clear
*import excel "usu_individual_t117.xls", sheet("Sheet 1") firstrow case(lower)

destring deccfr, replace
drop if (deccfr<1 | deccfr>10)
drop if (nro_hogar==51 | nro_hogar==71)
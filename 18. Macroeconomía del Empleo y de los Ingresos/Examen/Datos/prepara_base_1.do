*##############################################################################*
* IMPORTACIÓN DE BASES *
*##############################################################################*


foreach base of newlist individual hogar {
	clear all
	import excel "usu_`base'_t419.xls", sheet("Sheet 1") firstrow case(lower)
	save "usu_`base'_t419", replace
}


*##############################################################################*
* UNIÓN DE BASES *
*##############################################################################*


use "usu_individual_t419", clear
destring, replace
sort codusu nro_hogar aglomerado
save "2019_T4_Individual", replace

use "usu_hogar_t419", clear
destring, replace
sort codusu nro_hogar aglomerado
merge 1:m codusu nro_hogar aglomerado using "2019_T4_Individual"
erase "2019_T4_Individual.dta"

tabulate _merge
drop if (_merge==1)
drop _merge
duplicates report
duplicates drop
compress

save "Base", replace
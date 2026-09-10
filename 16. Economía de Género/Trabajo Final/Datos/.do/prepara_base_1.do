*##############################################################################*
* IMPORTACIÓN DE BASES *
*##############################################################################*


clear all
import excel "$data/usu_individual_t120.xlsx", sheet("Sheet 1") firstrow case(lower)
save "$data/usu_individual_t120", replace

clear all
import excel "$data/usu_hogar_t120.xlsx", sheet("Sheet 1") firstrow case(lower)
save "$data/usu_hogar_t120", replace


*##############################################################################*
* UNIÓN DE BASES *
*##############################################################################*


use "$data/usu_individual_t120", clear
destring, replace
sort codusu nro_hogar aglomerado
save "$data/2020_T1_Individual", replace

use "$data/usu_hogar_t120", clear
destring, replace
sort codusu nro_hogar aglomerado
merge 1:m codusu nro_hogar aglomerado using "$data/2020_T1_Individual"
erase "$data/2020_T1_Individual.dta"

tabulate _merge
drop if (_merge==1)
drop _merge
duplicates report
duplicates drop
compress

generate pondera_aux=round(pondera)
replace pondera=pondera_aux
drop pondera_aux

save "$data/Base", replace
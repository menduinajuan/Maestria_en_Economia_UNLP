clear all
set more off
version 16

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/8. Economía de la Distribución/Trabajos Prácticos/Trabajo Práctico N° 8/Datos"
use "usu_individual_t119", clear
*import excel "usu_individual_t119.xls", sheet("Sheet 1") firstrow case(lower)
*save "usu_individual_t119", replace


*##############################################################################*
								* EJERCICIO 1 *
*##############################################################################*


*INCISO (a)*

do "prepara_base"
quietly include "comandos"

*Ingreso laboral total familiar observado*
bysort id: egen ilatf_obs=total(ila)

*Microsimulación*
generate ilapcf_obs=ilatf_obs/miembros
generate ila_crec=ilapcf_obs*(1.05^10)

*Resultados*
do "genera-ing-sim" "crec"
do "indicadores" "crec"
do "rep-cic" "ipcf" "ipcf_crec"

*INCISO (b)*

do "prepara_base"
quietly include "comandos"

*Ingreso laboral total familiar observado*
bysort id: egen ilatf_obs=total(ila)

*Microsimulación*

generate temp1=p21*0.25 if (pp04b_cod==8300 | pp04b_cod==8401 | pp04b_cod==8402)
egen n_p21=rowtotal(p21 temp1), missing

generate temp2=tot_p12*0.25 if (pp04b_cod==8300 | pp04b_cod==8401 | pp04b_cod==8402)
egen n_tot_p12=rowtotal(tot_p12 temp2), missing

egen ila_emp=rowtotal(n_p21 n_tot_p12)

*Resultados*
do "genera-ing-sim" "emp"
do "indicadores" "emp"
do "rep-cic" "ipcf" "ipcf_emp"

drop temp1 temp2 n_p21 n_tot_p12

*INCISO (c)*

do "prepara_base"
quietly include "comandos"

*Ingreso laboral total familiar observado*
bysort id: egen ilatf_obs=total(ila)

*Microsimulación*

local lp=4006.098

generate aux=`lp'-ila
generate transf=.
replace transf=aux if (aux>0 & ch06>60)

generate n_indiv_pobres=1 if (transf>0 & !missing(transf))
summarize n_indiv_pobres [w=pondera]

generate transf_sum=sum(transf)
summarize transf_sum
local transf_sum=r(max)
display as text "Monto Total de las Transferencias = " as result `transf_sum'
local n_indiv_ricos=`transf_sum'/`lp'
display	as text "Cantidad de observaciones de la muestra de individuos ricos a debitarle un monto igual a la Línea de Pobreza = $ `lp' = " as result `n_indiv_ricos'

gsort -ila

replace transf=-`lp' if (ila>=88000 & !missing(ila))

generate n_indiv_ricos=1 if (transf<0 & !missing(transf))
summarize n_indiv_ricos [w=pondera]

egen ila_transf=rowtotal(ila transf)

do "genera-ing-sim" "transf"
do "indicadores" "transf"
do "rep-cic" "ipcf" "ipcf_transf"

drop aux transf transf_sum


*##############################################################################*
								* EJERCICIO 2 *
*##############################################################################*


*INCISO (a)*

do "prepara_base"
do "comandos"

do "sim-mincer_1" "secc_40" "40"
do "genera-ing-familiar" "secc_40"
do "indicadores" "secc_40"
do "rep-cic" "ipcf" "ipcf_secc_40"

*INCISO (b)*

do "prepara_base"
do "comandos"

do "sim-mincer_1" "secc_60" "60"
do "genera-ing-familiar" "secc_60"
do "indicadores" "secc_60"
do "rep-cic" "ipcf" "ipcf_secc_60"

*INCISO (c)*

do "prepara_base"
do "comandos"

do "sim-mincer_1" "secc_80" "80"
do "genera-ing-familiar" "secc_80"
do "indicadores" "secc_80"
do "rep-cic" "ipcf" "ipcf_secc_80"

*INCISO (d)*

do "prepara_base"
do "comandos"

do "sim-mincer_2" "secc"
do "genera-ing-familiar" "secc"
do "indicadores" "secc"
do "rep-cic" "ipcf" "ipcf_secc"


*##############################################################################*
								* EJERCICIO 3 *
*##############################################################################*


*INCISO (a)*

do "prepara_base"
do "comandos"
do "estimate-mincer"
do "estimate-occup"
do "desc-data"

do "sim-secc" "secc"

do "indicadores" "secc"
do "rep-cic" "ipcf" "ipcf_secc"

*INCISO (b)*

do "prepara_base"
do "comandos"
do "estimate-mincer"
do "estimate-occup"
do "desc-data"

do "scen-defn-blank"
do "sim-part" "blank" "shk_part" "15" "999"
do "scen-defn-unemp"
do "sim-part" "unemp" "shk_part" "15" "999"

do "indicadores" "unemp"
do "rep-cic" "ipcf" "ipcf_unemp"
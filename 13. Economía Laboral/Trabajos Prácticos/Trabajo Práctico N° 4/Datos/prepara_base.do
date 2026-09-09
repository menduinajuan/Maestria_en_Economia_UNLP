*##############################################################################*
* GENERACIÓN DE VARIABLES RELEVANTES *
*##############################################################################*


generate informal=1-djubila

generate cond_act=.
replace cond_act=1 if (ocupado==1)
replace cond_act=2 if (desocupado==1)
replace cond_act=3 if (pea==0)

label variable cond_act "Condición de actividad"
label define cond_act 1 "Ocupado" 2 "Desocupado" 3 "Inactivo"
label values cond_act cond_act

generate rel_ocup=.
replace rel_ocup=1 if (relacion_laboral==1 | relacion_laboral==3)
replace rel_ocup=2 if (relacion_laboral==2 & informal==0)
replace rel_ocup=3 if (relacion_laboral==2 & informal==1)
replace rel_ocup=4 if (relacion_laboral==5)
replace rel_ocup=5 if (cond_act==3)

label variable rel_ocup "Relación ocupacional"
label define rel_ocup 1 "Cuentapropista" 2 "Asal. Formal" 3 "Asal. Informal" 4 "Desocupado" 5 "Inactivo"
label values rel_ocup rel_ocup


*##############################################################################*
* MANTENER Y ORDENAR *
*##############################################################################*


keep idp_h idp_i idp_t idp_p idp_match pondera edad qipcf informal cond_act rel_ocup

sort idp_h idp_i idp_t
reshape wide pondera edad qipcf informal cond_act rel_ocup, i(idp_h idp_i) j(idp_t)

order idp_h idp_i idp_p idp_match pondera* edad* qipcf* informal* cond_act* rel_ocup*
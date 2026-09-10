clear all
set more off
version 16


*##############################################################################*
* CONFIGURACIÓN *
*##############################################################################*


*local disco="C:/"
local disco="G:/Mi unidad"
global dir     "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/16. Economía de Género/Trabajo Final/Datos"
global data    "$dir/.dta"
global dofiles "$dir/.do"
global results "$dir/.res"


*##############################################################################*
* COMANDOS *
*##############################################################################*


quietly include "$dofiles/comando_cuantiles"


*##############################################################################*
* PREPARACIÓN DE BASE *
*##############################################################################*


do "$dofiles/prepara_base_1"
do "$dofiles/prepara_base_2"


*##############################################################################*
* DATOS *
*##############################################################################*


use "$data/Base", clear
drop if (pondih==0)																// Se excluye a hogares sin respuesta de ingresos
drop if (hogar_sec==1)															// Se excluye a hogares secundarios ("Servicio doméstico / Pensionistas")
set seed 12345																	// Se fija semilla para la simulación


*##############################################################################*
* MODELO LOGIT *
*##############################################################################*


global covariables = "hombre edad c.edad#c.edad c.edad#i.hombre i.nivel_educ i.nivel_educ#i.hombre jefe i.jefe#i.hombre niños i.niños#i.hombre casado miembros lipcf"

logit ocupado ${covariables} if ((ocupado==1 & informal==0) | desocupado==1), vce(robust)
predict aux1
logit ocupado ${covariables} if ((ocupado==1 & informal==1) | desocupado==1), vce(robust)
predict aux2

generate pscore=.
replace pscore=aux1 if (informal==0)
replace pscore=aux2 if (informal==1)
drop aux*

label variable pscore "Probabilidad de estar ocupado"


*##############################################################################*
* SIMULACIÓN ESCENARIOS POST-COVID19 (sin y con respuesta de política) *
*##############################################################################*


********************************************************************************
* Variaciones de Empleo *
********************************************************************************

							*2do TRIMESTRE 2020*

*Formales*
generate employ_sim_1=.
replace employ_sim_1=0.234 if (sector_indec==1  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)
replace employ_sim_1=0.038 if (sector_indec==2  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)
replace employ_sim_1=0.259 if (sector_indec==3  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)
replace employ_sim_1=0.224 if (sector_indec==4  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)
replace employ_sim_1=0.295 if (sector_indec==5  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)
replace employ_sim_1=0.161 if (sector_indec==6  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)
replace employ_sim_1=0.108 if (sector_indec==7  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)
replace employ_sim_1=0.000 if (sector_indec==8  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)	// -0.058
replace employ_sim_1=0.000 if (sector_indec==9  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)	// -0.019
replace employ_sim_1=0.025 if (sector_indec==10 & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)
replace employ_sim_1=0.181 if (sector_indec==11 & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)

*Informales*
replace employ_sim_1=0.233 if (sector_indec==1  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_1=0.417 if (sector_indec==2  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_1=0.475 if (sector_indec==3  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_1=0.382 if (sector_indec==4  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_1=0.679 if (sector_indec==5  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_1=0.381 if (sector_indec==6  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_1=0.465 if (sector_indec==7  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_1=0.452 if (sector_indec==8  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_1=0.381 if (sector_indec==9  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_1=0.501 if (sector_indec==10 & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_1=0.390 if (sector_indec==11 & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)

							*3er TRIMESTRE 2020*

*Formales*
generate employ_sim_2=.
replace employ_sim_2=0.106 if (sector_indec==1  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)
replace employ_sim_2=0.000 if (sector_indec==2  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)	// -0.007
replace employ_sim_2=0.000 if (sector_indec==3  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)	// -0.003
replace employ_sim_2=0.092 if (sector_indec==4  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)
replace employ_sim_2=0.000 if (sector_indec==5  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)	// -0.039
replace employ_sim_2=0.075 if (sector_indec==6  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)
replace employ_sim_2=0.073 if (sector_indec==7  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)
replace employ_sim_2=0.000 if (sector_indec==8  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)	// -0.103
replace employ_sim_2=0.000 if (sector_indec==9  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)	// -0.068
replace employ_sim_2=0.079 if (sector_indec==10 & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)
replace employ_sim_2=0.158 if (sector_indec==11 & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)

*Informales*
replace employ_sim_2=0.320 if (sector_indec==1  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_2=0.282 if (sector_indec==2  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_2=0.231 if (sector_indec==3  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_2=0.327 if (sector_indec==4  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_2=0.530 if (sector_indec==5  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_2=0.161 if (sector_indec==6  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_2=0.402 if (sector_indec==7  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_2=0.447 if (sector_indec==8  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_2=0.156 if (sector_indec==9  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_2=0.354 if (sector_indec==10 & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_2=0.276 if (sector_indec==11 & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)

							*4to TRIMESTRE 2020*

*Formales*
generate employ_sim_3=.
replace employ_sim_3=0.203 if (sector_indec==1  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)
replace employ_sim_3=0.000 if (sector_indec==2  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)	// -0.168
replace employ_sim_3=0.000 if (sector_indec==3  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)	// -0.126
replace employ_sim_3=0.092 if (sector_indec==4  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)
replace employ_sim_3=0.261 if (sector_indec==5  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)
replace employ_sim_3=0.077 if (sector_indec==6  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)
replace employ_sim_3=0.000 if (sector_indec==7  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)	// -0.043
replace employ_sim_3=0.000 if (sector_indec==8  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)	// -0.073
replace employ_sim_3=0.000 if (sector_indec==9  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)	// -0.120
replace employ_sim_3=0.101 if (sector_indec==10 & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)
replace employ_sim_3=0.069 if (sector_indec==11 & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==0)

*Informales*
replace employ_sim_3=0.150 if (sector_indec==1  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_3=0.000 if (sector_indec==2  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)	// -0.023
replace employ_sim_3=0.000 if (sector_indec==3  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)	// -0.213
replace employ_sim_3=0.229 if (sector_indec==4  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_3=0.494 if (sector_indec==5  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_3=0.231 if (sector_indec==6  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_3=0.168 if (sector_indec==7  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_3=0.269 if (sector_indec==8  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_3=0.000 if (sector_indec==9  & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)	// -0.072
replace employ_sim_3=0.254 if (sector_indec==10 & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)
replace employ_sim_3=0.302 if (sector_indec==11 & ocupado==1 & privado==1 & (rel_lab==2 | rel_lab==3) & informal==1)

********************************************************************************
* Variaciones de Ingreso *
********************************************************************************

							*2do TRIMESTRE 2020*

generate wage_sim_1=.
replace wage_sim_1=(1-0.0034) if (privado==1 & informal==0)
replace wage_sim_1=(1+0.0195) if (privado==0)
replace wage_sim_1=(1+0.0169) if (privado==1 & informal==1)

							*3er TRIMESTRE 2020*

generate wage_sim_2=.
replace wage_sim_2=(1+0.0529) if (privado==1 & informal==0)
replace wage_sim_2=(1+0.0719) if (privado==0)
replace wage_sim_2=(1+0.1254) if (privado==1 & informal==1)

							*4to TRIMESTRE 2020*

generate wage_sim_3=.
replace wage_sim_3=(1+0.1566) if (privado==1 & informal==0)
replace wage_sim_3=(1+0.1522) if (privado==0)
replace wage_sim_3=(1+0.2505) if (privado==1 & informal==1)

********************************************************************************
* Simulación de Empleo *
********************************************************************************

sort sector_indec informal pscore
by sector_indec informal: generate rsum_pondih=sum(pondih)
by sector_indec informal: egen total_pondih=total(pondih)

							*2do TRIMESTRE 2020*

by sector_indec informal: generate aux1=employ_sim_1*total_pondih
by sector_indec informal: generate employ_imputed_1=(rsum_pondih<=aux1) if (aux1!=.)

egen hogar_imputed=max(employ_imputed_1), by(id)
generate aux2=(employ_imputed_1==1 & informal==0)
egen hogar_imputed_formal_1=max(aux2), by(id)
drop aux*

							*3er TRIMESTRE 2020*

by sector_indec informal: generate aux1=employ_sim_2*total_pondih
by sector_indec informal: generate employ_imputed_2=(rsum_pondih<=aux1) if (aux1!=.)

egen hogar_imputed_2=max(employ_imputed_2), by(id)
generate aux2=(employ_imputed_2==1 & informal==0)
egen hogar_imputed_formal_2=max(aux2), by(id)
drop aux*

							*4to TRIMESTRE 2020*

by sector_indec informal: generate aux1=employ_sim_3*total_pondih
by sector_indec informal: generate employ_imputed_3=(rsum_pondih<=aux1) if (aux1!=.)

egen hogar_imputed_3=max(employ_imputed_3), by(id)
generate aux2=(employ_imputed_3==1 & informal==0)
egen hogar_imputed_formal_3=max(aux2), by(id)
drop aux*

********************************************************************************
* Simulación de Ingreso (sin respuesta de política) *
********************************************************************************

							*2do TRIMESTRE 2020*

generate ing_laboral_sim_1a=ing_laboral
replace ing_laboral_sim_1a=0 if (employ_imputed_1==1)
replace ing_laboral_sim_1a=ing_laboral_sim_1a*wage_sim_1 if (employ_imputed_1!=1 & wage_sim_1!=.)

replace ing_laboral_sim_1a=ing_laboral_sim_1a*(0.951133)
replace ing_laboral_sim_1a=ing_laboral_sim_1a-aguinaldo
replace ing_laboral_sim_1a=0 if (ing_laboral_sim_1a<0)

egen ing_total_sim_1a=rsum(ing_laboral_sim_1a ing_nolaboral)
egen itf_sim_1a=sum(ing_total_sim_1a), by(id)
generate ipcf_sim_1a=itf_sim_1a/miembros

							*3er TRIMESTRE 2020*

generate ing_laboral_sim_2a=ing_laboral
replace ing_laboral_sim_2a=0 if (employ_imputed_2==1)
replace ing_laboral_sim_2a=ing_laboral_sim_2a*wage_sim_2 if (employ_imputed_2!=1 & wage_sim_2!=.)

replace ing_laboral_sim_2a=ing_laboral_sim_2a*(0.897552)

egen ing_total_sim_2a=rsum(ing_laboral_sim_2a ing_nolaboral)
egen itf_sim_2a=sum(ing_total_sim_2a), by(id)
generate ipcf_sim_2a=itf_sim_2a/miembros

							*4to TRIMESTRE 2020*

generate ing_laboral_sim_3a=ing_laboral
replace ing_laboral_sim_3a=0 if (employ_imputed_3==1)
replace ing_laboral_sim_3a=ing_laboral_sim_3a*wage_sim_3 if (employ_imputed_3!=1 & wage_sim_3!=.)

replace ing_laboral_sim_3a=ing_laboral_sim_3a*(0.790004)
replace ing_laboral_sim_3a=ing_laboral_sim_3a-aguinaldo
replace ing_laboral_sim_3a=0 if (ing_laboral_sim_3a<0)

egen ing_total_sim_3a=rsum(ing_laboral_sim_3a ing_nolaboral)
egen itf_sim_3a=sum(ing_total_sim_3a), by(id)
generate ipcf_sim_3a=itf_sim_3a/miembros

********************************************************************************
* Simulación de Ingreso (con respuesta de política) *
********************************************************************************

							*2do TRIMESTRE 2020*

*Montos beneficios*

generate v_ife_1=20000*(1/3)													// Se otorgaron 2 IFE en este trimestre (abril y junio)
generate v_bono_auh_1=3103*(0.8)*(1/3)											// Se otorgó 1 Bono AUH (el 80%) en este trimestre (abril)
generate v_bono_jubi_1=3000*(1/3)												// Se otorgó 1 Bono Jubilados en este trimestre (abril)

*Imputación de variables laborales para los que pierden el empleo*

generate estado_orig=estado
replace estado=2 if (employ_imputed_1==1)
foreach var of varlist cat_ocup pp07h {
	generate `var'_orig=`var'
	replace `var'=0 if (employ_imputed_1==1)
}

	*Perceptores AUH*

	quietly include "$dofiles/beneficiarios_auh"

	*Perceptores IFE*

	*Trabajadores asalariados formales en el hogar
	replace desc_jubi=0 if (desc_jubi==.)
	generate desc_jubi_2=desc_jubi
	replace desc_jubi_2=0 if (sector_indec==10)									// No se excluyen trabajadores domésticos
	replace desc_jubi_2=0 if (employ_imputed_1==1)								// No se excluyen trabajadores que pierden el empleo en la simulación	
	egen flia_formal=max(desc_jubi_2), by(id)

	*Jubilados/Pensionados en el hogar
	generate jubi=(ing_jubi>0 & ing_jubi!=.)
	egen flia_jubi=max(jubi), by(id)

	*Trabajadores domésticos
	generate emp_domestico=1 if (sector_indec==10)

	*Trabajadores informales, trabajadores domésticos y perceptores de AUH en el hogar
	egen informal_f=sum(informal), by(id)
	egen emp_domestico_f=sum(emp_domestico), by(id)
	egen auh_f=sum(beneficiario_auh), by(id)

*IFE*

generate perceptor_ife=0
replace perceptor_ife=1 if ((informal_f>=1 | emp_domestico_f>=1 | auh_f>=1) & (flia_formal!=1 & flia_jubi!=1))

generate ife_1=0
replace ife_1=v_ife_1 if (perceptor_ife==1 & relacion==1)

*BONO AUH*

generate bono_auh_1=0
replace bono_auh_1=v_bono_auh_1 if (beneficiario_auh==1 & hogar_imputed_formal_1==0)

*BONO JUBILADOS*

generate jubi_min=(ing_jubi>0 & ing_jubi<15892)

generate bono_jubi_1=0
replace bono_jubi_1=v_bono_jubi_1 if (jubi_min==1)

*SIMULACIÓN DE INGRESO*

egen policy_response_1=rsum(ife_1 bono_auh_1 bono_jubi_1)
replace policy_response_1=policy_response_1*(0.951133)

generate ing_nolaboral_sim_1b=ing_nolaboral
replace ing_nolaboral_sim_1b=ing_nolaboral_sim_1b+policy_response_1

egen ing_total_sim_1b=rsum(ing_laboral_sim_1a ing_nolaboral_sim_1b)

egen itf_sim_1b=sum(ing_total_sim_1b), by(id)
generate ipcf_sim_1b=itf_sim_1b/miembros

							*3er TRIMESTRE 2020*

*Montos beneficios*

generate v_ife_2=10000*(1/3)													// Se otorgó 1 IFE en este trimestre (agosto)
generate v_bono_auh_2=3103*(0.8)*(1/3)
generate v_bono_jubi_2=3000*(1/3)

*Imputación de variables laborales para los que pierden el empleo*

foreach var of varlist estado cat_ocup pp07h {
	drop `var'
	generate `var'=`var'_orig
}

replace estado=2 if (employ_imputed_2==1)
foreach var of varlist cat_ocup pp07h {
	replace `var'=0 if (employ_imputed_2==1)
}

	*Perceptores AUH*

	drop beneficiario_auh hogar_auh
	quietly include "$dofiles/beneficiarios_auh"

	*Perceptores IFE*

	*Trabajadores asalariados formales en el hogar
	drop desc_jubi_2 flia_formal
	generate desc_jubi_2=desc_jubi
	replace desc_jubi_2=0 if (sector_indec==10)									// No se excluyen trabajadores domésticos
	replace desc_jubi_2=0 if (employ_imputed_2==1)								// No se excluyen trabajadores que pierden el empleo en la simulación
	egen flia_formal=max(desc_jubi_2), by(id)

	*Jubilados/Pensionados en el hogar
	drop jubi flia_jubi
	generate jubi=(ing_jubi>0 & ing_jubi!=.)
	egen flia_jubi=max(jubi), by(id)

	*Trabajadores domésticos
	drop emp_domestico
	generate emp_domestico=1 if (sector_indec==10)

	*Trabajadores informales, trabajadores domésticos y perceptores de AUH en el hogar
	drop informal_f emp_domestico_f auh_f
	egen informal_f=sum(informal), by(id)
	egen emp_domestico_f=sum(emp_domestico), by(id)
	egen auh_f=sum(beneficiario_auh), by(id)

*IFE*

drop perceptor_ife
generate perceptor_ife=0
replace perceptor_ife=1 if ((informal_f>=1 | emp_domestico_f>=1 | auh_f>=1) & (flia_formal!=1 & flia_jubi!=1))

generate ife_2=0
replace ife_2=v_ife_2 if (perceptor_ife==1 & relacion==1)

*BONO AUH*

generate bono_auh_2=0
replace bono_auh_2=v_bono_auh_2 if (beneficiario_auh==1 & hogar_imputed_formal_2==0)

*BONO JUBILADOS*

generate bono_jubi_2=0
replace bono_jubi_2=v_bono_jubi_2 if (jubi_min==1)

*SIMULACIÓN DE INGRESO*

egen policy_response_2=rsum(ife_2 bono_auh_2 bono_jubi_2)
replace policy_response_2=policy_response_2*(0.897552)

generate ing_nolaboral_sim_2b=ing_nolaboral
replace ing_nolaboral_sim_2b=ing_nolaboral_sim_2b+policy_response_2

egen ing_total_sim_2b=rsum(ing_laboral_sim_2a ing_nolaboral_sim_2b)

egen itf_sim_2b=sum(ing_total_sim_2b), by(id)
generate ipcf_sim_2b=itf_sim_2b/miembros

							*4to TRIMESTRE 2020*

*Montos beneficios*

*generate v_ife_3=0																// No se otorgó IFE en este trimestre
generate v_bono_auh_3=6000*(1/3)												// Se otorgó 1 Bono AUH (retención del 20% durante 2019) en este trimestre (diciembre)
generate v_bono_jubi_3=3000

*Imputación de variables laborales para los que pierden el empleo*

foreach var of varlist estado cat_ocup pp07h {
	drop `var'
	generate `var'=`var'_orig
}

replace estado=2 if (employ_imputed_3==1)
foreach var of varlist cat_ocup pp07h {
	replace `var'=0 if (employ_imputed_3==1)
}

	*Perceptores AUH*

	drop beneficiario_auh hogar_auh
	quietly include "$dofiles/beneficiarios_auh"

*IFE*

*No se otorgó en este trimestre

*BONO AUH*

generate bono_auh_3=0
replace bono_auh_3=v_bono_auh_3 if (beneficiario_auh==1 & hogar_imputed_formal_3==0)

*BONO JUBILADOS*

generate bono_jubi_3=0
replace bono_jubi_3=v_bono_jubi_3 if (jubi_min==1)

*SIMULACIÓN DE INGRESO*

egen policy_response_3=rsum(bono_auh_3 bono_jubi_3)
replace policy_response_3=policy_response_3*(0.790004)

generate ing_nolaboral_sim_3b=ing_nolaboral
replace ing_nolaboral_sim_3b=ing_nolaboral_sim_3b+policy_response_3

egen ing_total_sim_3b=rsum(ing_laboral_sim_3a ing_nolaboral_sim_3b)

egen itf_sim_3b=sum(ing_total_sim_3b), by(id)
generate ipcf_sim_3b=itf_sim_3b/miembros


*##############################################################################*
* RESULTADOS *
*##############################################################################*


do "$dofiles/resultados" "ipcf" "ipcf_sim_1a" "ipcf_sim_1b" "ipcf_sim_2a" "ipcf_sim_2b" "ipcf_sim_3a" "ipcf_sim_3b"
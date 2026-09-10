clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/13. Economía Laboral/Trabajos Prácticos/Trabajo Práctico N° 3/Datos"
use "panes_mmv", clear


*search rdplot


*##############################################################################*
								* EJERCICIO 1 *
*##############################################################################*


rdplot prD z
rdplot prD z, binselect(es)
rdplot prD z, binselect(qs)


*##############################################################################*
								* EJERCICIO 2 *
*##############################################################################*


rdplot ps_fwave z, p(1)
rdplot ps_swave z, p(1)


*##############################################################################*
								* EJERCICIO 3 *
*##############################################################################*


generate Dz=D*z
generate z2=z*z
generate Dz2=D*z*z

local controles "i.geo bl_medad lnbl_ytoth_pc bl_hhsize bl_meduc i.sexo i.edad i.aniosed07"

foreach y of varlist prD ps_fwave ps_swave {

	*Sin controles*
	regress `y' D, cluster(z)
	estimates store est_`y'_1
	regress `y' D z Dz, cluster(z)
	estimates store est_`y'_2
	regress `y' D z Dz z2 Dz2, cluster(z)
	estimates store est_`y'_3

	*Con controles*
	regress `y' D `controles', cluster(z)
	estimates store est_`y'_4
	regress `y' D z Dz `controles', cluster(z)
	estimates store est_`y'_5
	regress `y' D z Dz z2 Dz2 `controles', cluster(z)
	estimates store est_`y'_6

}

estimates table	est_prD_1 est_prD_2 est_prD_3 est_prD_4 est_prD_5 est_prD_6 ///
				est_ps_fwave_1 est_ps_fwave_2 est_ps_fwave_3 est_ps_fwave_4 est_ps_fwave_5 est_ps_fwave_6 ///
				est_ps_swave_1 est_ps_swave_2 est_ps_swave_3 est_ps_swave_4 est_ps_swave_5 est_ps_swave_6, ///
				stats(N r2) keep(D) b(%10.3f) se(%10.3f) p(%10.3f)


*##############################################################################*
								* EJERCICIO 4 *
*##############################################################################*


foreach y of varlist ps_fwave ps_swave {

	*Sin controles*
	ivregress 2sls `y' (prD=D), cluster(z)
	estimates store est_`y'_1
	ivregress 2sls `y' z Dz (prD=D), cluster(z)
	estimates store est_`y'_2
	ivregress 2sls `y' z Dz z2 Dz2 (prD=D), cluster(z)
	estimates store est_`y'_3

	*Con controles*
	ivregress 2sls `y' `controles' (prD=D), cluster(z)
	estimates store est_`y'_4
	ivregress 2sls `y' z Dz `controles' (prD=D), cluster(z)
	estimates store est_`y'_5
	ivregress 2sls `y' z Dz z2 Dz2 `controles' (prD=D), cluster(z)
	estimates store est_`y'_6

}

estimates table	est_ps_fwave_1 est_ps_fwave_2 est_ps_fwave_3 est_ps_fwave_4 est_ps_fwave_5 est_ps_fwave_6 ///
				est_ps_swave_1 est_ps_swave_2 est_ps_swave_3 est_ps_swave_4 est_ps_swave_5 est_ps_swave_6, ///
				stats(N r2) keep(prD) b(%10.3f) se(%10.3f) p(%10.3f)


*##############################################################################*
								* EJERCICIO 5 *
*##############################################################################*


preserve

drop if (edad==999999)

regress lnbl_ytoth_pc D z Dz if (lnbl_ytoth_pc!=999999)
regress bl_meduc D z Dz if (bl_meduc!=999999 & edad>16)
regress bl_hhsize D z Dz

restore


*##############################################################################*
								* EJERCICIO 6 *
*##############################################################################*


sysdir set PERSONAL "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/13. Economía Laboral/Trabajos Prácticos/Trabajo Práctico N° 3/Datos"

histogram z, ytitle("Número de observaciones") xtitle("Puntaje Ingreso Predicho") frequency
DCdensity z, breakpoint(0) generate(Xj Yj r0 fhat se_fhat)
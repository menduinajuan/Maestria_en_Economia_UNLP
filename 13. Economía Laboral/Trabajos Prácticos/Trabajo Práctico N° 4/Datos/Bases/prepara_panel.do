*##############################################################################*
* UNIÓN DE BASES (Individual y Hogar) *
*##############################################################################*


local lista "t108 t208 t308 t408 t109 t209 t309 t409 t110 t210 t310 t410"

foreach base of local lista {
	use "Individual_`base'", clear
	merge m:1 CODUSU nro_hogar using "Hogar_`base'"
	drop _merge
	renvars CODUSU nro_hogar componente ano4 trimestre \ idi_codusu idi_nro_hogar idi_componente idi_ano4 idi_trimestre
	save "arg_`base'", replace
}


*##############################################################################*
* UNIÓN DE BASES (Trimestre por Trimestre) *
*##############################################################################*


use "arg_t108", clear

local lista "t208 t308 t408 t109 t209 t309 t409 t110 t210 t310 t410"

local i=1
generate idp_t=`i'
label variable idp_t "Período"

foreach base of local lista {
	local i=`i'+1
	append using "arg_`base'"
	replace idp_t=`i' if (idp_t==.)
}

save "arg-panel", replace
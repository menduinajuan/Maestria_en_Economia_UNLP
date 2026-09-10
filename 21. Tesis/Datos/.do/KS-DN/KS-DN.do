args t0 t1


*##############################################################################*
* DINARDO et al. (1996) *
*##############################################################################*


generate year_d=.
replace year_d=0 if (year==`t0')
replace year_d=1 if (year==`t1')

logit year_d miembros_h p_muj niños_hog educ_hog jefe_mujer jefe_edad jefe_cp t_plf t_des ayudas_hog
predict prY, pr

summarize year_d [w=fex_c]

generate phi_1=(prY/r(mean))/((1-prY)/(1-r(mean))) if (year_d==0)
replace phi_1=1 if (year_d==1)

generate phi_2=((1-prY)/(1-r(mean)))/(prY/r(mean)) if (year_d==1)
replace phi_2=1 if (year_d==0)


*##############################################################################*
* COMBINACIÓN DE KOLENIKOV Y SHORROCKS (2005) CON DINARDO et al. (1996) *
*##############################################################################*


*Descomposición observada

foreach fgt of newlist fgt0 fgt1 fgt2 {

	foreach linea of newlist p i {
		skdecomp ipcug [w=fex_c], by(year) varpl(l`linea') indicator(`fgt') idpl(dominio)
		matrix define ob_`fgt'_`linea'=r(b)'
	}

}

*Descomposiciones contrafactuales

foreach fgt of newlist fgt0 fgt1 fgt2 {

	foreach linea of newlist p i {

		forvalues i=1(1)2 {
			skdecomp ipcug [w=phi_`i'], by(year) varpl(l`linea') indicator(`fgt') idpl(dominio)
			matrix define phi_`fgt'_`linea'_`i'=r(b)'
		}

	}

}

*Matriz resumen

foreach fgt of newlist fgt0 fgt1 fgt2 {

	foreach linea of newlist p i {
		matrix define   KS_DN_`fgt'_`linea' = J(3,4,.)
		matrix rownames KS_DN_`fgt'_`linea' = "Observado" "Efecto Composición" "Efecto Estructura"
		matrix colnames KS_DN_`fgt'_`linea' = "Crecimiento" "Redistribución" "Línea" "Total"
	}

}

foreach fgt of newlist fgt0 fgt1 fgt2 {

	foreach linea of newlist p i {

		forvalues i=1(1)4 {
			matrix KS_DN_`fgt'_`linea' [1,`i'] = ob_`fgt'_`linea'[3,`i']
			matrix KS_DN_`fgt'_`linea' [3,`i'] = (phi_`fgt'_`linea'_1[3,`i']+phi_`fgt'_`linea'_2[3,`i'])/2
			matrix KS_DN_`fgt'_`linea' [2,`i'] = KS_DN_`fgt'_`linea'[1,`i']-KS_DN_`fgt'_`linea'[3,`i']
		}

	}

}

foreach fgt of newlist fgt0 fgt1 fgt2 {

	foreach linea of newlist p i {
		matrix KS_`fgt'_`linea'_ob=KS_DN_`fgt'_`linea'[1,1..4]
		matrix KS_`fgt'_`linea'_EC=KS_DN_`fgt'_`linea'[2,1..4]
		matrix KS_`fgt'_`linea'_EE=KS_DN_`fgt'_`linea'[3,1..4]
	}

}

drop year_d prY phi*
*CRITERIO DE ELEGIBILIDAD 1: Hogar con menores de edad como hijos o nietos*


generate aux_menor=0
replace aux_menor=1 if ((edad>=0 & edad<18) & (relacion_est==3 | relacion_est==5))

tabstat aux_menor [w=pondih], by(dipcf) statistics(mean sum) save

egen elegibilidad_1=max(aux_menor), by(id)
label variable elegibilidad_1 "Elegibilidad 1: Hogar tiene algún miembro menor de edad como hijo o nieto"


*CRITERIO DE ELEGIBILIDAD 2: Hogar con mayores de edad desocupados o trabajadores informales*


generate aux_desocup_informal=0
replace aux_desocup_informal=1 if (desocupado==1) 														// Desocupados
replace aux_desocup_informal=1 if (rel_lab==2 & desc_jubi==0 & trab_dom!=1)								// Trabajador asalariado informal (sin descuento jubilatorio) -
																										// no servicio doméstico
replace aux_desocup_informal=1 if (rel_lab==3 & cober_med==4) 											// Trabajador cuenta propia informal (sin cobertura de salud)
replace aux_desocup_informal=1 if (rel_lab==3 & cober_med!=4 & dipcf<=6 & nivel_ed!=6)					// Trabajador cuenta propia informal (con cobertura de salud, pero
																										// perteneciente a los primeros tres quintiles y con nivel educativo
																										// distinto a universitario completo) - no servicio doméstico
replace aux_desocup_informal=1 if (rel_lab==4)															// Trabajador familiar sin remuneracion
replace aux_desocup_informal=1 if (inactivo==1 & (ing_jubi==0 | ing_jubi==.))							// Inactivo sin ingresos jubilatorios
replace aux_desocup_informal=. if (edad<18)

tabstat aux_desocup_informal [w=pondih], by(dipcf) statistics(mean sum) save

egen elegibilidad_2=max(aux_desocup_informal), by(id)
label variable elegibilidad_2 "Elegibilidad 2: Hogar tiene algún miembro mayor de edad desocupado o trabajador informal"


*CRITERIO DE ELEGIBILIDAD 3: Hogar con mayores de edad trabajadores domésticos informales*


generate aux_domestico=0
replace aux_domestico=1 if (trab_dom==1 & desc_jubi==0)													// Trabajador doméstico informal
replace aux_domestico=. if (edad<18)

tabstat aux_domestico [w=pondih], by(dipcf) statistics(sum) save

egen elegibilidad_3=max(aux_domestico), by(id)
label variable elegibilidad_3 "Elegibilidad 3: Hogar tiene algún miembro mayor de edad trabajador doméstico informal"


*CRITERIO DE EXCLUSIÓN 1: Hogar con jefe o cónyuge trabajadores formales*


generate jefe_formal=0
replace jefe_formal=1 if (ocupado==1 & rel_lab==2 & desc_jubi==1 & relacion_est==1 & trab_dom!=1)		// No se excluyen trabajadores domésticos
replace jefe_formal=1 if (ocupado==1 & rel_lab==3 & cober_med!=4 & dipcf>6 & relacion_est==1)			// Se excluyen trabajadores cuenta propia formales

generate conyuge_formal=0
replace conyuge_formal=1 if (ocupado==1 & rel_lab==2 & desc_jubi==1 & relacion_est==2 & trab_dom!=1)	// No se excluyen trabajadores domésticos
replace conyuge_formal=1 if (ocupado==1 & rel_lab==3 & cober_med!=4 & dipcf>6 & relacion_est==2)		// Se excluyen trabajadores cuenta propia formales

egen jefe_conyuge_formal=rowmax(jefe_formal conyuge_formal)

egen exclusion_1=max(jefe_conyuge_formal), by(id)
label variable exclusion "Exclusión 1: Hogar tiene jefe o cónyuge trabajador formal"


*Beneficario AUH: Hogar con algún menor de edad (hijo o nieto) que tiene desocupados, trabajadores informales o trabajadores domésticos informales y que no tiene jefe o cónyuge formal*


generate beneficiario_auh=(elegibilidad_1==1 & (elegibilidad_2==1 | elegibilidad_3==1) & exclusion_1==0)
replace beneficiario_auh=. if (aux_menor!=1)
label variable beneficiario_auh "Potencial beneficiario de la AUH"

tabstat beneficiario_auh [w=pondih], by(dipcf) statistics(sum) save


*CRITERIO DE EXCLUSIÓN 2: Hogar con beneficiario de AUH nieto/a, pero hijo/a es trabajador formal (quien podría ser el padre/madre del chico/a)*


generate nieto_auh=(relacion_est==5 & beneficiario_auh==1)
egen nro_nieto_auh=sum(nieto_auh), by(id)

generate hijo_formal=0 if (nro_nieto_auh>0 & nro_nieto_auh!=.)
replace hijo_formal=1 if ((rel_lab==2 & desc_jubi==1 & relacion_est==3) & (nro_nieto_auh>0 & nro_nieto_auh!=.))

egen exclusion_2=max(hijo_formal), by(id)
replace beneficiario_auh=0 if (beneficiario_auh==1 & exclusion_2==1)


*BENEFICIARIO AUH: Hogar con, al menos, un beneficiario de la AUH*


egen hogar_auh=max(beneficiario_auh), by(id)
label variable hogar_auh "Hogar con al menos un beneficiario de la AUH"

tabstat beneficiario_auh [w=pondih], by(dipcf) statistics(sum) save


drop aux* elegibilidad* exclusion* jefe_formal conyuge_formal jefe_conyuge_formal nieto_auh nro_nieto_auh hijo_formal
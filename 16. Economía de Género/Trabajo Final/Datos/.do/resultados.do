args esc0 esc1 esc2 esc3 esc4 esc5 esc6


*##############################################################################*
* INGRESO PER CÁPITA FAMILIAR PROMEDIO POR DECIL Y GÉNERO DEL JEFE DE HOGAR *
*##############################################################################*


*Por Decil*

forvalues i=1(1)2 {
	table dipcf [w=pondih] if (genero_jefe==`i'), contents(mean `esc0' mean `esc1' mean `esc2')
	table dipcf [w=pondih] if (genero_jefe==`i'), contents(mean `esc0' mean `esc3' mean `esc4')
	table dipcf [w=pondih] if (genero_jefe==`i'), contents(mean `esc0' mean `esc5' mean `esc6')
}

table dipcf [w=pondih], contents(mean `esc0' mean `esc1' mean `esc2')
table dipcf [w=pondih], contents(mean `esc0' mean `esc3' mean `esc4')
table dipcf [w=pondih], contents(mean `esc0' mean `esc5' mean `esc6')

*Toda la Población*

forvalues i=0(1)6 {
	forvalues j=1(1)2 {
		summarize `esc`i'' [w=pondih] if (genero_jefe==`j')
	}
	summarize `esc`i'' [w=pondih]
}


*##############################################################################*
* INGRESO PER CÁPITA FAMILIAR PROMEDIO POR SECTOR Y GÉNERO DEL JEFE DE HOGAR *
*##############################################################################*


*Por Sector*

forvalues i=1(1)2 {
	table sector_indec [w=pondih] if (genero_jefe==`i'), contents(mean `esc0' mean `esc1' mean `esc2')
	table sector_indec [w=pondih] if (genero_jefe==`i'), contents(mean `esc0' mean `esc3' mean `esc4')
	table sector_indec [w=pondih] if (genero_jefe==`i'), contents(mean `esc0' mean `esc5' mean `esc6')
}

table sector_indec [w=pondih], contents(mean `esc0' mean `esc1' mean `esc2')
table sector_indec [w=pondih], contents(mean `esc0' mean `esc3' mean `esc4')
table sector_indec [w=pondih], contents(mean `esc0' mean `esc5' mean `esc6')

*Todos los Sectores*

forvalues i=0(1)6 {
	forvalues j=1(1)2 {
		summarize `esc`i'' [w=pondih] if ((sector_indec>=1 & sector_indec<=12) & genero_jefe==`j')
	}
	summarize `esc`i'' [w=pondih] if (sector_indec>=1 & sector_indec<=12)
}


*##############################################################################*
* GÉNERO Y GRUPOS DE EDAD *
*##############################################################################*


*Composición del género individual y del género del jefe de hogar por decil, por sector y por grupo de edad*

foreach i of varlist dipcf sector_indec {
	foreach j of varlist genero genero_jefe {
		tabulate `i' `j' [w=pondih]
	}
}

tabulate g_edad_3 genero [w=pondih]

*Distribución de los individuos de cada grupo de edad por decil / género individual*

forvalues i=1(1)5 {
	tabulate dipcf genero [w=pondih] if (g_edad_3==`i')
}


*##############################################################################*
* INFORMALIDAD *
*##############################################################################*


*Distribución de los trabajadores informales y tasa de informalidad por decil, por sector, por género individual*

foreach i of varlist dipcf sector_indec genero {
	tabstat informal [w=pondih], by(`i') statistics(sum mean)
}

*Distribución de los trabajadores informales por decil / género individual y por sector / género individual*

tabulate dipcf genero [w=pondih] if (informal==1)
tabulate sector_indec genero [w=pondih] if (informal==1)


*##############################################################################*
* EMPLEO PERDIDO *
*##############################################################################*


*Empleo por grupos de edad, género individual y niños en el hogar (1er. Trim. 2020 - 4to. Trim. 2020)*

generate ocupado_1=ocupado
forvalues i=2(1)4 {
	generate ocupado_`i'=ocupado
}
replace ocupado_2=0 if (employ_imputed_1==1)
replace ocupado_3=0 if (employ_imputed_2==1)
replace ocupado_4=0 if (employ_imputed_3==1)

foreach var of varlist genero genero_niños {
	forvalues i=1(1)4 {
		table g_edad_3 `var' [w=pondih], contents(mean ocupado_`i') row column
	}
}

*Empleo por sector y género individual (1er. Trim. 2020 - 4to. Trim. 2020)*

foreach i of newlist ocup1 ocup2 ocup3 ocup4 {
	matrix define sector_`i'=J(11,2,.)
	matrix rownames sector_`i' = "s1" "s2" "s3" "s4" "s5" "s6" "s7" "s8" "s9" "s10" "s11"
	matrix colnames sector_`i' = "Hombre" "Mujer"
}

forvalues i=1(1)11 {
	forvalues j=1(1)2 {
		summarize sector_indec [w=pondih] if (sector_indec==`i' & genero==`j')
		local s`i'_g`j'_ocup1=r(sum_w)
		matrix sector_ocup1 [`i',`j']=`s`i'_g`j'_ocup1'
		summarize sector_indec [w=pondih] if (sector_indec==`i' & genero==`j' & employ_imputed_1!=1)
		local s`i'_g`j'_ocup2=r(sum_w)
		matrix sector_ocup2 [`i',`j']=`s`i'_g`j'_ocup2'
		summarize sector_indec [w=pondih] if (sector_indec==`i' & genero==`j' & employ_imputed_2!=1)
		local s`i'_g`j'_ocup3=r(sum_w)
		matrix sector_ocup3 [`i',`j']=`s`i'_g`j'_ocup3'
		summarize sector_indec [w=pondih] if (sector_indec==`i' & genero==`j' & employ_imputed_3!=1)
		local s`i'_g`j'_ocup4=r(sum_w)
		matrix sector_ocup4 [`i',`j']=`s`i'_g`j'_ocup4'
	}
}

forvalues i=1(1)4 {
	matrix list sector_ocup`i'
}

*Distribución de los individuos que perdieron el empleo por sector / género individual*

forvalues i=1(1)3 {
	tabulate sector_indec genero [w=pondih] if (employ_imputed_`i'==1)
}


*##############################################################################*
* RESPUESTA DE POLÍTICA *
*##############################################################################*


generate aux1=(ife_1>0 & ife_1!=.)
egen hogar_ife_1=max(aux1), by(id)

generate aux2=(bono_auh_1>0 & bono_auh_1!=.)
egen hogar_auh_1=max(aux2), by(id)

*Distribución de los individuos que recibieron cada una de las respuesta de política por decil (1er. trim. ahead)*

tabulate dipcf [w=pondih] if (ife_1>0 & ife_1!=.)
tabulate dipcf [w=pondih] if (bono_auh_1>0 & bono_auh_1!=.)
tabulate dipcf [w=pondih] if (bono_jubi_1>0 & bono_jubi_1!=.)

*Composición del género individual y del género jefe de hogar por respuesta de política (1er. trim. ahead)*

foreach i of varlist genero genero_jefe {
	tabulate hogar_ife_1 `i' [w=pondih] if (hogar_ife_1==1 & edad>=18 & edad<=60)
}

foreach i of varlist genero genero_jefe {
	tabulate hogar_auh_1 `i' [w=pondih] if (hogar_auh_1==1 & edad>=18 & edad<=60)
}

foreach i of varlist genero genero_jefe {
	tabulate bono_jubi_1 `i' [w=pondih] if (bono_jubi_1>0 & bono_jubi_1!=.)
}

drop ocupado_* aux* hogar_ife_1 hogar_auh_1
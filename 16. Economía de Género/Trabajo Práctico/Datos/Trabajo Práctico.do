clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/16. Economía de Género/Trabajo Práctico/Datos"
*do "prepara_base_1"
use "Base", clear
do "prepara_base_2"


*##############################################################################*
								* EJERCICIO 1 *
*##############################################################################*


forvalues i=1(1)2 {
	summarize activo [w=pondera] if (genero==`i')
}

summarize activo [w=pondera]

graph bar (mean) activo [w=pondera],	over(genero) asyvars bargap(100) blabel(bar, format(%5.3g)) ///
										ylabel(0.1 "10%" 0.2 "20%" 0.3 "30%" 0.4 "40%" 0.5 "50%" 0.6 "60%" 0.7 "70%" 0.8 "80%" 0.9 "90%" 1.0 "100%") ///
										title("Participación laboral por género", color(black)) ytitle("") ///
										note("Fuente: Elaboración propia en base a EPH (4to. Trim. 2019)") name("ej1", replace)


*##############################################################################*
								* EJERCICIO 2 *
*##############################################################################*


levelsof region2, local(levels)

foreach i of local levels {

	forvalues j=1(1)2 {
		summarize activo [w=pondera] if (region2==`i' & genero==`j')
	}

	summarize activo [w=pondera] if (region2==`i')

}

graph hbar (mean) activo [w=pondera],	over(genero) over(region2) asyvars bargap(20) blabel(bar, format(%5.3g)) ///
										ylabel(0.1 "10%" 0.2 "20%" 0.3 "30%" 0.4 "40%" 0.5 "50%" 0.6 "60%" 0.7 "70%" 0.8 "80%" 0.9 "90%" 1.0 "100%") ///
										title("Participación laboral por género y región", color(black)) ytitle("") ///
										note("Fuente: Elaboración propia en base a EPH (4to. Trim. 2019)") name("ej2", replace)

*Combinación gráficos ejercicios 1 y 2*

graph combine ej1 ej2, rows(1)


*##############################################################################*
								* EJERCICIO 3 *
*##############################################################################*


forvalues i=1(1)2 {
	summarize ing_horario [w=pondiio] if (genero==`i')
}

summarize ing_horario [w=pondiio]

graph bar (mean) ing_horario [w=pondiio],	over(genero) asyvars bargap(100) blabel(bar, format(%6.4g)) ///
											ylabel (0 "$0" 50 "$50" 100 "$100" 150 "$150" 200 "$200" 250 "$250") ///
											title("Ingreso horario promedio por género", color(black)) ytitle("") ///
											note("Fuente: Elaboración propia en base a EPH (4to. Trim. 2019)") name("ej3", replace)


*##############################################################################*
								* EJERCICIO 4 *
*##############################################################################*


*Share promedio*

summarize share [w=pondiio]

*Share promedio y decil de ingreso*

forvalues i=1(1)10 {
	summarize share [w=pondiio] if (dipcf==`i')
}

graph bar (mean) share [w=pondiio],	over(dipcf) bargap(20) blabel(bar, format(%5.3g)) ylabel(0.1 "10%" 0.2 "20%" 0.3 "30%" 0.4 "40%" 0.5 "50%") ///
									title("Share promedio por decil de ingreso", color(black)) ytitle("") ///
									note("Fuente: Elaboración propia en base a EPH (4to. Trim. 2019)") name("ej4a", replace)

*Share promedio y nivel educativo*

forvalues i=1(1)6 {
	summarize share [w=pondiio] if (nivel_educ==`i')
}

graph bar (mean) share [w=pondiio],	over(nivel_educ, relabel(1 "Primario Incomp." 2 "Primario Comp." 3 "Secundario Incomp." 4 "Secundario Comp." ///
									5 "Superior Incomp." 6 "Superior Comp.")) bargap(20) blabel(bar, format(%5.3g)) ///
									ylabel(0.1 "10%" 0.2 "20%" 0.3 "30%" 0.4 "40%" 0.5 "50%") title("Share promedio por nivel educativo", color(black)) ytitle("") ///
									note("Fuente: Elaboración propia en base a EPH (4to. Trim. 2019)") name("ej4b", replace)

*Share promedio y región*

levelsof region2, local(levels)

foreach i of local levels {
	summarize share [w=pondiio] if (region2==`i')
}

graph bar (mean) share [w=pondiio],	over(region2) bargap(20) blabel(bar, format(%5.3g)) ylabel(0.1 "10%" 0.2 "20%" 0.3 "30%" 0.4 "40%" 0.5 "50%") ///
									title("Share promedio por región", color(black)) ytitle("") ///
									note("Fuente: Elaboración propia en base a EPH (4to. Trim. 2019)") name("ej4c", replace)

*Combinación gráficos ejercicio 4*

graph combine ej4a ej4b ej4c, cols(1)

					
*##############################################################################*
								* EJERCICIO 5 *
*##############################################################################*


forvalues i=1(1)4 {
	summarize activo [w=pondera] if (genero_niños==`i')
}

graph bar (mean) activo [w=pondera],	over(genero) over(niños) asyvars bargap(20) blabel(bar, format(%5.3g)) ///
										ylabel(0.1 "10%" 0.2 "20%" 0.3 "30%" 0.4 "40%" 0.5 "50%" 0.6 "60%" 0.7 "70%" 0.8 "80%" 0.9 "90%" 1.0 "100%") ///
										title("Participación laboral por género y niños en el hogar", color(black)) ytitle("") ///
										note("Fuente: Elaboración propia en base a EPH (4to. Trim. 2019)") name("ej5", replace)
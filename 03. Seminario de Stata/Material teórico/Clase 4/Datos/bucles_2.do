clear all
set more off

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/3. Seminario de Stata/Material teórico/Clase 4/Datos"
use "nic98_cedlas-resumida", clear


matrix resultados=J(4,1,.)
matrix rownames resultados = "1" "2" "3" "4"
matrix colnames resultados = "Ingreso laboral"

forvalues i=1(1)4 {
	summarize ila [weight=pondera] if (region==`i')
	matrix resultados[`i',1]=r(mean)
}

matrix list resultados, title("Ingreso laboral promedio en Nicaragua")
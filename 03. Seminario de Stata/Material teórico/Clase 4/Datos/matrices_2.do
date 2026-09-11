clear all
set more off

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/3. Seminario de Stata/Material teórico/Clase 4/Datos"
use "nic98_cedlas-resumida", clear


summarize lp_2usd
local lp=r(mean)

generate pobre=1 if (ipcf<`lp')
replace pobre=0 if (ipcf>=`lp' & ipcf!=.)

matrix Pob=J(1,3,.)
matrix list Pob

summarize pobre [weight=pondera]

*Mostrar los valores acumulados luego del summarize*
return list

*Usar los valores acumulados en r()*
display "Pobreza en	Nicaragua = " r(mean)

*Asignar el valor a la matriz*
summarize pobre [weight=pondera]
matrix Pob[1,1]=r(mean)*100
matrix list Pob

*Nombrar las columnas y filas de la matriz*
matrix colnames Pob = "Total" "Urbano" "Rural"
matrix rownames Pob = "Pobreza"
matrix list Pob

*Incluir en la matriz la tasa de pobreza urbana y rural*
summarize pobre [weight=pondera] if urbano==1
matrix Pob [1,2]=r(mean)*100
summarize pobre [weight=pondera] if urbano==0
matrix Pob [1,3]=r(mean)*100

matrix list Pob, title("Pobreza en Nicaragua")

*Exportar matriz con resultados a un archivo .xls*
preserve
drop _all
svmat Pob, names(col)
export excel using "pobreza_nic98.xls", firstrow(variables) replace
restore
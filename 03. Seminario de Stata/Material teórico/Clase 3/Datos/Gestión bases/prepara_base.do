clear all
set more off

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/3. Seminario de Stata/Material teórico/Clase 3/Datos/Gestión bases"


*Importar la base de datos con formato .csv"*

import delimited "inc_region.csv"

*Guardar la base de datos con formato .dta*

save "inc_region", replace
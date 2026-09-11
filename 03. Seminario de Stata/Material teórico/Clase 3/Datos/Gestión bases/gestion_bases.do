clear all
set more off

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/3. Seminario de Stata/Material teórico/Clase 3/Datos/Gestión bases"
use "inc_region", clear


describe

encode region, generate(nregion)
drop region
rename nregion region
order region
list

*Comando xpose*

xpose, clear varname
list

*Volver a la base original*

xpose, clear varname
drop _varname
list

*Etiquetar variable y valores de una variable*

label define region 1 "Cuyo" 2 "GBA" 3 "NEA" 4 "NOA" 5 "Pampeana" 6 "Patagonia"
label values region region
label variable region "Region"

*Comando reshape*

reshape long ila, i(region) j(year)
graph twoway connected ila year, by(region)

reshape wide ila, i(region) j(year)

*Comando collapse*

reshape long ila, i(region) j(year)
collapse (mean) ila, by(region)
collapse (mean) ila
clear all
set more off

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/3. Seminario de Stata/Material teórico/Clase 4/Datos"
use "nic98_cedlas-resumida", clear


*Generar una macro local con la línea de pobreza*

summarize lp_2usd
local lp=r(mean)

*Generar indicador condición de pobreza*

generate pobre=1 if (ipcf<`lp')
replace pobre=0 if (ipcf>=`lp' & ipcf!=.)

tabulate pobre [weight=pondera]
tabulate pobre [weight=pondera] if (urbano==1)
tabulate pobre [weight=pondera] if (urbano==0)

table urbano [weight=pondera], contents(mean pobre) row
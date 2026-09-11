clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/3. Seminario de Stata/Material teórico/Clase 1/Datos"
use "ecu11_cedlas_resumida", clear


*Describe*

describe
help summarize

*Estadísticas descriptivas (no condicionales)*

summarize
summarize ipcf
summarize ila ipcf
summarize p*
summarize urbano
summarize hombre

*Estadísticas descriptivas (condicionales)*

summarize ipcf if (urbano==1)
summarize ipcf if (urbano==0)

*Estadísticas descriptivas ([, opciones])*

summarize ipcf
summarize ipcf, detail

*Estadísticas descriptivas (en rango)*

summarize hombre in 1/10
summarize hombre in -10/-1

*Tabulate*

tabulate region
tabulate region hombre

*Table*

table region
table (region), statistic(mean ipcf)
table (region), statistic(frequency) statistic(mean ipcf) statistic(sd ipcf)
table (region), statistic(frequency) statistic(mean ipcf) statistic(sd ipcf)
table (region), statistic(frequency) statistic(mean ipcf) statistic(mean ila)

*Ordenamiento*

sort id
gsort -id
gsort +id
sort id edad
gsort id -edad

*Replace*

replace itf=itf/1000
replace ipcf=0 if (urbano==0)
replace ipcf=0 if (urbano==0 & hombre==1)
replace ipcf=0 if (urbano==0 | hombre==1)

*Preserve y Restore*

summarize hombre
preserve
replace hombre=0 if (hombre==1)
summarize hombre
restore
summarize hombre

*Generate*

generate edad2=edad*edad
generate grupo=1 if (edad<=10 & hombre==1)
replace grupo=0 if (grupo==.)

*Resultados*

summarize ipcf
return list
generate ipcf_media=ipcf/r(mean)
rename ipcf_media ipcf_mu

*By (una variable)*

sort region
by region: summarize ipcf
bysort region: summarize ipcf

*By (dos variable)*

sort region hombre
by region hombre: summarize ila
egen reg_h=group(region hombre)
sort reg_h
by reg_h: summarize ila

*Borrar observaciones y variables*

drop if (edad<5)
drop ii

*Egen (opción sum y rsum)*

generate suma1=sum(pondera)
egen suma2=sum(pondera)
egen suma3=total(pondera)
sort id
browse id miembros edad

sort ila
generate aux=ila+inla
egen aux1=rsum(ila inla)
egen aux2=rsum(ila inla), missing
egen aux3=rowtotal(ila inla)
egen aux4=rowtotal(ila inla), missing
summarize aux*
drop aux*

*Ponderadores (aplicar los ponderadores hace representativa la información a nivel poblacional; de lo contrario, sólo es representativa a nivel muestral)*

summarize ipcf
summarize ipcf [weight=pondera]
summarize ipcf [fweight=pondera]

*Display*

display "hola"
display 2*2
display ipcf[1]
display ipcf[_N]
display "Tasa de desempleo = " 2*4

*Ejercicio 1: Calcular la cantidad de miembros por hogar promedio en Ecuador 2011"

sort id 
summarize miembros [weight=pondera]
egen hogar=tag(id)
summarize miembros [weight=pondera] if (hogar==1)

*Ejercicio 2: Particionar la base datos según el id y, luego, sumar unos*

generate a=1
bysort id: egen miembros1=total(a)
drop a
compare miembros miembros1
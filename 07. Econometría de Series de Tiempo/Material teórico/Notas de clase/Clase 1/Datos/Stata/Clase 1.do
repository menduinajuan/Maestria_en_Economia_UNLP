*MAGDALENA CORNEJO
*UNLP 2019
*Clase 1 - Procesos estocásticos univariados

import delimited "C:\Users\Magdalena Cornejo\Dropbox\UNLP\Clase 1\STATA\infla.csv"

*como la variable "time" es string, genero una nueva variable "month" con formato mensual
gen month=monthly(time,"YM")
format month %tm

*le indico a Stata que la base de datos es de series temporales:
tsset month

*Genero el primer rezago de cpi y de wage:
gen cpiL1=L.cpi
gen wageL1=L.wage
*chequeo:
br cpi cpiL1
br wage wageL1

*Genero la variable inflación como diferencia logarítmica del cpi*100
gen lncpi=ln(cpi)
gen infln=D.lncpi*100

*Genero la variable cambio porcentual de salarios como diferencia logarítmica del wage *100
gen lnwage=ln(wage)
gen pcwage=D.lnwage


regress infln pcwage
estat bgodfrey, lags(1/2)
estat bgodfrey, lags(1/2) small /*versión para muestra pequeña*/

*Para ver hasta qué rezago es significativo (estimo la regresión auxiliar)
predict resid, resid
regress resid pcwage L.resid L2.resid
regress resid pcwage L.resid L2.resid L3.resid	/*Hasta el segundo rezago es significativo*/

*Modelo autorregresivo con regresores adicionales:
regress infln pcwage L.infln L2.infln
estat bgodfrey, lags(1/2)
estat bgodfrey, lags(1/3)

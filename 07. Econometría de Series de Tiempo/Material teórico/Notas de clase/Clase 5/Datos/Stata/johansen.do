*MAGDALENA CORNEJO
*SERIES DE TIEMPO 2019
*UNLP

**COINTEGRACION EN SISTEMAS

clear all
import excel "C:\Users\Magdalena Cornejo\Dropbox\UNLP\Clase 5\Excel\danish.xlsx", sheet("Hoja1") firstrow
gen quarter=quarterly(trim,"YQ")
format quarter %tq
tsset quarter

twoway (tsline LRM) (tsline LRY, lcolor(red) lpattern(solid) yaxis(2)), legend(order(1 "LRM" 2 "LRY"))
twoway (tsline LRM) (tsline IBO, lcolor(blue) lpattern(solid) yaxis(2)), legend(order(1 "LRM" 2 "IBO"))
twoway (tsline LRM) (tsline IDE, lcolor(green) lpattern(solid) yaxis(2)), legend(order(1 "LRM" 2 "IDE"))

*Al 5% todas son I(1):
dfuller LRM, lag(2) trend regress
dfuller D.LRM, lag(1) regress

dfuller LRY, trend regress
dfuller D.LRY, regress

dfuller IBO, lag(1) trend regress
dfuller D.IBO, regress

dfuller IDE, lag(1) trend regress
dfuller D.IDE, regress

*Determino longitud del VAR y estimo:
varsoc LRM LRY IBO IDE
var LRM LRY IBO IDE, lag(2) 

*Evalúo autocorrelación y normalidad:
varlmar, mlag(3)
varnorm
*Si quieren controlar esa leve asimetría de LRY obtengan los residuos de las ecuaciones y evalúen si hay algún outlier. Controlen con una dummy irrestricta en el VAR.

*Prueba de cointegración (se basa en el supuesto de normalidad, al menos que no haya asimetría):
*opción sin trend en el espacio de COI:
vecrank LRM LRY IBO IDE, lags(2) 
vecrank LRM LRY IBO IDE, lags(2) max

*opción con trend en el espacio de COI:
vecrank LRM LRY IBO IDE, lags(2) trend(rtrend)
vecrank LRM LRY IBO IDE, lags(2) max trend(rtrend)

*Al 99% (reporta valores críticos al 1%):
vecrank LRM LRY IBO IDE, lags(2) level99
vecrank LRM LRY IBO IDE, lags(2) max level99

*Si queremos que reporte vc's al 1% y 5%:
vecrank LRM LRY IBO IDE, lags(2) levela
vecrank LRM LRY IBO IDE, lags(2) max levela

*Solución de largo plazo (la última parte del output, OJO con los signos por la normalización):
vec LRM LRY IBO IDE, lags(2) 
vec LRM LRY IBO IDE, lags(2) trend(rtrend) /*la trend no es significativa, así que me quedo con la prueba de COI sin trend y los resultados de la línea anterior*/


*CON DUMMIES ESTACIONALES:

*Genero dummies estacionales centradas:
egen q=seq(), to(4)
tab q, gen(D)
forval i=1/4{
	gen CS`i'=D`i'-1/4
	}
	
*Determino longitud del VAR y estimo:
varsoc LRM LRY IBO IDE, exog(CS*)
var LRM LRY IBO IDE, lag(1) exog(CS*)
test CS1 CS2 CS3

*Evalúo autocorrelación y normalidad:
varlmar, mlag(2)
varnorm

*Prueba de cointegración:
vecrank LRM LRY IBO IDE, lags(1) sindicators(CS*) levela
vecrank LRM LRY IBO IDE, lags(1) max sindicators(CS*) levela

vecrank LRM LRY IBO IDE, lags(1) trend(rtrend) sindicators(CS*) levela
vecrank LRM LRY IBO IDE, lags(1) max trend(rtrend) sindicators(CS*) levela

vec LRM LRY IBO IDE, lags(1) sindicators(CS*)
vec LRM LRY IBO IDE, lags(1) trend(rtrend) sindicators(CS*) /*OJO que acá la trend roba el efecto de LRY e IDE*/

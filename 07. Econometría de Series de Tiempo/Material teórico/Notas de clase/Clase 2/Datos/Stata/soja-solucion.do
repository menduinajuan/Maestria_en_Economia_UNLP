*MAGDALENA CORNEJO
*SERIES DE TIEMPO 2019
*UNLP

clear all
import delimited "C:\Users\Magdalena Cornejo\Dropbox\UNLP\Clase 2\Bases de datos\soja.csv"
gen mes=monthly(month,"YM")
format mes %tm

tsset mes
tsline s, title("Precio spot de la soja en Chicago (USD/MT)")
tsline f, title("Precio futuro de la soja en Chicago (USD/MT)")

*Aplico la diferencia logartímica:
gen LS=ln(s)
gen LF=ln(f)

gen DLS=D.LS
gen DLF=D.LF

tsline DLS DLF

*Busco el orden apropiado del VAR usando criterios de información:
varsoc DLS DLF, maxlag(12)

*Estimo el VAR:
var DLS DLF, lags(1/10)

*Evalúo que supere las pruebas de diagnóstico:
varlmar, mlag(11)
varnorm

*Observo los residuos:
predict resid1, resid equation(#1)
predict resid2, resid equation(#2)

tsline resid1
tsline resid2

*No se ven grandes outliers. La no-normalidad es básicamente un problem de exceso de curtosis.

*PRUEBA DE CAUSALIDAD EN SENTIDO DE GRANGER
vargranger

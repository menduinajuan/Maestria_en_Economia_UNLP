*MAGDALENA CORNEJO
*SERIES DE TIEMPO 2019
*UNLP

*ESTIMACION DE MODELOS VAR

clear all
import delimited "C:\Users\Magdalena Cornejo\Dropbox\UNLP\Clase 2\Bases de datos\var.csv"
gen time=tq(1960q1)+_n-1
format time %tq

tsset time

tsline invest income cons

*Tomo diferencias logarítmicas de las variables:
gen linvest=ln(invest)
gen lincome=ln(income)
gen lcons=ln(cons)

gen dlinvest=D.linvest*100
gen dlincome=D.lincome*100
gen dlcons=D.lcons*100

tsline dlinvest dlincome dlcons

*VAR(2)
var dlinvest dlincome dlcons, lags(2)

*FIRs 10 pasos adelante:
irf create irf10, set(varirfs) step(10) replace
irf graph oirf, impulse(dlinvest) response(dlinvest dlincome dlcons)
irf graph oirf, impulse(dlincome) response(dlinvest dlincome dlcons)
irf graph oirf, impulse(dlcons) response(dlinvest dlincome dlcons)

*DV:
irf table fevd

*MAGDALENA CORNEJO
*SERIES DE TIEMPO 2019
*UNLP

*Simulación de distintos procesos AR(1):

clear all
set seed 1234
set obs 100
gen time=_n
tsset time

gen rb=invnorm(runiform())

*AR(1) con phi=0.8:
gen y1=0
replace y1=0.8*L.y1+rb if time>1
tsline y1
ac y1, lags(12)
pac y1, lags(12)

*AR(1) con phi=1 (es decir, un RW):
gen y2=0
replace y2=L.y2+rb if time>1
tsline y2
ac y2, lags(12)
pac y2, lags(12)

*AR(1) con phi=1.05:
gen y3=0
replace y3=1.05*L.y3+rb if time>1
tsline y3
ac y3, lags(12)
pac y3, lags(12)

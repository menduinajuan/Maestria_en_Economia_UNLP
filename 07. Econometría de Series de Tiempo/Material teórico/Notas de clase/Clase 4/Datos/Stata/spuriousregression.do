*MAGDALENA CORNEJO
*SERIES DE TIEMPO 2019
*UNLP

**SIMULANDO: REGRESION ESPURIA

clear all
set seed 1234
set obs 100
gen time=_n
tsset time

gen e=invnorm(runiform())
gen v=invnorm(runiform())

gen y=2
replace y=2+L.y+e if time>1
gen x=-1
replace x=-1+L.x+v if time>1

twoway (tsline y, sort yaxis(1)) (tsline x, sort yaxis(2) lcolor(red) lpattern(solid)), legend(order(1 "y" 2 "x"))

reg y x
predict resid, resid
tsline resid
ac resid
pac resid
dfuller resid, lag(1) trend
dfuller resid, lag(1)

gen Dy=D.y
gen Dx=D.x

twoway (tsline Dy, sort yaxis(1)) (tsline Dx, sort yaxis(2) lcolor(red) lpattern(solid)), legend(order(1 "Dy" 2 "Dx"))

reg Dy Dx

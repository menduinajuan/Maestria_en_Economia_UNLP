*MAGDALENA CORNEJO
*SERIES DE TIEMPO 2019
*UNLP

clear all
set seed 1234
set obs 200
gen time=_n
tsset time

*SIMULANDO UN RUIDO BLANCO (rb es N(0,1)):
gen e=invnorm(runiform())
tsline e

*SIMULANDO PROCESOS MA(1):
gen y=5+e+0.5*L.e
tsline y
ac y

gen x=-3+e+0.9*L.e
tsline x
ac x

gen z=9+e-1.2*L.e
tsline z
ac z

*SIMULANDO PROCESOS AR(1):
*condición inicial (y0=0)
gen ybis=0
replace ybis=0.1*L.ybis+e if time>1
tsline ybis
ac ybis

gen xbis=0
replace xbis=-0.5*L.xbis+e if time>1
tsline xbis
ac xbis

gen zbis=0
replace zbis=0.95*L.zbis+e if time>1
tsline zbis
ac zbis

*SIMULANDO PROCESOS ARMA(p,q):
*condición inicial (y0=0)
gen y1=0
replace y1=0.8*L.y1+e if time>1
gen y2=0
replace y2=0.1*L.y2+0.5*L2.y2+e if time>2
gen y3=0
replace y3=e+0.8*L.e if time>1
gen y4=0
replace y4=e+0.1*L.e-0.4*L2.e+0.5*L3.e if time>3
gen y5=0
replace y5=0.5*L.y5+e-0.3*L.e if time>1
gen y6=0
replace y6=0.5*L.y6-0.2*L2.y6+e-0.3*L.e if time>2

forval i=1/6{
	tsline y`i', name(y`i')
}

gr combine y1 y2 y3 y4 y5 y6 

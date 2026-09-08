*MAGDALENA CORNEJO
*SERIES DE TIEMPO 2019
*UNLP

*TENDENCIAS DETERMINISTICAS:

clear all
import excel "C:\Users\Magdalena Cornejo\Dropbox\UNLP\Clase 3\STATA\RGDP.xlsx", sheet("RGDP") firstrow

gen trimestre=quarterly(quarter,"YQ")
format trimestre %tq

tsset trimestre, quarterly

tsline RGDP

gen trend=_n
gen trend2=trend^2
gen trend3=trend^3

reg RGDP trend trend2 trend3
predict RGDPhat
predict RGDP_sintrend, resid

twoway (tsline RGDP) (tsline RGDPhat, lcolor(red) lpattern(solid))

*MAGDALENA CORNEJO
*SERIES DE TIEMPO 2019
*UNLP

**COINTEGRACION

clear all
import excel "C:\Users\Magdalena Cornejo\Dropbox\UNLP\Clase 4\Excel\soja.xlsx", sheet("Sheet1") firstrow

gen mes=monthly(month,"YM")
format mes %tm
tsset mes

gen LS=log(S)
gen LF=log(F)

twoway (tsline LS) (tsline LF, lcolor(red) lpattern(solid)), legend(order(1 "LS" 2 "LF"))

dfuller LS, lag(1) trend
dfuller LF, lag(1) trend

dfuller D.LS 
dfuller D.LF

reg LS LF
predict resid, resid
ac resid
pac resid

*Test de Engle-Granger:
egranger LS LF, lags(2) trend regress
egranger LS LF, lags(1) trend regress

*Estimación del MCE:
reg D.LS L.LS L.LF D.L.LS D.L.LF 
estat bgodfrey, lags(1/2)

*versión restringida:
reg LS LF
predict TCE, resid

reg D.LS L.TCE D.L.LS D.L.LF 
estat bgodfrey, lags(1/2)

*MAGDALENA CORNEJO
*SERIES DE TIEMPO 2018
*UNLP

**ARCH

clear all
import excel "C:\Users\Magdalena Cornejo\Dropbox\UNLP\Clase 6\Excel\currencies.xlsx", sheet("Sheet1") firstrow

tsset day

tsline RGBP
histogram RGBP, normal
sum RGBP, d
sktest RGBP

arima RGBP, ar(1) 
predict resid, resid
wntestq resid

histogram resid, normal
sum resid, d
sktest resid

*Evaluando efectos ARCH en los residuos:
*estat archlm ---> funciona después de regress. Tenemos que hacerlo a mano :(

gen resid2=resid^2
reg resid2 L.resid2
test L.resid2

reg resid2 L.resid2 L2.resid2
test L.resid2  L2.resid2



*Estimación de un modelo ARCH(1) puro:
arch RGBP, arch(1)

*Estimación de un modelo ARCH(1) con términos AR(1) como regresor (en la ecuación de la media):
arch RGBP L.RGBP, arch(1)
predict res, resid
predict h, var
gen stdres=res/(h^.5)
sum res stdres, d

qui histogram res, normal name(u, replace)
qui histogram stdres, normal name(e, replace)
graph combine u e, cols(2)

arch RGBP L.RGBP, arch(1) vce(robust)

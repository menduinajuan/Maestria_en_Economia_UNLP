capture program drop roy

program define roy

clear all

*Argumentos del programa*

args obs sd1 sd2 rho delta

display as text "obs = " as result `obs'
display as text "sd1 = " as result `sd1'
display as text "sd2 = " as result `sd2'
display as text "rho = " as result `rho'

set obs `obs'

*Generar los valores para la normal bivariada*
generate y1=invnorm(uniform())*`sd1'
generate y2p=invnorm(uniform())*`sd2'
generate y2=(`sd2'*y1/`sd1')*`rho'+y2p*sqrt(1-(`rho')^2)

*Graficar las distribuciones no condicionadas*
kdensity y1
graph export "y1_`delta'.png", replace
kdensity y2
graph export "y2_`delta'.png", replace

*Generar y según el mecanismo de selección de Roy*
generate y=max(y1,y2)

*Graficar la distribución resultante del mecanismo de selección de Roy*
kdensity y
graph export "y_`delta'.png", replace

summarize y
local cv=r(sd)/r(mean)
regress y1 y2
predict yhat
graph twoway (scatter y1 y2) (lfit y1 y2)
graph export "scatter_`delta'.png", replace
display as text "CV de y = " as result `cv'

correlate y1 y2
local correlacion=r(rho)
display as text "Correlación y1 y2 = " as result `correlacion'

end
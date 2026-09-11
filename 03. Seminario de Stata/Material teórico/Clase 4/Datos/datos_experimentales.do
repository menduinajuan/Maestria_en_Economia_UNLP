clear all
set more off

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/3. Seminario de Stata/Material teórico/Clase 4/Datos"


*Fijar la cantidad de observaciones*
set obs 1000

*Fijar la semilla*
set seed 12345

*Uniforme entre a y b generate h= a+(b-a)*runiform()*
generate x=runiform()
generate w=runiform()*10

*Normal media 0 y sd 1*
generate u=rnormal()

*Generar y*
generate y=4+2.6*x+1.1*w+u
drop u

*Comando regress (MCO)*
regress y x
regress y x w

*Comandos postregresión*

*Estimación del modelo*
predict yhat_0
generate yhat_1=_b[_cons]+_b[x]*x+_b[w]*w
compare yhat_0 yhat_1

*Errores*
predict errores_0, residuals
generate errores_1=y-yhat_0
compare errores_0 errores_1

*Test de hipótesis lineales*
test x=0
test x=2.5
test x+w=3.7

*Gráficos*

drop yhat*

regress y x
predict yhat_1

regress y x w
predict yhat_2

*Predicción del primer modelo*
graph twoway (scatter yhat_1 y) (line y y) 

*Predicción del segundo modelo*
graph twoway (scatter yhat_2 y) (line y y)

*Ambos*
graph twoway (scatter yhat_1 y) (scatter yhat_2 y) (line y y), legend(label(1 "yhat_1") label(2 "yaht_2"))
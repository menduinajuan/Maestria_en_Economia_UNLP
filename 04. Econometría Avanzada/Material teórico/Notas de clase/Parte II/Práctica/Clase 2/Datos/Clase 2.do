clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/4. Econometría Avanzada/Material teórico/Notas de clase/Parte II/Práctica/Clase 2/Datos"
use "arg_eph_03_15", clear


describe
tabulate year
keep if year==2015


*MODELO PARA SALARIO HORARIO*


*Estimación MCO*

regress lwage pric seci secc supi supc hombre edad edad2 _reg2 _reg3 _reg4 _reg5 _reg6, robust

*Estimación en Dos Etapas (manual)*

*Primera Etapa*
probit trabaja pric seci secc supi supc hombre edad edad2 casado nro_hijos asiste _reg2 _reg3 _reg4 _reg5 _reg6
predict xb2, xb
generate lambda=normalden(xb2)/normprob(xb2)
*Segunda Etapa*
regress lwage pric seci secc supi supc hombre edad edad2 _reg2 _reg3 _reg4 _reg5 _reg6 lambda, robust

*Estimación Heckman*

heckman lwage pric seci secc supi supc hombre edad edad2 _reg2 _reg3 _reg4 _reg5 _reg6, ///
		select(trabaja = pric seci secc supi supc hombre edad edad2 casado nro_hijos asiste _reg2 _reg3 _reg4 _reg5 _reg6) twostep

*Estimación Heckman por MV*

heckman lwage pric seci secc supi supc hombre edad edad2 _reg2 _reg3 _reg4 _reg5 _reg6, ///
		select(trabaja = pric seci secc supi supc hombre edad edad2 casado nro_hijos asiste _reg2 _reg3 _reg4 _reg5 _reg6)


*MODELO PARA HORAS TRABAJADAS*


*Estimación por MCO empleando Variable Censurada*

regress hstrt pric seci secc supi supc hombre edad edad2 casado nro_hijos asiste _reg2 _reg3 _reg4 _reg5 _reg6, robust

*Estimación por MV empleando Variable Censurada (ll: left-censoring limit)*

tobit hstrt pric seci secc supi supc hombre edad edad2 casado nro_hijos asiste _reg2 _reg3 _reg4 _reg5 _reg6, ll(0)

*Efectos Parciales*

*Variable Censurada: dE(Y|X)/dX*
margins, predict (ystar(0,.)) at((mean) edad pric=0 seci=0 secc=1 supi=0 supc=0 nro_hijos=2 asiste=0) dydx(edad)
margins, predict (ystar(0,.)) at((mean) edad pric=0 seci=0 secc=1 supi=0 supc=0 nro_hijos=2 asiste=0) dydx(nro_hijos)
*Variable Truncada: dE(Y|X,Y>0)/dX*
margins, predict (e(0,.)) at((mean) edad pric=0 seci=0 secc=1 supi=0 supc=0 nro_hijos=2 asiste=0) dydx(edad)
margins, predict (e(0,.)) at((mean) edad pric=0 seci=0 secc=1 supi=0 supc=0 nro_hijos=2 asiste=0) dydx(nro_hijos)
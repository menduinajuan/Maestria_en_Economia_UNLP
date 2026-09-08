/************************************************************************
MODELOS DE SELECCION MUESTRAL

Parte 1: Determinantes del salario 
Parte 2: Modelos de horas trabajadas
************************************************************************/
clear all

** Directorio de trabajo
cd "F:\Docencia\Econometria Avanzada\2019\tp2 - seleccion y censura 2018\clase"


* Abro base 
use "arg_eph_03_15.dta", clear
describe
ta year 


keep if year==2015
	/*******************************************************************
	1.			              Determinantes del salario
	*********************************************************************/

** Ecuacion de salarios
* MCO
reg lwage pric seci secc supi supc hombre edad edad2 _reg2 _reg3 _reg4 _reg5 _reg6, robust

** Heckman en dos etapas (estimacion manual)
* Primera etapa
probit trabaja pric seci secc supi supc hombre edad edad2 casado nro_hijos asiste _reg2 _reg3 _reg4 _reg5 _reg6

predict xb2, xb
generate lambda = normalden(xb2)/normprob(xb2) 
* normalden(): the standard normal density, N(0, 1)
* normprob(): probability of the cumulative standard normal distribution

* Segunda etapa
regress lwage pric seci secc supi supc hombre edad edad2 _reg2 _reg3 _reg4 _reg5 _reg6 lambda, robust


* Metodo de Heckman en dos etapas (comando)
* Mirar el coeficiente de lambda para el test!
heckman lwage pric seci secc supi supc hombre edad edad2 _reg2 _reg3 _reg4 _reg5 _reg6, select(trabaja = pric seci secc supi supc hombre edad edad2 casado nro_hijos asiste _reg2 _reg3 _reg4 _reg5 _reg6) twostep

** Maximo verosimil
heckman lwage pric seci secc supi supc hombre edad edad2 _reg2 _reg3 _reg4 _reg5 _reg6, select(trabaja = pric seci secc supi supc hombre edad edad2 casado nro_hijos asiste _reg2 _reg3 _reg4 _reg5 _reg6)

	/*******************************************************************
	2.			              Modelos de horas trabajadas
	*********************************************************************/

* Estimacion del modelo lineal por MCO empleando la variable censurada
regress hstrt pric seci secc supi supc hombre edad edad2 casado nro_hijos asiste _reg2 _reg3 _reg4 _reg5 _reg6  

* Estimacion de un modelo con variable censurada por MV ( ll: left-censoring limit)
tobit hstrt pric seci secc supi supc hombre edad edad2 casado nro_hijos asiste _reg2 _reg3 _reg4 _reg5 _reg6 , ll(0)

* CASO (para los efectos parciales)
*	- edad promedio, 
*	- secundaria completa
*	- no estudia y 
*	- tiene 2 hijos 

* Censurada: dE(Y|X)/dX
margins, predict(ystar(0,.)) at((mean) edad pric=0 seci=0 secc=1 supi=0 supc=0 asiste=0 nro_hijos=2) dydx(edad)

* Truncada: dE(Y|X,Y>0)/dX
margins, predict(e(0,.)) at((mean) edad pric=0 seci=0 secc=1 supi=0 supc=0 asiste=0 nro_hijos=2) dydx(edad)

exit

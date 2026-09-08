clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/4. Econometría Avanzada/Material teórico/Notas de clase/Parte II/Práctica/Clase 1/Datos"
use "cornwell", clear


*ssc install outreg2


*ESTRUCTURA DE LOS DATOS*


describe

sort county year
xtset county year
xtdescribe

local y "lcrmrte"
local x "lprbarr lprbconv lprbpris lavgsen lpolpc ldensity lpctymle lwcon lwtuc lwtrd lwfir lwser lwmfg lwfed lwsta lwloc west central urban lpctmin"


*ESTADÍSTICAS DESCRIPTIVAS*


xtsum county year `y' `x'


*ESTIMACIÓN POLS (Pooled OLS)*


regress `y' `x'
outreg2 using "Regresiones.xls", replace noaster dec(3) ctitle("POLS")


*ESTIMACIONES ALTERNATIVAS*


*Estimador Between*
xtreg `y' `x', be
outreg2 using "Regresiones.xls", append noaster dec(3) ctitle("Between")

*Estimador Within o de Efectos Fijos (¡ver test de efectos fijos!)*
xtreg `y' `x', fe
outreg2 using "Regresiones.xls", append noaster dec(3) ctitle("Within") nocons
regress `y' `x' i.county 

*Estimador de Primeras Diferencias*
regress D.(`y' `x'), noconstant
outreg2 using "Regresiones.xls", append noaster dec(3) ctitle("Primeras Diferencias") nocons

*Estimador de Efectos Aleatorios*
xtreg `y' `x', re theta
outreg2 using "Regresiones.xls", append noaster dec(3) ctitle("Efectos Aletorios")


*TEST DE HAUSMAN*


quietly xtreg `y' `x', fe
estimates store fixed

quietly xtreg `y' `x', re
estimates store random

hausman fixed random


*RÉPLICA PAPER 2SLS CON EFECTOS FIJOS*


local x_iv "lprbconv lprbpris lavgsen ldensity lpctymle lwcon lwtuc lwtrd lwfir lwser lwmfg lwfed lwsta lwloc west central urban lpctmin"

*Primera Etapa* 
xtreg lprbarr lmix ltaxpc `x_iv', fe
predict lprbarr_hat
xtreg lpolpc lmix ltaxpc `x_iv', fe
predict lpolpc_hat

*Segunda Etapa*
xi: xtreg `y' lprbarr_hat lprbconv lprbpris lavgsen lpolpc_hat ldensity lpctymle lwcon lwtuc lwtrd lwfir lwser lwmfg lwfed lwsta lwloc west central urban lpctmin i.year, fe
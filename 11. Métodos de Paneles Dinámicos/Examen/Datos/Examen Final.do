clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/11. Métodos de Paneles Dinámicos/Examen/Datos"


*##############################################################################*
								* EJERCICIO 1 *
*##############################################################################*


use "Gasoline", clear
*import excel "Gasoline.xls", sheet("Gasoline") firstrow case(lower)

egen id=group(country)
tabulate id

sort id year
xtset id year

describe
xtdescribe

local y "lgaspcar"
local x "lrpmg lincomep lcarpcap"

*INCISO (a)*

*Estimaciones (POLS, EF y EA)*

regress `y' `x'
regress `y' `x', robust
xtreg `y' `x', fe
xtreg `y' `x', fe robust
xtreg `y' `x', re
xtreg `y' `x', re robust

*Correlación Serial*

quietly xtreg `y' `x', re robust
estimates store re
xttest0

xtserial `y' `x'

*Efectos Fijos vs. Efectos Aleatorios*

quietly xtreg `y' `x', fe
estimates store fe
quietly xtreg `y' `x', re
estimates store re
hausman fe re

mundlak `y' `x', p
test mean__lrpmg mean__lincomep mean__lcarpcap

*INCISO (b)*

quietly xtreg `y' `x', re robust
xttest1, unadjusted

*INCISO (c)*

regress `y' `x', cluster(id)
xtreg `y' `x', re
xtreg `y' `x', re cluster(id)

*INCISO (d)*

*Tests de Raiz Unitaria*

*Requieren Panel fuertemente balanceado*
xtunitroot llc `y'
*Se rechaza H0		----->		alpha<1
xtunitroot ht `y'
*No se rechaza H0	----->		alpha=1
xtunitroot breitung `y'
*No se rechaza H0	----->		alpha=1
xtunitroot hadri `y'
*Se rechaza H0		----->		alpha=1

*No requieren Panel fuertemente balanceado*
xtunitroot ips `y'
*Se rechaza H0		----->		alpha<1
xtunitroot fisher `y', dfuller lags(1)
*Se rechaza H0		----->		alpha<1
xtunitroot fisher `y', pperron lags(1)
*Se rechaza H0		----->		alpha<1

tabulate year if (year!=1960), generate(yr)

*Efectos Aleatorios*
xtreg `y' `x' l.lgaspcar, re robust
*Arellano y Bond (1991)*
xtabond2 `y' `x' l.(`y' `x') yr*, gmmstyle(l.(`y' `x'))								ivstyle(yr*, equation(level)) robust noleveleq
xtabond2 `y' `x' l.(`y' `x') yr*, gmmstyle(l.(`y' `x'), laglimits(1 1))				ivstyle(yr*, equation(level)) robust noleveleq
xtabond2 `y' `x' l.(`y' `x') yr*, gmmstyle(l.(`y' `x'), collapse)					ivstyle(yr*, equation(level)) robust noleveleq
*Blundell y Bond (1998)*
xtabond2 `y' `x' l.(`y' `x') yr*, gmmstyle(l.(`y' `x'))								ivstyle(yr*, equation(level)) robust
xtabond2 `y' `x' l.(`y' `x') yr*, gmmstyle(l.(`y' `x'), laglimits(1 1) collapse)	ivstyle(yr*, equation(level)) robust


*##############################################################################*
								* EJERCICIO 2 *
*##############################################################################*


*INCISO (a)*

clear all
set seed 12345

capture program drop montecarlo

program montecarlo, rclass
drop _all

*Parámetros*

local n=100
local t=10
local nxt=`n'*`t'
local alpha=1
local beta=1
local sigmamu=1
local sigmav=1

*Estructura*

set obs `nxt'

generate aux=1
generate nxt=sum(aux)

generate id=0
local count=0
forvalues i=1(1)`n' {
	replace id=`i' if (nxt>`count' & nxt<=`count'+`t')
	local count=`count'+`t'
}

local nxt_t=`nxt'-`t'

generate year=0
forvalues j=0(`t')`nxt_t' {

	local count=`j'

	forvalues i=1(1)`t' {
		replace year=`i' if (nxt>`count' & nxt<=`count'+1)
		local count=`count'+1
	}

}

sort id year
xtset id year

*Modelo*

generate m=rnormal() if (year==1)
bysort id: egen u=mean(m)
bysort id: generate v=rnormal()
bysort id: generate x=rnormal()
generate y=`alpha'+`beta'*x+u+v

drop aux nxt m

*Regresiones*

regress y x
return scalar betaMCO=_b[x]
matrix V=e(V)
matrix varbeta=V[1,1]
generate varMCO=det(varbeta)
summarize varMCO
return scalar varMCO=r(mean)

regress y x, cluster(id)
return scalar betaMCOC=_b[x]
matrix V=e(V)
matrix varbeta=V[1,1]
generate varMCOC=det(varbeta)
summarize varMCOC
return scalar varMCOC=r(mean)

xtreg y x, re
return scalar betaEA=_b[x]
matrix V=e(V)
matrix varbeta=V[1,1]
generate varEA=det(varbeta)
summarize varEA
return scalar varEA=r(mean)

end

*Simulación*

simulate betaMCO=r(betaMCO) betaMCOC=r(betaMCOC) betaEA=r(betaEA) varMCO=r(varMCO) varMCOC=r(varMCOC) varEA=r(varEA), reps(1000) seed(12345): montecarlo

*Estadísticas descriptivas*

summarize, detail
histogram betaMCO,  percent normal
histogram betaMCOC, percent normal
histogram betaEA,   percent normal
histogram varMCO,   percent normal
histogram varMCOC,  percent normal
histogram varEA,    percent normal

*INCISO (b)*

clear all
set seed 12345

capture program drop montecarlo

program montecarlo, rclass
drop _all

*Parámetros*

local n=100
local t=10
local nxt=`n'*`t'
local alpha=1
local beta=1
local sigmamu=1
local sigmav=1

*Estructura*

set obs `nxt'

generate aux=1
generate nxt=sum(aux)

generate id=0
local count=0
forvalues i=1(1)`n' {
	replace id=`i' if (nxt>`count' & nxt<=`count'+`t')
	local count=`count'+`t'
}

local nxt_t=`nxt'-`t'

generate year=0
forvalues j=0(`t')`nxt_t' {

	local count=`j'

	forvalues i=1(1)`t' {
		replace year=`i' if (nxt>`count' & nxt<=`count'+1)
		local count=`count'+1
	}

}

sort id year
xtset id year

*Modelo*

generate m=rnormal() if (year==1)
bysort id: egen u=mean(m)
bysort id: generate v=rnormal()
bysort id: generate x=u+rnormal()
generate y=`alpha'+`beta'*x+u+v

drop aux nxt m

*Regresiones*

regress y x
return scalar betaMCO=_b[x]
matrix V=e(V)
matrix varbeta=V[1,1]
generate varMCO=det(varbeta)
summarize varMCO
return scalar varMCO=r(mean)

regress y x, cluster(id)
return scalar betaMCOC=_b[x]
matrix V=e(V)
matrix varbeta=V[1,1]
generate varMCOC=det(varbeta)
summarize varMCOC
return scalar varMCOC=r(mean)

xtreg y x, re
return scalar betaEA=_b[x]
matrix V=e(V)
matrix varbeta=V[1,1]
generate varEA=det(varbeta)
summarize varEA
return scalar varEA=r(mean)

end

*Simulación*

simulate betaMCO=r(betaMCO) betaMCOC=r(betaMCOC) betaEA=r(betaEA) varMCO=r(varMCO) varMCOC=r(varMCOC) varEA=r(varEA), reps(1000) seed(12345): montecarlo

*Estadísticas descriptivas*

summarize, detail
histogram betaMCO,  percent normal
histogram betaMCOC, percent normal
histogram betaEA,   percent normal
histogram varMCO,   percent normal
histogram varMCOC,  percent normal
histogram varEA,    percent normal

*INCISO (c)*

clear all
set seed 12345

capture program drop montecarlo

program montecarlo, rclass
drop _all

*Parámetros*

local n=100
local t=10
local nxt=`n'*`t'
local alpha=1
local beta=1
local sigmamu=1
local sigmav=1

*Estructura*

set obs `nxt'

generate aux=1
generate nxt=sum(aux)

generate id=0
local count=0
forvalues i=1(1)`n' {
	replace id=`i' if (nxt>`count' & nxt<=`count'+`t')
	local count=`count'+`t'
}

local nxt_t=`nxt'-`t'

generate year=0
forvalues j=0(`t')`nxt_t' {

	local count=`j'

	forvalues i=1(1)`t' {
		replace year=`i' if (nxt>`count' & nxt<=`count'+1)
		local count=`count'+1
	}

}

sort id year
xtset id year

*Modelo*

generate m=rnormal() if (year==1)
bysort id: egen u=mean(m)
bysort id: generate v=rnormal()
bysort id: generate e=rnormal()
generate e_L1=e[_n-1]
replace e_L1=0 if (e_L1==.)
bysort id: generate x=e+0.5*e_L1
generate y=`alpha'+`beta'*x+u+v

drop aux nxt m

*Regresiones*

regress y x
return scalar betaMCO=_b[x]
matrix V=e(V)
matrix varbeta=V[1,1]
generate varMCO=det(varbeta)
summarize varMCO
return scalar varMCO=r(mean)

regress y x, cluster(id)
return scalar betaMCOC=_b[x]
matrix V=e(V)
matrix varbeta=V[1,1]
generate varMCOC=det(varbeta)
summarize varMCOC
return scalar varMCOC=r(mean)

xtreg y x, re
return scalar betaEA=_b[x]
matrix V=e(V)
matrix varbeta=V[1,1]
generate varEA=det(varbeta)
summarize varEA
return scalar varEA=r(mean)

end

*Simulación*

simulate betaMCO=r(betaMCO) betaMCOC=r(betaMCOC) betaEA=r(betaEA) varMCO=r(varMCO) varMCOC=r(varMCOC) varEA=r(varEA), reps(1000) seed(12345): montecarlo

*Estadísticas descriptivas*

summarize, detail
histogram betaMCO,  percent normal
histogram betaMCOC, percent normal
histogram betaEA,   percent normal
histogram varMCO,   percent normal
histogram varMCOC,  percent normal
histogram varEA,    percent normal


*##############################################################################*
								* EJERCICIO 3 *
*##############################################################################*


*Cálculo del Sesgo Dinámico de Nickell (1981) mediante Experimentos de Monte Carlo*

clear all
set seed 12345

capture program drop nickell

program nickell, rclass
drop _all

args t alpha sigmau sigmav

*Locales*

local n=100
local t=`t'
local nxt=`n'*`t'
local alpha=`alpha'

*Estructura*

set obs `nxt'

generate year=_n-int(_n/`t')*`t'
generate id=1+int(_n/`t')
replace id=id-1 if (year==0)

sort id year
xtset id year

*Modelo*

generate m=rnormal(0,`sigmau') if (year==0)
bysort id: egen u=mean(m)
bysort id: generate v=rnormal(0,`sigmav'*`t')
bysort id: generate y=u+v if (year==0)
bysort id: replace y=`alpha'*l.y+u+v if (year>0)
drop m

*Regresión*

xtreg y l.y, fe
return scalar alpha=_b[l.y]

end

matrix define   N = J(6,8,.)
matrix rownames N = "2" "3" "5" "10" "15" "20"
matrix colnames N = "0" "0.10" "0.25" "0.50" "0.75" "0.90" "0.95" "0.99"

local count_r=1

foreach t in 3 4 6 11 16 21 {

	local count_c=1
	
	foreach alpha in 0 0.10 0.25 0.50 0.75 0.90 0.95 0.99 {
		simulate Sesgo_Dinámico=(r(alpha)-`alpha'), reps(1000) seed(12345): nickell `t' `alpha' 1 1
		summarize Sesgo_Dinámico, detail
		matrix N [`count_r',`count_c']=r(mean)
		local count_c=`count_c'+1
	}

	local count_r=`count_r'+1

}

matrix list N, format(%4.3f)

*Cálculo del Sesgo Dinámico de Nickell (1981) mediante Ecuación (18)*

clear all
set obs 10

matrix define   plim = J(6,8,.)
matrix rownames plim = "2" "3" "5" "10" "15" "20"
matrix colnames plim = "0" "0.10" "0.25" "0.50" "0.75" "0.90" "0.95" "0.99"

local count_r=1

foreach t in 2 3 5 10 15 20 {

	local count_c=1

	foreach alpha in 0 0.10 0.25 0.50 0.75 0.90 0.95 0.99 {
		local plim=-(((1+`alpha')/(`t'-1))*(1-(1/`t')*((1-`alpha'^`t')/(1-`alpha'))))/ ///
					(1-(2*`alpha')/((1-`alpha')*(`t'-1))*(1-(1/`t')*((1-`alpha'^`t')/(1-`alpha'))))
		matrix plim [`count_r',`count_c']=`plim'
		local count_c=`count_c'+1
	}

	local count_r=`count_r'+1
	
}

matrix list plim, format(%4.3f)
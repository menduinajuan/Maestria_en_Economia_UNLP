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
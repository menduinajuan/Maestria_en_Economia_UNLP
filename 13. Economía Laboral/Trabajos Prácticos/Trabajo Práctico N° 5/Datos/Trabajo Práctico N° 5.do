clear all
set more off
version 17

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/13. Economía Laboral/Trabajos Prácticos/Trabajo Práctico N° 5/Datos"
use "synth_smoking", clear


*ssc install synth


*##############################################################################*
								* EJERCICIO 2 *
*##############################################################################*


*Figura 1*

bysort year: egen mean_cigsale=mean(cigsale) if (state!=3)

graph twoway	(line cigsale year if (state==3)) (line mean_cigsale year if (state!=3)), ///
				ytitle("per-capita cigarette sales (in packs)") xtitle("year") xline(1989) ///
				legend (label(1 "California") label(2 "Rest of the U.S."))

*Figura 2*

xtset state year

synth	cigsale lnincome(1980(1)1988) age15to24(1980(1)1988) retprice(1980(1)1988) beer(1984(1)1988) cigsale(1988) cigsale(1980) cigsale(1975), ///
		trunit(3) trperiod(1989) figure keep(synth3.dta) replace

*Figura 3*

clear all
use "synth3", clear

keep _Y_treated _Y_synthetic _time
drop if (_time==.)

rename _time year
rename _Y_treated treated3
rename _Y_synthetic synthetic3

order year treated3 synthetic3

generate gap3=treated3-synthetic3

graph twoway line gap3 year, ytitle("gap in per-capita cigarette sales (in packs)") xtitle("year") yline(0) xline(1989) legend(off)
	
save "synth3", replace

*Figura 4*

clear all
use "synth_smoking", clear

xtset state year

local statelist 1 2 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39

foreach i of local statelist {

	clear all
	use "synth_smoking", clear

	xtset state year

	synth	cigsale lnincome(1980(1)1988) age15to24(1980(1)1988) retprice(1980(1)1988) beer(1984(1)1988) cigsale(1988) cigsale(1980) cigsale(1975), ///
			trunit(`i') trperiod(1989) figure keep(synth`i'.dta) replace

	use "synth`i'", clear

	keep _Y_treated _Y_synthetic _time
	drop if (_time==.)

	rename _time year
	rename _Y_treated treated`i'
	rename _Y_synthetic synthetic`i'

	order year treated`i' synthetic`i'

	generate gap`i'=treated`i'-synthetic`i'

	save "synth`i'", replace

}

clear all
use "synth3", clear

local statelist 1 2 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39

foreach i of local statelist {
	merge 1:1 year using "synth`i'"
	drop _merge
	sort year
}

graph twoway	(line gap1 year , lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap2 year , lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap4 year , lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap5 year , lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap6 year , lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap7 year , lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap8 year , lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap9 year , lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap10 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap11 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap12 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap13 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap14 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap15 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap16 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap17 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap18 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap19 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap20 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap21 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap22 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap23 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap24 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap25 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap26 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap27 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap28 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap29 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap30 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap31 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap32 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap33 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap34 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap35 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap36 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap37 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap38 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap39 year, lp(solid) lw(vthin) lcolor(gs10)) ///
				(line gap3 year, lp(solid) lw(vthin) lcolor(black)), ///
				ytitle("gap in per-capita cigarette state (in packs)") xtitle("year") yline(0) xline(1989) legend(off)

save "placebo", replace


*##############################################################################*
								* EJERCICIO 3 *
*##############################################################################*


clear all
use "synth_smoking", clear

*Tabla 1*

summarize lnincome age15to24 retprice if (year>=1980 & year<=1988 & state!=3)
summarize beer if (year>=1984 & year<=1988 & state!=3)
summarize cigsale if (year==1988 & state!=3)
summarize cigsale if (year==1980 & state!=3)
summarize cigsale if (year==1975 & state!=3)

*Tabla 2*

*Obtenida en "Figura 2"


*##############################################################################*
								* EJERCICIO 4 *
*##############################################################################*


clear all
use "placebo", clear

matrix define   A = J(39,1,.)
matrix rownames A = "Alabama" "Arkansas" "California" "Colorado" "Connecticut" "Delaware" "Georgia" "Hawaii" "Idaho" "Illinois" ///
					"Indiana" "Iowa" "Kansas" "Kentucky" "Louisiana" "Maine" "Minnesota" "Mississippi" "Missouri" "Montana" ///
					"Nebraska" "Nevada" "New Hampshire" "New Mexico" "North Carolina" "North Dakota" "Ohio" "Oklahoma" "Pennsylvania" "Rhode Island" ///
					"South Carolina" "South Dakota" "Tennessee" "Texas" "Vermont" "Virginia" "West Virginia" "Wisconsin" "Wyoming"
matrix colnames A = "Ratio MSPE"
matrix list A

local statelist 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39

foreach i of local statelist {

	generate gap_aux=gap`i'^2
	summarize gap_aux

	egen mean_pre=mean(gap_aux) if (year>=1980 & year<=1988)
	summarize mean_pre
	egen aux_pre=max(mean_pre)
	summarize aux_pre

	egen mean_post=mean(gap_aux) if (year>=1989)
	summarize mean_post
	egen aux_post=max(mean_post)
	summarize aux_post

	generate ratio=aux_post/aux_pre
	summarize ratio
	local ratio=r(mean)

	matrix A [`i',1]=`ratio'

	drop gap_aux mean_pre mean_post aux_pre aux_post ratio

}

matrix list A

preserve
drop _all
svmat A
rename A1 ratio
histogram ratio, ytitle("frequency") xtitle("post/pre-Proposition 99 mean squared prediction error") bin(39) frequency
restore
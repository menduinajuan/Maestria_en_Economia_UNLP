use "$data/prepara_base/Bases_2009/Personas_2009", clear
egen id=concat(directorio secuencia_p)

local i=1
forvalues j=1103475(1)1103479 {
	replace directorio=2073161+`i' if (directorio==`j' & dpto==13)
	local i=`i'+1
}

replace directorio=2073167 if (directorio==1111986 & dpto==66)

local i=1
forvalues j=1122804(1)1122806 {
	replace directorio=2073167+`i' if (directorio==`j' & mes==5)
	local i=`i'+1
}

local i=1
foreach j of numlist 1122878 1122880 1122881 1122882 1122884 1122885 1122886 1122894 {
	replace directorio=2073170+`i' if (directorio==`j' & dpto==47)
	local i=`i'+1
}

local i=1
foreach j of numlist 1133526 1133527 1133528 1133529 1133530 1133531 1133532 1133539 1133540 1133541 {
	replace directorio=2073178+`i' if (directorio==`j' & dpto==50)
	local i=`i'+1
}

replace directorio=2073189 if (directorio==1138288 & dpto==68)
replace directorio=2073190 if (directorio==1139796 & dpto==76)
replace directorio=2073191 if (directorio==1149268 & dpto==52)
replace directorio=2073192 if (directorio==1162987 & dpto==73)
replace directorio=2073193 if (directorio==1164762 & dpto==76)
replace directorio=2073194 if (directorio==1164766 & dpto==76)

local i=1
foreach j of numlist 1167773 1167774 1167775 1167776 1167777 1167778 1167779 1167780 1167782 1167784 1167785 1167787 1167789 1167790 1167794 1167796 {
	replace directorio=2073194+`i' if (directorio==`j' & dpto==63)
	local i=`i'+1
}

local i=1
foreach j of numlist 1167798 1167799 1167800 1167801 1167802 1167803 1167806 1167807 1167808 1167809 {
	replace directorio=2073210+`i' if (directorio==`j' & dpto==66)
	local i=`i'+1
}

local i=1
foreach j of numlist 1168176 1168178 1168281 1168303 1168305 {
	replace directorio=2073220+`i' if (directorio==`j' & dpto==76)
	local i=`i'+1
}

replace directorio=2073226 if (directorio==1168745 & dpto==54)

local i=1
foreach j of numlist 1170880 1170920 1170940 {
	replace directorio=2073226+`i' if (directorio==`j' & dpto==19)
	local i=`i'+1
}

replace directorio=2073230 if (directorio==1170996 & dpto==73)

local i=1
foreach j of numlist 1171923 1171940 1171943 1171968 {
	replace directorio=2073230+`i' if (directorio==`j' & dpto==68)
	local i=`i'+1
}

rename fex_c_a fex_c

drop id

save "$data/prepara_base/Personas_2009", replace
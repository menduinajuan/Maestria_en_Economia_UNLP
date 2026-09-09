generate prii=1 if (nivel_ed==1 | nivel_ed==7)
generate pric=1 if (nivel_ed==2)
generate seci=1 if (nivel_ed==3)
generate secc=1 if (nivel_ed==4)
generate supi=1 if (nivel_ed==5)
generate supc=1 if (nivel_ed==6)

egen aux=rsum(prii pric seci secc supi supc)
replace prii=0 if (prii!=1 & aux==1)
replace pric=0 if (pric!=1 & aux==1)
replace seci=0 if (seci!=1 & aux==1)
replace secc=0 if (secc!=1 & aux==1)
replace supi=0 if (supi!=1 & aux==1)
replace supc=0 if (supc!=1 & aux==1)

drop if aux!=1
drop aux

generate edulevel=.
replace edulevel=1 if (prii==1)
replace edulevel=2 if (pric==1)
replace edulevel=3 if (seci==1)
replace edulevel=4 if (secc==1)
replace edulevel=5 if (supi==1)
replace edulevel=6 if (supc==1)

label define edulevel 1 "Primario Incompleto", add
label define edulevel 2 "Primario Completo", add
label define edulevel 3 "Secundario Incompleto", add
label define edulevel 4 "Secundario Completo", add
label define edulevel 5 "Superior Incompleto", add
label define edulevel 6 "Superior Completo", add
args nombre

generate sampsel=1 if (sampocup==1 & edad>=18)

clonevar prii_aux=prii
clonevar pric_aux=pric
clonevar seci_aux=seci
clonevar secc_aux=secc
clonevar supi_aux=supi
clonevar supc_aux=supc

replace secc=1 if ((prii==1 | pric==1 | seci==1) & sampsel==1)
replace prii=0 if (prii==1 & sampsel==1)
replace pric=0 if (pric==1 & sampsel==1)
replace seci=0 if (seci==1 & sampsel==1)

matrix score xlambda21_sim=lambda21
matrix score xlambda31_sim=lambda31
		
generate delta_u21_sim=xlambda21_sim+r21_cal
generate delta_u31_sim=xlambda31_sim+r31_cal

generate ocup_sim=.
replace ocup_sim=1 if (delta_u21_sim<=0	            & delta_u31_sim<=0)
replace ocup_sim=2 if (delta_u21_sim>0              & delta_u31_sim<=delta_u21_sim)
replace ocup_sim=3 if (delta_u21_sim<=delta_u31_sim	& delta_u31_sim>0)

drop xlambda?1_sim delta_u?1_sim

tabulate ocup ocup_sim if (sampocup==1)

drop prii pric seci secc supi supc

rename (prii_aux pric_aux seci_aux secc_aux supi_aux supc_aux) (prii pric seci secc supi supc)

tabulate ocup_sim, generate(ocupdum_sim)

rename (ocupdum?) (ocupdum?_aux)

rename (ocupdum_sim?) (ocupdum?)

do "genera-ing-laboral" "`nombre'"

replace ila_`nombre'=ila if (ocup_sim==ocup)

replace ila_`nombre'=. if (ocup_sim==1 & sampsel==1)

drop ocupdum?
rename (ocupdum?_aux) (ocupdum?)

do "genera-ing-familiar" "`nombre'"

rename ocup_sim occup_`nombre'

drop sampsel
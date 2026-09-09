args nombre

generate sampsel=1 if (edad>=18)

regress lila edad edad2 hombre pric seci secc supi supc [pw=pondih] if muestra==1 & (ocup==2 | ocup==3), robust

local cons=_b[_cons]
local edad=_b[edad]
local edad2=_b[edad2]
local hombre=_b[hombre]
local pric=_b[pric]
local seci=_b[seci]
local secc=_b[secc]
local supi=_b[supi]
local supc=_b[supc]

predict yhat, xb
predict residual, residuals

replace secc=1 if ((prii==1 | pric==1 | seci==1) & sampsel==1)
replace prii=0 if (prii==1 & sampsel==1)
replace pric=0 if (pric==1 & sampsel==1)
replace seci=0 if (seci==1 & sampsel==1)

generate lila_`nombre'=`cons'+`edad'*edad+`edad2'*edad2+`hombre'*hombre+`pric'*pric+`seci'*seci+`secc'*secc+`supi'*supi+`supc'*supc+residual
generate ila_`nombre'=exp(lila_`nombre') if (sampsel==1)
replace ila_`nombre'=ila if (sampsel!=1)

drop lila_`nombre'
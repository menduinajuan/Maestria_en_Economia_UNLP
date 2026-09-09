args nombre

summarize lp [w=fex_c]
local lp=r(mean)

generate aux=lp-ila
generate `nombre'=.
replace `nombre'=aux if (aux>0 & edad>60)

generate n_pobres=1 if (`nombre'>0 & `nombre'!=.)
summarize n_pobres [w=fex_c]

generate `nombre'_sum=sum(`nombre')
summarize `nombre'_sum
local `nombre'_sum=r(max)
display as text "Monto total de las transferencias = " as result ``nombre'_sum'
local n_ricos=``nombre'_sum'/`lp'
display	as text "Cantidad de observaciones de la muestra de individuos ricos a debitarle un monto igual a la Línea de Pobreza = $ `lp' = " as result `n_ricos'

gsort -ila

replace `nombre'=-`lp' if (ila>=5000000 & ila!=.)

generate n_ricos=1 if (`nombre'<0 & `nombre'!=.)
summarize n_ricos [w=fex_c]

egen ila_`nombre'=rowtotal(ila `nombre')

do "$dofiles/simulaciones/genera-ing-familiar" "`nombre'"
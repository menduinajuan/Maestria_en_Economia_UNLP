clear all
set more off

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/13. Economía Laboral/Trabajos Prácticos/Trabajo Práctico N° 4/Datos/Bases"
*do "prepara_panel"
use "arg-panel", clear


*Duplicados en términos de las varpanel*

local varpanel "idi_codusu idi_nro_hogar idi_componente idi_ano4 idi_trimestre"
duplicates report `varpanel'

*Identificador del Hogar*

egen idp_h=group(idi_codusu idi_nro_hogar)
label var idp_h "Identificador Hogar"

*Identificador del Individuo*

egen idp_i=group(idi_componente)
label variable idp_i "Identificador Individuo"

*Duplicados en términos de idp_t idp_h idp_i*

duplicates report idp_t idp_h idp_i 

*Identificador del primer período donde aparece cada familia*

bysort idp_h: egen idp_p=min(idp_t)
label variable idp_p "Número de Panel"

*Variables que identifican hogar e individuo deberían repetirse únicamente por panel*

duplicates tag idp_h idp_i, generate(aux)

generate nrep=aux+1
label variable nrep "Número de veces que aparece cada individuo"
drop aux

tabulate nrep, missing

*Dummy para individuos con más de una observación*

generate idp_match=.
replace idp_match=0 if (nrep==1)
replace idp_match=1 if (nrep>1)
label variable idp_match "= 1 si el individuo está en más de un período"

tabulate idp_match, missing

*Coherencia Panel*

generate cohp=.
replace cohp=0 if (idp_match==0)
replace cohp=1 if (idp_match==1)
label variable cohp "Coherencia Panel"

tabulate cohp, missing

*Cambios de sexo*

generate hombre=.
replace hombre=0 if (ch04==2)
replace hombre=1 if (ch04==1)

bysort nrep idp_h idp_i: generate aux=hombre-hombre[_n-1]

replace cohp=100 if (aux!=0 & aux!=. & cohp==1)
drop aux

*Generación de otras variables*

generate edad=ch06

generate ocupado=.
replace ocupado=0 if (estado==2)
replace ocupado=1 if (estado==1)

generate desocupado=.
replace desocupado=0 if (estado==1)
replace desocupado=1 if (estado==2)

*Nos quedamos sólo con individuos que están más de una vez*

generate no_coherente=.
replace no_coherente=0 if (cohp==1)
replace no_coherente=1 if (cohp!=1)

bysort idp_h idp_i: egen siempre_coherente=sum(no_coherente)

keep if siempre_coherente==0

*Nos quedamos sólo con paneles completos (sin hogares secundarios)*

generate hogarsec=0
replace hogarsec=1 if (idi_nro_hogar==51 | idi_nro_hogar==71)

keep if (nrep==4 & hogarsec==0)

*Nos quedamos sin las variables auxiliares*

drop cohp no_coherente siempre_coherente

*Ordenar*

order idi_codusu idi_nro_hogar idi_componente idp_h idp_i idp_t idp_p idi_ano4 idi_trimestre idp_match nrep pondera hogarsec edad hombre ocupado desocupado

*Guardar base*

save "panel-arg", replace
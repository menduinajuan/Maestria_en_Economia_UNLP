*##############################################################################*
* GENERACIÓN DE VARIABLES RELEVANTES *
*##############################################################################*


*Identificador del hogar*

sort codusu nro_hogar
egen id=group(codusu nro_hogar)

label variable id "Identificador del hogar"

*Regiones*

generate region2=region
replace region2=32 if (aglomerado==32)
replace region2=33 if (aglomerado==33)

label variable region2 "Región"
label define region2 32 "CABA" 33 "GBA" 40 "NOA" 41 "NEA" 42 "Cuyo" 43 "Pampeana" 44 "Patagónica"
label values region2 region2

*Género*

generate genero=ch04

label variable genero "Género"
label define genero 1 "Hombre" 2 "Mujer" 
label values genero genero

*Edad*

generate edad=ch06
replace edad=0 if (edad==-1)

label variable edad "Edad"

*Nivel educativo*

generate nivel_educ=nivel_ed
replace nivel_educ=1 if (nivel_ed==7)

label variable nivel_educ "Nivel educativo"
label define nivel_educ	1 "Primario Incompleto / Sin Instrucción" 2 "Primario Completo" 3 "Secundario Incompleto" ///
						4 "Secundario Completo" 5 "Superior Universitario Incompleto" 6 "Superior Universitario Completo"
label values nivel_educ nivel_educ

*Condiciones de actividad laboral*

generate ocupado=.
replace ocupado=0 if (estado!=1)
replace ocupado=1 if (estado==1)

generate desocupado=.
replace desocupado=0 if (estado!=2)
replace desocupado=1 if (estado==2)

generate activo=.
replace activo=0 if (ocupado==0 | desocupado==0)
replace activo=1 if (ocupado==1 | desocupado==1)

label variable ocupado "=1 si ocupado"
label define ocupado 0 "No ocupado" 1 "Ocupado"
label values ocupado ocupado

label variable desocupado "=1 si desocupado"
label define desocupado 0 "No descupado" 1 "Descupado"
label values desocupado desocupado

label variable activo "=1 si activo"
label define activo 0 "Inactivo" 1 "Activo"
label values activo activo

*Identificación de jefe/a y de cónyuge/pareja*

generate jefe=.
replace jefe=0 if (ch03!=1)
replace jefe=1 if (ch03==1)

generate conyuge=.
replace conyuge=0 if (ch03!=2)
replace conyuge=1 if (ch03==2)

label variable jefe "=1 si jefe de hogar"
label define jefe 0 "No jefe de hogar" 1 "Jefe de hogar"
label values jefe jefe

label variable conyuge "=1 si cónyuge"
label define conyuge 0 "No cónyuge" 1 "Cónyuge"
label values conyuge conyuge

*Identificación de hogares con niños*

generate aux=0
replace aux=1 if (edad<18 & (ch03==3 | ch03==5))
egen niños=max(aux), by(id)
drop aux

label variable niños "=1 si niños en el hogar"
label define niños 0 "Hogar sin niños" 1 "Hogar con niños"
label values niños niños

*Género jefe de hogar*

generate aux=.
replace aux=1 if (genero==1 & jefe==1)
replace aux=2 if (genero==2 & jefe==1)
egen genero_jefe=max(aux), by(id)
drop aux

label variable genero_jefe "Género jefe de hogar"
label define genero_jefe 1 "Jefe hombre" 2 "Jefe mujer"
label values genero_jefe genero_jefe

*Género cónyuge/pareja*

generate aux=.
replace aux=1 if (genero==1 & conyuge==1)
replace aux=2 if (genero==2 & conyuge==1)
egen genero_conyuge=max(aux), by(id)
drop aux

label variable genero_conyuge "Género cónyuge"
label define genero_conyuge 1 "Cónyuge hombre" 2 "Cónyuge mujer"
label values genero_conyuge genero_conyuge

*Género y niños en el hogar*

generate genero_niños=.
replace genero_niños=1 if (genero==1 & niños==0)
replace genero_niños=2 if (genero==1 & niños==1)
replace genero_niños=3 if (genero==2 & niños==0)
replace genero_niños=4 if (genero==2 & niños==1)

label variable genero_niños "Género y niños en el hogar"
label define genero_niños 1 "Hombre sin niños" 2 "Hombre con niños"  3 "Mujer sin niños" 4 "Mujer con niños"
label values genero_niños genero_niños

*Ingresos de la ocupación principal*

generate ing_ocupp=p21
generate horas_ocupp=pp3e_tot*4
generate ing_horario=p21/horas_ocupp if (ing_ocupp>0)

label variable ing_ocupp   "Ingreso de la ocupación principal"
label variable horas_ocupp "Horas trabajadas en la ocupación principal"
label variable ing_horario "Ingreso horario de la ocupación principal"

*Identificación de parejas heterosexuales*

keep if (edad>=25 & edad<=55)													// Se incluye sólo a individuos entre 25 y 55 años de edad (tal como pide el enunciado)

generate ph=0
replace ph=1 if (((genero_jefe==1 & genero_conyuge==2) | (genero_jefe==2 & genero_conyuge==1)) & (jefe==1 | conyuge==1))

generate aux=1 if (ph==1 & ing_ocupp==-9)
egen no_resp=max(aux), by(id)
replace no_resp=0 if (ph==0)

replace ph=0 if (no_resp==1)													// Se excluye parejas con "no respuesta" de ingreso de la ocupación principal (ing_ocupp==-9)

drop aux no_resp

*Ingreso relativo de la mujer en el ingreso de la pareja heterosexual*

egen ing_ph=sum(ing_ocupp) if (ph==1), by(id)
generate share=ing_ocupp/ing_ph if (ph==1 & genero==2)

*Percentiles / Deciles de ingreso*

quietly include "comando_cuantiles"

cuantiles ipcf [w=pondih] if (ipcf>=0), ncuantiles(100) orden_aux(id componente relacion edad) generate(pipcf)
cuantiles ipcf [w=pondih] if (ipcf>=0), ncuantiles(10)  orden_aux(id componente relacion edad) generate(dipcf)

label variable pipcf "Percentiles del ingreso per cápita familiar"
label variable dipcf "Deciles del ingreso per cápita familiar"

*Ordenamiento*

sort id componente
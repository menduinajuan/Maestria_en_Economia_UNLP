/*
- P21: "MONTO DE INGRESO DE LA OCUPACIÓN PRINCIPAL"

- PP3E_TOT: "Total de horas que trabajó en la semana en la ocupación principal"

- PP3F_TOT: "Total de horas que trabajó en la semana en otras Ocupaciones"

- PP04B_COD: ¿A qué se dedica o produce el negocio/empresa/institución?
(Ver Clasificador de Actividades Económicas para Encuestas Sociodemográficas del Mercosur – CAES - MERCOSUR)

- TOT_P12: "MONTO DE INGRESO DE OTRAS OCUPACIONES"
(Incluye: ocupación secundaria, ocupación previa a la semana de referencia, deudas/retroactivos por ocupaciones anteriores al mes de referencia, etc.)

- P47T: "MONTO DE INGRESO TOTAL INDIVIDUAL"

- T_Vi : "MONTO TOTAL DE INGRESOS NO LABORALES"

- ITF: "MONTO DEL INGRESO TOTAL FAMILIAR"

- IPCF: "MONTO DEL INGRESO PER CÁPITA FAMILIAR"
*/


clear all
set more off

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/8. Economía de la Distribución/Trabajos Prácticos/Trabajo Práctico N° 8/Datos"
use "usu_individual_t119", clear
*import excel "usu_individual_t119.xls", sheet("Sheet 1") firstrow case(lower)


*Limpieza*

destring deccfr, replace
drop if (deccfr>10)
drop if (nro_hogar==51 | nro_hogar==71)

*Números al azar (utilizado para clasificar)*

generate rnd=runiform()

*Ingresos*

clonevar ipcf_obs=ipcf
clonevar ii=p47t

*Identificador del hogar*

egen id=group(codusu nro_hogar)

*Miembros del hogar*

sort id rnd
by id: generate miembros=_N

*Edad*

clonevar edad=ch06
generate edad2=edad*edad

*Sexo*

generate hombre=.
replace hombre=0 if (ch04==2)
replace hombre=1 if (ch04==1)
generate gender=hombre+1

*Estado laboral*

generate ocupado=.
replace ocupado=0 if (estado==2)
replace ocupado=1 if (estado==1)

generate desocupado=.
replace desocupado=0 if (estado==1)
replace desocupado=1 if (estado==2)

*Ingreso laboral*

egen ila=rowtotal(p21 tot_p12)
replace ila=0 if (ila<0 & ocupado==1)
replace ila=. if (ocupado!=1)
generate lila=log(ila)

*Pertenencia a la muestra para Ecuación Mincer*

generate muestra=1 if (edad>=15 & edad<=64)

*Nivel educativo*

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

drop if (aux!=1)
drop aux

generate edulev=.
replace edulev=1 if (prii==1)
replace edulev=2 if (pric==1)
replace edulev=3 if (seci==1)
replace edulev=4 if (secc==1)
replace edulev=5 if (supi==1)
replace edulev=6 if (supc==1)

*Asistencia escolar*

generate asiste=.
replace asiste=0 if (asiste!=1 & !missing(ch10))
replace asiste=1 if (ch10==1)

*Clasificación CIIU*

generate aux1=strofreal(pp04b_cod)
generate aux2=strlen(aux1)
*aux2 contiene número de dígitos en pp04b_cod original

generate ciiu2d=strofreal(pp04b_cod,"%04.0f") if (aux2==3 | aux2==4)
replace ciiu2d=substr(ciiu2d,1,2) if (aux2==3 | aux2==4)
replace ciiu2d=strofreal(pp04b_cod,"%02.0f") if (aux2==1 | aux2==2)
*si 1 o 2 dígitos, se reporta código CIIU 2 dígitos
*si 3 o 4 dígitos, se reporta código CIIU 4 dígitos

generate ciiu2d_alt=real(ciiu2d)

*Categoría ocupacional*

generate ocup=.
replace ocup=1 if (ocupado!=1)
replace ocup=2 if (cat_ocup==3)
replace ocup=3 if (cat_ocup==1 | cat_ocup==2 | cat_ocup==4)

label define ocup 1 "not working" 2 "wage worker" 3 "self-employed"
label values ocup ocup

*Generación de variables ficticias a partir de "ocup"*

tabulate ocup, generate(ocupdum)

*Jefe de hogar*

generate jefe=.
replace jefe=0 if (ch03!=1 & ch03!=.)
replace jefe=1 if (ch03==1)

*Casado*

generate casado=.
replace casado=0 if (casado!=1 & ch07!=.)
replace casado=1 if (ch07==1 | ch07==2)

*Conteo categorías (Género y Ocupación)*

levelsof gender
local aux=r(levels)
global n_gender:word count `aux'
display "Categorías Género = " $n_gender

levelsof ocup
local aux=r(levels)
global n_ocup:word count `aux'
display "Categorías Ocupación = " $n_ocup
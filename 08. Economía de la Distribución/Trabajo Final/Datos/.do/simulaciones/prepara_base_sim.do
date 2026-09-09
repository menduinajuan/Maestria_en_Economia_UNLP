*Año*

keep if (year==2018)

*Números al azar (utilizados para clasificar)*

set seed 12345
generate rnd=runiform()

*Pertenencia a la muestra para Ecuación Mincer*

generate muestra=1 if (edad>=15 & edad<=64)

*Ingresos*

generate ipcug_obs=ipcug
bysort id: generate itug=ipcug*miembros_ug

*Género*

generate gender=hombre+1

*Ingreso laboral*

generate ila=ing_lab
replace ila=0 if (ila<0 & ocupado==1)
replace ila=. if (ocupado!=1)
generate lila=log(ila)

*Nivel educativo*

generate edulev=nivel_educ

*Categoría ocupacional*

generate ocup=.
replace ocup=1 if (ocupado!=1)
replace ocup=2 if (cat_ocup==1 | cat_ocup==2 | cat_ocup==3)
replace ocup=3 if (cat_ocup==4 | cat_ocup==5 | cat_ocup==6)

label variable ocup "Categoría ocupacional"
label define ocup 1 "No trabaja" 2 "Trabajador asalariado" 3 "Trabajador no asalariado"
label values ocup ocup

*Generación de variables ficticias a partir de "ocup"*

tabulate ocup, generate(ocupdum)

*Conteo de categorías (Género y Ocupación)*

levelsof gender
local aux=r(levels)
global n_gender:word count `aux'
display "Categorías Género = " $n_gender

levelsof ocup
local aux=r(levels)
global n_ocup:word count `aux'
display "Categorías Ocupación = " $n_ocup
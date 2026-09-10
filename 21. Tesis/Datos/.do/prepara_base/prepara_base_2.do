*##############################################################################*
* GENERACIÓN DE VARIABLES *
*##############################################################################*


foreach i of numlist 2002 2003 2004 2005 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 {

use "$data/prepara_base/Base_`i'", clear

*AÑO*

generate year=`i'

*REGIÓN*

if (year==2002 | year==2003 | year==2004 | year==2005) {
	replace dominio="BARRANQUILLA"		if (dominio=="BARRANQUILLA A.M.")
	replace dominio="BOGOTÁ"			if (dominio=="BOGOTA")
	replace dominio="BUCARAMANGA"		if (dominio=="BUCARAMANGA A.M.")
	replace dominio="CALI"				if (dominio=="CALI A.M.")
	replace dominio="CÚCUTA"			if (dominio=="CUCUTA A.M.")
	replace dominio="IBAGUÉ"			if (dominio=="IBAGUE")
	replace dominio="MANIZALES"			if (dominio=="MANIZALES A.M.")
	replace dominio="MEDELLÍN"			if (dominio=="MEDELLIN A.M.")
	replace dominio="PEREIRA"			if (dominio=="PEREIRA A.M.")
	replace dominio="RURAL"				if (dominio=="RESTO")
}

if (year==2008 | year==2009 | year==2010) {
	replace dominio="BARRANQUILLA"		if (dominio=="BARRANQUILLA A.M.")
	replace dominio="BOGOTÁ"			if (dominio=="BOGOTA")
	replace dominio="BUCARAMANGA"		if (dominio=="BUCARAMANGA A.M.")
	replace dominio="CALI"				if (dominio=="CALI A.M.")
	replace dominio="CÚCUTA"			if (dominio=="CUCUTA A.M.")
	replace dominio="IBAGUÉ"			if (dominio=="IBAGUE")
	replace dominio="MANIZALES"			if (dominio=="MANIZALES A.M.")
	replace dominio="MEDELLÍN"			if (dominio=="MEDELLIN A.M.")
	replace dominio="PEREIRA"			if (dominio=="PEREIRA A.M.")
	replace dominio="RURAL"				if (dominio=="RESTO")
	replace dominio="OTRAS CABECERAS"	if (dominio=="ARMENIA")
	replace dominio="OTRAS CABECERAS"	if (dominio=="FLORENCIA") 
	replace dominio="OTRAS CABECERAS"	if (dominio=="NEIVA")
	replace dominio="OTRAS CABECERAS"	if (dominio=="POPAYÁN")
	replace dominio="OTRAS CABECERAS"	if (dominio=="QUIBDÓ")
	replace dominio="OTRAS CABECERAS"	if (dominio=="RIOHACHA")
	replace dominio="OTRAS CABECERAS"	if (dominio=="SANTA MARTA")
	replace dominio="OTRAS CABECERAS"	if (dominio=="SINCELEJO")
	replace dominio="OTRAS CABECERAS"	if (dominio=="TUNJA")
	replace dominio="OTRAS CABECERAS"	if (dominio=="VALLEDUPAR")
}

if (year==2011 | year==2012 | year==2013 | year==2014 | year==2015 | year==2016 | year==2018) {
	replace dominio="BOGOTÁ"			if (dominio=="BOGOTA")
	replace dominio="CÚCUTA"			if (dominio=="CUCUTA")
	replace dominio="IBAGUÉ"			if (dominio=="IBAGUE")
	replace dominio="MEDELLÍN"			if (dominio=="MEDELLIN")
	replace dominio="MONTERÍA"			if (dominio=="MONTERIA")
	replace dominio="OTRAS CABECERAS"	if (dominio=="ARMENIA")
	replace dominio="OTRAS CABECERAS"	if (dominio=="FLORENCIA") 
	replace dominio="OTRAS CABECERAS"	if (dominio=="NEIVA")
	replace dominio="OTRAS CABECERAS"	if (dominio=="POPAYAN")
	replace dominio="OTRAS CABECERAS"	if (dominio=="QUIBDO")
	replace dominio="OTRAS CABECERAS"	if (dominio=="RIOHACHA")
	replace dominio="OTRAS CABECERAS"	if (dominio=="SANTA MARTA")
	replace dominio="OTRAS CABECERAS"	if (dominio=="SINCELEJO")
	replace dominio="OTRAS CABECERAS"	if (dominio=="TUNJA")
	replace dominio="OTRAS CABECERAS"	if (dominio=="VALLEDUPAR")
	replace dominio="OTRAS CABECERAS"	if (dominio=="RESTO URBANO")
}

if (year==2011) {
	replace dominio="OTRAS CABECERAS"	if (dominio=="RESTO URBANO")
}

if (year==2017) {
	replace dominio="BARRANQUILLA"		if (dominio=="Barranquilla")
	replace dominio="BOGOTÁ"			if (dominio=="Bogota")
	replace dominio="BUCARAMANGA"		if (dominio=="Bucaramanga")
	replace dominio="CALI"				if (dominio=="Cali")
	replace dominio="CARTAGENA"			if (dominio=="Cartagena")
	replace dominio="CÚCUTA"			if (dominio=="Cucuta")
	replace dominio="IBAGUÉ"			if (dominio=="Ibague")
	replace dominio="MANIZALES"			if (dominio=="Manizales")
	replace dominio="MEDELLÍN"			if (dominio=="Medellin")
	replace dominio="MONTERÍA"			if (dominio=="Monteria")
	replace dominio="PASTO"				if (dominio=="Pasto")
	replace dominio="PEREIRA"			if (dominio=="Pereira")
	replace dominio="VILLAVICENCIO"		if (dominio=="Villavicencio")
	replace dominio="OTRAS CABECERAS"	if (dominio=="Armenia")
	replace dominio="OTRAS CABECERAS"	if (dominio=="Florencia") 
	replace dominio="OTRAS CABECERAS"	if (dominio=="Neiva")
	replace dominio="OTRAS CABECERAS"	if (dominio=="Popayan")
	replace dominio="OTRAS CABECERAS"	if (dominio=="Quibdo")
	replace dominio="OTRAS CABECERAS"	if (dominio=="Riohacha")
	replace dominio="OTRAS CABECERAS"	if (dominio=="Santa Marta")
	replace dominio="OTRAS CABECERAS"	if (dominio=="Sincelejo")
	replace dominio="OTRAS CABECERAS"	if (dominio=="Tunja")
	replace dominio="OTRAS CABECERAS"	if (dominio=="Valledupar")
	replace dominio="OTRAS CABECERAS"	if (dominio=="Resto Urbano")
	replace dominio="RURAL"             if (dominio=="Rural")
}

*ÁREA METROPOLITANA*

generate ciudad=.
replace ciudad=1  if (dominio=="BARRANQUILLA")
replace ciudad=2  if (dominio=="BOGOTÁ")
replace ciudad=3  if (dominio=="BUCARAMANGA")
replace ciudad=4  if (dominio=="CALI")
replace ciudad=5  if (dominio=="CARTAGENA")
replace ciudad=6  if (dominio=="CÚCUTA")
replace ciudad=7  if (dominio=="IBAGUÉ")
replace ciudad=8  if (dominio=="MANIZALES")
replace ciudad=9  if (dominio=="MEDELLÍN")
replace ciudad=10 if (dominio=="MONTERÍA")
replace ciudad=11 if (dominio=="PASTO")
replace ciudad=12 if (dominio=="PEREIRA")
replace ciudad=13 if (dominio=="VILLAVICENCIO")

*AÑOS DE EDUCACIÓN*

if (year==2008 | year==2009 | year==2010 | year==2011 | year==2012 | year==2013 | year==2014 | year==2015 | year==2016 | year==2017 | year==2018) {

	generate p10=.

	*Primario o menos
	replace p10=100 if (p6210==1 & p6210s1==0)
	replace p10=200 if (p6210==2 & p6210s1==0)
	replace p10=201 if (p6210==2 & p6210s1==1)
	replace p10=300 if (p6210==3 & p6210s1==0)
	replace p10=301 if (p6210==3 & p6210s1==1)
	replace p10=302 if (p6210==3 & p6210s1==2)
	replace p10=303 if (p6210==3 & p6210s1==3)
	replace p10=304 if (p6210==3 & p6210s1==4)
	replace p10=305 if (p6210==3 & p6210s1==5)

	*Secundario
	replace p10=400 if (p6210==4 & p6210s1==0)
	replace p10=406 if (p6210==4 & p6210s1==6)
	replace p10=407 if (p6210==4 & p6210s1==7)
	replace p10=408 if (p6210==4 & p6210s1==8)
	replace p10=409 if (p6210==4 & p6210s1==9)
	replace p10=410 if (p6210==5 & p6210s1==10)
	replace p10=411 if (p6210==5 & p6210s1==11)
	replace p10=412 if (p6210==5 & p6210s1==12)
	replace p10=413 if (p6210==5 & p6210s1==13)

	*Superior o Universitario
	replace p10=500 if (p6210==6 & p6210s1==0)
	replace p10=501 if (p6210==6 & p6210s1==1)
	replace p10=502 if (p6210==6 & p6210s1==2)
	replace p10=503 if (p6210==6 & p6210s1==3)
	replace p10=504 if (p6210==6 & p6210s1==4)
	replace p10=505 if (p6210==6 & p6210s1==5)
	replace p10=506 if (p6210==6 & p6210s1==6)
	replace p10=507 if (p6210==6 & p6210s1==7)
	replace p10=508 if (p6210==6 & p6210s1==8)
	replace p10=509 if (p6210==6 & p6210s1==9)
	replace p10=510 if (p6210==6 & p6210s1==10)
	replace p10=511 if (p6210==6 & p6210s1==11)
	replace p10=512 if (p6210==6 & p6210s1==12)
	replace p10=513 if (p6210==6 & p6210s1==13)
	replace p10=514 if (p6210==6 & p6210s1==14)
	replace p10=515 if (p6210==6 & p6210s1==15)

	*No sabe, no informa
	replace p10=999 if (p6210==9 & p6210s1==99)

}

generate educ=.

*Primario o menos
replace educ=0  if (p10==100 | p10==200 | p10==201 | p10==300)
replace educ=1  if (p10==301)
replace educ=2  if (p10==302)
replace educ=3  if (p10==303)
replace educ=4  if (p10==304)
replace educ=5  if (p10==305)

*Secundario
replace educ=5  if (p10==400)
replace educ=6  if (p10==406)
replace educ=7  if (p10==407)
replace educ=8  if (p10==408)
replace educ=9  if (p10==409)
replace educ=10 if (p10==410 | p10==610)
replace educ=11 if (p10==411 | p10==611)
replace educ=12 if (p10==412 | p10==612)
replace educ=13 if (p10==413 | p10==613)

*Superior o Universitario
replace educ=12 if (p10==500)
replace educ=13 if (p10==501)
replace educ=14 if (p10==502)
replace educ=15 if (p10==503)
replace educ=16 if (p10==504)
replace educ=17 if (p10==505)
replace educ=18 if (p10==506)
replace educ=19 if (p10==507)
replace educ=20 if (p10==508)
replace educ=21 if (p10==509)
replace educ=22 if (p10==510)
replace educ=23 if (p10==511)
replace educ=24 if (p10==512)
replace educ=25 if (p10==513)
replace educ=26 if (p10==514)
replace educ=27 if (p10==515)

*AÑOS DE EDUCACIÓN PROMEDIO EN EL HOGAR*

egen educ_hog=mean(educ), by(id)

*NIVEL EDUCATIVO (DUMMIES)*

generate prii=1 if (educ<5)
generate pric=1 if (educ==5)
generate seci=1 if (educ>5 & educ<11)
generate secc=1 if (educ==11)
generate supi=1 if (educ>11 & educ<16)
generate supc=1 if (educ>=16)

replace prii=0 if (prii!=1)
replace pric=0 if (pric!=1)
replace seci=0 if (seci!=1)
replace secc=0 if (secc!=1)
replace supi=0 if (supi!=1)
replace supc=0 if (supc!=1)

*NIVEL EDUCATIVO*

generate nivel_educ=.
replace nivel_educ=1 if (prii==1)
replace nivel_educ=2 if (pric==1)
replace nivel_educ=3 if (seci==1)
replace nivel_educ=4 if (secc==1)
replace nivel_educ=5 if (supi==1)
replace nivel_educ=6 if (supc==1)

*GÉNERO*

if (year==2002 | year==2003 | year==2004 | year==2005) {
	generate hombre=.
	replace hombre=0 if (p4==2)
	replace hombre=1 if (p4==1)
	generate mujer=.
	replace mujer=0  if (p4==1)
	replace mujer=1  if (p4==2)
}

if (year==2008 | year==2009 | year==2010 | year==2011 | year==2012 | year==2013 | year==2014 | year==2015 | year==2016 | year==2017 | year==2018) {
	generate hombre=.
	replace hombre=0 if (p6020==2)
	replace hombre=1 if (p6020==1)
	generate mujer=.
	replace mujer=0  if (p6020==1)
	replace mujer=1  if (p6020==2)
}

*EDAD*

if (year==2002 | year==2003 | year==2004 | year==2005) {
	generate edad=p5
}

if (year==2008 | year==2009 | year==2010 | year==2011 | year==2012 | year==2013 | year==2014 | year==2015 | year==2016 | year==2017 | year==2018) {
	generate edad=p6040
}

*EDAD AL CUADRADO*

generate edad2=edad*edad

*GRUPO DE EDAD*

generate g_edad=.
replace g_edad=1 if (edad>=0 & edad<=25)
replace g_edad=2 if (edad>=26 & edad<=35)
replace g_edad=3 if (edad>=36 & edad<=45)
replace g_edad=4 if (edad>=46 & edad<=55)
replace g_edad=5 if (edad>=56 & edad<=64)
replace g_edad=6 if (edad>=65)

*RELACIÓN DE PARENTESCO*

if (year==2002 | year==2003 | year==2004 | year==2005) {
	generate relacion=p3
	replace relacion=4 if (p3==5)
	replace relacion=5 if (p3==4 | p3==6 | p3==7 | p3==8 | p3==9)
	replace relacion=6 if (p3==12 | p3==13)
	replace relacion=7 if (p3==14)
	replace relacion=8 if (p3==15)
	replace relacion=9 if (p3==10 | p3==11)
}

if (year==2008 | year==2009 | year==2010 | year==2011 | year==2012 | year==2013 | year==2014 | year==2015 | year==2016 | year==2017 | year==2018) {
	generate relacion=p6050
}

*ESTADO OCUPACIONAL (DUMMIES)*

generate ocupado=.
replace ocupado=0 if (oc==.)
replace ocupado=1 if (oc==1)

generate desocupado=.
replace desocupado=0 if (des==.)
replace desocupado=1 if (des==1)

generate inactivo=.
replace inactivo=0 if (ina==.)
replace inactivo=1 if (ina==1)

generate activo=.
replace activo=0 if (ocupado==0 | desocupado==0)
replace activo=1 if (ocupado==1 | desocupado==1)

*generate activo=.
*replace activo=0 if (inactivo==1 & pet==1)
*replace activo=1 if (inactivo==0 & pet==1)

*ESTADO OCUPACIONAL*

generate estado=.
replace estado=1 if (ocupado==1)
replace estado=2 if (desocupado==1)
replace estado=3 if (inactivo==1)

*CATEGORÍA OCUPACIONAL*

if (year==2002 | year==2003 | year==2004 | year==2005) {
	generate cat_ocup=p27
}

if (year==2008 | year==2009 | year==2010 | year==2011 | year==2012 | year==2013 | year==2014 | year==2015 | year==2016 | year==2017 | year==2018) {
	generate cat_ocup=p6430
	replace cat_ocup=6 if (p6430==7)
	replace cat_ocup=7 if (p6430==9)
}

*RELACIÓN LABORAL*

generate rel_lab=.
replace rel_lab=1 if (cat_ocup==5)
replace rel_lab=2 if (cat_ocup==1 | cat_ocup==2)
replace rel_lab=3 if (cat_ocup==4)
replace rel_lab=4 if (cat_ocup==6)
replace rel_lab=5 if (cat_ocup==3)
replace rel_lab=6 if (desocupado==1)

*DESCUENTO JUBILATORIO*

if (year==2008 | year==2009 | year==2010 | year==2011 | year==2012 | year==2013 | year==2014 | year==2015 | year==2016 | year==2017 | year==2018) {
	generate desc_jubi=.
	replace desc_jubi=0 if (p6920==2)
	replace desc_jubi=1 if (p6920==1)
}

*PERCENTILES / DECILES DEL IPCUG*

quietly include "$dofiles/comandos/comando_cuantiles"
generate fex_c_aux=round(fex_c)
cuantiles ingpcug [w=fex_c_aux] if (ingpcug>=0), ncuantiles(100) orden_aux(id orden relacion edad) generate(pipcug)
cuantiles ingpcug [w=fex_c_aux] if (ingpcug>=0), ncuantiles(10)  orden_aux(id orden relacion edad) generate(dipcug)
sort id orden dominio
drop fex_c_aux

*INFORMALIDAD LABORAL*

if (year==2008 | year==2009 | year==2010 | year==2011 | year==2012 | year==2013 | year==2014 | year==2015 | year==2016 | year==2017 | year==2018) {
	generate informal=.
	replace informal=0 if (ocupado==1)
	replace informal=1 if (ocupado==1 & ((rel_lab==2 & desc_jubi==0) | (rel_lab==3 & dipcug<=6)))
}

*JEFE*

generate jefe=.
replace jefe=0 if (relacion!=1)
replace jefe=1 if (relacion==1)

*JEFE - MUJER*

generate aux=.
replace aux=0 if (jefe==1 & mujer==0)
replace aux=1 if (jefe==1 & mujer==1)
egen jefe_mujer=max(aux), by(id)
drop aux

*JEFE - EDAD*

generate aux1=0
replace aux1=jefe*edad
generate aux2=0
replace aux2=1 if (aux1>0 & aux1<=30)
egen jefe_edad=max(aux2), by(id)
drop aux*

*JEFE - GRUPO DE EDAD*

generate aux=0
replace aux=jefe*g_edad
egen jefe_gedad=max(aux), by(id)
drop aux*

*JEFE - NIVEL EDUCATIVO*

generate aux=0
replace aux=jefe*nivel_educ
egen jefe_neduc=max(aux), by(id)
drop aux*

*JEFE - ESTADO OCUPACIONAL*

generate aux=0
replace aux=jefe*estado
egen jefe_estado=max(aux), by(id)
drop aux*

*JEFE - CATEGORÍA OCUPACIONAL*

generate aux=0
replace aux=jefe*cat_ocup
egen jefe_cocup=max(aux), by(id)
drop aux*

*JEFE - TRABAJADOR CUENTA PROPIA*

generate aux=.
replace aux=0 if (jefe==1 & cat_ocup!=4)
replace aux=1 if (jefe==1 & cat_ocup==4)
egen jefe_cp=max(aux), by(id)
drop aux

*MIEMBROS EN EL HOGAR*

generate aux=1
egen miembros_h=sum(aux), by(id)
drop aux

*MIEMBROS EN LA UNIDAD DE GASTO*

generate aux=1 if (relacion!=6 & relacion!=7 & relacion!=8)
egen miembros_ug=sum(aux), by(id)
drop aux

*MIEMBROS MUJERES EN EL HOGAR*

egen n_muj=total(mujer), by(id)
generate p_muj=n_muj/miembros_h

*MIEMBROS NIÑOS EN EL HOGAR*

generate niño=.
replace niño=0 if (edad>=12)
replace niño=1 if (edad<12)

egen n_niños=total(niño), by(id)
egen niños_hog=max(niño), by(id)

*POBLACIÓN EN EDAD DE TRABAJAR (PET)*

*generate pet=0
*replace pet=1 if ((dominio!="RURAL" & edad>=12) | (dominio=="RURAL" & edad>=10))
replace pet=0 if (pet==.)
egen n_pet=total(pet), by(id)

*ACTIVOS EN EL HOGAR*

egen n_ac=total(activo), by(id)
egen n_am=total(activo & mujer), by(id)
by id: generate t_plf=n_am/n_muj

*INACTIVOS EN EL HOGAR*

egen n_ina=total(inactivo), by(id)

*OCUPADOS EN EL HOGAR*

egen n_oc=total(ocupado), by(id)

*DESOCUPADOS EN EL HOGAR*

egen n_des=total(desocupado), by(id)
by id: generate t_des=n_des/n_ac

*INFORMALES EN EL HOGAR*

if (year==2008 | year==2009 | year==2010 | year==2011 | year==2012 | year==2013 | year==2014 | year==2015 | year==2016 | year==2017 | year==2018) {
	egen n_inf=total(informal), by(id)
	by id: generate t_inf=n_inf/n_oc
}

*HORAS TRABAJADAS SEMANALES*

if (year==2002 | year==2003 | year==2004 | year==2005) {
	egen horas=rowtotal(p34   p39)  , missing
}

if (year==2008 | year==2009 | year==2010 | year==2011 | year==2012 | year==2013 | year==2014 | year==2015 | year==2016 | year==2017 | year==2018) {
	egen horas=rowtotal(p6800 p7045), missing
}

*INGRESOS LABORALES*

egen ing_lab_1=rowtotal(impa impaes ie iees isa isaes), missing
egen ing_lab_2=rowtotal(imdi imdies)                  , missing
egen ing_lab  =rowtotal(ing_lab_1 ing_lab_2)          , missing
generate ing_lab_hor =ing_lab/(horas*4)
generate ling_lab_hor=log(ing_lab_hor)

*INGRESOS NO LABORALES*

if (year==2012 | year==2013 | year==2014 | year==2015 | year==2016 | year==2017 | year==2018) {
	egen iof3  =rowtotal(iof3h   iof3i)  , missing
	egen iof3es=rowtotal(iof3hes iof3ies), missing
}

egen ing_nolab_1  =rowtotal(iof1 iof1es iof6 iof6es), missing
egen ing_nolab_2  =rowtotal(iof2 iof2es iof3 iof3es), missing
egen ing_nolab    =rowtotal(ing_nolab_1 ing_nolab_2), missing
egen ing_nolab_hog=sum(ing_nolab), by(id)

*INGRESOS TOTALES*

egen ing_tot_ob=rowtotal(impa ie isa imdi iof1 iof2 iof3 iof6)                , missing
egen ing_tot_es=rowtotal(impaes iees isaes imdies iof1es iof2es iof3es iof6es), missing
egen ing_tot   =rowtotal(ing_lab ing_nolab)                                   , missing

*AYUDAS EN EL HOGAR*

if (year==2002 | year==2003 | year==2004 | year==2005) {
	generate aux=0
	replace aux=1 if (valor33a>0 | valor59a>0 | valor66a>0)
	egen ayudas_hog=max(aux), by(id)
	drop aux
}

if (year==2008 | year==2009 | year==2010 | year==2011 | year==2012 | year==2013 | year==2014 | year==2015 | year==2016 | year==2017 | year==2018) {
	generate aux=0
	replace aux=1 if (p7510s1a1>0 | p7510s2a1>0 | p7510s3a1>0)
	egen ayudas_hog=max(aux), by(id)
	drop aux
}

*INDIVIDUOS POBRES*

if (year==2002 | year==2003 | year==2004) {
	generate aux=.
	replace aux=0 if (pobre=="No Pobre")
	replace aux=1 if (pobre=="pobre")
	drop pobre
	rename aux pobre
}

*generate pobre=0
*replace pobre=1 if (ingpcug<lp)
egen n_pob=sum(pobre), by(id)

*INDIVIDUOS INDIGENTES*

if (year==2002 | year==2003 | year==2004) {
	generate aux=.
	replace aux=0 if (indigente=="No indigente")
	replace aux=1 if (indigente=="Indigente")
	drop indigente
	rename aux indigente
}

*generate indigente=0
*replace indigente=1 if (ingpcug<li)
egen n_indig=sum(indigente), by(id)

*GUARDAR BASE*

save "$data/prepara_base/Base_`i'_n", replace

}


*##############################################################################*
* UNIÓN DE BASES *
*##############################################################################*


use "$data/prepara_base/Base_2002_n", clear

foreach i of numlist 2005 2008 2015 2018 {
	append using "$data/prepara_base/Base_`i'_n", force
}

save "$data/prepara_base/Base_aux", replace


*##############################################################################*
* ETIQUETAR, ORDENAR, AGRUPAR Y MANTENER *
*##############################################################################*


use  "$data/prepara_base/Base_aux", clear
do   "$dofiles/prepara_base/prepara_base_3"
save "$data/Base", replace
*Identificador del hogar*

sort codusu nro_hogar
egen id=group(codusu nro_hogar)

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

*Género*

generate hombre=.
replace hombre=0 if (ch04==2)
replace hombre=1 if (ch04==1)

*Edad*

generate edad=ch06

generate edad_15_34=0
replace edad_15_34=1 if (edad>=15 & edad<=34)

generate edad_35_44=0
replace edad_35_44=1 if (edad>=35 & edad<=44)

generate edad_45_60=0
replace edad_45_60=1 if (edad>=45 & edad<=60)

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

*Cónyuge*

generate conyuge=.
replace conyuge=0 if (ch03!=2)
replace conyuge=1 if (ch03==2)

*Ausencia de cónyuge en el hogar*

generate aux=0
replace aux=1 if (conyuge==0)
egen no_conyuge=min(aux), by(id)
drop aux

*Presencia de cónyuge desocupado o inactivo en el hogar*

generate aux1=0
replace aux1=1 if (conyuge==1 & desocupado==1)
egen conyuge_desocupado=max(aux1), by(id)

generate aux2=0
replace aux2=1 if (conyuge==1 & activo==0)
egen conyuge_inactivo=max(aux2), by(id)

drop aux*

*Presencia de menores de 1 año en el hogar*

generate aux=0
replace aux=1 if (edad==-1)
egen menor_1=max(aux), by(id)
drop aux

*Presencia de menores de 1 a 2 años en el hogar*

generate aux=0
replace aux=1 if (edad==1 | edad==2)
egen de_1_a_2=max(aux), by(id)
drop aux

*Presencia de menores de 3 a 17 años en el hogar*

generate aux=0
replace aux=1 if (edad>=3 & edad<=17)
egen de_3_a_17=max(aux), by(id)
drop aux

*Número de hijos en el hogar*

generate aux=0
replace aux=1 if (ch03==3)
egen hijos=total(aux), by(id)
drop aux

*Presencia de adultos mayores en el hogar*

generate aux=0
replace aux=1 if (edad>55)
egen adultos=max(aux), by(id)
drop aux

keep if (edad>=15 & edad<=60)													// Se incluye sólo el conjunto de individuos entre 15 y 60 años de edad

*Ingreso total por transferencias del hogar*

drop if (v5_m==-9)
egen transf=sum(v5_m), by(id)

*Ingreso total familiar neto de transferencias*

generate itf_neto=itf-transf
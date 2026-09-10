*Identificador del hogar*

sort codusu nro_hogar
egen id=group(codusu nro_hogar)

*Ingreso horario de la ocupación principal (asalariados)*

generate ilaho=pp08d1/(pp3e_tot*4)
generate lilaho=log(ilaho)

*Condición de actividad laboral*

generate ocupado=.
replace ocupado=0 if (estado!=1)
replace ocupado=1 if (estado==1)

*Género*

generate hombre=.
replace hombre=0 if (ch04==2)
replace hombre=1 if (ch04==1)

generate mujer=.
replace mujer=0 if (ch04==1)
replace mujer=1 if (ch04==2)

*Edad*

generate edad=ch06
generate edad2=edad^2

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

*Jefe de hogar*

generate jefe=.
replace jefe=0 if (ch03!=1)
replace jefe=1 if (ch03==1)

*Informalidad*

generate informal=0
replace informal=1 if (pp07h==2 | pp07i==2)

*Rama de actividad*

generate agricultura=0
replace agricultura=1 if (pp04b_cod==1 | pp04b_cod==101 | pp04b_cod==102 | pp04b_cod==103 | pp04b_cod==104 | pp04b_cod==200 | pp04b_cod==300)

generate minas=0
replace minas=1 if (pp04b_cod==600 | pp04b_cod==700 | pp04b_cod==800 | pp04b_cod==900)

generate industria=0
replace industria=1 if ((pp04b_cod==10 | pp04b_cod==20 | pp04b_cod==26) | (pp04b_cod>=1001 & pp04b_cod<=3300))

generate construccion=0
replace construccion=1 if (pp04b_cod==4000)

generate comercio=0
replace comercio=1 if ((pp04b_cod==45 | pp04b_cod==48) | (pp04b_cod>=4501 & pp04b_cod<=4811))

generate transporte=0
replace transporte=1 if (pp04b_cod==49 | (pp04b_cod>=4901 & pp04b_cod<=5300))

generate financiero=0
replace financiero=1 if (pp04b_cod>=6400 & pp04b_cod<=6600)

generate otros_sectores=0
replace otros_sectores=1 if (agricultura==0 & minas==0 & industria==0 & construccion==0 & transporte==0 & financiero==0)

*Tamaño del establecimiento*

generate est_chico=0
replace est_chico=1 if (pp04c>=1 & pp04c<=5)									// De 1 a 5 personas

generate est_mediano=0
replace est_mediano=1 if (pp04c>=6 & pp04c<=8)									// De 6 a 40 personas

generate est_grande=0
replace est_grande=1 if (pp04c>=9 & pp04c<=11)									// De 41 a 500 personas

generate est_muygrande=0
replace est_muygrande=1 if (pp04c>=12)											// Más de 500 personas

*Regiones*

generate region2=region
replace region2=32 if (aglomerado==32)
replace region2=33 if (aglomerado==33)

generate caba=.
replace caba=0 if (region2!=32)
replace caba=1 if (region2==32)

generate gba=.
replace gba=0 if (region2!=33)
replace gba=1 if (region2==33)

generate noa=.
replace noa=0 if (region2!=40)
replace noa=1 if (region2==40)

generate nea=.
replace nea=0 if (region2!=41)
replace nea=1 if (region2==41)

generate cuyo=.
replace cuyo=0 if (region2!=42)
replace cuyo=1 if (region2==42)

generate pampeana=.
replace pampeana=0 if (region2!=43)
replace pampeana=1 if (region2==43)

generate patagonica=.
replace patagonica=0 if (region2!=44)
replace patagonica=1 if (region2==44)
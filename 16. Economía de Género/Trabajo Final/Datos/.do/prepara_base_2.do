*##############################################################################*
* GENERACIÓN DE VARIABLES *
*##############################################################################*


use "$data/Base", clear

*Identificador del hogar*

sort codusu nro_hogar
egen id=group(codusu nro_hogar)

label variable id "Identificador del hogar"

*Relación de parentesco*

generate relacion=.
replace relacion=1 if (ch03==1)
replace relacion=2 if (ch03==2)
replace relacion=3 if (ch03==3)
replace relacion=4 if (ch03==6 | ch03==7)
replace relacion=5 if (ch03==4 | ch03==5 | ch03==8 | ch03==9)
replace relacion=6 if (ch03==10 | (nro_hogar>=51 & nro_hogar<=71) | componente==51)

label variable relacion "Relación de parentesco"
label define relacion	1 "Jefe/a" 2 "Cónyuge / Pareja" 3 "Hijo/a / Hijastro/a" ///
						4 "Madre / Padre - Suegro/a" 5 "Yerno/Nuera - Nieto/a - Hermano/a - Otros Familiares" 6 "No Familiares - Servicio doméstico / Pensionistas"
label values relacion relacion

*Relación de parentesco estandarizada*

generate relacion_est=" 1 - Jefe/a                           " if (ch03==1)
replace relacion_est =" 2 - Cónyuge / Pareja                 " if (ch03==2)
replace relacion_est =" 3 - Hijo/a / Hijastro/a              " if (ch03==3)
replace relacion_est =" 4 - Yerno/Nuera                      " if (ch03==4)
replace relacion_est =" 5 - Nieto/a                          " if (ch03==5)
replace relacion_est =" 6 - Madre / Padre                    " if (ch03==6)
replace relacion_est =" 7 - Suegro/a                         " if (ch03==7)
replace relacion_est =" 8 - Hermano/a                        " if (ch03==8)
replace relacion_est =" 9 - Otros Familiares                 " if (ch03==9)
replace relacion_est ="10 - No Familiares                    " if (ch03==10)
replace relacion_est ="11 - Servicio doméstico / Pensionistas" if ((nro_hogar>=51 & nro_hogar<=71) | componente==51)

encode relacion_est, generate(aux)
drop relacion_est
rename aux relacion_est

label variable relacion_est "Relación de parentesco estandarizada"

*Miembros de hogares secundarios*

generate hogar_sec=0
replace hogar_sec=1 if (relacion_est==11)

label variable hogar_sec "=1 si miembro de un hogar secundario"
label define hogar_sec 0 "Miembro de un hogar principal" 1 "Miembro de un hogar secundario"
label values hogar_sec hogar_sec

*Número de miembros del hogar principal*

generate aux=1
egen miembros=sum(aux) if (hogar_sec==0 & relacion!=.), by(id)
drop aux

label variable miembros "Número de miembros del hogar principal"

*Edad*

generate edad=ch06
replace edad=0 if (edad==-1)
replace edad=. if (edad==99)

label variable edad "Edad"

*Grupos de edad*

generate g_edad_1=.
replace g_edad_1=1 if (edad>=0 & edad<=17)
replace g_edad_1=2 if (edad>=18 & edad<=64)
replace g_edad_1=3 if (edad>=65 & edad!=.)

generate g_edad_2=.
replace g_edad_2=1 if (edad>=0 & edad<=17)
replace g_edad_2=2 if (edad>=18 & edad<=40)
replace g_edad_2=3 if (edad>=41 & edad<=64)
replace g_edad_2=4 if (edad>=65 & edad!=.)

generate g_edad_3=.
replace g_edad_3=1 if (edad>=0 & edad<=17)
replace g_edad_3=2 if (edad>=18 & edad<=24)
replace g_edad_3=3 if (edad>=25 & edad<=40)
replace g_edad_3=4 if (edad>=41 & edad<=64)
replace g_edad_3=5 if (edad>=65 & edad!=.)

label variable g_edad_1 "Grupos de edad 1"
label define g_edad_1 1 "[0,17]" 2 "[18,64]" 3 "[65+]"
label values g_edad_1 g_edad_1

label variable g_edad_2 "Grupos de edad 2"
label define g_edad_2 1 "[0,17]" 2 "[18,40]" 3 "[41,64]" 4 "[65+]"
label values g_edad_2 g_edad_2

label variable g_edad_3 "Grupos de edad 3"
label define g_edad_3 1 "[0,17]" 2 "[18,24]" 3 "[25,40]"  4 "[41,64]" 5 "[65+]"
label values g_edad_3 g_edad_3

*Género*

generate hombre=.
replace hombre=0 if (ch04==2)
replace hombre=1 if (ch04==1)

generate genero=.
replace genero=1 if (hombre==1)
replace genero=2 if (hombre==0)

label variable hombre "=1 si hombre"
label define hombre 0 "Mujer" 1 "Hombre" 
label values hombre hombre

label variable genero "Género"
label define genero 1 "Hombre" 2 "Mujer" 
label values genero genero

*Jefe de hogar*

generate jefe=1 if (relacion==1)
replace jefe=0 if (relacion!=1)
replace jefe=. if (relacion==. | hogar_sec==1)

label variable jefe "=1 si jefe de hogar"
label define jefe 0 "No jefe de hogar" 1 "Jefe de hogar"
label values jefe jefe

*Género jefe de hogar*

generate aux=.
replace aux=1 if (genero==1 & jefe==1)
replace aux=2 if (genero==2 & jefe==1)
egen genero_jefe=max(aux), by(id)
drop aux

label variable genero_jefe "Género jefe de hogar"
label define genero_jefe 1 "Jefe hombre" 2 "Jefe mujer"
label values genero_jefe genero_jefe

*Niños en el hogar*

generate aux=0
replace aux=1 if (edad<18 & (ch03==3 | ch03==5))
egen niños=max(aux), by(id)
drop aux

label variable niños "=1 si niños en el hogar"
label define niños 0 "Hogar sin niños" 1 "Hogar con niños"
label values niños niños

*Género y niños en el hogar*

generate genero_niños=.
replace genero_niños=1 if (genero==1 & niños==0)
replace genero_niños=2 if (genero==1 & niños==1)
replace genero_niños=3 if (genero==2 & niños==0)
replace genero_niños=4 if (genero==2 & niños==1)

label variable genero_niños "Género y niños en el hogar"
label define genero_niños 1 "Hombre sin niños" 2 "Hombre con niños"  3 "Mujer sin niños" 4 "Mujer con niños"
label values genero_niños genero_niños

*Género jefe de hogar y niños en el hogar*

generate generojefe_niños=.
replace generojefe_niños=1 if (genero_jefe==1 & niños==0)
replace generojefe_niños=2 if (genero_jefe==1 & niños==1)
replace generojefe_niños=3 if (genero_jefe==2 & niños==0)
replace generojefe_niños=4 if (genero_jefe==2 & niños==1)

label variable generojefe_niños "Género jefe de hogar y niños en el hogar"
label define generojefe_niños 1 "Jefe hombre sin niños" 2 "Jefe hombre con niños"  3 "Jefe mujer sin niños" 4 "Jefe mujer con niños"
label values generojefe_niños generojefe_niños

*Estado civil*

generate casado=.
replace casado=0 if (ch07>=3 & ch07<=5)
replace casado=1 if (ch07==1 | ch07==2)

label variable casado "=1 si casado"
label define casado 0 "No casado" 1 "Casado"
label values casado casado

*Nivel educativo*

generate nivel_educ=nivel_ed
replace nivel_educ=1 if (nivel_ed==7)

label variable nivel_educ "Nivel educativo"
label define nivel_educ	1 "Primario Incompleto / Sin Instrucción" 2 "Primario Completo" 3 "Secundario Incompleto" ///
						4 "Secundario Completo" 5 "Superior Universitario Incompleto" 6 "Superior Universitario Completo"
label values nivel_educ nivel_educ

*Condiciones de actividad laboral*

generate ocupado=.
replace ocupado=0 if (estado==2 | estado==3 | estado==4)
replace ocupado=1 if (estado==1)

generate desocupado=.
replace desocupado=0 if (estado==1 | estado==3 | estado==4)
replace desocupado=1 if (estado==2)

generate inactivo=.
replace inactivo=0 if (estado==1 | estado==2 | estado==4)
replace inactivo=1 if (estado==3)

label variable ocupado "=1 si ocupado"
label define   ocupado 0 "No ocupado" 1 "Ocupado"
label values   ocupado ocupado

label variable desocupado "=1 si desocupado"
label define   desocupado 0 "No desocupado" 1 "Desocupado"
label values   desocupado desocupado

label variable inactivo "=1 si inactivo"
label define   inactivo 0 "No inactivo" 1 "Inactivo"
label values   inactivo inactivo

*Relación laboral*

generate rel_lab=.
replace rel_lab=1 if (cat_ocup==1)
replace rel_lab=2 if (cat_ocup==3)
replace rel_lab=3 if (cat_ocup==2)
replace rel_lab=4 if (cat_ocup==4)
replace rel_lab=5 if (desocupado==1)

label variable rel_lab "Relación laboral"
label define rel_lab 1 "Patrón" 2 "Obrero o empleado" 3 "Cuenta propia" 4 "Trabajador familiar sin remuneración" 5 "Desocupado"
label values rel_lab rel_lab

*Trabajadores domésticos*

generate trab_dom=.
replace trab_dom=0 if (pp04b1==2)
replace trab_dom=1 if (pp04b1==1)

label variable trab_dom "=si trabajador doméstico"
label define trab_dom 0 "No trabajador doméstico" 1 "Trabajador doméstico"
label values trab_dom trab_dom

*Descuento jubilatorio*

generate desc_jubi=.
replace desc_jubi=0 if (pp07h==2)
replace desc_jubi=1 if (pp07h==1)

label variable desc_jubi "=1 si descuento jubilatorio"
label define desc_jubi 0 "Sin descuento jubilatorio" 1 "Con descuento jubilatorio"
label values desc_jubi desc_jubi

*Cobertura médica*

generate cober_med=.
replace cober_med=0 if (ch08==4)
replace cober_med=1 if (ch08!=4)

label variable cober_med "=1 si cobertura médica"
label define cober_med 0 "Sin cobertura médica" 1 "Con cobertura médica"
label values cober_med cober_med

*Ingreso laboral*

egen ing_labor=rsum(pp06c pp06d pp08d1 pp08f1 pp08f2 pp08j1 pp08j2 pp08j3 tot_p12)

*Ingreso no laboral*

replace t_vi=0 if (t_vi<0)

egen ing_nolabor=rsum(t_vi)
egen ing_nolabor_aux=rsum(v2_m v3_m v4_m v5_m v8_m v9_m v10_m v11_m v12_m v18_m v19_am v21_m)

generate v22_m=ing_nolabor-ing_nolabor_aux
replace v22_m=0 if (v22_m<0)

*Ingreso total individual*

egen ing_tot=rsum(ing_labor ing_nolabor)
generate ing_labor_aux=p47t-ing_tot if (p47t>ing_tot)

egen ing_laboral=rsum(ing_labor ing_labor_aux)
egen ing_nolaboral=rsum(ing_nolabor_aux v22_m)
egen ing_total=rsum(ing_laboral ing_nolaboral)

drop ing_labor ing_labor_aux ing_nolabor ing_nolabor_aux v22_m ing_tot

label variable ing_laboral   "Ingreso laboral"
label variable ing_nolaboral "Ingreso no laboral"
label variable ing_total     "Ingreso total"

*Ingreso total familiar e Ingreso per cápita familiar*

rename itf itf_indec
rename ipcf ipcf_indec

egen itf=sum(ing_total), by(codusu nro_hogar trimestre)
generate ipcf=itf/miembros
generate lipcf=ln(ipcf)

label variable itf   "Ingreso total familiar"
label variable ipcf  "Ingreso per cápita familiar"
label variable lipcf "Logaritmo del ingreso per cápita familiar"

*Aguinaldo*

egen aguinaldo=rowtotal(pp08j1 v21_m)

label variable aguinaldo "Aguinaldo"

*Ingreso por jubilaciones y pensiones*

replace v21_m=v21_m/6
egen ing_jubi=rsum(v2_m v21_m)
replace ing_jubi=. if (ing_jubi==0)

label variable ing_jubi "Ingreso por jubilaciones y pensiones"

*Percentiles / Deciles de ingreso*

cuantiles ipcf [w=pondih] if (ipcf>=0), ncuantiles(100) orden_aux(id componente relacion edad) generate(pipcf)
cuantiles ipcf [w=pondih] if (ipcf>=0), ncuantiles(10)  orden_aux(id componente relacion edad) generate(dipcf)

label variable pipcf "Percentiles del ingreso per cápita familiar"
label variable dipcf "Deciles del ingreso per cápita familiar"

*Trabajadores Privados/Públicos*

generate privado=.
replace privado=0 if (pp04a==1 | pp04a==3 | pp04a==9)
replace privado=1 if (pp04a==2)

label variable privado "=1 si trabajador privado"
label define privado 0 "Trabajador público u otro" 1 "Trabajador privado"
label values privado privado

*Trabajadores Informales/Formales*

generate informal=.
replace informal=0 if (ocupado==1)
replace informal=1 if (ocupado==1 & ((rel_lab==2 & desc_jubi==0) | (rel_lab==3 & dipcf<=6)))

label variable informal "=1 si trabajador informal"
label define informal 0 "Trabajador formal" 1 "Trabajador informal"
label values informal informal

*CIIU (a dos dígitos)*

rename pp04b_cod rama
sort rama
tostring rama, replace

generate len=length(rama)
generate aux1=substr(rama,1,1) if (len==1 | len==3)
generate aux2=substr(rama,1,2) if (len==2 | len==4)
generate ciiu_2d=aux1+aux2

destring rama, replace
destring ciiu_2d, replace
drop aux* len

label variable ciiu_2d "Clasificación Internacional Industrial Uniforme (CIIU) a dos dígitos"

*Sectores INDEC*

generate sector_indec=.
replace sector_indec=1  if ((ciiu_2d>=1 & ciiu_2d<=3) | (ciiu_2d>=5 & ciiu_2d<=9))
replace sector_indec=2  if ((ciiu_2d>=10 & ciiu_2d<=33) | rama==9502)
replace sector_indec=3  if (ciiu_2d==40)
replace sector_indec=4  if ((ciiu_2d>=45 & ciiu_2d<=48) | rama==9503)
replace sector_indec=5  if (ciiu_2d>=55 & ciiu_2d<=56)
replace sector_indec=6  if ((ciiu_2d>=49 & ciiu_2d<=53) | (ciiu_2d>=58 & ciiu_2d<=63))
replace sector_indec=7  if (ciiu_2d==35 | ciiu_2d==36 | (ciiu_2d>=64 & ciiu_2d<=66) | ciiu_2d==68 | (ciiu_2d>=69 & ciiu_2d<=75) | (ciiu_2d>=77 & ciiu_2d<=82))
replace sector_indec=8  if (ciiu_2d==85)
replace sector_indec=9  if ((ciiu_2d>=37 & ciiu_2d<=39) | (ciiu_2d>=83 & ciiu_2d<=84) | (ciiu_2d>=86 & ciiu_2d<=88) | (ciiu_2d>=90 & ciiu_2d<=93))
replace sector_indec=10 if (ciiu_2d==97)
replace sector_indec=11 if (((ciiu_2d>=94 & ciiu_2d<=96) | ciiu_2d==98 | ciiu_2d==99) & (rama!=9502 & rama!=9503))
replace sector_indec=12 if (sector_indec==. & ciiu_2d!=.)

label variable sector_indec "Sectores INDEC"
label define sector_indec  1 "Actividades primarias", add
label define sector_indec  2 "Industria manufacturera", add
label define sector_indec  3 "Construcción", add
label define sector_indec  4 "Comercio", add
label define sector_indec  5 "Hoteles y restaurantes", add
label define sector_indec  6 "Transporte, almacenaje y comunicaciones", add
label define sector_indec  7 "Servicios financieros, inmobiliarios, alquileres y empresariales", add
label define sector_indec  8 "Enseñanza", add
label define sector_indec  9 "Servicios sociales y de salud", add
label define sector_indec 10 "Trabajo doméstico", add
label define sector_indec 11 "Otros servicios comunitarios, sociales y personales", add
label define sector_indec 12 "Sin especificar", add
label values sector_indec sector_indec


*##############################################################################*
* GUARDADO DE BASE *
*##############################################################################*


order id, first
sort id componente
save "$data/Base", replace
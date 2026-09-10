*##############################################################################*
* ETIQUETAS (280 variables) *
*##############################################################################*


*HOGARES 2002, 2003, 2004 y 2005 (26 variables -26 menos 0-)*


label variable 	llave_hog 		"Llave hogar"
label variable 	llave_viv 		"Llave vivienda"

label variable	clase 			"Clase"
label define 	clase			1 "Cabecera" 2 "Resto"
label values	clase			clase

label variable	dpto			"Departamento"
label define	dpto			5 "ANTIOQUIA" 8 "ATLÁNTICO" 11 "BOGOTÁ D.C." 13 "BOLÍVAR" 15 "BOYACÁ" 17 "CALDAS" 18 "CAQUETÁ" 19 "CAUCA" 20 "CESAR" 23 "CÓRDOBA" ///
								25 "CUNDINAMARCA" 27 "CHOCÓ" 41 "HUILA" 44 "LA GUAJIRA" 47 "MAGDALENA" 50 "META" 52 "NARIÑO" 54 "NORTE DE SANTANDER" 63 "QUINDÍO" ///
								66 "RISARALDA" 68 "SANTANDER" 70 "SUCRE" 73 "TOLIMA" 76 "VALLE DEL CAUCA"
label values	dpto			dpto

label variable	dominio			"Dominio: Cada una de las 13 A.M., Otras cabeceras y Rural"

label variable	mes				"Mes"
label define	mes				1 "Enero" 2 "Febrero" 3 "Marzo" 4 "Abril" 5 "Mayo" 6 "Junio" 7 "Julio" 8 "Agosto" 9 "Septiembre" 10 "Octubre" 11 "Noviembre" 12 "Diciembre"
label values	mes				mes

label variable	aiii8			"La vivienda ocupada por este hogar es:"
label variable	aiii9			"¿Cuánto pagan mensualmente por arriendo o por cuota de amortización?"
label variable	ncuartos		"Incluyendo sala-comedor, ¿de cuántos cuartos en total dispone este hogar?"
label variable	nper			"Número de personas del hogar"
label variable	npersug			"Número de personas de la unidad de gasto"
label variable	ingtotug		"Ingreso total de la unidad de gasto antes de imputación de arriendo a propietarios y usufructuarios"
label variable	ingtotuge		"Ingreso total empalmado de la unidad de gasto antes de imputación de arriendo a propietarios y usufructuarios"
label variable	tenviv			"La vivienda ocupada por este hogar es: (con imputación para 13 A.M., trimestres 1, 2 y 4)"
label variable	arrimp			"Valor de arriendo imputado"
label variable	cuota_i			"Valor de cuota de propietarios que están pagando la vivienda (con imputación)"
label variable	ingtotugearr	"Ingreso total empalmado de la unidad de gasto con imputación de arriendo a propietarios y usufructuarios"
label variable	ingpcuge		"Ingreso per cápita empalmado de la unidad de gasto con imputación de arriendo a propietarios y usufructuarios"
label variable	li				"Línea de indigencia"
label variable	lp				"Línea de pobreza"

label variable	pobre			"=1 si pobre"
label define	pobre			0 "No pobre" 1 "Pobre"
label values	pobre			pobre

label variable	indigente		"=1 si indigente"
label define	indigente		0 "No indigente" 1 "Indigente"
label values	indigente		indigente

label variable	npobres			"Número de individuos pobres en el hogar"
label variable	nindigentes		"Número de individuos indigentes en el hogar"
label variable	fex_dpto_c		"Factor de expansión departamental"
label variable	fex_c			"Factor de expansión anual"


*HOGARES 2008 (8 variables -26 menos 18-)*


label variable	directorio		"Llave vivienda"																							/*llave_viv*/
label variable	secuencia_p		"Llave hogar"																								/*llave_hog*/
label variable	p5000			"Incluyendo sala-comedor, ¿de cuántos cuartos en total dispone este hogar?"									/*ncuartos*/
label variable	p5010			"¿En cuántos de esos cuartos duermen las personas de este hogar?"

label variable	p5090			"La vivienda ocupada por este hogar es:"																	/*aiii8*/
label define	p5090			1 "Propia, totalmente pagada" 2 "Propia, la están pagando" 3 "En arriendo o subarriendo" 4 "En usufructo"	///
								5 "Posesión sin título (Ocupante)" 6 "Otra"
label values	p5090			p5090

label variable	p5100			"¿Cuánto pagan mensualmente por cuota de amortización?"														/*aiii9*/
label variable	p5130			"Si tuviera que pagar arriendo por esta vivienda, ¿cuánto estima que tendría que pagar mensualmente?"		/*arrimp*/
label variable	p5140			"¿Cuánto pagan mensualmente por arriendo?"																	/*aiii9*/


*HOGARES 2014, 2015 y 2018 (2 variables -25 menos 23-)*


label variable	ingtotugarr		"Ingreso total de la unidad de gasto con imputación de arriendo a propietarios y usufructuarios"
label variable	ingpcug			"Ingreso per cápita de la unidad de gasto con imputación de arriendo a propietarios y usufructuarios"


*PERSONAS 2002, 2003, 2004 y 2005 (76 variables -83 menos 7-)*


label variable	orden			"Identificación de la persona"

label variable	capital			"Capital"
label define	capital			0 "No" 1 "Sí"
label values	capital			capital

label variable	estrato1		"Estrato socioeconómico para las 13 A.M., y sextil de ICV para otras cabeceras y resto"
label define	estrato1		1 "Estrato 1" 2 "Estrato 2" 3 "Estrato 3" 4 "Estrato 4" 5 "Estrato 5" 6 "Estrato 6"
label values	estrato1		estrato1

label variable	p3				"¿Cuál es el parentesco con la persona jefe del hogar?"
label define	p3				1 "Jefe(a)" 2 "Esposo(a)" 3 "Hijo(a) o Hijastro(a)" 4 "Yerno o Nuera" 5 "Nieto(a)" 6 "Padre o Madre" 7 "Suegro(a)" ///
								8 "Hermano(a) o Cuñado(a)" 9 "Otro pariente" 10 "Húesped" 11 "Otro no pariente" 12 "Empleado(a) del servicio doméstico" ///
								13 "Hijo(a) del servicio doméstico" 14 "Pensionista" 15 "Trabajador(a)"
label values	p3				p3

label variable	p4				"Sexo"
label define	p4				1 "Hombre" 2 "Mujer"
label values	p4				p4

label variable	p5				"Edad"

label variable	p6				"Estado civil"
label define	p6				1 "En unión libre" 2 "Casado(a)" 3 "Viudo(a)" 4 "Separado(a) o Divorciado(a)" 5 "Soltero(a)"
label values	p6				p6

label variable	p10				"¿Cuál es el nivel educativo más alto alcanzado y el último año aprobado en ese nivel?"
label variable	p10u			"Último año aprobado"

label variable	p12				"¿En qué actividad ocupó la mayor parte del tiempo la semana pasada?"
label define	p12				1 "Trabajando" 2 "Buscando trabajo" 3 "Estudiando" 4 "Oficios del hogar" 5 "Otra actividad" 6 "Incapacitado permanente para trabajar"
label values	p12				p12

label variable	p24				"¿Qué hace en este trabajo?"

label variable	p27				"En este trabajo, es:"
label define	p27				1 "Obrero o empleado de empresa particular" 2 "Obrero o empleado del gobierno" 3 "Empleado doméstico" 4 "Trabajador por cuenta propia" ///
								5 "Patrón o Empleador" 6 "Trabajador familiar sin remuneración" 7 "Otro" 8 "Ninguno"
label values	p27				p27

label variable	valor28			"¿Cuánto ganó el mes pasado en este empleo? (incluya propinas y comisiones y excluya viáticos y pagos en especie)"

label variable	p29				"Además del salario en dinero, ¿el mes pasado recibió alimentos como parte de pago?"
label define	p29				1 "Sí" 2 "No" 9 "No sabe"
label values	p29				p29

label variable	valor29			"Valor mes $ alimentos"

label variable	p30				"Además del salario en dinero, ¿el mes pasado recibió vivienda como parte de pago?"
label define	p30				1 "Sí" 2 "No" 9 "No sabe"
label values	p30				p30

label variable	valor30			"Valor mes $ vivienda"

label variable	valor31			"¿Cuál fue la ganancia neta en esa actividad, negocio o profesión el mes pasado? Para el caso rural, corresponde a los últimos 12 meses"
label variable	valor32a		"¿Cuanto recibió el mes pasado por concepto de arriendo?"
label variable	valor32b		"¿Cuanto recibió el mes pasado por concepto de pensiones o jubilaciones?"
label variable	valor33a		"¿Cuánto recibió en total durante los últimos 12 meses por concepto de ayudas en dinero?"
label variable	valor33b		"¿Cuánto recibió en total durante los últimos 12 meses por concepto de intereses y dividendos?"
label variable	valor33c		"¿Cuánto recibió en total durante los últimos 12 meses por concepto de otras fuentes?"
label variable	p34				"¿Cuántas horas a la semana trabaja, normalmente, en ese trabajo?"

label variable	p37				"¿Además de la ocupación principal, ¿tenía la semana pasada otro trabajo o negocio?"
label define	p37				1 "Sí" 2 "No"
label values	p37				p37

label variable	valor38			"¿Cuánto recibió o ganó el mes pasado en ese segundo trabajo?"
label variable	p39				"¿Cuántas horas trabajó la semana pasada en ese segundo trabajo?"
label variable	p53				"¿Ha buscado trabajo por primera vez o había trabajado antes, por lo menos, durante dos semanas consecutivas?"

label variable	p57				"En este último trabajo, era: (Desocupados)"
label define	p57				1 "Obrero o empleado de empresa particular" 2 "Obrero o empleado del gobierno" 3 "Empleado doméstico" 4 "Trabajador por cuenta propia" ///
								5 "Patrón o Empleador" 6 "Trabajador familiar sin remuneración" 7 "Otro" 8 "Ninguno"
label values	p57				p57

label variable	valor58a		"¿Cuánto recibió el mes pasado por concepto de trabajo?"
label variable	valor58b		"¿Cuanto recibió el mes pasado por concepto de arriendo?"
label variable	valor58c		"¿Cuanto recibió el mes pasado por concepto de pensiones o jubilaciones?"
label variable	valor59a		"¿Cuánto recibió en total durante los últimos 12 meses por concepto de ayudas en dinero?"
label variable	valor59b		"¿Cuánto recibió en total durante los últimos 12 meses por concepto de intereses y dividendos?"
label variable	valor59c		"¿Cuánto recibió en total durante los últimos 12 meses por concepto de otras fuentes?"
label variable	valor65a		"¿Cuánto recibió el mes pasado por concepto de trabajo?"
label variable	valor65b		"¿Cuánto recibió el mes pasado por concepto de arriendo?"
label variable	valor65c		"¿Cuánto recibió el mes pasado por concepto de pensiones o jubilaciones?"
label variable	valor66a		"¿Cuánto recibió en total durante los últimos 12 meses por concepto de ayudas en dinero?"
label variable	valor66b		"¿Cuánto recibió en total durante los últimos 12 meses por concepto de intereses y dividendos?"
label variable	valor66c		"¿Cuánto recibió en total durante los últimos 12 meses por concepto de otras fuentes?"

label variable	p30a			"¿Normalmente, utiliza transporte de la empresa para desplazarse a su trabajo (bús, automóvil particular u oficial)?"
label define	p30a			1 "Sí" 2 "No" 9 "No sabe, no informa"
label values	p30a			p30a

label variable	valor30a		"Valor mes $ transporte"
label variable	p30b			"Además del salario en dinero, ¿el mes pasado recibió otros ingresos en especie por su trabajo (electrodomésticos, mercados diferentes alimentos o bonos de Sodexo)?"
label variable	valor30b		"Valor mes $ otros ingresos en especie"

label variable	pet				"=1 si en edad de trabajar"
label define	pet				0 "No edad de trabajar" 1 "En edad de trabajar"
label values	pet				pet

label variable	oc				"Ocupados"
label variable	des				"Desocupados"
label variable	ina				"Inactivos"
label variable	impa			"Ingreso monetario de la primera actividad antes de imputación"
rename			isa				imsa
label variable	imsa			"Ingreso monetario de la segunda actividad antes de imputación"
label variable	ie				"Ingreso en especie antes de imputación"
label variable	imdi			"Ingreso por trabajo de desocupados e inactivos antes de imputación"
label variable	iof1			"Ingreso por intereses y dividendos antes de imputación"
label variable	iof2			"Ingreso por jubilaciones y pensiones antes de imputación"
label variable	iof3			"Ingreso por ayudas antes de imputación"
label variable	iof6			"Ingreso por arriendos antes de imputación"
label variable	cclasnr2		"Estado de IMPA"
label variable	cclasnr3		"Estado de IMSA"
label variable	cclasnr4		"Estado de IE"
label variable	cclasnr5		"Estado de IMDI"
label variable	cclasnr6		"Estado de IOF1"
label variable	cclasnr7		"Estado de IOF2"
label variable	cclasnr8		"Estado de IOF3"
label variable	cclasnr11		"Estado de IOF6"
label variable	impaes			"Ingreso monetario de la primera actividad imputado (sólo para faltantes, extremos o ceros inconsistentes)"
rename			isaes			imsaes
label variable	imsaes			"Ingreso monetario de la segunda actividad imputado (sólo para faltantes o extremos)"
label variable	iees			"Ingreso en especie imputado (sólo para faltantes o extremos)"
label variable	imdies			"Ingreso por trabajo de desocupados e inactivos imputado (sólo para faltantes o extremos)"
label variable	iof1es			"Ingreso por intereses y dividendos imputado (sólo para faltantes o extremos)"
label variable	iof2es			"Ingreso por jubilaciones y pensiones imputado (sólo para faltantes o extremos)"
label variable	iof3es			"Ingreso por ayudas imputado (sólo para faltantes o extremos)"
label variable	iof6es			"Ingreso por arriendos imputado (sólo para faltantes o extremos)"
label variable	ingtotob		"Ingreso total observado"
label variable	ingtotes		"Ingreso total imputado"
label variable	ingtot			"Ingreso total"


*PERSONAS 2008 (94 variables -135 menos 41-)*


label variable	p6020			"Sexo"
label define	p6020			1 "Hombre" 2 "Mujer"
label values	p6020			p6020

label variable	p6040			"Edad"

label variable	p6050			"¿Cuál es el parentesco con la persona jefe del hogar?"
label define	p6050			1 "Jefe(a) del hogar" 2 "Pareja, Esposo(a), Cónyuge" 3 "Hijo(a), Hijastro(a)" 4 "Nieto(a)" 5 "Otro pariente" ///
								6 "Empleado(a) del servicio doméstico" 7 "Pensionista" 8 "Trabajador(a)" 9 "Otro no pariente"
label values	p6050			p6050

label variable	p6090			"¿Está afiliado, es cotizante o es beneficiario de alguna entidad de seguridad social en salud?"
label define	p6090			1 "Sí" 2 "No" 9 "No sabe, no informa"
label values	p6090			p6090

label variable	p6100			"¿A cuál de los siguientes regímenes de seguridad social en salud está afiliado?"
label define	p6100			1 "Contributivo (EPS)" 2 "Especial (Fuerzas Armadas, Ecopetrol, universidades públicas)" 3 "Subsidiado (EPS-S)" 9 "No sabe, no informa"
label values	p6100			p6100

label variable	p6210			"¿Cuál es el nivel educativo más alto alcanzado y el último año o grado aprobado en este nivel?"
label define	p6210			1 "Ninguno" 2 "Preescolar" 3 "Básica primaria (1°-5°)" 4 "Básica secundaria (6°-9°)" 5 "Media (10°-13 °)" 6 "Superior o Universitaria" ///
								9 "No sabe, no informa"
label values	p6210			p6210

label variable	p6210s1			"Grado escolar aprobado"

label variable	p6240			"¿En que actividad ocupó la mayor parte del tiempo la semana pasada?"
label define	p6240			1 "Trabajando" 2 "Buscando trabajo" 3 "Estudiando" 4 "Oficios del hogar" 5 "Incapacitado permanente para trabajar" 6 "Otra actividad"
label values    p6240			p6240

label variable	oficio			"¿Qué hace en este trabajo?"

label variable	p6426			"¿Cuánto tiempo lleva trabajando en esta empresa, negocio, industria, oficina, firma o finca de manera continua?"

label variable	p6430			"En este trabajo, es: (Posición ocupacional primera actividad)"
label define	p6430			1 "Obrero o empleado de empresa particular" 2 "Obrero o empleado del gobierno" 3 "Empleado doméstico" 4 "Trabajador por cuenta propia" ///
								5 "Patrón o Empleador" 6 "Trabajador familiar sin remuneración" 7 "Trabajador sin remuneración en empresas o negocios de otros hogares" ///
								8 "Jornalero o Peón" 9 "Otro"
label values	p6430			p6430

label variable	p6500			"Antes de descuentos, ¿cuánto ganó el mes pasado en este empleo? (incluya propinas y comisiones y excluya viáticos y pagos en especie)"

label variable	p6510			"¿El mes pasado recibió ingresos por concepto de horas extras?"
label define	p6510			1 "Sí" 2 "No" 9 "No sabe, no informa"
label values	p6510			p6510

label variable	p6510s1			"¿Cuánto recibió por horas extras?"

label variable	p6510s2			"¿Incluyó este valor en los ingresos del mes pasado? Horas extras"
label define	p6510s2			1 "Sí" 2 "No"
label values	p6510s2			p6510s2

label variable	p6545			"¿El mes pasado recibió a. primas (Técnica, de antigüedad, de clima, de orden público, otras, etc.)?"
label define	p6545			1 "Sí" 2 "No" 9 "No sabe, no informa"
label values	p6545			p6545

label variable	p6545s1			"¿Cuánto recibió por primas?"

label variable	p6545s2			"¿Incluyó este valor en los ingresos del mes pasado que me declaró anteriormente? Primas"
label define	p6545s2			1 "Sí" 2 "No"
label values	p6545s2			p6545s2

label variable	p6580			"¿El mes pasado recibió b. bonificaciones?"
label define	p6580			1 "Sí" 2 "No" 9 "No sabe, no informa"
label values	p6580			p6580

label variable	p6580s1			"¿Cuánto recibió por bonificaciones?"

label variable	p6580s2			"¿Incluyó este valor en los ingresos del mes pasado que me declaró anteriormente? Bonificaciones"
label define	p6580s2			1 "Sí" 2 "No"
label values	p6580s2			p6545s2

label variable	p6585s1			"¿El mes pasado recibió a. auxilio o subsidio de alimentación?"
label define	p6585s1			1 "Sí" 2 "No" 9 "No sabe, no informa"
label values	p6585s1			p6585s1

label variable	p6585s1a1		"¿Cuánto recibió por auxilio o subsidio de alimentación?"

label variable	p6585s1a2		"¿Incluyó este valor en los ingresos del mes pasado que me declaró anteriormente? Auxilio o subsidio de alimentación"
label define	p6585s1a2		1 "Sí" 2 "No"
label values	p6585s1a2		p6585s1a2

label variable	p6585s2			"¿El mes pasado recibió b. auxilio o subsidio de transporte?"
label define	p6585s2			1 "Sí" 2 "No" 9 "No sabe, no informa"
label values	p6585s2			p6585s2

label variable	p6585s2a1		"¿Cuánto recibió por auxilio o subsidio de transporte?"

label variable	p6585s2a2		"¿Incluyó este valor en los ingresos del mes pasado que me declaró anteriormente? Auxilio o subsidio de transporte"
label define	p6585s2a2		1 "Sí" 2 "No"
label values	p6585s2a2		p6585s2a2

label variable	p6585s3			"¿El mes pasado recibió c. subsidio familiar?"
label define	p6585s3			1 "Sí" 2 "No" 9 "No sabe, no informa"
label values	p6585s3			p6585s3

label variable	p6585s3a1		"¿Cuánto recibió por subsidio familiar?"

label variable	p6585s3a2		"¿Incluyó este valor en los ingresos del mes pasado que me declaró anteriormente? Subsidio familiar"
label define	p6585s3a2		1 "Sí" 2 "No"
label values	p6585s3a2		p6585s3a2

label variable	p6585s4			"¿El mes pasado recibió d. subsidio educativo?"
label define	p6585s4			1 "Sí" 2 "No" 9 "No sabe, no informa"
label values	p6585s4			p6585s4

label variable	p6585s4a1		"¿Cuánto recibió por subsidio educativo?"

label variable	p6585s4a2		"¿Incluyó este valor en los ingresos del mes pasado que me declaró anteriormente? Subsidio educativo"
label define	p6585s4a2		1 "Sí" 2 "No"
label values	p6585s4a2		p6585s4a2

label variable	p6590			"Además del salario en dinero, ¿el mes pasado recibió alimentos como parte de pago por su trabajo?"
label define	p6590			1 "Sí" 2 "No" 9 "No sabe, no informa"
label values	p6590			p6590

label variable	p6590s1			"¿En cuánto estima lo que recibió? Alimentos"

label variable	p6600			"Además del salario en dinero, ¿el mes pasado recibió vivienda como parte de pago por su trabajo?"
label define	p6600			1 "Sí" 2 "No" 9 "No sabe, no informa"
label values	p6600			p6600

label variable	p6600s1			"¿En cuánto estima lo que recibió? Vivienda"

label variable	p6610			"¿Normalmente, utiliza transporte de la empresa para desplazarse a su trabajo (bús o automóvil)?"
label define	p6610			1 "Sí" 2 "No" 9 "No sabe, no informa"
label values	p6610			p6610

label variable	p6610s1			"¿En cuánto estima lo que recibió? Transporte"

label variable	p6620			"Además del salario en dinero, ¿el mes pasado recibió otros ingresos en especie por su trabajo (electrodomésticos, ropa, productos diferentes a alimentos o bonos tipo Sodexo)?"
label define	p6620			1 "Sí" 2 "No" 9 "No sabe, no informa"
label values	p6620			p6620

label variable	p6620s1			"¿En cuánto estima lo que recibió? Otros ingresos en especie"

label variable	p6630s1			"¿En los últimos 12 meses recibió a. prima de servicios?"
label define	p6630s1			1 "Sí" 2 "No"
label values	p6630s1			p6630s1

label variable	p6630s1a1		"¿Cuánto recibió? Prima de servicios"

label variable	p6630s2			"¿En los últimos 12 meses recibió b. prima de navidad?"
label define	p6630s2			1 "Sí" 2 "No"
label values	p6630s2			p6630s2

label variable	p6630s2a1		"¿Cuánto recibió? Prima de navidad"

label variable	p6630s3			"¿En los últimos 12 meses recibió c. prima de vacaciones?"
label define	p6630s3			1 "Sí" 2 "No"
label values	p6630s3			p6630s3

label variable	p6630s3a1		"¿Cuánto recibió? Prima de vacaciones"

label variable	p6630s4			"¿En los últimos 12 meses recibió d. viáticos permanentes y/o bonificaciones anuales?"
label define	p6630s4			1 "Sí" 2 "No"
label values	p6630s4			p6630s4

label variable	p6630s4a1		"¿Cuánto recibió? Viáticos permanentes y/o bonificaciones anuales"

label variable	p6630s6			"¿En los últimos 12 meses recibió e. pagos por accidentes de trabajo?"
label define	p6630s6			1 "Sí" 2 "No"
label values	p6630s6			p6630s6

label variable	p6630s6a1		"¿Cuánto recibió? Pagos por accidentes de trabajo"

label variable	p6750			"Ganancia neta del mes pasado"
label variable	p6760			"¿A cuántos meses corresponde lo que recibió?"
label variable	p550			"¿Cuál fue la ganancia neta del negocio o de la cosecha durante los últimos 12 meses?"
label variable	p6800			"¿Cuántas horas a la semana trabaja, normalmente, en ese trabajo?"

label variable	p6870			"¿Cuántas personas en total tiene la empresa, negocio, industria, oficina, firma, finca o sitio donde trabaja?"
label define	p6870			1 "Trabaja solo" 2 "2 a 3 personas" 3 "4 a 5 personas" 4 "6 a 10 personas" 5 "11 a 19 personas" 6 "20 a 30 personas" ///
								7 "31 a 50 personas" 8 "51 a 100 personas" 9 "101 o más personas"
label values	p6870			p6870

label variable	p6920			"¿Está cotizando, actualmente, a un fondo de pensiones?"
label define	p6920			1 "Sí" 2 "No" 3 "Ya es pensionado"
label values	p6920			p6920

label variable	p7040			"Además de la ocupación principal, ¿tenía la semana pasada otro trabajo o negocio?"
label define	p7040			1 "Sí" 2 "No"
label values	p7040			p7040

label variable	p7045			"¿Cuántas horas trabajó la semana pasada en ese segundo trabajo?"

label variable	p7050			"En este trabajo, es: (Posición ocupacional segunda actividad)"
label define	p7050			1 "Obrero o empleado de empresa particular" 2 "Obrero o empleado del gobierno" 3 "Empleado doméstico" 4 "Trabajador por cuenta propia" ///
								5 "Patrón o Empleador" 6 "Trabajador familiar sin remuneración" 7 "Trabajador sin remuneración en empresas o negocios de otros hogares" ///
								8 "Jornalero o Peón" 9 "Otro"
label values	p7050			p7050

label variable	p7070			"¿Cuánto recibió o ganó el mes pasado en ese segundo trabajo o negocio?"

label variable	p7090			"Además de las horas que trabaja actualmente, ¿quiere trabajar más horas?"
label define	p7090			1 "Sí" 2 "No"
label values	p7090			p7090

label variable	p7110			"Durante las últimas 4 semanas, ¿hizo diligencias para trabajar más horas?"
label define	p7110			1 "Sí" 2 "No"
label values	p7110			p7110

label variable	p7120			"Si la semana pasada le hubiera resultado la posibilidad de trabajar más horas, ¿estaba disponible para hacerlo?"
label define	p7120			1 "Sí" 2 "No"
label values	p7120			p7120

label variable	p7140s1			"¿Por qué motivos desea cambiar de trabajo o empleo: a. Para mejorar la utilización de sus capacidades o formación?"
label define	p7140s1			1 "Sí" 2 "No"
label values	p7140s1			p7140s1

label variable	p7140s2			"¿Por qué motivos desea cambiar de trabajo o empleo: b. Desea mejorar sus ingresos?"
label define	p7140s2			1 "Sí" 2 "No"
label values	p7140s2			p7140s2

label variable	p7150			"Durante las últimas 4 semanas, ¿hizo diligencias para cambiar de trabajo?"
label define	p7150			1 "Sí" 2 "No"
label values	p7150			p7150

label variable	p7160			"Si le resultara un nuevo trabajo o empleo, ¿podría empezar a desempeñarlo antes de un mes?"
label define	p7160			1 "Sí" 2 "No" 9 "No sabe, no informa"
label values	p7160			p7160

label variable	p7310			"¿Ha buscado trabajo por primera vez o había trabajado antes, por lo menos, durante dos semanas consecutivas?"
label define	p7310			1 "Primera vez" 2 "Trabajó antes"
label values	p7310			p7310

label variable	p7350			"En este último trabajo, era: (Desocupados)"
label define	p7350			1 "Obrero o empleado de empresa particular" 2 "Obrero o empleado del gobierno" 3 "Empleado doméstico" 4 "Trabajador por cuenta propia" ///
								5 "Patrón o Empleador" 6 "Trabajador familiar sin remuneración" 7 "Trabajador sin remuneración en empresas o negocios de otros hogares" ///
								8 "Jornalero o Peón" 9 "Otro"
label values	p7350			p7350

label variable	p7422			"¿Recibió o ganó el mes pasado ingresos por concepto de trabajo? (Desocupados)"
label define	p7422			1 "Sí" 2 "No"
label values	p7422			p7422

label variable	p7422s1			"¿Cuánto ganó el mes pasado en ingresos por concepto de trabajo? (Desocupados)"

label variable	p7472			"¿Recibió o ganó el mes pasado ingresos por concepto de trabajo? (Inactivos)"
label define	p7472			1 "Sí" 2 "No"
label values	p7472			p7472

label variable	p7472s1			"¿Cuánto ganó el mes pasado en ingresos por concepto de trabajo? (Inactivos)"

label variable	p7495			"¿El mes pasado recibió pagos por concepto de arriendos y/o pensiones?"
label define	p7495			1 "Sí" 2 "No"
label values	p7495			p7495

label variable	p7500s1			"¿El mes pasado recibió pagos por: a. arriendos de casas, apartamentos, fincas, lotes, vehículos, equipos, etc.?"
label define	p7500s1			1 "Sí" 2 "No" 9 "No sabe, no informa"
label values	p7500s1			p7500s1

label variable	p7500s1a1		"Valor mes pasado Arriendos de casas"

label variable	p7500s2			"¿El mes pasado recibió pagos por: b. pensiones o jubilaciones por vejez, invalidez o sustitución pensional?"
label define	p7500s2			1 "Sí" 2 "No" 9 "No sabe, no informa"
label values	p7500s2			p7500s2

label variable	p7500s2a1		"Valor mes pasado Pensiones o jubilaciones por vejez"

label variable	p7500s3			"¿El mes pasado recibió pagos por: c. pensión alimenticia por paternidad, divorcio o separación?"
label define	p7500s3			1 "Sí" 2 "No" 9 "No sabe, no informa"
label values	p7500s3			p7500s3

label variable	p7500s3a1		"Valor mes pasado Pensión alimenticia por paternidad"

label variable	p7505			"Durante los últimos 12 meses, ¿recibió dinero de otros hogares, personas o instituciones no gubernamentales; dinero por intereses, dividendos, utilidades o por cesantias?"
label define	p7505			1 "Sí" 2 "No" 
label values	p7505			p7505

label variable	p7510s1			"Durante los últimos 12 meses, ¿recibió a. dinero de otros hogares o personas residentes en el país?"
label define	p7510s1			1 "Sí" 2 "No" 9 "No sabe, no informa"
label values	p7510s1			p7520s1

label variable	p7510s1a1		"Valor $ Dinero de otros hogares o personas residentes en el país"

label variable	p7510s2			"Durante los últimos 12 meses, ¿recibió b. dinero de otros hogares o personas residentes fuera del país?"
label define	p7510s2			1 "Sí" 2 "No" 9 "No sabe, no informa"
label values	p7510s2			p7520s2

label variable	p7510s2a1		"Valor $ Dinero de otros hogares o personas residentes fuera del país"

label variable	p7510s3			"Durante los últimos 12 meses, ¿recibió c. ayudas en dinero de instituciones del país o fuera del país?"
label define	p7510s3			1 "Sí" 2 "No" 9 "No sabe, no informa"
label values	p7510s3			p7520s3

label variable	p7510s3a1		"Valor $ Ayudas en dinero de instituciones del país o fuera del país"

label variable	p7510s5			"Durante los últimos 12 meses, ¿recibió d. dinero por intereses de préstamos o CDT´s, depósitos de ahorros, utilidades, ganancias o dividendos por inversiones?"
label define	p7510s5			1 "Sí" 2 "No" 9 "No sabe, no informa"
label values	p7510s5			p7520s5

label variable	p7510s5a1		"Valor $ Dinero por intereses de préstamos"

label variable	p7510s6			"Durante los últimos 12 meses, ¿recibió e. dinero por concepto de cesantías y/o intereses a las cesantías?"
label define	p7510s6			1 "Sí" 2 "No" 9 "No sabe, no informa"
label values	p7510s6			p7520s6

label variable	p7510s6a1		"Valor $ Dinero por concepto de cesantías y/o intereses a las cesantías"

label variable	p7510s7			"Durante los últimos 12 meses, ¿recibió f. dinero de otras fuentes diferentes a las anteriores?"
label define	p7510s7			1 "Sí" 2 "No" 9 "No sabe, no informa"
label values	p7510s7			p7520s7

label variable	p7510s7a1		"Valor $ Dinero de otras fuentes diferentes a las anteriores"


*PERSONAS 2014, 2015 y 2018 (4 variables -137 menos 133-)*


label variable	iof3h			"Ingreso por ayudas de hogares antes de imputación"
label variable	iof3i			"Ingreso por ayudas de instituciones antes de imputación"
label variable	iof3hes			"Ingreso por ayudas de hogares imputado (sólo para faltantes o extremos)"
label variable	iof3ies			"Ingreso por ayudas de instituciones imputado (sólo para faltantes o extremos)"


*NUEVAS VARIABLES (70 variables -70 menos 0-)*


label variable	id				"Identificación del hogar"
label variable 	year 			"Año"

label variable 	ciudad			"Área metropolitana"
label define	ciudad			1 "BARRANQUILLA" 2 "BOGOTÁ" 3 "BUCARAMANGA" 4 "CALI" 5 "CARTAGENA" 6 "CÚCUTA" 7 "IBAGUÉ" 8 "MANIZALES" 9 "MEDELLÍN" 10 "MONTERÍA" ///
								11 "PASTO" 12 "PEREIRA" 13 "VILLAVICENCIO"
label values 	ciudad			ciudad

label variable 	educ			"Años de educación"
label variable 	educ_hog		"Años de educación promedio en el hogar"
label variable 	prii			"=1 si primario incompleto"
label variable 	pric			"=1 si primario completo"
label variable 	seci			"=1 si secundario incompleto"
label variable 	secc			"=1 si secundario completo"
label variable 	supi			"=1 si superior incompleto"
label variable 	supc			"=1 si superior completo"

label variable	nivel_educ		"Nivel educativo"
label define	nivel_educ		1 "Primario incompleto" 2 "Primario completo" 3 "Secundario incompleto" 4 "Secundario completo" 5 "Superior incompleto" 6 "Superior completo"
label values	nivel_educ		nivel_educ

label variable	hombre			"=1 si hombre"
label define	hombre			0 "Mujer" 1 "Hombre"
label values	hombre			hombre

label variable	mujer			"=1 si mujer"
label define	mujer			0 "Hombre" 1 "Mujer"
label values	mujer			mujer

label variable	edad	 		"Edad"
label variable	edad2			"Edad al cuadrado"

label variable	g_edad			"Grupos de edad"
label define	g_edad			1 "[0,25]" 2 "[26,35]" 3 "[36,45]" 4 "[46,55]" 5 "[56,64]" 6 "[65+]"
label values	g_edad			g_edad

label variable	relacion		"Relación de parentesco"
label define	relacion		1 "Jefe(a) del hogar" 2 "Pareja, Esposo(a), Cónyuge" 3 "Hijo(a), Hijastro(a)" 4 "Nieto(a)" 5 "Otro pariente" ///
								6 "Empleado(a) del servicio doméstico" 7 "Pensionista" 8 "Trabajador(a)" 9 "Otro no pariente"
label values	relacion		relacion

label variable	ocupado			"=1 si ocupado"
label define	ocupado			0 "No ocupado" 1 "Ocupado"
label values	ocupado			ocupado

label variable	desocupado		"=1 si desocupado"
label define	desocupado		0 "No desocupado" 1 "Desocupado"
label values	desocupado		desocupado

label variable	activo			"=1 si activo"
label define	activo			0 "No activo" 1 "Activo"
label values	activo			activo

label variable	inactivo		"=1 si inactivo"
label define	inactivo		0 "No inactivo" 1 "Inactivo"
label values	inactivo		inactivo

label variable	estado			"Estado ocupacional"
label define	estado			1 "Ocupado" 2 "Desocupado" 3 "Inactivo"
label values	estado			estado

label variable	cat_ocup		"Categoría ocupacional"
label define	cat_ocup		1 "Obrero o empleado de empresa particular" 2 "Obrero o empleado del gobierno" 3 "Empleado doméstico" 4 "Trabajador por cuenta propia" ///
								5 "Patrón o Empleador" 6 "Trabajador familiar sin remuneración" 7 "Otro" 8 "Ninguno"
label values	cat_ocup		cat_ocup

label variable	rel_lab			"Relación laboral"
label define	rel_lab			1 "Patrón o Empleador" 2 "Obrero o empleado" 3 "Trabajador por cuenta propia" ///
								4 "Trabajador familiar sin remuneración" 5 "Empleado doméstico" 6 "Desocupado"
label values	rel_lab			rel_lab

label variable	desc_jubi		"=1 si descuento jubilatorio"
label define	desc_jubi		0 "Sin descuento jubilatorio" 1 "Con descuento jubilatorio"
label values	desc_jubi		desc_jubi

label variable	pipcug			"Percentiles del ipcug"
label variable	dipcug			"Deciles del ipcug"

label variable	informal		"=1 si trabajador informal"
label define	informal		0 "Trabajador formal" 1 "Trabajador informal"
label values	informal		informal

label variable	jefe			"=1 si jefe de hogar"
label define	jefe			0 "No jefe de hogar" 1 "Jefe de hogar"
label values	jefe			jefe

label variable	jefe_mujer		"=1 si jefe de hogar mujer"
label define	jefe_mujer		0 "Jefe de hogar hombre" 1 "Jefe de hogar mujer"
label values	jefe_mujer		jefe_mujer

label variable	jefe_edad		"=1 si jefe de hogar tiene 30 años de edad o menos"
label define	jefe_edad		0 "Jefe de hogar con 31 años de edad o más" 1 "Jefe de hogar con 30 años de edad o menos"
label values	jefe_edad		jefe_edad

label variable	jefe_gedad		"Jefe - Grupo de edad"
label define	jefe_gedad		1 "[0,25]" 2 "[26,35]" 3 "[36,45]" 4 "[46,55]" 5 "[56,64]" 6 "[65+]"
label values	jefe_gedad		jefe_gedad

label variable	jefe_neduc		"Jefe - Nivel educativo"
label define	jefe_neduc		1 "Primario incompleto" 2 "Primario completo" 3 "Secundario incompleto" 4 "Secundario completo" 5 "Superior incompleto" 6 "Superior completo"
label values	jefe_neduc		jefe_neduc

label variable	jefe_estado		"Jefe - Estado ocupacional"
label define	jefe_estado		1 "Ocupado" 2 "Desocupado" 3 "Inactivo"
label values	jefe_estado		jefe_estado

label variable	jefe_cocup		"Jefe - Categoría ocupacional"
label define	jefe_cocup		1 "Obrero o empleado de empresa particular" 2 "Obrero o empleado del gobierno" 3 "Empleado doméstico" 4 "Trabajador por cuenta propia" ///
								5 "Patrón o Empleador" 6 "Trabajador familiar sin remuneración" 7 "Otro" 8 "Ninguno"
label values	jefe_cocup		jefe_cocup

label variable	jefe_cp			"=1 si jefe de hogar cuenta propia"
label define	jefe_cp			0 "Jefe de hogar no cuenta propia" 1 "Jefe de hogar cuenta propia"
label values	jefe_cp			jefe_cp

label variable	miembros_h		"Número de miembros en el hogar"
label variable	miembros_ug		"Número de miembros en la unidad de gasto"
label variable	n_muj			"Número de mujeres en el hogar"
label variable	p_muj			"Porcentaje de mujeres en el hogar"

label variable	niño			"=1 si niño menor a 12 años de edad"
label define	niño			0 "No niño" 1 "Niño"
label values	niño			niño

label variable	n_niños			"Número de niños menores a 12 años de edad en el hogar"

label variable	niños_hog		"=1 si niños menores a 12 años de edad en el hogar"
label define	niños_hog		0 "Hogar sin niños menores a 12 años de edad" 1 "Hogar con niños menores a 12 años de edad"
label values	niños_hog		niños_hog

label variable	n_pet			"Número de individuos en edad de trabajar en el hogar"
label variable	n_ac			"Número de individuos activos en el hogar"
label variable	n_am			"Número de mujeres activas en el hogar"
label variable	t_plf			"Tasa de participación laboral femenina en el hogar"
label variable	n_ina			"Número de individuos inactivos en el hogar"
label variable	n_oc			"Número de individuos ocupados en el hogar"
label variable	n_des			"Número de individuos desocupados en el hogar"
label variable	t_des			"Tasa de desempleo en el hogar"
label variable	n_inf			"Número de individuos informales en el hogar"
label variable	t_inf			"Tasa de informalidad en el hogar"
label variable	ing_lab_1		"Ingresos laborales"
label variable	ing_lab_2		"Otros ingresos laborales"
label variable	ing_lab			"Ingreso laboral"
label variable	ing_lab_hor		"Ingreso laboral horario"
label variable	ling_lab_hor	"Logaritmo del ingreso laboral horario"
label variable	ing_nolab_1		"Ingresos no laborales por propiedades"
label variable	ing_nolab_2		"Ingresos no laborales por transferencias recibidas"
label variable	ing_nolab		"Ingreso no laboral"
label variable	ing_nolab_hog	"Ingreso no laboral en el hogar"
label variable	ing_tot_ob		"Ingreso total observado"
label variable	ing_tot_es		"Ingreso total imputado"
label variable	ing_tot			"Ingreso total"

label variable	ayudas_hog		"=1 si ayudas en el hogar"
label define	ayudas_hog		0 "Hogar sin ayudas" 1 "Hogar con ayudas"
label values	ayudas_hog		ayudas_hog

label variable	n_pob			"Número de individuos pobres en el hogar"
label variable	n_indig			"Número de individuos indigentes en el hogar"


*##############################################################################*
* ORDENAR TODAS LAS VARIABLES (280 variables) *
*##############################################################################*


/*
order	llave_viv llave_hog directorio secuencia_p mes fex_c fex_dpto_c clase dpto dominio aiii8 p5090 aiii9 p5100 p5140 ncuartos p5000 p5010 nper npersug ///
		ingtotug ingtotuge tenviv arrimp p5130 cuota_i ingtotugarr ingtotugearr ingpcug ingpcuge lp li pobre indigente npobres nindigentes ///
		/*HOGARES 2002, 2003, 2004, 2005, 2008, 2014, 2015 y 2018 (36 variables)*/ ///
		orden capital estrato1 p3 p4 p5 p6 p10 p10u p12 p24 p27 valor28 p29 valor29 p30 valor30 valor31 valor32a valor32b valor33a valor33b valor33c p34 p37 valor38 ///
		p39 p53 p57 valor58a valor58b valor58c valor59a valor59b valor59c valor65a valor65b valor65c valor66a valor66b valor66c p30a valor30a p30b valor30b pet oc ///
		des ina impa imsa ie imdi iof1 iof2 iof3 iof3h iof3i iof6 cclasnr2 cclasnr3 cclasnr4 cclasnr5 cclasnr6 cclasnr7 cclasnr8 cclasnr11 impaes imsaes iees imdies ///
		iof1es iof2es iof3es iof3hes iof3ies iof6es ingtotob ingtotes ingtot ///
		/*PERSONAS 2002, 2003, 2004, 2005, 2014, 2015 y 2018 (80 variables)*/ ///
		p6020 p6040 p6050 p6090 p6100 p6210 p6210s1 p6240 oficio p6426 p6430 p6500 p6510 p6510s1 p6510s2 p6545 p6545s1 p6545s2 p6580 p6580s1 p6580s2 p6585s1 p6585s1a1 ///
		p6585s1a2 p6585s2 p6585s2a1 p6585s2a2 p6585s3 p6585s3a1 p6585s3a2 p6585s4 p6585s4a1 p6585s4a2 p6590 p6590s1 p6600 p6600s1 p6610 p6610s1 p6620 p6620s1 p6630s1 ///
		p6630s1a1 p6630s2 p6630s2a1 p6630s3 p6630s3a1 p6630s4 p6630s4a1 p6630s6 p6630s6a1 p6750 p6760 p550 p6800 p6870 p6920 p7040 p7045 p7050	p7070 p7090 p7110 p7120 ///
		p7140s1 p7140s2 p7150 p7160 p7310 p7350 p7422 p7422s1 p7472 p7472s1 p7495 p7500s1 p7500s1a1 p7500s2 p7500s2a1 p7500s3 p7500s3a1 p7505 p7510s1 p7510s1a1 p7510s2 ///
		p7510s2a1 p7510s3 p7510s3a1 p7510s5 p7510s5a1 p7510s6 p7510s6a1 p7510s7 p7510s7a1 ///
		/*PERSONAS 2008 (94 variables)*/ ///
		id year ciudad educ educ_hog prii pric seci secc supi supc nivel_educ hombre mujer edad edad2 g_edad relacion ocupado desocupado activo inactivo ///
		estado cat_ocup rel_lab desc_jubi pipcug dipcug informal jefe jefe_mujer jefe_edad jefe_gedad jefe_neduc jefe_estado jefe_cocup jefe_cp ///
		miembros_h miembros_ug n_muj p_muj niño n_niños niños_hog n_pet n_ac n_am t_plf n_ina n_oc n_des t_des n_inf t_inf horas ///
		ing_lab_1 ing_lab_2 ing_lab ing_lab_hor ling_lab_hor ing_nolab_1 ing_nolab_2 ing_nolab ing_nolab_hog ing_tot_ob ing_tot_es ing_tot ayudas_hog n_pob n_indig ///
		/*NUEVAS VARIABLES (70 variables)*/
*/


*##############################################################################*
* AGRUPAR VARIABLES DUPLICADAS *
*##############################################################################*


*HOGARES*

generate itug_sri=ingtotug
egen     itug_cri=rowtotal(ingtotugearr ingtotugarr)
egen     ipcug   =rowtotal(ingpcuge     ingpcug)
generate lipcug  =ln(ipcug)

label variable	itug_sri		"Ingreso total de la unidad de gasto sin renta implícita"
label variable	itug_cri		"Ingreso total de la unidad de gasto con renta implícita"
label variable	ipcug			"Ingreso per cápita de la unidad de gasto"
label variable	lipcug			"Logaritmo del ingreso per cápita de la unidad de gasto"

*PERSONAS*

rename p4  aux1
rename p5  aux2
rename p34 aux3
rename p39 aux4

egen p4 =rowtotal(aux1 p6020)
egen p5 =rowtotal(aux2 p6040)
egen p34=rowtotal(aux3 p6800), missing
egen p39=rowtotal(aux4 p7045), missing
drop aux*

label variable	p4				"Sexo"
label values	p4				p4
label variable	p5				"Edad"
label variable	p34				"¿Cuántas horas a la semana trabaja, normalmente, en ese trabajo?"
label variable	p39				"¿Cuántas horas trabajó la semana pasada en ese segundo trabajo?"


*##############################################################################*
* MANTENER Y ORDENAR VARIABLES FINALES BASE (129-102 variables) *
*##############################################################################*


/*
keep	mes fex_c fex_dpto_c dpto dominio capital nper npersug itug_sri itug_cri ipcug lp li pobre indigente npobres nindigentes ///
		/*HOGARES (17 variables)*/ ///
		orden p3 p6050 p4 p5 p10 p6090 p34 p39 pet oc des ina impa impaes ie iees imsa imsaes imdi imdies iof1 iof1es iof2 iof2es iof3 iof3es iof6 iof6es valor33a ///
		valor59a valor66a p7510s1a1 p7510s2a1 p7510s3a1 p7510s5a1 p7510s6a1 p7510s7a1 ingtotob ingtotes ingtot /// 
		/*PERSONAS (41 variables)*/ ///
		id year ciudad educ educ_hog prii pric seci secc supi supc nivel_educ hombre mujer edad edad2 g_edad relacion ocupado desocupado activo inactivo ///
		estado cat_ocup rel_lab desc_jubi informal miembros_h miembros_ug n_muj p_muj niño n_niños niños_hog ///
		n_pet n_ac n_am t_plf n_ina n_oc n_des t_des n_inf t_inf ///
		jefe jefe_mujer jefe_edad jefe_gedad jefe_neduc jefe_estado jefe_cocup jefe_cp horas ///
		ing_lab_1 ing_lab_2 ing_lab ing_lab_hor ling_lab_hor ing_nolab_1 ing_nolab_2 ing_nolab ing_nolab_hog ing_tot_ob ing_tot_es ing_tot ayudas_hog n_pob n_indig ///
		lipcug pipcug dipcug ///
		/*NUEVAS VARIABLES (71 variables)*/

order	id orden year mes fex_c fex_dpto_c dpto dominio ciudad capital nper npersug itug_sri itug_cri ipcug lipcug pipcug dipcug lp li pobre indigente npobres nindigentes ///
		/*(24 variables)*/ ///
		p3 p6050 p4 p5 p10 p6090 p34 p39 pet oc des ina impa impaes ie iees imsa imsaes imdi imdies iof1 iof1es iof2 iof2es iof3 iof3es iof6 iof6es valor33a ///
		valor59a valor66a p7510s1a1 p7510s2a1 p7510s3a1 p7510s5a1 p7510s6a1 p7510s7a1 ingtotob ingtotes ingtot ///
		/*(40 variables)*/ ///
		educ educ_hog prii pric seci secc supi supc nivel_educ hombre mujer edad edad2 g_edad relacion ocupado desocupado activo inactivo ///
		estado cat_ocup rel_lab desc_jubi informal miembros_h miembros_ug n_muj p_muj niño n_niños niños_hog ///
		n_pet n_ac n_am t_plf n_ina n_oc n_des t_des n_inf t_inf ///
		jefe jefe_mujer jefe_edad jefe_gedad jefe_neduc jefe_estado jefe_cocup jefe_cp horas ///
		ing_lab_1 ing_lab_2 ing_lab ing_lab_hor ling_lab_hor ing_nolab_1 ing_nolab_2 ing_nolab ing_nolab_hog ing_tot_ob ing_tot_es ing_tot ayudas_hog n_pob n_indig ///
		/*(65 variables)*/

keep	id orden year mes fex_c fex_dpto_c dpto dominio ciudad capital ///
		miembros_h miembros_ug n_muj p_muj niño n_niños niños_hog ///
		hombre mujer edad edad2 g_edad educ educ_hog prii pric seci secc supi supc nivel_educ relacion ///
		jefe jefe_mujer jefe_edad jefe_gedad jefe_neduc jefe_estado jefe_cocup jefe_cp ///
		estado cat_ocup rel_lab desc_jubi pet n_pet activo n_ac n_am t_plf inactivo n_ina ocupado n_oc desocupado n_des t_des informal n_inf t_inf ///
		impa impaes ie iees imsa imsaes imdi imdies iof1 iof1es iof2 iof2es iof3 iof3es iof6 iof6es ///
		horas ing_lab_1 ing_lab_2 ing_lab ing_lab_hor ling_lab_hor ing_nolab_1 ing_nolab_2 ing_nolab ing_nolab_hog ingtotob ingtotes ingtot ayudas_hog ///
		itug_sri itug_cri ipcug lipcug pipcug dipcug lp li pobre indigente n_pob n_indig

order	id orden year mes fex_c fex_dpto_c dpto dominio ciudad capital ///
		miembros_h miembros_ug n_muj p_muj niño n_niños niños_hog ///
		hombre mujer edad edad2 g_edad educ educ_hog prii pric seci secc supi supc nivel_educ relacion ///
		jefe jefe_mujer jefe_edad jefe_gedad jefe_neduc jefe_estado jefe_cocup jefe_cp ///
		estado cat_ocup rel_lab desc_jubi pet n_pet activo n_ac n_am t_plf inactivo n_ina ocupado n_oc desocupado n_des t_des informal n_inf t_inf ///
		impa impaes ie iees imsa imsaes imdi imdies iof1 iof1es iof2 iof2es iof3 iof3es iof6 iof6es ///
		horas ing_lab_1 ing_lab_2 ing_lab ing_lab_hor ling_lab_hor ing_nolab_1 ing_nolab_2 ing_nolab ing_nolab_hog ingtotob ingtotes ingtot ayudas_hog ///
		itug_sri itug_cri ipcug lipcug pipcug dipcug lp li pobre indigente n_pob n_indig
*/

keep	id orden year mes fex_c fex_dpto_c dpto dominio ciudad capital ///
		miembros_h miembros_ug n_muj p_muj n_niños niños_hog educ_hog jefe_mujer jefe_edad jefe_gedad jefe_neduc jefe_estado jefe_cocup jefe_cp ///
		n_pet n_ac n_am t_plf n_ina n_oc n_des t_des n_inf t_inf ing_nolab_hog ayudas_hog itug_sri itug_cri ipcug lipcug pipcug dipcug lp li n_pob n_indig ///
		hombre mujer niño edad edad2 g_edad educ prii pric seci secc supi supc nivel_educ relacion jefe ///
		estado cat_ocup rel_lab desc_jubi pet activo inactivo ocupado desocupado informal pobre indigente ///
		impa impaes ie iees imsa imsaes imdi imdies iof1 iof1es iof2 iof2es iof3 iof3es iof6 iof6es ///
		horas ing_lab_1 ing_lab_2 ing_lab ing_lab_hor ling_lab_hor ing_nolab_1 ing_nolab_2 ing_nolab ingtotob ingtotes ingtot

order	id orden year mes fex_c fex_dpto_c dpto dominio ciudad capital ///
		miembros_h miembros_ug n_muj p_muj n_niños niños_hog educ_hog jefe_mujer jefe_edad jefe_gedad jefe_neduc jefe_estado jefe_cocup jefe_cp ///
		n_pet n_ac n_am t_plf n_ina n_oc n_des t_des n_inf t_inf ing_nolab_hog ayudas_hog itug_sri itug_cri ipcug lipcug pipcug dipcug lp li n_pob n_indig ///
		hombre mujer niño edad edad2 g_edad educ prii pric seci secc supi supc nivel_educ relacion jefe ///
		estado cat_ocup rel_lab desc_jubi pet activo inactivo ocupado desocupado informal pobre indigente ///
		impa impaes ie iees imsa imsaes imdi imdies iof1 iof1es iof2 iof2es iof3 iof3es iof6 iof6es ///
		horas ing_lab_1 ing_lab_2 ing_lab ing_lab_hor ling_lab_hor ing_nolab_1 ing_nolab_2 ing_nolab ingtotob ingtotes ingtot

sort year id orden dominio

describe
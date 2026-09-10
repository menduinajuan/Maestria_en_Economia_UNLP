rename Directorio directorio
rename Secuencia_p secuencia_p
rename Mes mes
rename Clase clase
rename Depto dpto
rename Dominio dominio

foreach i of numlist 5000 5010 5090 5100 5130 5140 {
	rename P`i' p`i'
}

rename Nper nper
rename Npersug npersug

foreach i of newlist ngtotug ngtotugarr ngpcug {
	rename I`i' i`i'
}

rename Li li
rename Lp lp
rename Pobre pobre
rename Indigente indigente
rename Npobres npobres
rename Nindigentes nindigentes
rename Fex_c fex_c
rename Fex_dpto fex_dpto_c

order directorio secuencia_p mes clase dpto
rename Directorio directorio
rename Secuencia_p secuencia_p
rename Orden orden
rename Clase clase
rename Dpto dpto
rename Dominio dominio
rename Capital capital
rename Mes mes
rename Estrato1 estrato1

global variables = "6020 6040 6050 6090 6100 6210 6210s1 6240 6426 6430 6500 6510 6510s1 6510s2 6545 6545s1 6545s2 6580 6580s1 6580s2 6585s1 6585s1a1 6585s1a2 6585s2 6585s2a1 6585s2a2 6585s3 6585s3a1 6585s3a2 6585s4 6585s4a1 6585s4a2 6590 6590s1 6600 6600s1 6610 6610s1 6620 6620s1 6630s1 6630s1a1 6630s2 6630s2a1 6630s3 6630s3a1 6630s4 6630s4a1 6630s6 6630s6a1 6750 6760 550 6800 6870 6920 7040 7045 7050 7070 7090 7110 7120 7140s1 7140s2 7150 7160 7310 7350 7422 7422s1 7472 7472s1 7495 7500s1 7500s1a1 7500s2 7500s2a1 7500s3 7500s3a1 7505 7510s1 7510s1a1 7510s2 7510s2a1 7510s3 7510s3a1 7510s5 7510s5a1 7510s6 7510s6a1 7510s7 7510s7a1"

foreach i of global variables {
	rename P`i' p`i'
}

rename Oficio oficio
rename Pet pet
rename Oc oc
rename Des des

foreach i of newlist na mpa sa e mdi of1 of2 of3h of3i of6 {
	rename I`i' i`i'
}

foreach i of newlist clasnr2 clasnr3 clasnr4 clasnr5 clasnr6 clasnr7 clasnr8 clasnr11 {
	rename C`i' c`i'
}

foreach i of newlist mpaes saes ees mdies of1es of2es of3hes of3ies of6es ngtotob ngtotes ngtot {
	rename I`i' i`i'
}

rename Fex_c fex_c
rename Fex_dpto fex_dpto_c

order directorio secuencia_p orden clase dpto
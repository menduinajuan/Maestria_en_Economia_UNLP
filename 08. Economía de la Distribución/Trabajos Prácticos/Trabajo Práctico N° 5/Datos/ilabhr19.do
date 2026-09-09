generate inglab=p21
generate hrtrb=pp3e_tot*4
generate ilabhr=inglab/hrtrb
drop if (ilabhr==. | ilabhr==0)
generate lilabhr=ln(ilabhr)
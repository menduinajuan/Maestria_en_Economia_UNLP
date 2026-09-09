args nombre

sort id

*Ingreso laboral total familiar simulado*
by id: egen ilatf_sim=total(ila_`nombre')

*Ingreso total familiar simulado*
generate itf_`nombre'=itf-ilatf_obs+ilatf_sim

*Ingreso per cápita familiar simulado*
generate ipcf_`nombre'=itf_`nombre'/miembros

drop ilatf_obs ilatf_sim
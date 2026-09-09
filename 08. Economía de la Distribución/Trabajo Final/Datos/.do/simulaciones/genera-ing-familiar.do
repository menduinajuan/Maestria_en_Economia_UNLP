args nombre

sort id

*Ingreso laboral total de la unidad de gasto observado*
egen ilatug_obs=total(ila), by(id)

*Ingreso laboral total de la unidad de gasto simulado*
egen ilatug_sim=total(ila_`nombre'), by(id)

*Ingreso total de la unidad de gasto simulado*
generate itug_`nombre'=itug-ilatug_obs+ilatug_sim

*Ingreso per cápita de la unidad de gasto simulado*
generate ipcug_`nombre'=itug_`nombre'/miembros_ug

drop ilatug_obs ilatug_sim
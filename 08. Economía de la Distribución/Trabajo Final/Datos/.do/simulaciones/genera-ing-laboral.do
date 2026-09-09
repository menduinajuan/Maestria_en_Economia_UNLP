args nombre

matrix score xbeta_aux=beta

generate lila_sim=xbeta_aux+resid
generate ila_`nombre'=exp(lila_sim)
replace ila_`nombre'=ila if (sampsel!=1)

drop xbeta_aux lila_sim
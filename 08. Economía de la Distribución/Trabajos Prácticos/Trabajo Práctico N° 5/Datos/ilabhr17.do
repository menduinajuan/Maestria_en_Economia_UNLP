generate inglab=p21
generate hrtrb=pp3e_tot*4
generate ilabhr=inglab/hrtrb
drop if (ilabhr==. | ilabhr==0)

local ipc17=103.80
local ipc19=197.10

replace ilabhr=ilabhr*(`ipc19'/`ipc17')

generate lilabhr=ln(ilabhr)
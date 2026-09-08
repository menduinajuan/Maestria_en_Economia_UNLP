'Magdalena Cornejo
'UNLP 2019
'Simulando procesos ARMA(p,q)

'creo el workfile que se llama "mcarlo" (donde T=200)
wfcreate mcarlo u 1 200

'set seed for random number generator
rndseed 1234

'Procesos MA(1):
genr e=nrnd 'Genera una N(0,1)

smpl @first+1 @last 
genr y=5+e+0.5*e(-1)
genr x=-3+e+0.9*e(-1)
genr z=9+e-1.2*e(-1)

'Procesos AR(1):
smpl @all
genr ybis=0
smpl @first+1 @last 
genr ybis=0.1*ybis(-1)+e

smpl @all
genr xbis=0
smpl @first+1 @last 
genr xbis=-0.5*xbis(-1)+e

smpl @all
genr zbis=0
smpl @first+1 @last 
genr zbis=0.95*zbis(-1)+e

'Procesos ARMA(p,q):
smpl @all
genr y1=0
smpl @first+1 @last 
genr y1=0.8*y1(-1)+e

smpl @all
genr y2=0
smpl @first+2 @last 
genr y2=0.1*y2(-1)+0.5*y2(-2)+e

smpl @all
genr y3=0
smpl @first+1 @last 
genr y3=e+0.8*e(-1)

smpl @all
genr y4=0
smpl @first+3 @last 
genr y4=e+0.1*e(-1)-0.4*e(-2)+0.5*e(-3)

smpl @all
genr y5=0
smpl @first+1 @last 
genr y5=0.5*y5(-1)+e-0.3*e(-1)

smpl @all
genr y6=0
smpl @first+2 @last 
genr y6=0.5*y6(-1)-0.2*y6(-2)+e-0.3*e(-1)



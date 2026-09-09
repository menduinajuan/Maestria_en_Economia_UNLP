regress lila edad edad2 hombre pric seci secc supi supc ocupdum3 [w=fex_c] if (muestra==1 & (ocup==2 | ocup==3))

matrix define beta=e(b)

estimate store mincer

local sigma=e(rmse)
display "sigma = " `sigma'

generate sampmincer=1 if (e(sample))

matrix score xbeta=beta

generate resid=lila-xbeta if (sampmincer==1)
replace resid=rnormal(0,`sigma') if (sampmincer!=1)
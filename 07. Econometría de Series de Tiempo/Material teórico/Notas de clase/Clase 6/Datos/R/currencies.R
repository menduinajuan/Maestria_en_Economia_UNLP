#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#Modelos GARCH#

install.packages("fGarch")
install.packages("rugarch")
install.packages("tseries")
install.packages("normtest")
install.packages("aTSA")
library(tseries)
library(normtest)
library(fGarch)
library(aTSA)
library(rugarch)

datos <- read.csv("C:/Users/Magdalena Cornejo/Dropbox/UNLP/Clase 6/R/currencies.csv")
attach(datos)

rjpy <- ts(datos$RJPY, frequency = )
plot(rjpy)
plot(rjpy^2)
acf(rjpy[2:1827]^2)

#Evalúo si hay efectos ARCH:
fit <- arima(rjpy[2:1827], order=c(0,0,0)) 
arch.test(fit)

?ugarchspec #miren todas las opciones de modelo que tienen en esta función

#Estimo un TGARCH:
garchSpec <- ugarchspec(
  variance.model=list(model="fGARCH",
                      garchOrder=c(1,1),
                      submodel="TGARCH"),
  mean.model=list(armaOrder=c(0,0)), 
  distribution.model="std")
TgarchFit <- ugarchfit(spec=garchSpec, data=rjpy[2:1827])
coef(TgarchFit) #el coeficiente eta11 es el que corresponde al término de asimetría
TgarchFit@fit$se.coef

TgarchFit #output completo

plot.ts(TgarchFit@fit$var)


#Estimo un EGARCH:
garchSpec <- ugarchspec(
  variance.model=list(model="eGARCH",
                      garchOrder=c(1,1)),
  mean.model=list(armaOrder=c(0,0)), 
  distribution.model="std")
egarchFit <- ugarchfit(spec=garchSpec, data=rjpy[2:1827])
coef(egarchFit) #el coeficiente gamma1 es el que corresponde al término de asimetría
egarchFit@fit$se.coef

egarchFit #output completo

#Gráfico comparativo de varianzas condicionales estimadas:
par(mfrow=c(2,1),mar= c(2, 2, 2, 0.5),oma=c(0,0,0,0))
plot.ts(TgarchFit@fit$var, main="TGARCH")
plot.ts(egarchFit@fit$var, main="EGARCH")

#Estimo un GARCH-in-mean:
garchSpec <- ugarchspec(
  variance.model=list(model="fGARCH",
                      garchOrder=c(1,1),
                      submodel="APARCH"),
  mean.model=list(armaOrder=c(0,0),
            include.mean=TRUE,
           archm=TRUE,
           archpow=2
            ),
  distribution.model="std")
garchmFit <- ugarchfit(spec=garchSpec, data=rjpy[2:1827]) #va a tardar un poco
coef(garchmFit) #el coeficiente lambda es el que corresponde a la prima de riesgo
garchmFit@fit$se.coef

garchmFit #output completo

par(mfrow=c(2,1),mar= c(2, 2, 2, 0.5),oma=c(0,0,0,0))
plot.ts(garchmFit@fit$fitted.values, main="RJPY Fitted values")
plot.ts(garchmFit@fit$var, main="Varianza condicional estimada")

plot.ts(garchmFit@fit$var)
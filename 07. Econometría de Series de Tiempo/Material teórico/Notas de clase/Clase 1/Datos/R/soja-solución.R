#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#Aplicación de la Metodología de Box-Jenkins#

datos <- read.csv("C:/Users/Magdalena Cornejo/Dropbox/UNLP/Clase 1/R/soja.csv")
s<-ts(datos$s, frequency=12, start=c(1979,1))
plot(s, main="Precio spot de la soja")

#Le aplico la diferencia logarítmica:
ds<-diff(log(s))*100
ds<-ts(ds, frequency=12, start=c(1979,2))
plot(ds, main="Variación mensual del precio spot de la soja (en %)")

#Correlogramas:
acf(ds, main="ACF de la variación en el precio de la soja")
pacf(ds, main="PACF de la variación en el precio de la soja")

#Estimación:
ar1<-arima(ds,order=c(1,0,0))
ar1
Box.test(ar1$residuals, lag=12, type="Ljung-Box")

ma1<-arima(ds,order=c(0,0,1))
ma1 #mirando el AIC, el AR(1) es preferible al MA(1)
Box.test(ma1$residuals, lag=12, type="Ljung-Box")

#Aplicando automáticamente la metodología de Box-Jenkins:
library(forecast)

fit<-auto.arima(ds, ic=c("aic")); summary(fit) 
plot(fit$residuals)
Box.test(fit$residuals, lag=12, type="Ljung-Box")
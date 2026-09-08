#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#Automatización de la metodología de Box-Jenkins#

library(datasets)
plot.ts(WWWusage)

#Voy a aplicarle la diferencia logarítmica:
dy <- diff(log(WWWusage))
plot.ts(dy)

#Automatización de la metodología:
library(forecast)
fit <- auto.arima(dy)
summary(fit)
plot(fit$residuals)
Box.test(fit$residuals, lag=5, type="Ljung-Box")
#realizo un pronóstico 20 pasos adelante:
plot(forecast(fit,h=20))
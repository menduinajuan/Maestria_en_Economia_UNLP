#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#Tendencias Determinísticas#

install.packages("tseries")
library(tseries)

datos <- read.csv("C:/Users/Magdalena Cornejo/Dropbox/UNLP/Clase 3/R/RGDP.csv")
attach(datos)
RGDP<-ts(RGDP, frequency=4, start=c(1947,1))
plot(RGDP, main="Quarterly U.S. Real GDP (Seasonally Adjusted)")

time<-seq(1:length(RGDP))
fit<-lm(RGDP~time+I(time^2)+I(time^3))
summary(fit)
RGDPhat<-predict(fit)
RGDPhat<-ts(RGDPhat, frequency=4, start=c(1947,1))
plot(RGDP)
lines(RGDPhat,col="red")

RGDP_sintrend <- fit$residuals
plot.ts(RGDP_sintrend)
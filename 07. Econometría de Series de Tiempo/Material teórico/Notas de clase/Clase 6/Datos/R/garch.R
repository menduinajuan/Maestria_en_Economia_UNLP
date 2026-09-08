#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#Modelos GARCH#

install.packages("fGarch")
install.packages("rmgarch")
install.packages("tseries")
install.packages("normtest")
install.packages("aTSA")
library(tseries)
library(normtest)
library(fGarch)
library(aTSA)
library(rmgarch)

datos <- read.csv("C:/Users/Magdalena Cornejo/Dropbox/UNLP/Clase 6/R/garch.csv")
attach(datos)

fspcom<-ts(fspcom, frequency=12, start=c(1947,1))
plot.ts(fspcom)
R<-diff(log(fspcom), diff = 1)
plot.ts(R)

R2 <- R^2
plot.ts(R2)
acf(R2)
pacf(R2)

garchFit(R~garch(1,1))

#Estimando por QML (con errores estándares robustos)
spec=ugarchspec(mean.model=list(armaOrder=c(0,0)),variance.model=list(garchOrder=c(1,1)))
garch11<-ugarchfit(spec,R)
garch11

plot.ts(garch11@fit$var)

jb.norm.test(garch11@fit$residuals)
kurtosis.norm.test(garch11@fit$residuals)
skewness.norm.test(garch11@fit$residuals)
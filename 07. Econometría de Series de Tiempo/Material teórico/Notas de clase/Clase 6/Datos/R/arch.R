#Magdalena Cornejo#
#UdeSA 2019 - Econometría de Series de Tiempo#
#Modelos ARCH#

options(scipen = 999)

#install.packages("tseries")
#install.packages("normtest")
#install.packages("aTSA")
#install.packages("fGarch")
#install.packages("rugarch")
#install.packages("rmgarch")

library(tseries)
library(normtest)
library(aTSA)
library(fGarch)
library(rugarch)
library(rmgarch)

datos <- read.csv("C:/Users/Magdalena Cornejo/Dropbox/UdeSA/Series de tiempo/2019/Clase 7/R/currencies.csv")
attach(datos)

RGBP<-RGBP[2:1827]
plot.ts(RGBP)
hist(RGBP)

#Gráfico tuneado:
m<-mean(RGBP)
std<-sqrt(var(RGBP))
hist(RGBP, density=20, breaks=20, prob=TRUE, ylim=c(0, 2), 
     main="Histograma con curva normal")
curve(dnorm(x, mean=m, sd=std), 
      col="darkblue", lwd=2, add=TRUE, yaxt="n")

#Test de normalidad:
jb.norm.test(RGBP)
kurtosis.norm.test(RGBP)
skewness.norm.test(RGBP)

#Estimo un AR(1):
fit<-arima(RGBP,order=c(1,0,0))
fit
Box.test(fit$residuals)

resid2 <- (fit$residuals)^2
acf(resid2)
pacf(resid2)
plot.ts(resid2)

jb.norm.test(fit$residuals)
kurtosis.norm.test(fit$residuals)
skewness.norm.test(fit$residuals)

#Evalúo si hay efectos ARCH en los residuos:
arch.test(fit)

#Estimación de un modelo ARCH(1) puro:
fit<-garch(RGBP,order=c(0,1))
summary(fit)
sigmacond<-fitted(fit)
plot.ts(sigmacond)
varcond <- sigmacond^2
plot.ts(varcond[,1])
lines(resid2, col="red")

#Estimación de un modelo AR(1)-ARCH(1):
ar1_arch1 <- garchFit(RGBP~arma(1,0)+garch(1,0))
summary(ar1_arch1)

#Obtengo los residuos estandarizados (e):
e=residuals(ar1_arch1,standardize=T)
hist(e)

jb.norm.test(e)
kurtosis.norm.test(e)
skewness.norm.test(e)

library(psych)
describe(e)
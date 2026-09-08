#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#Enfoque de Johansen#

install.packages("vars")
install.packages("tseries")
install.packages("urca")
library(vars)
library(tseries)
library(urca)
library(lmtest)

datos <- read.csv("C:/Users/Magdalena Cornejo/Dropbox/UNLP/Clase 5/R/danish.csv")
attach(datos)
LRM<-ts(LRM, frequency=4, start=c(1974,1))
LRY<-ts(LRY, frequency=4, start=c(1974,1))
IBO<-ts(IBO, frequency=4, start=c(1974,1))
IDE<-ts(IDE, frequency=4, start=c(1974,1))

plot.ts(LRM)
plot.ts(LRY)
plot.ts(IBO)
plot.ts(IDE)

y = cbind(LRM,LRY,IBO,IDE)
plot.ts(y, main="")

#Graficos de a pares:
#LRM con LRY:
par(mar= c(2, 4, 1, 4))
plot(LRM,type="l", lwd=2, xlab="",ylab="",bty="n") 
axis(side=2, at = pretty(range(LRM)))
par(new = TRUE)
plot(LRY, type = "l",lwd=2, col="red", axes = FALSE, bty = "n", xlab = "", ylab = "",bty="n")
axis(side=4, at = pretty(range(LRY)))
legend(1973, 6.1, legend=c("LRM (left axis)", "LRY (right axis)"),
       col=c("black", "red"), lty=1, cex=1.2,lwd=2,bty = "n")

#LRM con IBO:
par(mar= c(2, 4, 1, 4))
plot(LRM,type="l", lwd=2, xlab="",ylab="",bty="n") 
axis(side=2, at = pretty(range(LRM)))
par(new = TRUE)
plot(IBO, type = "l",lwd=2, col="blue", axes = FALSE, bty = "n", xlab = "", ylab = "",bty="n")
axis(side=4, at = pretty(range(IBO)))
legend(1973, 0.22, legend=c("LRM (left axis)", "IBO (right axis)"),
       col=c("black", "blue"), lty=1, cex=1.2,lwd=2,bty = "n")

#LRM con IDE:
par(mar= c(2, 4, 1, 4))
plot(LRM,type="l", lwd=2, xlab="",ylab="",bty="n") 
axis(side=2, at = pretty(range(LRM)))
par(new = TRUE)
plot(IDE, type = "l",lwd=2, col="darkgreen", axes = FALSE, bty = "n", xlab = "", ylab = "",bty="n")
axis(side=4, at = pretty(range(IDE)))
legend(1973, 0.12, legend=c("LRM (left axis)", "IDE (right axis)"),
       col=c("black", "darkgreen"), lty=1, cex=1.2,lwd=2,bty = "n")

#Al 5% son todas I(1):
summary(ur.df(LRM,type="trend",selectlags="BIC"))
summary(ur.df(diff(LRM,1),type="drift",selectlags="BIC"))

summary(ur.df(LRY,type="trend",selectlags="BIC"))
summary(ur.df(diff(LRY,1),type="drift",selectlags="BIC"))

summary(ur.df(IBO,type="trend",selectlags="BIC"))
summary(ur.df(diff(IBO,1),type="drift",selectlags="BIC"))

summary(ur.df(IDE,type="trend",selectlags="BIC"))
summary(ur.df(diff(IDE,1),type="drift",selectlags="BIC"))

#Determino longitud del VAR y estimo:
VARselect(y, lag.max=4, type="both")
var = VAR(y,p=2,type=c("const"))
summary(var)

#Evalúo autocorrelación y normalidad del VAR:
serial.test(var, lags.pt=3, type="PT.asymptotic")
normality.test(var, multivariate.only=TRUE)
normality.test(var, multivariate.only=FALSE) #En forma univariada (ecuación x ecuación)
#Para corregir la asimetría se pueden graficar los residuos y ver si hay algún outlier. En dicho caso, controlar con una dummy.

#Prueba de cointegración:
#Opción sin trend en el espacio de COI:
summary(ca.jo(y, type="trace", ecdet="const", K=2))
summary(ca.jo(y, type="eigen", ecdet="const", K=2))
#Opción con trend en el espacio de COI:
summary(ca.jo(y, type="trace", ecdet="trend", K=2))
summary(ca.jo(y, type="eigen", ecdet="trend", K=2))

#Estimación del VECM:
cointest<-ca.jo(y, type="trace", ecdet="const", K=2)
vecm<-cajorls(cointest, r=1)
summary(vecm$rlm)

cointest<-ca.jo(y, type="trace", ecdet="trend", K=2)
vecm<-cajorls(cointest, r=1)
summary(vecm$rlm)


#Aplicación de Johansen & Juselius (1990) - Parte II
#Si queremos generar a mano las dummies estacionales centradas:
CS1 = rep(c(1, 0, 0, 0), length(y)/ 4)-.25
CS2 = rep(c(0, 1, 0, 0), length(y)/ 4)-.25
CS3 = rep(c(0, 0, 1, 0), length(y)/ 4)-.25
CS4 = rep(c(0, 0, 0, 1), length(y)/ 4)-.25

CS=cbind(CS1,CS2,CS3)

#Determino longitud del VAR y estimo:
VARselect(y, lag.max=4, type="both", season=4)
var = VAR(y,p=2,type=c("const"),season=4)
var = VAR(y,p=2,type=c("const"))
summary(var)

#Evalúo autocorrelación y normalidad del VAR:
serial.test(var, lags.bg=3, type="PT.asymptotic")
normality.test(var, multivariate.only=TRUE)

#Y continúan con el análisis...
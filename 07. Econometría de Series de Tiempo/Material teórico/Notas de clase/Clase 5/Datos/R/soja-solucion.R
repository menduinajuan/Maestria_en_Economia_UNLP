#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#Solucion - COI precios de la soja#

library(vars)
library(tseries)
library(urca)
library(lmtest)

datos <- read.csv("C:/Users/Magdalena Cornejo/Dropbox/UNLP/Clase 5/R/soja.csv")
attach(datos)

LS<-ts(log(S), frequency=12, start=c(1979,1))
LF<-ts(log(F), frequency=12, start=c(1979,1))

y <- cbind(LS,LF)

#LRM con LRY:
par(mar= c(2, 4, 1, 4))
plot(LS,type="l", lwd=2) 
lines(LF, lwd=2, col="red")
legend(1990, 6.8, legend=c("log(S)", "log(F)"),
       col=c("black", "red"), lty=1, cex=1.2,lwd=2,bty = "n")

#Ya habíamos probado que ambas era I(1)

#Estimo un VAR(4) en niveles:
var <- VAR(y,p=4,type=c("const"))
summary(var)
#Evalúo ausencia de autocorrelación y normalidad en los errores
serial.test(var, lags.pt=5, type="PT.asymptotic")
normality.test(var, multivariate.only=TRUE)
normality.test(var, multivariate.only=FALSE)
#solo hay un problema de curtosis, puedo igual testear COI via Johansen

#Aplico el test de Johansen:
summary(ca.jo(y, type="trace", ecdet="const", K=4))
summary(ca.jo(y, type="eigen", ecdet="const", K=4))

summary(ca.jo(y, type="trace", ecdet="trend", K=4))
summary(ca.jo(y, type="eigen", ecdet="trend", K=4))

trend <- seq(1,401)
summary(lm(LS~LF+trend)) #la tendencia SI es significativa

#Estimación del VECM:
cointest<-ca.jo(y, type="trace", ecdet="trend", K=4)
vecm<-cajorls(cointest, r=1)
summary(vecm$rlm) #al 5% el futuro es débilmente exógeno

#Estimo en forma uniecuacional:
mce <- dyn$lm(diff(LS)~lag(LS,-1)+lag(LF,-1)+diff(lag(LS,-1))+diff(lag(LF,-1)))
summary(mce) #Voy a eliminar las que no resultaron estadísticamente significativas
mce <- dyn$lm(diff(LS)~lag(LS,-1)+lag(LF,-1)+diff(lag(LS,-1)))
summary(mce)

#Para ver si LF es fuertemente exógeno: falta ver si causa en sentido de Granger a LS
grangertest(LS~LF, order=4)  #considero order=4 porque ese era el orden del VAR en niveles sobre el cual probé cointegración
grangertest(LF~LS, order=4)  #considero order=4 porque ese era el orden del VAR en niveles sobre el cual probé cointegración
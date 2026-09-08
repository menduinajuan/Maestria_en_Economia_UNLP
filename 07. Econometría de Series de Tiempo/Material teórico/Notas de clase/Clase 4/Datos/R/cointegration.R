#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#Cointegracion#

#install.packages("egcm")
library(egcm)

datos <- read.csv("C:/Users/Magdalena Cornejo/Dropbox/UNLP/Clase 4/R/soja.csv")
attach(datos)

LS<-ts(log(S), frequency=12, start=c(1979,1))
LF<-ts(log(F), frequency=12, start=c(1979,1))

#Gráfico:
par(mar= c(2, 4, 1, 4))
plot(LS,type = "l",lwd=2, col="black", xlab="",ylab="",bty="n", cex.axis=1.2, main="")
lines(LF, col = "red", lwd=2)
legend(2000, 6.8, legend=c("log(S)", "log(F)"),
       col=c("black", "red"), lty=1, cex=1.2,lwd=2,bty = "n")

#Unit root tests:
summary(ur.df(LS,type="trend",selectlags="BIC"))
summary(ur.df(LF,type="trend",selectlags="BIC"))

#Diferenciando:
DLS<-diff(LS)
DLF<-diff(LF)

par(mar= c(2, 4, 1, 4))
plot(DLS,type = "l",lwd=2, col="black", xlab="",ylab="",bty="n", cex.axis=1.2, main="")
lines(DLF, col = "red", lwd=2)
legend(1998, 0.25, legend=c("dlog(S)", "dlog(F)"),
       col=c("black", "red"), lty=1, cex=1.2,lwd=2,bty = "n")

summary(ur.df(DLS,type="drift",selectlags="BIC"))
summary(ur.df(DLF,type="drift",selectlags="BIC"))

#Estimación en niveles:
fit<-lm(LS~LF)
summary(fit)
resid<-resid(fit)
plot.ts(resid, xlab="month", ylab="residuals")
acf(resid)
pacf(resid)

#Test de Engle-Granger:
summary(egcm(LS,LF))

#Estimacion del MCE:
install.packages("dyn")
library(dyn)
MCE<-dyn$lm(diff(LS)~lag(LS,-1)+lag(LF,-1)+diff(lag(LS,-1))+diff(lag(LF,-1)))
summary(MCE)

library(lmtest)
bgtest(MCE,order=2,type="Chisq")


#Version restringida (construyendo el término de correcciónde errores):
largoplazo<-lm(LS~LF)
TCE<-largoplazo$residuals
TCE<-ts(TCE, frequency=12, start=c(1979,1))

MCE_R<-dyn$lm(diff(LS)~lag(TCE,-1)+diff(lag(LS,-1))+diff(lag(LF,-1)))
summary(MCE_R)
bgtest(MCE_R,order=2,type="Chisq")
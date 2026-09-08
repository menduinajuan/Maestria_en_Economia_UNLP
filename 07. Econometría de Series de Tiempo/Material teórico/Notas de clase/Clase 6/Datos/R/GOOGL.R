#Forma automática de bajar datos de Yahoo Finance:
library(tseries)
P <- get.hist.quote(instrument = "GOOGL", start = "2006-01-01", end = "2019-10-24", 
                    quote = "AdjClose", provider = "yahoo", compression = "d", 
                    retclass = "zoo")
plot.ts(P)
R <- diff(log(P),1)*100
plot(R)

par(mar= c(2, 2, 1, 1))
plot(P,type = "l",lwd=2, col="black", xlab="",ylab="",bty="n", main="GOOGL Adjusted Price", ylim=c(0,1300))
par(mar= c(2, 2, 1, 1))
plot(R,type = "l",lwd=2, col="red", xlab="",ylab="",bty="n", main="GOOGL Stock Return (%)")

par(mar= c(2, 2, 1, 1))
hist(R, breaks=100, freq=F, main="Histograma del retorno", xlim=c(-15,15))
lines(density(R), col="blue", lwd=2)

library(psych)
summary(R)
describe(R)

library(aTSA)
R <- ts(R, frequency = )
fit<-arima(R[2:3475],order=c(0,0,0))
arch.test(fit)

R2 <- R^2
plot.ts(R2)
R2 <- ts(R2, frequency = )
acf(R2)
pacf(R2)

library(fGarch)
ARCH6 <- garchFit(R ~ arma(0,0)+garch(6,0))
summary(ARCH6)

#prueben incrementar el orden del ARCH para evaluar si los siguientes rezagos son estadísticamente significativos
#prueben estimar un ARCH(3) y evaluar si los rezagos adicionales son estadísticamente significativos
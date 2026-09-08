#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#Simulación: Regresión Espuria#

library(tseries)
library(urca)

#errores ruido blanco:
e <- rnorm(100,mean=0,sd=1)
v <- rnorm(100,mean=0,sd=1)

#RWs:
set.seed(15)
n=100
y=vector(length=100)
for (i in 2:n){
  y[1]=e[1]
  y[i]=2+y[i-1]+e[i];
}

x=vector(length=100)
for (i in 2:n){
  x[1]=v[1]
  x[i]=-1+x[i-1]+v[i];
}

#Gráfico:
par(mar= c(2, 4, 1, 4))
plot(x,type = "l",lwd=2, col="black", xlab="",ylab="",bty="n", cex.axis=1.2, main="")
par(new = TRUE)
plot(y, type = "l",lwd=2, col="red", axes = FALSE, bty = "n", xlab = "", ylab = "",bty="n",ylim=c(0,200))
axis(side=4, at = pretty(range(y)),cex.axis=1.2)
legend(40, 50, legend=c("x", "y"),
       col=c("black", "red"), lty=1, cex=1.2,lwd=2,bty = "n")

#Estimación en niveles:
fit<-lm(y~x)
summary(fit)

resid<-resid(fit)
plot.ts(resid)
acf(resid)
pacf(resid)

summary(ur.df(resid,type="trend",selectlags="BIC"))
summary(ur.df(resid,type="drift",selectlags="BIC"))

#Tomando diferencias:
Dy <- diff(y,diff=1)
Dx <- diff(x,diff=1)

#Gráfico:
par(mar= c(2, 4, 1, 4))
plot(Dx,type = "l",lwd=2, col="black", xlab="",ylab="",bty="n", cex.axis=1.2, main="")
axis(side=2, at = pretty(range(Dx)),cex.axis=1.2)
par(new = TRUE)
plot(Dy, type = "l",lwd=2, col="red", axes = FALSE, bty = "n", xlab = "", ylab = "",bty="n",ylim=c(-2,5))
axis(side=4, at = pretty(range(Dy)),cex.axis=1.2)
legend(16, -0.8, legend=c("Dx", "Dy"),
       col=c("black", "red"), lty=1, cex=1.2,lwd=2,bty = "n")

#Estimación en diferencias:
fit2 <- lm(Dy~Dx)
summary(fit2)
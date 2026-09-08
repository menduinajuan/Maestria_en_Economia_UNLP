#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#Clase 4 - Cointegración#


##### Simulaci?n: Regresi?n Espuria #####


library(tseries)
library(urca)

#Errores ruido blanco#

e <- rnorm(100, mean = 0, sd = 1)
v <- rnorm(100, mean = 0, sd = 1)

#RWs#

set.seed(15)
n = 100

y = vector(length = 100)
for (i in 2:n) {
  y[1] = e[1]
  y[i] = 2 + y[i-1] + e[i]
}

x = vector(length = 100)
for (i in 2:n) {
  x[1] = v[1]
  x[i] = -1 + x[i-1] + v[i]
}

#Gr?fico#

par(mar = c(2, 4, 1, 4))
plot(x, type = "l", lwd = 2, col = "black", xlab = "", ylab = "", bty = "n", cex.axis = 1.2, main = "")
axis(side = 2, at = pretty(range(x)), cex.axis = 1.2)
par(new = TRUE)
plot(y, type = "l", lwd = 2, col = "red", axes = FALSE, bty = "n", xlab = "", ylab = "", bty = "n", ylim = c(0, 200))
axis(side = 4, at = pretty(range(y)), cex.axis = 1.2)
legend(40, 50, legend = c("x", "y"), col = c("black", "red"), lty = 1, cex = 1.2, lwd = 2, bty = "n")

#Estimaci?n en niveles#

fit <- lm(y ~ x)
summary(fit)

resid <- resid(fit)
plot.ts(resid)
acf(resid)
pacf(resid)

summary(ur.df(resid, type = "trend", selectlags = "BIC"))
summary(ur.df(resid, type = "drift", selectlags = "BIC"))

#Diferenciando#

Dy <- diff(y, diff = 1)
Dx <- diff(x, diff = 1)

#Gr?fico#

par(mar = c(2, 4, 1, 4))
plot(Dx,type = "l", lwd = 2, col = "black", xlab = "", ylab = "", bty = "n", cex.axis = 1.2, main = "")
axis(side = 2, at = pretty(range(Dx)), cex.axis = 1.2)
par(new = TRUE)
plot(Dy, type = "l", lwd = 2, col = "red", axes = FALSE, bty = "n", xlab = "", ylab = "", bty = "n", ylim = c(-2, 5))
axis(side = 4, at = pretty(range(Dy)), cex.axis = 1.2)
legend(16, -0.8, legend = c("Dx", "Dy"), col = c("black", "red"), lty = 1, cex = 1.2, lwd = 2, bty = "n")

#Estimaci?n en diferencias#

fit2 <- lm(Dy ~ Dx)
summary(fit2)


##### Cointegraci?n: Ejemplo #####


install.packages("egcm")
library(egcm)

datos <- read.csv("G:/Mi Unidad/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/7. Econometría de Series de Tiempo/Material teórico/Notas de clase/Clase 4/Datos/Excel/soja.csv")
attach(datos)

LS <- ts(log(s), frequency = 12, start = c(1979, 1))
LF <- ts(log(f), frequency = 12, start = c(1979, 1))

#Gr?fico#

par(mar = c(2, 4, 1, 4))
plot(LS,type = "l", lwd = 2, col = "black", xlab = "", ylab = "", bty = "n", cex.axis = 1.2, main = "")
lines(LF, lwd = 2, col = "red")
legend(2000, 6.5, legend = c("log(s)", "log(f)"), col = c("black", "red"), lty = 1, cex = 1.2, lwd = 2, bty = "n")

#Unit Root Test#

summary(ur.df(LS, type = "trend", selectlags = "BIC"))
summary(ur.df(LF, type = "trend", selectlags = "BIC"))

#Diferenciando#

DLS <- diff(LS)
DLF <- diff(LF)

#Gr?fico#

par(mar = c(2, 4, 1, 4))
plot(DLS, type = "l", lwd = 2, col = "black", xlab = "", ylab = "", bty = "n", cex.axis = 1.2, main = "")
lines(DLF, col = "red", lwd = 2)
legend(1998, 0.25, legend = c("dlog(s)", "dlog(f)"), col = c("black", "red"), lty = 1, cex = 1.2, lwd = 2, bty = "n")

summary(ur.df(DLS, type = "drift", selectlags = "BIC"))
summary(ur.df(DLF, type = "drift", selectlags = "BIC"))

#Estimaci?n en niveles#

fit <- lm(LS ~ LF)
summary(fit)
resid <- resid(fit)
plot.ts(resid, xlab = "month", ylab = "residuals")
acf(resid)
pacf(resid)

#Test de Engle-Granger#

summary(egcm(LS, LF))

#Estimacion del MCE#

install.packages("dyn")
library(dyn)

MCE <- dyn$lm(diff(LS) ~ lag(LS, -1) + lag(LF, -1) + diff(lag(LS, -1)) + diff(lag(LF, -1)))
summary(MCE)

library(lmtest)
bgtest(MCE, order = 2, type = "Chisq")

#Versi?n restringida (construyendo el t?rmino de correcci?n de errores)#

largoplazo <- lm(LS ~ LF)
TCE <- largoplazo$residuals
TCE <- ts(TCE, frequency = 12, start = c(1979, 1))

MCE_R <- dyn$lm(diff(LS) ~ lag(TCE, -1) + diff(lag(LS, -1)) + diff(lag(LF, -1)))
summary(MCE_R)
bgtest(MCE_R, order = 2, type = "Chisq")
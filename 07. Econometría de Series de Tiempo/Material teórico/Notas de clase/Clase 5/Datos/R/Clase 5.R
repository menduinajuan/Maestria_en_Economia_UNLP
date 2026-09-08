#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#Clase 5 - Cointegración en Sistemas de Ecuaciones#


##### Enfoque de Johansen #####


install.packages("vars")
install.packages("lmtest")
library(tseries)
library(urca)
library(vars)
library(lmtest)

datos <- read.csv("G:/Mi Unidad/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/7. Econometría de Series de Tiempo/Material teórico/Notas de clase/Clase 5/Datos/Excel/danish.csv")
attach(datos)

LRM <- ts(LRM, frequency = 4, start = c(1974, 1))
LRY <- ts(LRY, frequency = 4, start = c(1974, 1))
IBO <- ts(IBO, frequency = 4, start = c(1974, 1))
IDE <- ts(IDE, frequency = 4, start = c(1974, 1))

plot.ts(LRM)
plot.ts(LRY)
plot.ts(IBO)
plot.ts(IDE)

y = cbind(LRM, LRY, IBO, IDE)
plot.ts(y, main = "")

#Gr?ficos de a pares#

#LRM con LRY#

par(mar = c(2, 4, 1, 4))
plot(LRM, type = "l", lwd = 2, xlab = "", ylab = "", bty = "n")
axis(side = 2, at = pretty(range(LRM)))
par(new = TRUE)
plot(LRY, type = "l", lwd = 2, col = "red", axes = FALSE, bty = "n", xlab = "", ylab = "", bty = "n")
axis(side = 4, at = pretty(range(LRY)))
legend(1973, 6.1, legend = c("LRM (left axis)", "LRY (right axis)"), col = c("black", "red"), lty = 1, cex = 1.2, lwd = 2, bty = "n")

#LRM con IBO#

par(mar = c(2, 4, 1, 4))
plot(LRM, type = "l", lwd = 2, xlab = "", ylab = "", bty = "n")
axis(side = 2, at = pretty(range(LRM)))
par(new = TRUE)
plot(IBO, type = "l", lwd = 2, col = "blue", axes = FALSE, bty = "n", xlab = "", ylab = "", bty = "n")
axis(side = 4, at = pretty(range(IBO)))
legend(1973, 0.22, legend = c("LRM (left axis)", "IBO (right axis)"), col = c("black", "blue"), lty = 1, cex = 1.2, lwd = 2, bty = "n")

#LRM con IDE#

par(mar = c(2, 4, 1, 4))
plot(LRM, type = "l", lwd = 2, xlab = "", ylab = "", bty = "n")
axis(side = 2, at = pretty(range(LRM)))
par(new = TRUE)
plot(IDE, type = "l", lwd = 2, col = "darkgreen", axes = FALSE, bty = "n", xlab = "", ylab = "", bty = "n")
axis(side = 4, at = pretty(range(IDE)))
legend(1973, 0.12, legend = c("LRM (left axis)", "IDE (right axis)"), col = c("black", "darkgreen"), lty = 1, cex = 1.2, lwd = 2, bty = "n")

#Al 5%, son todas I(1)#

summary(ur.df(LRM, type = "trend", selectlags = "BIC"))
summary(ur.df(diff(LRM, 1), type = "drift", selectlags = "BIC"))

summary(ur.df(LRY, type = "trend", selectlags = "BIC"))
summary(ur.df(diff(LRY, 1), type = "drift", selectlags = "BIC"))

summary(ur.df(IBO, type = "trend", selectlags = "BIC"))
summary(ur.df(diff(IBO, 1), type = "drift", selectlags = "BIC"))

summary(ur.df(IDE, type = "trend", selectlags = "BIC"))
summary(ur.df(diff(IDE, 1), type = "drift", selectlags = "BIC"))

#Determinar longitud del VAR y estimar#

VARselect(y, lag.max = 4, type = "both")
var = VAR(y, p = 2, type = c("const"))
summary(var)

#Evaluar autocorrelaci?n y normalidad del VAR#

serial.test(var, lags.pt = 3, type = "PT.asymptotic")
normality.test(var, multivariate.only = TRUE)
normality.test(var, multivariate.only = FALSE) #En forma univariada (ecuaci?n por ecuaci?n)
#Para corregir la asimetr?a, se pueden graficar los residuos y ver si hay alg?n outlier. En dicho caso, controlar con una dummy

#Prueba de cointegraci?n#

#Opci?n sin trend en el espacio de COI#
summary(ca.jo(y, type = "trace", ecdet = "const", K = 2))
summary(ca.jo(y, type = "eigen", ecdet = "const", K = 2))
#Opci?n con trend en el espacio de COI#
summary(ca.jo(y, type = "trace", ecdet = "trend", K = 2))
summary(ca.jo(y, type = "eigen", ecdet = "trend", K = 2))

#Aplicaci?n de Johansen & Juselius (1990) - Parte II#

#Se generan a mano las dummies estacionales centradas#

CS1 = rep(c(1, 0, 0, 0), length(y)/4) - .25
CS2 = rep(c(0, 1, 0, 0), length(y)/4) - .25
CS3 = rep(c(0, 0, 1, 0), length(y)/4) - .25
CS4 = rep(c(0, 0, 0, 1), length(y)/4) - .25
CS = cbind(CS1, CS2, CS3)

#Determinar la longitud del VAR y estimar#

VARselect(y, lag.max = 4, type = "both", season = 4)
var = VAR(y, p = 2, type = c("const"), season = 4)
var = VAR(y, p = 2, type = c("const"))
summary(var)

#Evaluar autocorrelaci?n y normalidad del VAR#

serial.test(var, lags.bg = 3, type = "PT.asymptotic")
normality.test(var, multivariate.only = TRUE)

#Y continuar con el an?lisis...


##### Aplicaciones #####


#Aplicaci?n 1: Money Demand (Johansen & Juselius, 1990)#

cointest <- ca.jo(y, type = "trace", ecdet = "const", K = 2)
vecm <- cajorls(cointest, r = 1)
summary(vecm$rlm)

cointest <- ca.jo(y, type = "trace", ecdet = "trend", K = 2)
vecm <- cajorls(cointest, r = 1)
summary(vecm$rlm)

#Aplicaci?n 2: Precio Spot y Futuro de Soja#

#install.packages("vars")
#install.packages("lmtest")
library(tseries)
library(urca)
library(vars)
library(lmtest)

datos <- read.csv("G:/Mi Unidad/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/7. Econometría de Series de Tiempo/Material teórico/Notas de clase/Clase 5/Datos/Excel/soja.csv")#

LS <- ts(log(s), frequency = 12, start = c(1979, 1))
LF <- ts(log(f), frequency = 12, start = c(1979, 1))

y <- cbind(LS, LF)

#LS con LF#

par(mar = c(2, 4, 1, 4))
plot(LS, type = "l", lwd = 2) 
lines(LF, lwd = 2, col = "red")
legend(1990, 6.5, legend = c("log(s)", "log(f)"), col = c("black", "red"), lty = 1, cex = 1.2, lwd = 2, bty = "n")
#Ya se hab?a probado que ambas eran I(1)

#Estimar un VAR(4) en niveles#

var <- VAR(y, p = 4, type = c("const"))
summary(var)

#Evaluar autocorrelaci?n y normalidad del VAR#

serial.test(var, lags.pt = 5, type = "PT.asymptotic")
normality.test(var, multivariate.only = TRUE)
normality.test(var, multivariate.only = FALSE)
#S?lo hay un problema de curtosis; se puede igual testear COI v?a Johansen

#Aplicar el test de Johansen#

summary(ca.jo(y, type = "trace", ecdet = "const", K = 4))
summary(ca.jo(y, type = "eigen", ecdet = "const", K = 4))

summary(ca.jo(y, type = "trace", ecdet = "trend", K = 4))
summary(ca.jo(y, type = "eigen", ecdet = "trend", K = 4))

trend <- seq(1, 401)
summary(lm(LS ~ LF + trend)) #La tendencia SI es significativa

#Estimaci?n del VECM#

cointest <- ca.jo(y, type = "trace", ecdet = "trend", K = 4)
vecm <- cajorls(cointest, r = 1)
summary(vecm$rlm) #Al 5%, el precio futuro es d?bilmente ex?geno

#Estimar en forma uniecuacional#

mce <- dyn$lm(diff(LS) ~ lag(LS, -1) + lag(LF, -1) + diff(lag(LS, -1)) + diff(lag(LF, -1)))
summary(mce) #Eliminar las que no resultaron estad?sticamente significativas
mce <- dyn$lm(diff(LS) ~ lag(LS, -1) + lag(LF, -1) + diff(lag(LS, -1)))
summary(mce)

#Para ver si LF es fuertemente ex?geno, falta ver si causa en sentido de Granger a LS
grangertest(LS ~ LF, order = 4) #Considerar order=4 porque ese era el orden del VAR en niveles sobre el cual se prob? cointegraci?n
grangertest(LF ~ LS, order = 4) #Considerar order=4 porque ese era el orden del VAR en niveles sobre el cual se prob? cointegraci?n
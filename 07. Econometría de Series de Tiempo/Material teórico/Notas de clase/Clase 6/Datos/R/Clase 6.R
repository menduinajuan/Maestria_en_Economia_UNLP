#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#Clase 6 - Modelos de Heterocedasticidad Condiconal#


##### Forma autom?tica de bajar datos de Yahoo Finance #####


install.packages("aTSA")
install.packages("fGarch")
install.packages("psych")
library(tseries)
library(aTSA)
library(fGarch)
library(psych)

P <- get.hist.quote(instrument = "GOOGL", start = "2006-01-01", end = "2019-10-24", quote = "AdjClose", provider = "yahoo", compression = "d", retclass = "zoo")
plot.ts(P)
R <- diff(log(P)) * 100
plot(R)

par(mar = c(2, 2, 1, 1))
plot(P, type = "l", lwd = 2, col = "black", xlab = "", ylab = "", bty = "n", main = "GOOGL Adjusted Price", ylim = c(0, 1300))
par(mar = c(2, 2, 1, 1))
plot(R, type = "l", lwd = 2, col = "red", xlab = "", ylab = "", bty = "n", main = "GOOGL Stock Return (%)")

par(mar = c(2, 2, 1, 1))
hist(R, breaks = 100, freq = F, main = "Histograma del Retorno", xlim = c(-15, 15))
lines(density(R), col = "blue", lwd = 2)

summary(R)
describe(R)

R <- ts(R, frequency = )
fit <- arima(R[2:3475], order = c(0, 0, 0))
arch.test(fit)

R2 <- R^2
plot.ts(R2)
R2 <- ts(R2, frequency = )
acf(R2)
pacf(R2)

ARCH3 <- garchFit(R ~ arma(0, 0) + garch(3, 0))
summary(ARCH3)
ARCH6 <- garchFit(R ~ arma(0, 0) + garch(6, 0))
summary(ARCH6)
ARCH7 <- garchFit(R ~ arma(0, 0) + garch(7, 0))
summary(ARCH7)


##### Simulando procesos ARCH #####


install.packages("rugarch")
library(rugarch)

arch1.spec = ugarchspec(variance.model = list(garchOrder = c(1, 0)), mean.model = list(armaOrder = c(0, 0)), fixed.pars = list(mu = 0, omega = 1, alpha1 = 0.8))
class(arch1.spec)
arch1.spec
set.seed(123)
arch1.sim = ugarchpath(arch1.spec, n.sim = 1000)
class(arch1.sim)
slotNames(arch1.sim)
names(arch1.sim@path)
plot.ts(arch1.sim@path$seriesSim)


##### Modelos ARCH #####


options(scipen = 999)

install.packages("openxlsx")
#install.packages("aTSA")
#install.packages("fGarch")
install.packages("normtest")
install.packages("rmgarch")
#install.packages("rugarch")
library(openxlsx)
library(tseries)
library(normtest)
library(aTSA)
library(fGarch)
library(rugarch)
library(rmgarch)

datos <- read.xlsx("G:/Mi Unidad/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/7. Econometría de Series de Tiempo/Material teórico/Notas de clase/Clase 6/Datos/Excel/curriencies.xlsx")
attach(datos)

RGBP <- RGBP[2:1827]
plot.ts(RGBP)
hist(RGBP)

#Gr?fico tuneado#
m <- mean(RGBP)
std <- sqrt(var(RGBP))
hist(RGBP, density = 20, breaks = 20, prob = TRUE, ylim = c(0, 2), main = "Histograma con Curva Normal")
curve(dnorm(x, mean = m, sd = std), col = "darkblue", lwd = 2, add = TRUE, yaxt = "n")

#Test de normalidad#
jb.norm.test(RGBP)
kurtosis.norm.test(RGBP)
skewness.norm.test(RGBP)

#Estimar un AR(1)#
fit <- arima(RGBP, order = c(1, 0, 0))
fit
Box.test(fit$residuals)

resid2 <- (fit$residuals)^2
plot.ts(resid2)
acf(resid2)
pacf(resid2)

jb.norm.test(fit$residuals)
kurtosis.norm.test(fit$residuals)
skewness.norm.test(fit$residuals)

#Evaluar si hay efectos ARCH en los residuos#
arch.test(fit)

#Estimaci?n de un modelo ARCH(1) puro#
fit <- garch(RGBP, order = c(0, 1))
summary(fit)
sigmacond <- fitted(fit)
plot.ts(sigmacond)
varcond <- sigmacond^2
plot.ts(varcond[, 1])
lines(resid2, col = "red")

#Estimaci?n de un modelo AR(1)-ARCH(1)#
ar1_arch1 <- garchFit(RGBP ~ arma(1, 0) + garch(1, 0))
summary(ar1_arch1)

#Obtener los residuos estandarizados (e)#
e = residuals(ar1_arch1, standardize = T)
hist(e)

jb.norm.test(e)
kurtosis.norm.test(e)
skewness.norm.test(e)

library(psych)
describe(e)


##### Modelos GARCH #####


#install.packages("openxlsx")
#install.packages("aTSA")
#install.packages("fGarch")
#install.packages("normtest")
#install.packages("rmgarch")
library(openxlsx)
library(tseries)
library(normtest)
library(aTSA)
library(fGarch)
library(rmgarch)

datos <- read.xlsx("G:/Mi Unidad/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/7. Econometría de Series de Tiempo/Material teórico/Notas de clase/Clase 6/Datos/Excel/garch.xlsx")
attach(datos)

fspcom <- ts(fspcom, frequency = 12, start = c(1947, 1))
plot.ts(fspcom)
R <- diff(log(fspcom))
plot.ts(R)

R2 <- R^2
plot.ts(R2)
acf(R2)
pacf(R2)

garchFit(R ~ garch(1, 1))

#Estimar por QML (con errores est?ndares robustos)#
spec = ugarchspec(mean.model = list(armaOrder = c(0, 0)), variance.model = list(garchOrder = c(1, 1)))
garch11 <- ugarchfit(spec, R)
garch11

plot.ts(garch11@fit$var)

jb.norm.test(garch11@fit$residuals)
kurtosis.norm.test(garch11@fit$residuals)
skewness.norm.test(garch11@fit$residuals)


##### Retorno del S&P #####


require(timeDate)

datos <- read.csv("G:/Mi Unidad/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/7. Econometría de Series de Tiempo/Material teórico/Notas de clase/Clase 6/Datos/Excel/^GSPC.csv")
attach(datos)

P <- ts(Adj.Close, frequency = 250, start = c(2000, 1, 3), end = c(2017, 8, 7))
R <- diff(log(P)) * 100
plot.ts(R, main = "Retorno diario del S&P500 (en %)")

h <- hist(R, breaks = 48, col = "red", main = "Histograma con Curva Normal")
xfit <- seq(min(R), max(R), length = 40)
yfit <- dnorm(xfit, mean = mean(R), sd = sd(R))
yfit <- yfit * diff(h$mids[1:2]) * length(R)
lines(xfit, yfit, col = "blue", lwd = 2)


##### Modelos GARCH #####


#install.packages("openxlsx")
#install.packages("aTSA")
#install.packages("fGarch")
#install.packages("normtest")
#install.packages("rugarch")
library(openxlsx)
library(tseries)
library(normtest)
library(aTSA)
library(fGarch)
library(rugarch)

datos <- read.xlsx("G:/Mi Unidad/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/7. Econometría de Series de Tiempo/Material teórico/Notas de clase/Clase 6/Datos/Excel/curriencies.xlsx")
attach(datos)

RJPY <- RJPY[2:1827]
plot.ts(RJPY)
plot.ts(RJPY^2)
acf(RJPY^2)

#Evaluar si hay efectos ARCH#
fit <- arima(RJPY, order = c(0, 0, 0)) 
arch.test(fit)

?ugarchspec #Mirar todas las opciones de modelos que tiene esta funci?n

#Estimar un TGARCH#
garchSpec <- ugarchspec(variance.model = list(model = "fGARCH", garchOrder = c(1, 1), submodel = "TGARCH"), mean.model = list(armaOrder = c(0, 0), include.mean = TRUE), distribution.model = "std")
TgarchFit <- ugarchfit(spec = garchSpec, data = RJPY)
coef(TgarchFit) #El coeficiente eta11 es el que corresponde al t?rmino de asimetr?a
TgarchFit@fit$se.coef
TgarchFit #Output completo#
plot.ts(TgarchFit@fit$var)

#Estimar un EGARCH#
garchSpec <- ugarchspec(variance.model = list(model = "eGARCH", garchOrder = c(1, 1)), mean.model = list(armaOrder = c(0, 0), include.mean = TRUE), distribution.model = "std")
egarchFit <- ugarchfit(spec = garchSpec, data = RJPY)
coef(egarchFit) #El coeficiente gamma1 es el que corresponde al t?rmino de asimetr?a
egarchFit@fit$se.coef
egarchFit #Output completo#
plot.ts(egarchFit@fit$var)

#Gr?fico comparativo de varianzas condicionales estimadas#
par(mfrow = c(2, 1), mar = c(2, 2, 2, 0.5), oma = c(0, 0, 0, 0))
plot.ts(TgarchFit@fit$var, main = "TGARCH")
plot.ts(egarchFit@fit$var, main = "EGARCH")

#Estimar un GARCH-in-mean#
garchSpec <- ugarchspec(variance.model = list(model = "fGARCH", garchOrder = c(1, 1), submodel = "APARCH"), mean.model = list(armaOrder = c(0, 0), include.mean = TRUE, archm = TRUE, archpow = 2), distribution.model = "std")
garchmFit <- ugarchfit(spec = garchSpec, data = RJPY)
coef(garchmFit) #El coeficiente lambda es el que corresponde a la prima de riesgo
garchmFit@fit$se.coef
garchmFit #Output completo#
par(mfrow = c(2, 1), mar = c(2, 2, 2, 0.5), oma = c(0, 0, 0, 0))
plot.ts(garchmFit@fit$fitted.values, main = "RJPY Fitted Values")
plot.ts(garchmFit@fit$var, main = "Varianza Condicional Estimada")
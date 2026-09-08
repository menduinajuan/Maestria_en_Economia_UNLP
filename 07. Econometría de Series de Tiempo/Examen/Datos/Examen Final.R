# Econometría de Series de Tiempo - Examen Final
# Juan Menduiña


#Limpiar la memoria#
ls()
rm(list = ls())

#Evitar notación científica en números decimales#
options(scipen = 999)

#Paquetes utilizados#
R.version.string
.libPaths()
paquetes <- c("aTSA", "fGarch", "forecast", "gets", "normtest", "openxlsx", "rugarch", "tseries", "urca", "vars", "zoo")
install.packages(paquetes, dependencies = TRUE, type = "binary")

resultados <- sapply(paquetes, function(p) {
  ok <- suppressWarnings(require(p, character.only = TRUE))
  ok
})
print(resultados)
install.packages("https://cran.r-project.org/src/contrib/Archive/normtest/normtest_1.1.tar.gz", repos = NULL, type = "source")
install.packages("future", dependencies = TRUE, type = "binary")

library(aTSA)
library(fGarch)
library(forecast)
library(gets)
library(normtest)
library(openxlsx)
library(rugarch)
library(tseries)
library(urca)
library(vars)
library(zoo)


##### PREGUNTA 1: El tipo de cambio real y los precios de las materias primas #####


base1 <- read.xlsx("G:/Mi Unidad/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/7. Econometría de Series de Tiempo/Examen/Datos/base1.xlsx")
from <- as.Date("2002-01-01")
to <- as.Date("2019-09-01")
months <- seq.Date(from = from, to = to, by = "month")
timeIndex <- as.Date(months)


                        ##### Inciso (a) #####


datos1 <- zoo(base1[, 2], order.by = timeIndex)
datos2 <- zoo(base1[, 3], order.by = timeIndex)

  ## Variables en niveles ##

logIPMP <- log(base1$IPMP)
logIPMP <- ts(logIPMP, frequency = 12, start = c(2002, 2))
plot(logIPMP, main = "Logaritmo del IPMP", ylab = "logIPMP", xlab = "Tiempo", type = "l", col = "red")
#La serie logIPMP parece no ser estacionaria

logITCRM <- log(base1$ITCRM)
logITCRM <- ts(logITCRM, frequency = 12, start = c(2002, 2))
plot(logITCRM, main = "Logaritmo del ITCRM", ylab = "logITCRM", xlab = "Tiempo", type = "l", col = "red")
#La serie logITCRM parece no ser estacionaria

  ## Variables en diferencias ##

d_logIPMP <- diff(logIPMP) * 100
d_logIPMP <- ts(d_logIPMP, frequency = 12, start = c(2002, 2))
plot(d_logIPMP, main = "Primera Diferencia del Logaritmo del IPMP", ylab = "d_logIPMP", xlab = "Tiempo", type = "l", col = "blue")
#La serie d_logIPMP parece ser estacionaria

d_logITCRM <- diff(logITCRM) * 100
d_logITCRM <- ts(d_logITCRM, frequency = 12, start = c(2002, 2))
plot(d_logITCRM, main = "Primera Diferencia del Logaritmo del ITCRM", ylab = "d_logITCRM", xlab = "Tiempo", type = "l", col = "blue")
#La serie d_logITCRM parece ser estacionaria

  ## Test ADF ##

#En todos los casos, se utiliza el número de rezagos que surge del Criterio de Selección Bayesiano de Schwarz
#Dadas las gráficas de logIPMP y de logITCRM, se utilizan los test con constante y con tendencia determinística
#Dadas las gráficas de d_logIPMP y de d_logITCRM, se utilizan los test con constante y sin tendencia determinística

summary(ur.df(logIPMP, type = "trend", selectlags = "BIC"))
#No se rechaza la hipótesis nula -----> No estacionaria
summary(ur.df(logITCRM, type = "trend", selectlags = "BIC"))
#No se rechaza la hipótesis nula -----> No estacionaria
summary(ur.df(d_logIPMP, type = "drift", selectlags = "BIC"))
#Se rechaza la hipótesis nula -----> Estacionaria
summary(ur.df(d_logITCRM, type = "drift", selectlags = "BIC"))
#Se rechaza la hipótesis nula -----> Estacionaria

  ## TesT PP ##

summary(ur.pp(logIPMP, model = "trend", lags = "short"))
#Se rechaza la hipótesis nula -----> Estacionaria
summary(ur.pp(logITCRM, model = "trend", lags = "short"))
#Se rechaza la hipótesis nula -----> Estacionaria
summary(ur.pp(d_logIPMP, model = "constant", lags = "short"))
#Se rechaza la hipótesis nula -----> Estacionaria
summary(ur.pp(d_logITCRM, model = "constant", lags = "short"))
#Se rechaza la hipótesis nula -----> Estacionaria

  ## TesT KPSS ##

summary(ur.kpss(logIPMP, type = "tau", lags = "short"))
#Se rechaza la hipótesis nula -----> No estacionaria
summary(ur.kpss(logITCRM, type = "tau", lags = "short"))
#Se rechaza la hipótesis nula -----> No estacionaria
summary(ur.kpss(d_logIPMP, type = "mu", lags = "short"))
#No se rechaza la hipótesis nula -----> Estacionaria
summary(ur.kpss(d_logITCRM, type = "mu", lags = "short"))
#No se rechaza la hipótesis nula -----> Estacionaria


                        ##### Inciso (b) #####


  ## Serie d_logIPMP ##

acf(coredata(d_logIPMP), main = "ACF de d_logIPMP")
pacf(coredata(d_logIPMP), main = "PACF de d_logIPMP")

arma1 <- auto.arima(d_logIPMP, ic = c("aic"))
summary(arma1)
arma2 <- auto.arima(d_logIPMP, ic = c("bic"))
summary(arma2)
#Mediante la automatización de la metodología de Box-Jenkins, utilizando los criterios de información AIC y BIC, se obtiene un ARMA(2,0) y un modelo ARMA(1,0), respectivamente

arma1 <- arima(d_logIPMP, order = c(1, 0, 0))
arma1
Box.test(arma1$residuals, lag = 12, type = "Box-Pierce")
arma2 <- arima(d_logIPMP, order = c(2, 0, 0))
arma2
Box.test(arma2$residuals, lag = 12, type = "Box-Pierce")
arma3 <- arima(d_logIPMP, order = c(1, 0, 1))
arma3
Box.test(arma3$residuals, lag = 12, type = "Box-Pierce")
arma4 <- arima(d_logIPMP, order = c(2, 0, 1))
arma4
Box.test(arma4$residuals, lag = 12, type = "Box-Pierce")
arma5 <- arima(d_logIPMP, order = c(2, 0, 2))
arma5
Box.test(arma5$residuals, lag = 12, type = "Box-Pierce")
#Se selecciona el modelo ARMA(1,0) por tener residuos RB y el menor AIC

plot(arma1$residuals, main = "Residuos d_logIPMP - ARMA(1,0)", ylab = "Residuos", xlab = "Tiempo", type = "l", col = "red")
abline(h = 0, col = "blue")

  ## Serie d_logITCRM ##

acf(coredata(d_logITCRM), main = "ACF de d_logITCRM")
pacf(coredata(d_logITCRM), main = "PACF de d_logITCRM")

arma1 <- auto.arima(d_logITCRM, ic = c("aic"))
summary(arma1)
arma2 <- auto.arima(d_logITCRM, ic = c("bic"))
summary(arma2)
#Mediante la automatización de la metodología de Box-Jenkins, utilizando los criterios de información AIC y BIC, se obtiene un modelo ARMA(0,1)(1,0)[12]

arma1 <- arima(d_logITCRM, order = c(0, 0, 1)(1, 0, 0)[12])
arma1
Box.test(arma1$residuals, lag = 12, type = "Box-Pierce")
arma2 <- arima(d_logITCRM, order = c(1, 0, 1))
arma2
Box.test(arma2$residuals, lag = 12, type = "Box-Pierce")
arma3 <- arima(d_logITCRM, order = c(0, 0, 2))
arma3
Box.test(arma3$residuals, lag = 12, type = "Box-Pierce")
arma4 <- arima(d_logITCRM, order = c(1, 0, 2))
arma4
Box.test(arma4$residuals, lag = 12, type = "Box-Pierce")
arma5 <- arima(d_logITCRM, order = c(2, 0, 2))
arma5
Box.test(arma5$residuals, lag = 12, type = "Box-Pierce")
#Se seleccion el modelo ARMA(0,1)(1,0)[12] por tener residuos RB y el menor AIC

plot(arma1$residuals, main = "Residuos d_logITCRM - ARMA(0,1)(1,0)[12]", ylab = "Residuos", xlab = "Tiempo", type = "l", col = "red")
abline(h = 0, col = "blue")


                        ##### Inciso (c) #####


  ## Longitud del VAR, Estimación, Pruebas de diagnósticos y FIR ##

y <- cbind(d_logIPMP, d_logITCRM)
VARselect(y, lag.max = 12, type = "both")
#Se selecciona un modelo VAR de orden 1

var1 <- VAR(y, p = 1, type = "const")
summary(var1)

serial.test(var1, lags.pt = 2, type = "PT.asymptotic")
#No se rechaza la hipótesis nula (al 10%) -----> Ausencia de autocorrelación
normality.test(var1, multivariate.only = TRUE)
#Se rechaza la hipótesis nula -----> Ausencia de normalidad multivariada de los errores (se apela al Teorema Central del Límite dado el tamaño de la muestra)

fir <- irf(var1, n.ahead = 10, ortho = TRUE, runs = 1000, seed = 12345)
fir
plot(fir)

  ## Causalidad en sentido de Granger ##

grangertest(d_logIPMP ~ d_logITCRM, order = 1)
grangertest(d_logITCRM ~ d_logIPMP, order = 1)
#No existe causalidad en sentido de Granger


                        ##### Inciso (d) #####


  ## Gráficos ##

par(mar = c(2, 4, 1, 4))
plot(logIPMP, main = "", ylab = "", xlab = "", type = "l", lwd = 2)
axis(side = 2, at = pretty(range(logIPMP)))
par(new = TRUE)
plot(logITCRM, main = "", ylab = "", xlab = "", type = "l", lwd = 2, col = "red", axes = FALSE)
axis(side = 4, at = pretty(range(logITCRM)))

  ## Orden de integración ##

summary(ur.df(logIPMP, type = "trend", selectlags = "BIC"))
summary(ur.df(logITCRM, type = "trend", selectlags = "BIC"))
#Ambas series son I(1), como se vió anteriormente

  ## Prueba de cointegración (Enfoque de Johansen-Juselius) ##

x <- cbind(logIPMP, logITCRM)
plot.ts(x, main = "", xlab = "Tiempo", type = "l", col = "red")
#Opción sin trend en el espacio de COI
summary(ca.jo(x, type = "trace", ecdet = "const", K = 2)) 
summary(ca.jo(x, type = "eigen", ecdet = "const", K = 2))
#Opción con trend en el espacio de COI
summary(ca.jo(x, type = "trace", ecdet = "trend", K = 2)) 
summary(ca.jo(x, type = "eigen", ecdet = "trend", K = 2))
#No se rechaza la hipótesis nula (en ningún caso) -----> No hay cointegración


##### PREGUNTA 2: Modelos de volatilidad #####


                        ##### Inciso (a) #####


DJIA <- get.hist.quote(instrument = "%5EDJI", start = "2000-01-01", end = "2019-09-30", quote = "AdjClose", provider = "yahoo", compression = "d", retclass = "zoo")
plot(DJIA, main = "Dow Jones Industrial Average", ylab = "DJIA", xlab = "Tiempo", type = "l", col = "red")

rt <- log(DJIA) - log(lag(DJIA))
plot(rt, main = "Retornos Diarios del DJIA", ylab = "Retornos", xlab = "Tiempo", type = "l", col = "blue")
DJIA$rt = rt

  ## Test ADF, PP y KPSS ##

#Dada la gráfica de rt, se utilizan los test con constante y sin tendencia determinística

summary(ur.df(rt, type = "drift", selectlags = "BIC"))
#Se rechaza la hipótesis nula -----> Estacionaria
summary(ur.pp(rt, model = "constant", lags = "short"))
#Se rechaza la hipótesis nula -----> Estacionaria
summary(ur.kpss(rt, type = "mu", lags = "short"))
#No se rechaza la hipótesis nula -----> Estacionaria

  ## Constrastes de Chow (uso de algoritmos para la detección de breacks o outliers) ##

#IIS (Impulse Indicator Saturation)#
isat(rt, iis = TRUE, sis = FALSE, tis = FALSE, t.pval = 0.000201329, plot = TRUE)
#SIS (Step Indicator Saturation)#
isat(rt, iis = FALSE, sis = TRUE, tis = FALSE, t.pval = 0.000201329, plot = TRUE)
#TIS (Trend Indicator Saturation)#
isat(rt, iis = FALSE, sis = FALSE, tis = TRUE, t.pval = 0.000201329, plot = TRUE)
#IIS + SIS (Super Saturation)#
isat(rt, iis = TRUE, sis = TRUE, tis = FALSE, t.pval = 0.000100665, plot = TRUE)
#IIS + SIS + TIS (Ultra Saturation)#
isat(rt, iis = TRUE, sis = TRUE, tis = TRUE, t.pval = 0.000067110, plot = TRUE)
#Fecha tentativa de quiebre: 10 de octubre de 2008


                        ##### Inciso (b) #####


rt <- ts(rt, frequency = 250, start = c(2000, 01, 01), end = c(2019, 09, 30))

  ## Test de Normalidad de la serie de retornos ##

jb.norm.test(rt)
kurtosis.norm.test(rt)
skewness.norm.test(rt)
#Se rechazan las hipótesis nulas -----> No normalidad, no curtosis y no simetría

  ## Estimación de un modelo AR(1) ##

rt1 <- arima(rt, order = c(1, 0, 0))
rt1
Box.test(rt1$residuals)
#No se rechaza la hipótesis nula -----> Ausencia de autocorrelación (?)

  ## Inspección visual de los residuos al cuadrado para captar cambios en la varianza ##

rt2 <- (rt1$residuals)^2
plot(rt2)
acf(rt2)
pacf(rt2)

  ## Test de Normalidad de los residuos del modelo AR(1) ##

jb.norm.test(rt1$residuals)
kurtosis.norm.test(rt1$residuals)
skewness.norm.test(rt1$residuals)
#Se rechazan las hipótesis nulas -----> No normalidad, no curtosis y no simetría

  ## Evaluar si hay efectos ARCH en los residuos ##

arch.test(rt1)
#Se rechaza la hipótesis nula -----> Hay efectos ARCH

  ## Estimación de un modelo AR(1)-ARCH(1) ##

ar1_arch1 <- garchFit(rt ~ arma(1, 0) + garch(1, 0))
summary(ar1_arch1)
# 1. constante no es estadísticamente significativa y omega es estadísticamente significativo
# 2. primer rezago de rt no es estadísticamente significativo -----> No hay efectos AR
# 3. primer rezago del residuo al cuadrado es estadísticamente significativo -----> Hay efectos ARCH
# 4. Por lo tanto, se tiene un modelo ARCH(1) puro

#Este modelo se estimó por MV, por lo que se requiere que los errores sean normales para la estimación y, en este caso, no lo son
#Se estima un modelo con errores estándares robustos para obtener una estimación más consistente

  ## Estimación por QML (con errores estándares robustos) ##

spec = ugarchspec(mean.model = list(armaOrder = c(0, 0)), variance.model = list(garchOrder = c(1, 0)))
garch10 <- ugarchfit(spec, rt)
garch10
#Los resultados no cambian, pero, ahora, se tienen estimaciones más consistentes

plot.ts(garch10@fit$var, main = "Volatilidad Estimada de los Retornos Diarios - GARCH(1,0)", ylab = "", xlab = "Tiempo")

jb.norm.test(garch10@fit$residuals)
kurtosis.norm.test(garch10@fit$residuals)
skewness.norm.test(garch10@fit$residuals)
#Se rechazan las hipótesis nulas -----> No normalidad, no curtosis y no simetría
#La normalidad no mejora mucho, pero se logra corregir algo la asimetría
Box.test(garch10@fit$var, type = "Box-Pierce")
#Se rechaza la hipótesis nula -----> Autocorrelación

  ## Modelo GARCH ##

#Se sabe que se tiene un modelo ARCH(1) puro. Ahora, se mira si se tiene un modelo GARCH(1,1)

spec = ugarchspec(mean.model = list(armaOrder = c(0, 0)), variance.model = list(garchOrder = c(1, 1)))
garch11 <- ugarchfit(spec, rt)
garch11
# 1. constante es estadisticamente significativa y omega no es estadísticamente significativo
# 2. primer rezago del residuo al cuadrado es estadísticamente significativo -----> Hay efectos ARCH
# 3. primer rezago de la varianza del residuo es estadísticamente significativa -----> Hay efectos GARCH
# 4. Por lo tanto, se tiene un modelo GARCH(1,1)

plot.ts(garch11@fit$var, main = "Volatilidad Estimada de los Retornos Diarios - GARCH(1,1)", ylab = "", xlab = "Tiempo")

jb.norm.test(garch11@fit$residuals)
kurtosis.norm.test(garch11@fit$residuals)
skewness.norm.test(garch11@fit$residuals)
#Se rechazan las hipótesis nulas -----> No normalidad, no curtosis y no simetría
Box.test(garch11@fit$var, type = "Box-Pierce")
#Se rechaza la hipótesis nula -----> Autocorrelación

#En conclusión, existen efectos GARCH(1,1)


                        ##### Inciso (c) #####


  ## Modelo TGARCH ##

garchSpec <- ugarchspec(variance.model = list(model = "fGARCH", garchOrder = c(1, 1), submodel = "TGARCH"), mean.model = list(armaOrder = c(0, 0), include.mean = TRUE), distribution.model = "std")
TgarchFit <- ugarchfit(spec = garchSpec, data = rt)
coef(TgarchFit) #El coeficiente eta11 es el que corresponde al término de asimetría
TgarchFit@fit$se.coef
TgarchFit
plot.ts(TgarchFit@fit$var, main = "Volatilidad Estimada de los Retornos Diarios - TGARCH(1,1)", ylab = "", xlab = "Tiempo")
#El término de asimetría no es estadísticamente significativo -----> No hay efecto apalancamiento

  ## Modelo EGARCH ##

garchSpec <- ugarchspec(variance.model = list(model = "eGARCH", garchOrder = c(1, 1)), mean.model = list(armaOrder = c(0, 0), include.mean = TRUE), distribution.model = "std")
egarchFit <- ugarchfit(spec = garchSpec, data = rt)
coef(egarchFit) #El coeficiente gamma1 es el que corresponde al término de asimetría
egarchFit@fit$se.coef
egarchFit
plot.ts(egarchFit@fit$var, main = "Volatilidad Estimada de los Retornos Diarios - EGARCH(1,1)", ylab = "", xlab = "Tiempo")
#El término de asimetría es estadísticamente significativo -----> Hay efecto apalancamiento

  ## Gráfico comparativo de varianzas condicionales estimadas ##

par(mfrow = c(2, 1), mar = c(2, 2, 2, 0.5), oma = c(0, 0, 0, 0))
plot.ts(TgarchFit@fit$var, main = "TGARCH")
plot.ts(egarchFit@fit$var, main = "EGARCH")
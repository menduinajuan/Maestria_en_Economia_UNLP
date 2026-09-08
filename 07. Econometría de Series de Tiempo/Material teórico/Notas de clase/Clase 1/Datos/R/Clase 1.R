#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#Clase 1 - Procesos Univariados Estacionarios#


##### Autocorrelaci?n #####


install.packages("zoo")     #Paquete para darle estructura de series temporales a los datos
install.packages("dyn")     #Paquete para correr modelos din?micos (con rezagos)
install.packages("lmtest")  #Paquete para correr tests LM sobre modelos lineales
library(zoo)
library(dyn)
library(lmtest)

options(scipen = 999)       #Para evitar notaci?n cient?fica en n?meros con decimales

#Para quienes usan Windows, notar que se usa "/" en lugar de "\"#

infla <- read.csv("G:/Mi Unidad/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/7. Econometría de Series de Tiempo/Material teórico/Notas de clase/Clase 1/Datos/Excel/infla.csv")
from <- as.Date("1983-12-01")
to <- as.Date("2006-05-01")

#Variable indicadora del tiempo#

months <- seq.Date(from = from, to = to, by = "month")
timeIndex <- as.Date(months)
infla <- zoo(infla[, -1], order.by = timeIndex)

#Generar el primer rezago de cpi y de wage#

cpiL1 <- lag(infla$cpi, k = -1)
wageL1 <- lag(infla$wage, k = -1)

#Generar la variable inflaci?n como diferencia logar?tmica de cpi*100#

infln <- diff(log(infla$cpi)) * 100

#Generar la variable cambio porcentual de salarios como diferencia logar?tmica de wage*100#

pcwage <- diff(log(infla$wage)) * 100

modelo.infla <- lm(infln ~ pcwage)
summary(modelo.infla)

#Gr?ficos#

plot(modelo.infla$residuals)
abline(h = 0, col = "red")
resid <- modelo.infla$residuals
residL1 <- lag(resid, -1)
resid <- resid[2:269] #Eliminar la primera observaci?n porque cuando le tom? el lag gener? un missing, as? puedo hacer el cross-plot sin problemas
plot(resid, residL1)

#Gr?fico tuneado#

par(mar = c(4, 4, 1, 4))
plot(resid, residL1, pch = 19)
abline(lm(resid ~ residL1, data = mtcars), col = "blue")
abline(h = 0, v = 0, col = "red")

#Test LM de Breusch-Godfrey#

bgtest(modelo.infla, order = 2)
coeftest(bgtest(modelo.infla, order = 2)) #El 2do. lag es significativo, por lo que se procede a testear con el siguiente orden de autocorrelaci?n
coeftest(bgtest(modelo.infla, order = 3)) #El 3er. lag no es significativo

#Modelo din?mico (con rezagos de la variable dependiente)#

modelo.infla.din <- dyn$lm(infln ~ pcwage + lag(infln, -1) + lag(infln, -2))
summary(modelo.infla.din)

#OJO que los residuos del modelo din?mico no tienen estructura temporal#

from <- as.Date("1984-03-01")
to <- as.Date("2006-05-01")
months <- seq.Date(from = from, to = to, by = "month")
timeIndex <- as.Date(months)

#Gr?ficos#

resid <- zoo(modelo.infla.din$residuals, order.by = timeIndex)
plot(resid)
abline(h = 0, col = "red")
residL1 <- lag(resid, -1)
#resid <- resid[2:269]# #Eliminar la primera observaci?n porque cuando le tom? el lag gener? un missing, as? puedo hacer el cross-plot sin problemas
plot(resid, residL1)

#Gr?fico tuneado#

par(mar = c(4, 4, 1, 4))
plot(resid, residL1, pch = 19)
abline(lm(resid ~ residL1), col = "blue")
abline(h = 0, v = 0, col = "red")

#Soluci?n Slide 49#

par(mfrow = c(2, 1))
plot(infla$cpi)
plot(infln)

par(mfrow = c(2, 1))
plot(infla$wage)
plot(pcwage)

#Soluci?n Slide 52#

summary(resid)

install.packages("stats") #Paquete de estad?sticas descriptivas
library(stats)

acf(coredata(resid), plot = F)
acf(coredata(resid)) #Si se grafica la funci?n de autocorrelaci?n (ACF)


##### Simulaci?n de Modelos ARMA #####


install.packages("boot")
library(boot)

#Simulando procesos MA(1)#

y <- 5 + arima.sim(n = 200, model = list(ma = c(0.5)), rand.gen = function(n, ...) rnorm(n, sd = 1))
ts.plot(y)
acf(y, type = "correlation", plot = T)

x <- -3 + arima.sim(n = 200, model = list(ma = c(0.9)), rand.gen = function(n, ...) rnorm(n, sd = 1))
ts.plot(x)
acf(x, type = "correlation", plot = T)

z <- 9 + arima.sim(n = 200, model = list(ma = c(-1.2)), rand.gen = function(n, ...) rnorm(n, sd = 1))
ts.plot(z)
acf(z, type = "correlation", plot = T)

#Simulando procesos AR(1)#

y <- arima.sim(n = 200, model = list(ar = c(0.1)), rand.gen = function(n, ...) rnorm(n, sd = 1))
ts.plot(y)
acf(y, type = "correlation", plot = T)

x <- arima.sim(n = 200, model = list(ar = c(-0.5)), rand.gen = function(n, ...) rnorm(n, sd = 1))
ts.plot(x)
acf(x, type = "correlation", plot = T)

z <- arima.sim(n = 200, model = list(ar = c(0.95)), rand.gen = function(n, ...) rnorm(n, sd = 1))
ts.plot(z)
acf(z, type = "correlation", plot = T)

#Simulando procesos ARMA(p,q)#

y1 <- arima.sim(n = 200, model = list(ar = c(0.8)), rand.gen = function(n, ...) rnorm(n, sd = 1))
ts.plot(y1)
acf(y1, type = "correlation", plot = T)

y2 <- arima.sim(n = 200, model = list(ar = c(0.1, 0.5)), rand.gen = function(n, ...) rnorm(n, sd = 1))
ts.plot(y2)
acf(y2, type = "correlation", plot = T)

y3 <- arima.sim(n = 200, model = list(ma = c(0.8)), rand.gen = function(n, ...) rnorm(n, sd = 1))
ts.plot(y3)
acf(y3, type = "correlation", plot = T)

y4 <- arima.sim(n = 200, model = list(ma = c(0.1, -0.4, 0.5)), rand.gen = function(n, ...) rnorm(n, sd = 1))
ts.plot(y4)
acf(y4, type = "correlation", plot = T)

y5 <- arima.sim(n = 200, model = list(ar = c(0.5), ma = c(-0.3)), rand.gen = function(n, ...) rnorm(n, sd = 1))
ts.plot(y5)
acf(y5, type = "correlation", plot = T)

y6 <- arima.sim(n = 200, model = list(ar = c(0.5, -0.2), ma = c(-0.3)), rand.gen = function(n, ...) rnorm(n, sd = 1))
ts.plot(y6)
acf(y6, type = "correlation", plot = T)


##### Automatizaci?n de la Metodolog?a de Box-Jenkins #####


library(datasets)
plot.ts(WWWusage)

#Aplicar diferencia logar?tmica#

dy <- diff(log(WWWusage))
plot.ts(dy)

#Automatizaci?n de la metodolog?a#

library(forecast)
fit <- auto.arima(dy)
summary(fit)
plot(fit$residuals)
Box.test(fit$residuals, lag = 5, type = "Ljung-Box")

#Realizar un pron?stico 20 pasos adelante#

plot(forecast(fit, h = 20))


##### Aplicaci?n de la Metodolog?a de Box-Jenkins #####


datos <- read.csv("C:/soja.csv") #("C:/JM/Economía/Maestría en Economía/7. Econometría de Series de Tiempo/Material teórico/Notas de clase/Clase 1/Datos/Excel/soja.csv")
s <- ts(datos$s, frequency = 12, start = c(1979, 1))
plot(s, main = "Precio spot de la soja")

#Aplicar diferencia logar?tmica#

ds <- diff(log(s)) * 100
ds <- ts(ds, frequency = 12, start = c(1979, 2))
plot(ds, main = "Variaci?n mensual del precio spot de la soja (en %)")

#Correlogramas#

acf(ds, main = "ACF de la variaci?n en el precio de la soja")
pacf(ds, main = "PACF de la variaci?n en el precio de la soja")

#Estimaci?n#

ar1 <- arima(ds, order = c(1, 0, 0))
ar1
Box.test(ar1$residuals, lag = 12, type = "Ljung-Box")

ma1 <- arima(ds, order = c(0, 0, 1))
ma1
Box.test(ma1$residuals, lag = 12, type = "Ljung-Box")
#Mirando el AIC, el AR(1) es preferible al MA(1)

#Aplicando autom?ticamente la metodolog?a de Box-Jenkins#

library(forecast)
fit <- auto.arima(ds, ic = c("aic"))
summary(fit) 
plot(fit$residuals)
Box.test(fit$residuals, lag = 12, type = "Ljung-Box")
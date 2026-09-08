#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#Clase 3 - Procesos No Estacionarios#


##### Tendencias Determin?sticas #####


library(tseries)

datos <- read.csv("G:/Mi Unidad/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/7. Econometría de Series de Tiempo/Material teórico/Notas de clase/Clase 3/Datos/Excel/RGDP.csv")
attach(datos)

RGDP<-ts(RGDP, frequency = 4, start = c(1947, 1))
plot(RGDP, main = "Quarterly U.S. Real GDP (Seasonally Adjusted)")

time <- seq(1:length(RGDP))
fit <- lm(RGDP ~ time + I(time^2) + I(time^3))
summary(fit)
RGDPhat <- predict(fit)
RGDPhat <- ts(RGDPhat, frequency = 4, start = c(1947, 1))
plot(RGDP)
lines(RGDPhat, col = "red")

RGDP_sintrend <- fit$residuals
plot.ts(RGDP_sintrend)


##### Simulaci?n #####


library(tseries)

#Ruido blanco#

rb <- rnorm(100, mean = 0, sd = 1)
plot.ts(rb)
hist(rb)

t <- seq(from = 1, to = 100, by = 1)
y <- 5 + 0.2 * t + rb
modelo <- lm(y ~ t)

#Distintos procesos AR (estacionarios y no estacionarios)#

y1 <- arima.sim(model = list(ar = 0.8), n = 100)
plot.ts(y1, main = "AR(1) estacionario")
acf(y1)
pacf(y1)

y2 <- cumsum(rb)
plot.ts(y2, main = "Random Walk")
acf(y2)
pacf(y2)

set.seed(15)
n = 100
y3 = vector(length = 100)
for (i in 2:n) {
  y3[1] = rb[1]
  y3[i] = 1.05 * y3[i-1] + rb[i]
}
plot.ts(y3)
acf(y3)
pacf(y3)


##### Unit Root Test #####


library(tseries)
library(urca)

#ADF Test#

datos <- read.csv("G:/Mi Unidad/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/7. Econometría de Series de Tiempo/Material teórico/Notas de clase/Clase 3/Datos/Excel/term.csv")
attach(datos)

r <- ts(r)
plot(r, main = "Difference between 180-day 90-day bank rates, %")

df1 <- ur.df(r, type = "none", selectlags = "BIC")
summary(df1)
df2 <- ur.df(r, type = "drift", selectlags = "BIC")
summary(df2)
df3 <- ur.df(r, type = "trend", selectlags = "BIC")
summary(df3)

datos <- read.csv("C:/soja.csv") #("G:/Mi Unidad/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/7. Econometría de Series de Tiempo/Material teórico/Notas de clase/Clase 3/Datos/Excel/soja.csv")

s <- ts(log(s), frequency = 12, start = c(1979, 5))
plot(s, main = "Precio spot de la soja en Chicago (en logs)")
summary(ur.df(s, type = "trend", selectlags = "BIC"))

ds <- diff(s, differences = 1) * 100
plot(ds, main = "Variaci?n del precio spot de la soja en Chicago (en %)")
summary(ur.df(ds, type = "drift", selectlags = "BIC"))
#Entonces, s es I(1), ya que ds es I(0)

datos <- read.csv("G:/Mi Unidad/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/7. Econometría de Series de Tiempo/Material teórico/Notas de clase/Clase 3/Datos/Excel/ipc.csv")

ipc <- ts(log(ipc), frequency = 12, start = c(2016, 12))
plot(ipc, main = "IPC cobertura nacional (en logs)")
summary(ur.df(ipc, type = "trend", selectlags = "BIC"))

infla <- diff(ipc, differences = 1) * 100
plot(infla, main = "Inflaci?n mensual cobertura nacional (en %)")
summary(ur.df(infla, type = "trend", selectlags = "BIC"))
summary(ur.df(infla, type = "drift", selectlags = "BIC"))

dinfla <- diff(infla, differences = 1) * 100
plot(dinfla, main = "Tasa de aceleraci?n de la inflaci?n mensual cobertura nacional (en %)")
summary(ur.df(dinfla, type = "drift", selectlags = "BIC"))
#Entonces, el IPC es I(2), la inflaci?n es I(1) y la tasa de aceleraci?n es I(0)

#PP Test#

summary(ur.pp(r, model = "constant", lags = "short"))
summary(ur.pp(s, model = "trend", lags = "short"))
summary(ur.pp(ds, model = "constant", lags = "short"))
summary(ur.pp(infla, model = "trend", lags = "short"))
summary(ur.pp(dinfla, model = "constant", lags = "short"))

#KPPS Test#

summary(ur.kpss(r, type = "mu", lags = "short"))
summary(ur.kpss(s, type = "tau", lags = "short"))
summary(ur.kpss(ipc, type = "tau", lags = "short"))
summary(ur.kpss(infla, type = "tau", lags = "short"))
summary(ur.kpss(dinfla, type = "mu", lags = "short"))


##### Simulaci?n de breaks #####


rb <- rnorm(100, mean = 0, sd = 1)
plot.ts(rb)

d <- rep(c(0,1), each = 50)
plot.ts(d)

y1 <- 3 + 5*d + rb
plot.ts(y1)

t <- c(rep(0,50), seq(1,50))
plot.ts(t)

y2 <- 10 - 0.2*d*t + rb
plot.ts(y2)

#Realizar el test ADF sobre ambas series#

library(urca)

summary(ur.df(y1, type = "trend", selectlags = "BIC"))
summary(ur.df(y1, type = "drift", selectlags = "BIC"))
summary(ur.df(y2, type = "trend", selectlags = "BIC"))
summary(ur.df(y2, type = "drift", selectlags = "BIC"))


##### Aplicaci?n IIS al TCN #####


library(zoo)
library(gets)

datos <- read.csv("G:/Mi Unidad/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/7. Econometría de Series de Tiempo/Material teórico/Notas de clase/Clase 3/Datos/Excel/TCN.csv")

from <- as.Date("2002-03-01")
to <- as.Date("2019-06-01")
month <- seq.Date(from = from, to = to, by = "month")
timeIndex <- as.Date(month)
TCN <- zoo(datos[, 2], order.by = timeIndex)
plot(TCN)

#IIS al 1%# (deber?a utilizar un target size de 1/208)
isat(TCN, iis = TRUE, sis = FALSE, tis = FALSE, t.pval = 0.01, plot = TRUE)
#SIS al 1%# (deber?a utilizar un target size de 1/208)
isat(TCN, iis = FALSE, sis = TRUE, tis = FALSE, t.pval = 0.01, plot = TRUE)
#TIS al 1%# (deber?a utilizar un target size de 1/208)
isat(TCN, iis = FALSE, sis = FALSE, tis = TRUE, t.pval = 0.01, plot = TRUE)
#IIS + SIS al 0.5%#
isat(TCN, iis = TRUE, sis = TRUE, tis = FALSE, t.pval = 0.005, plot = TRUE)
#IIS + SIS + TIS al 0.5%#
isat(TCN, iis = TRUE, sis = TRUE, tis = TRUE, t.pval = 0.005, plot = TRUE)
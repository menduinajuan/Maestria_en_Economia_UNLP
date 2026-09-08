#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#Procesos estacionarios univariados#

install.packages("zoo") #paquete para darle estructura de series temporales a los datos#
install.packages("lmtest") #paquete para correr tests LM sobre modelos lineales#
install.packages("dyn") #paquete para correr modelos dinámicos (con rezagos)#
library(zoo)
library(lmtest)
library(dyn)

options(scipen = 999) #para evitar notación científica en nros con decimales#
#Para quienes usan Windows: noten que se usa / en lugar de \:
infla <- read.csv("C:/Users/Magdalena Cornejo/Dropbox/UNLP/Clase 1/R/infla.csv")

from <- as.Date("1983-12-01")
to <- as.Date("2006-05-01")
#variable indicadora del tiempo:
months <- seq.Date(from=from,to=to,by="month")
timeIndex <- as.Date(months)

infla <- zoo(infla[,-1], order.by=timeIndex)

#Genero el primer rezago de cpi y de wage:
cpiL1<-lag(infla$cpi, k = -1)
wageL1<-lag(infla$wage, k = -1)

#Genero la variable inflación como diferencia logaritmica del cpi *100
infln <- diff(log(infla$cpi))*100
#Genero la variable cambio porcentual de salarios como diferencia logaritmica del cpi *100
pcwage <- diff(log(infla$wage))*100

modelo.infla <- lm(infln ~ pcwage)
summary(modelo.infla)

plot(modelo.infla$residuals)
abline(h=0,col="red")

resid <- modelo.infla$residuals
residL1 <- lag(resid, -1)
resid<-resid[2:269] #elimino la primera observación, porque cuando le tomé el lag generé un missing, así puedo hacer el cross-plot sin problemas
plot(resid,residL1)

#Gráfico tuneado:
par(mar= c(4, 4, 1, 4))
plot(resid,residL1, pch=19)
abline(lm(resid ~ residL1, data = mtcars), col = "blue")
abline(h=0,v=0,col="red")

#Test LM de Breusch-Godfrey
bgtest(modelo.infla, order=2)
coeftest(bgtest(modelo.infla, order=2))
coeftest(bgtest(modelo.infla, order=3)) #el 3er lag no es significativo#

#Modelo dinámico (con rezagos de la variable dependiente):
modelo.infla.din <- dyn$lm(infln ~ pcwage + lag(infln, -1) + lag(infln, -2))
summary(modelo.infla.din)

#OJO que los residuos del modelo dinámico no tienen estructura temporal
from <- as.Date("1984-03-01")
to <- as.Date("2006-05-01")
months <- seq.Date(from=from,to=to,by="month")
timeIndex <- as.Date(months)

resid <- zoo(modelo.infla.din$residuals, order.by=timeIndex)
plot(resid)
abline(h=0,col="red")

residL1 <- lag(resid, -1)
resid<-resid[2:270] #elimino la primera observación, porque cuando le tomé el lag generé un missing, así puedo hacer el cross-plot sin problemas
plot(resid,residL1)

#Gráfico tuneado:
par(mar= c(4, 4, 1, 4))
plot(resid,residL1, pch=19)
abline(lm(resid ~ residL1), col = "blue")
abline(h=0,v=0,col="red")

#Solución slide 43:
par(mfrow=c(2,1))
plot(infla$cpi)
plot(infln)

par(mfrow=c(2,1))
plot(infla$wage)
plot(pcwage)

#Solución slide 46:
summary(resid)
install.packages("stats")
library(stats)
acf(coredata(resid), plot=F)
acf(coredata(resid)) #si graficamos la función de autocorrelación (ACF)
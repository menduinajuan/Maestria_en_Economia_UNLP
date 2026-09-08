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
#Genero la variable cambio porcentual de salarios como diferencia logaritmica del wage *100
pcwage <- diff(log(infla$wage))*100

modelo.infla <- lm(infln ~ pcwage)
summary(modelo.infla)

#Test LM de Breusch-Godfrey
bgtest(modelo.infla, order=2)
coeftest(bgtest(modelo.infla, order=2))
coeftest(bgtest(modelo.infla, order=3)) #el 3er lag no es significativo#

#Modelo dinámico (con rezagos de la variable dependiente):
modelo.infla.din <- dyn$lm(infln ~ pcwage + lag(infln, -1) + lag(infln, -2))
summary(modelo.infla.din)
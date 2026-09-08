#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#Aplicación IIS al TCN#

install.packages("zoo") #Este paquete sirve para darle formato de series temporales a los datos.
install.packages("gets") #Este paquete es el que se usa para implementar IIS, SIS y TIS. También necesita el paquete zoo instalado.
library(zoo)
library(gets)

datos <- read.csv("C:/Users/Magdalena Cornejo/Dropbox/UNLP/Clase 3/R/TCN.csv")
attach(datos)

#Le doy formato de series temporales a los datos con el paquete "zoo":
from <- as.Date("2002-03-01")
to <- as.Date("2019-04-01")
month <- seq.Date(from=from,to=to,by="month") #variable indicadora del tiempo:
timeIndex <- as.Date(month)
TCN <- zoo(datos[,2], order.by=timeIndex) 

plot(TCN)

#IIS al 1%:
isat(TCN, iis=TRUE, sis=FALSE, tis=FALSE, t.pval=0.01, plot = TRUE)

#SIS al 1%:
isat(TCN, iis=FALSE, sis=TRUE, tis=FALSE, t.pval=0.01, plot = TRUE)

#IIS + SIS al 0.5%:
isat(TCN, iis=TRUE, sis=TRUE, tis=FALSE, t.pval=0.005, plot = TRUE)

#IIS + SIS + TIS al 0.5%:
isat(TCN, iis=TRUE, sis=TRUE, tis=TRUE, t.pval=0.005, plot = TRUE)
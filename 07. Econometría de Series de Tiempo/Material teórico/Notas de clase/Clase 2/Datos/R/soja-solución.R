#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#Estimación de un VAR y causalidad en sentido de Granger#

datos <- read.csv("C:/Users/Magdalena Cornejo/Dropbox/UNLP/Clase 2/Base de datos/soja.csv")
s<-ts(datos$s, frequency=12, start=c(1979,1))
plot(s, main="Precio spot de la soja")
f<-ts(datos$f, frequency=12, start=c(1979,1))
plot(f, main="Precio futuro de la soja")

#Aplico diferencias logarítmicas:
ds<-diff(log(s))*100
df<-diff(log(f))*100
plot(ds, main="Variación mensual del precio spot de la soja (en %)")
plot(df, main="Variación mensual del precio futuro de la soja (en %)")

#Busco el orden apropiado del VAR usando criterios de información:
#install.packages("vars")
library(vars)
y <- cbind(ds,df)
VARselect(y, lag.max=12, type="both")

#Estimación del VAR
modelo <- VAR(y, p = 10, type = "const")
summary(modelo)

#Pruebas de diagnóstico
serial.test(modelo, lags.pt=11, type="PT.asymptotic")
normality.test(modelo, multivariate.only=TRUE)

#Causalidad en sentido de Granger
grangertest(ds~df, order=10)
grangertest(df~ds, order=10)
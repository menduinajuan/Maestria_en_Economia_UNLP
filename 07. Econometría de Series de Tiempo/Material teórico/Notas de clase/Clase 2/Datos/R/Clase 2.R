#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#Clase 2 - Vectores Autorregresivos#


##### Estimaci?n de un VAR y causalidad en sentido de Granger #####


datos <- read.csv("G:/Mi Unidad/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/7. Econometría de Series de Tiempo/Material teórico/Notas de clase/Clase 2/Datos/Excel/soja.csv")

s <- ts(datos$s, frequency = 12, start = c(1979, 1))
plot(s, main = "Precio spot de la soja")

f <- ts(datos$f, frequency = 12, start = c(1979, 1))
plot(f, main = "Precio futuro de la soja")

#Aplicar diferencias logar?tmicas#

ds <- diff(log(s)) * 100
df <- diff(log(f)) * 100
plot(ds, main = "Variaci?n mensual del precio spot de la soja (en %)")
plot(df, main = "Variaci?n mensual del precio futuro de la soja (en %)")

#Buscar el orden apropiado del VAR usando criterios de informaci?n#

install.packages("vars")
library(vars)

y <- cbind(ds, df)
VARselect(y, lag.max = 12, type = "both")

#Estimaci?n del VAR#

modelo <- VAR(y, p = 10, type = "const")
summary(modelo)

#Pruebas de diagn?stico#

serial.test(modelo, lags.pt = 11, type = "PT.asymptotic")
normality.test(modelo, multivariate.only = TRUE)

#Causalidad en sentido de Granger#

grangertest(ds ~ df, order = 10)
grangertest(df ~ ds, order = 10)


##### An?lisis de modelos VAR #####


# datos <- read.csv("C:/var.csv") #("G:/Mi Unidad/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/7. Econometría de Series de Tiempo/Material teórico/Notas de clase/Clase 2/Datos/Excel/var.csv")
data <- ts(datos, frequency = 4, start = c(1960, 1))
plot(data,  main = "Variables en niveles")

#Aplicar diferencias logar?tmicas#

data <- diff(log(data)) * 100
plot(data,  main = "Variables en diferencias")

#Estimaci?n del VAR(2)#

library(vars)
modelo <- VAR(data, p = 2, type = "const")
summary(modelo)

#FIRs 10 pasos adelante#

fir <- irf(modelo, n.ahead = 10, ortho = TRUE, runs = 1000, seed = 12345)
plot(fir)

#DV#

fevd(modelo, n.ahead = 10)


##### Descomposici?n de Choleski #####


datos <- read.csv("G:/Mi Unidad/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/7. Econometría de Series de Tiempo/Material teórico/Notas de clase/Clase 2/Datos/Excel/var.csv")
data <- ts(datos, frequency = 4, start = c(1960, 1))
data <- diff(log(data)) * 100

library(vars)
modelo <- VAR(data, p = 2, type = "const")
modelo_summary <- summary(modelo); modelo_summary
modelo_summary$covres #S?lo reporta matriz de var-cov
modelo_summary$corres #S?lo reporta matriz de correlaciones

#Transformaci?n de Choleski#

t(chol(modelo_summary$covres))
#Se puede ver, por ejemplo, que un shock en invest tiene un efecto contempor?neo en income, pero no al rev?s
#Esta transformaci?n es la que se realiza para analizar las FIR o la DV trabajando con shocks ortogonales
#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#Descomposición de Choleski#

data <- read.csv("C:/Users/Magdalena Cornejo/Dropbox/UNLP/Clase 2/Bases de datos/var.csv")
data <- ts(data, start = c(1960, 1), frequency = 4)
data <- diff(log(data))*100

library(vars)
modelo <- VAR(data, p = 2, type = "const")
modelo_summary <- summary(modelo); modelo_summary
modelo_summary$covres  #sólo reporta matriz de var-cov
model0_summary$corres  #sólo reporta matriz de correlaciones

#Transformación de Choleski:
t(chol(modelo_summary$covres))
#se puede ver, p.ej., que un shock en invest tiene un efecto contemporáneo en income, pero no al revés.
#Esta transformación es la que se realiza para analizar las FIR o DV trabajando con shocks ortogonales.
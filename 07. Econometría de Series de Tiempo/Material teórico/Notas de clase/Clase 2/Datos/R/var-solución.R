#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#Análisis de modelos VAR#
data <- read.csv("C:/Users/Magdalena Cornejo/Dropbox/UNLP/Clase 2/Bases de datos/var.csv")
data <- ts(data, start = c(1960, 1), frequency = 4)

plot(data,  main = "Variables en niveles")

#Aplico diferencias logarítmicas
data <- diff(log(data))*100

plot(data,  main = "Variables en diferencias")

#Estimación del VAR(2)
#install.packages("vars")
library(vars)
modelo <- VAR(data, p = 2, type = "const")
summary(modelo)

#FIRs 10 pasos adelante:
fir <- irf(mfodelo, n.ahead = 10, ortho = TRUE, runs = 1000, seed = 12345)
plot(fir)

#DV:
fevd(modelo, n.ahead=10)
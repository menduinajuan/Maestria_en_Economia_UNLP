#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#Retorno del S&P#

require(timeDate)

datos <- read.csv("C:/Users/Magdalena Cornejo/Dropbox/UNLP/Clase 6/R/^GSPC.csv")
attach(datos)
P <- ts(Adj.Close, start = c(2000, 1,3), end = c(2017, 8,7), frequency = 250)
R <- diff(log(P)*100, diff = 1)
plot.ts(R, main="Retorno diario del S&P500 (en %)")

h<-hist(R, breaks=48, col="red", main="Histograma con Curva Normal")
xfit<-seq(min(R),max(R),length=40)
yfit<-dnorm(xfit,mean=mean(R),sd=sd(R))
yfit <- yfit*diff(h$mids[1:2])*length(R)
lines(xfit, yfit, col="blue", lwd=2)
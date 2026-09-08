#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#Simulación#

library(tseries)

#ruido blanco:
rb <- rnorm(100,mean=0,sd=1)
plot.ts(rb)
hist(rb)

t <- seq(from=1, to=100, by=1)
y <- 5+0.2*t+rb
modelo <- lm(y~t)


#Distintos procesos AR (estacionarios y no estacionarios):

y1 <- arima.sim(model=list(ar=0.8),n=100)
plot.ts(y1, main="AR(1) estacionario")
acf(y1)
pacf(y1)

y2 <- cumsum(rb)
plot.ts(y2, main="Random Walk")
acf(y2)
pacf(y2)

set.seed(15)
n=100
y3=vector(length=100)
for (i in 2:n){
  y3[1]=rb[1]
  y3[i]=1.05*y3[i-1]+rb[i];
}
plot.ts(y3)
acf(y3)
pacf(y3)
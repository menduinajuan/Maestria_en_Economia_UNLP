#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#Simulación de modelos ARMA#

install.packages("boot")
library(boot)

#Simulando procesos MA(1):
y <- 5+arima.sim(n=200, model=list(ma=c(0.5)),rand.gen=function(n, ...) rnorm(n, sd=1))
ts.plot(y)
acf(y,type="correlation",plot=T)

x <- -3+arima.sim(n=200, model=list(ma=c(0.9)),rand.gen=function(n, ...) rnorm(n, sd=1))
ts.plot(x)
acf(x,type="correlation",plot=T)

z <- 9+arima.sim(n=200, model=list(ma=c(-1.2)),rand.gen=function(n, ...) rnorm(n, sd=1))
ts.plot(z)
acf(z,type="correlation",plot=T)

#Simulando procesos AR(1):
y <- arima.sim(n=200, model=list(ar=c(0.1)),rand.gen=function(n, ...) rnorm(n, sd=1))
ts.plot(y)
acf(y,type="correlation",plot=T)

x <- arima.sim(n=200, model=list(ar=c(-0.5)),rand.gen=function(n, ...) rnorm(n, sd=1))
ts.plot(x)
acf(x,type="correlation",plot=T)

z <- arima.sim(n=200, model=list(ar=c(0.95)),rand.gen=function(n, ...) rnorm(n, sd=1))
ts.plot(z)
acf(z,type="correlation",plot=T)

#Simulando procesos ARMA(p,q):
y1 <- arima.sim(n=200, model=list(ar=c(0.8)),rand.gen=function(n, ...) rnorm(n, sd=1))
ts.plot(y1)
acf(y1,type="correlation",plot=T)

y2 <- arima.sim(n=200, model=list(ar=c(0.1,0.5)),rand.gen=function(n, ...) rnorm(n, sd=1))
ts.plot(y2)
acf(y2,type="correlation",plot=T)

y3 <- arima.sim(n=200, model=list(ma=c(0.8)),rand.gen=function(n, ...) rnorm(n, sd=1))
ts.plot(y3)
acf(y3,type="correlation",plot=T)

y4 <- arima.sim(n=200, model=list(ma=c(0.1,-0.4,0.5)),rand.gen=function(n, ...) rnorm(n, sd=1))
ts.plot(y4)
acf(y4,type="correlation",plot=T)

y5 <- arima.sim(n=200, model=list(ar=c(0.5), ma=c(-0.3)),rand.gen=function(n, ...) rnorm(n, sd=1))
ts.plot(y5)
acf(y5,type="correlation",plot=T)

y6 <- arima.sim(n=200, model=list(ar=c(0.5,-0.2), ma=c(-0.3)),rand.gen=function(n, ...) rnorm(n, sd=1))
ts.plot(y6)
acf(y6,type="correlation",plot=T)
#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#Simulación de breaks#

rb <- rnorm(100,mean=0,sd=1)
d <- rep(c(0,1), each=50)

y1 <- 3+5*d+rb
plot.ts(y1)


t <-c(rep(0,50),seq(1,50))
y2 <- 10-0.2*d*t+rb
plot.ts(y2)
  
#Realice el test ADF sobre ambas series:
library(urca)
summary(ur.df(y1,type="trend",selectlags="BIC"))
summary(ur.df(y1,type="drift",selectlags="BIC"))

summary(ur.df(y2,type="trend",selectlags="BIC"))
summary(ur.df(y2,type="drift",selectlags="BIC"))
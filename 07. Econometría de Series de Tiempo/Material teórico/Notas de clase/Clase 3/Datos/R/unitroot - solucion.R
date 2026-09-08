#Magdalena Cornejo#
#UNLP 2019 - Econometría de Series de Tiempo#
#UNIT ROOT TESTS#

library(tseries)
library(urca)

#ADF Test:

datos <- read.csv("C:/Users/Magdalena Cornejo/Dropbox/UNLP/Clase 3/R/term.csv")
attach(datos)

r<-ts(r)
plot(r, main="Difference between 180-day 90-day bank rates, %.")

df1<- ur.df(r,type="none",selectlags="BIC")
summary(df1)
df2<-ur.df(r,type="drift",selectlags="BIC")
summary(df2)
df3<-ur.df(r,type="trend",selectlags="BIC")
summary(df3)


datos <- read.csv("C:/Users/Magdalena Cornejo/Dropbox/UNLP/Clase 3/R/soja.csv")
attach(datos)

s<-ts(log(s), frequency=12, start=c(1979,5))
plot(s, main="Precio spot de la soja en Chicago (en logs)")

summary(ur.df(s,type="trend",selectlags="BIC"))

ds <- diff(s,differences=1)*100
plot(ds, main="Variación del precio spot de la soja en Chicago (en %)")
summary(ur.df(ds,type="drift",selectlags="BIC"))
#entonces, s es I(1) ya que ds es I(0)

datos <- read.csv("C:/Users/Magdalena Cornejo/Dropbox/UNLP/Clase 3/R/ipc.csv")
attach(datos)

ipc<-ts(log(ipc), frequency=12, start=c(2016,12))
plot(ipc, main="IPC cobertura nacional (en logs)")
summary(ur.df(ipc,type="trend",selectlags="BIC"))

infla <- diff(ipc,differences = 1)*100
plot(infla, main="Inflación mensual cobertura nacional (en %)")
summary(ur.df(infla,type="trend",selectlags="BIC"))
summary(ur.df(infla,type="drift",selectlags="BIC"))

dinfla <- diff(infla,differences = 1)*100
plot(dinfla, main="Tasa de aceleración de la inflación mensual cobertura nacional (en %)")
summary(ur.df(dinfla,type="drift",selectlags="BIC"))
#Entonces, el IPC es I(2), la inflación es I(1) y la tasa de aceleración es I(0)

#PP Test:
summary(ur.pp(r,model="constant",lags="short"))
summary(ur.pp(s,model="trend",lags="short"))
summary(ur.pp(ds,model="constant",lags="short"))
summary(ur.pp(infla,model="trend",lags="short"))
summary(ur.pp(dinfla,model="constant",lags="short"))

#KPPS Test:
summary(ur.kpss(r,type="mu",lags="short"))
summary(ur.kpss(s,type="tau",lags="short"))
summary(ur.kpss(ipc,type="tau",lags="short"))
summary(ur.kpss(infla,type="tau",lags="short"))
summary(ur.kpss(dinfla,type="mu",lags="short"))
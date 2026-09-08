close all;
var  k n i lambda c w h y q f m v  a LabProd LabShare TotHours;
predetermined_variables k n;
varexo  epsia;          

parameters beta e s alpha xi nu sigma epsilon delta nss qss hss ess rho mss fss thetass vss chi kss iss yss kappavsy kappa css lambdass 
eta1 wss eta2 b;


beta=0.99;
epsilon=2;

alpha=0.36;
delta=0.025;
s=0.15;
nu=0.6;
xi=1-nu;
rho=0.95; 
kappavsy=0.01;
nss=0.57;
hss=0.33;
ess=0.5*hss;
qss=0.9;
mss=s*nss;
vss=mss/qss;
fss=mss/(1-nss);
b=0.0;
chi=mss/(vss^nu*(ess*(1-nss))^(1-nu));
kss=((1/beta-1+delta)/(alpha*(hss*nss)^(1-alpha)))^(1/(alpha-1));
yss=kss^alpha*(hss*nss)^(1-alpha);
kappavss=kappavsy*yss;
kappa=kappavss/vss;
iss=delta*kss;
css=yss-iss-kappavss;
lambdass=1/css;
eta1=lambdass*(1-alpha)*yss/(nss*hss)/((1-hss)^(-epsilon));
csy=css/yss;
ksy=kss/yss;
whss=(1-alpha)*yss/nss+(1-s)*kappa/qss-1/beta*kappa/qss;
wss=whss/hss;
eta2=(whss-xi*((1-alpha)*yss/nss+fss*kappa/qss)+(1-xi)*(1/lambdass*eta1*(1-hss)^(1-epsilon)/(1-epsilon)-b))*lambdass*(1-epsilon)/(1-xi)/(1-ess)^(1-epsilon);
e=ess;

model; 
exp(k(+1))=(1-delta)*exp(k)+exp(i);
exp(n(+1))=(1-s)*exp(n)+exp(m);
1=beta*exp(lambda(+1))/exp(lambda)*(alpha*exp(y(+1))/exp(k(+1))+(1-delta));
kappa/exp(q)=beta*exp(lambda(+1))/exp(lambda)*((1-alpha)*exp(y(+1))/exp(n(+1))-exp(w(+1))*exp(h(+1))+(1-s)*kappa/exp(q(+1)));
exp(lambda)=1/exp(c);
exp(w)*exp(h)=xi*((1-alpha)*exp(y)/exp(n)+exp(f)*kappa/exp(q))+(1-xi)*((eta2*(1-e)^(1-epsilon)/(1-epsilon)-eta1*(1-exp(h))^(1-epsilon)/(1-epsilon))/exp(lambda)+b);
exp(y)=exp(k)^(alpha)*(exp(a)*exp(h)*exp(n))^(1-alpha);
exp(lambda)*(1-alpha)*exp(y)/(exp(n)*exp(h))=eta1*(1-exp(h))^(-epsilon);
exp(c)=exp(y)-exp(i)-kappa*exp(v);
exp(q)=exp(m)/exp(v);
exp(f)=exp(m)/(1-exp(n));
exp(m)=chi*exp(v)^nu*(e*(1-exp(n)))^(1-nu);
a=rho*a(-1)+epsia;
exp(LabProd)=exp(y)/(exp(n)*exp(h));
exp(LabShare)=exp(w)*exp(h)*exp(n)/exp(y);
exp(TotHours)=exp(n)*exp(h);
end; 


initval;
k=log(kss);
n=log(nss);
i=log(iss);
lambda=log(lambdass);
c=log(css);
w=log(wss);
h=log(hss);
y=log(yss);
q=log(qss);
m=log(mss); 
v=log(vss);
f=log(fss);
LabProd=log(exp(y)/(exp(n)*exp(h)));
LabShare=log(exp(w)*exp(h)*exp(n)/exp(y));
TotHours=log(exp(n)*exp(h));
end;
 
shocks;
var epsia=0.0145^2;
end; 

resid
check;

steady; 

% return

stoch_simul(order=1,irf=30,periods=0,hp_filter=1600);

close all;
var  V1t V2t Kc1t Kc2t N1t N2t Y1t Y2t Cc1t Cc2t lambda1t lambda2t Pc1t Pc2t h1t h2t 
W1t W2t P1t P2t mu1t mu2t xi1t xi2t m1t m2t q1t q2t Ic1t Ic2t Yb1t Yb2t lnV1t lnV2t
a1t a2t  LabProd1 LabProd2 TotHours1 TotHours2 lnTotHours1 lnTotHours2 LabShare1 LabShare2 lnYb1t lnYb2t lnN1t lnN2t lnIc1t lnIc2t lnCc1t lnCc2t;
 
predetermined_variables Kc1t Kc2t N1t N2t ;
varexo  epsiaa epsibb ;          

parameters beta eta gamma theta alpha delta s Phi epsilon phi A1 A2 rhoa rhoas
sigmaa psi omega1V1sY1 omega2V2sY2 N1s N2s e1 m1s h2s e2 m2s V1s V2s mu1s mu2s
Xi P1s P2s Pc1s Pc2s Y1sKc1 Kc1s  Y1s Y2sKc2 Kc2sh2N2 Kc2s Y2s Ic1s Ic2s
omega1 omega2 Yb1s Yb2s Cc1s Cc2s lambda1s lambda2s sigman xi1s xi2s W1s W2s
sigmau q2s gg;

beta=0.99;
eta=5;
gamma=0.85;
theta=1.5;
alpha=0.65;
delta=0.025;
s=0.1;
Phi=1.63;
epsilon=0.6;
phi=epsilon;
A1=1;
A2=1;
rhoa=0.906;
rhoas=0.088;
sigmaa=0.00852;
psi=0.133;
omega1V1sY1=0.01;
omega2V2sY2=0.01;
N1s=0.57;
h1s=1/3;
e1=0.5*h1s;
m1s=0.90;
N2s=0.57;
h2s=1/3;
e2=0.5*h2s;
m2s=0.90;
V1s=s*N1s/m1s;
V2s=s*N2s/m2s;
mu1s=V1s/(e1*(1-N1s));
mu2s=V2s/(e2*(1-N2s));
Xi=m1s/mu1s^(phi-1);
P1s=1;
P2s=1;
Pc1s=1;
Pc2s=1;
Y1sKc1=(1/beta-(1-delta))/(1-alpha);
Kc1sh1N1=(1/A1*Y1sKc1)^(-1/alpha);
Kc1s=Kc1sh1N1*h1s*N1s;
Y1s=Y1sKc1*Kc1s;
Y2sKc2=(1/beta-(1-delta))/(1-alpha);
Kc2sh2N2=(1/A2*Y2sKc2)^(-1/alpha);
Kc2s=Kc2sh2N2*h2s*N2s;
Y2s=Y2sKc2*Kc2s;
Ic1s=delta*Kc1s;
Ic2s=delta*Kc2s;
omega1=omega1V1sY1*Y1s/V1s;
omega2=omega2V2sY2*Y2s/V2s;
Yb1s=Y1s-omega1*V1s;
Yb2s=Y2s-omega2*V2s;
Cc1s=Yb1s-Ic1s;
Cc2s=Yb2s-Ic2s;
lambda1s=1/(Cc1s*Pc1s);
lambda2s=1/(Cc2s*Pc2s);
sigman=alpha*Y1s/(h1s*N1s)*P1s*lambda1s/(1-h1s)^(-eta);
xi1s=P1s*omega1/m1s;
xi2s=P2s*omega2/m2s;
W1s=((1-s)*xi1s-xi1s/beta+P1s*alpha*Y1s/(h1s*N1s)*h1s)/h1s;
W2s=((1-s)*xi2s-xi2s/beta+P2s*alpha*Y2s/(h2s*N2s)*h2s)/h2s;
sigmau=(lambda1s*W1s*h1s-(1-epsilon)*lambda1s*(P1s*alpha*Y1s/(h1s*N1s)*h1s+P1s*e1*mu1s*omega1)+epsilon*sigman*(1-h1s)^(1-eta)/(1-eta))*(1-eta)/((1-e1)^(1-eta)*epsilon);
q1s=Pc1s;
q2s=Pc2s;
gg=0.133;

model; 
    -Kc1t(+1)+(1-delta)*Kc1t+Ic1t=0;
    -N1t(+1)+(1-s)*N1t+m1t*V1t=0;
    -Kc2t(+1)+(1-delta)*Kc2t+Ic2t=0;
    -N2t(+1)+(1-s)*N2t+m2t*V2t=0;
    -Y1t+exp(a1t)*Kc1t^(1-alpha)*(h1t*N1t)^alpha=0;
    -1/Cc1t+lambda1t*Pc1t=0;
     alpha*Y1t/(h1t*N1t)-sigman*(1-h1t)^(-eta)/(P1t*lambda1t)=0;
    -W1t*h1t+epsilon*(sigmau*(1-e1)^(1-eta)/(1-eta)-sigman*(1-h1t)^(1-eta)/(1-eta))/lambda1t+(1-epsilon)*(P1t*alpha*Y1t/(h1t*N1t)*h1t+P1t*e1*mu1t*omega1)=0;
    -xi1t*lambda1t+beta*lambda1t(+1)*(P1t(+1)*alpha*Y1t(+1)/(h1t(+1)*N1t(+1))*h1t(+1)-W1t(+1)*h1t(+1)+(1-s)*xi1t(+1))=0;
    -P1t*omega1+xi1t*m1t=0;
    -q1t*lambda1t+beta*lambda1t(+1)*(P1t(+1)*(1-alpha)*Y1t(+1)/Kc1t(+1)+P1t(+1)*Phi/2*(Ic1t(+1)-delta*Kc1t(+1))^2/Kc1t(+1)^2+P1t(+1)*Phi*delta*(Ic1t(+1)-delta*Kc1t(+1))/Kc1t(+1)+(1-delta)*q1t(+1))=0;
    -q1t+Pc1t+P1t*Phi*(Ic1t-delta*Kc1t)/Kc1t=0;
    -m1t+Xi*mu1t^(phi-1)=0;
    -mu1t+V1t/(e1*(1-N1t))=0;
    -Y2t+exp(a2t)*Kc2t^(1-alpha)*(h2t*N2t)^alpha=0;
    -1/Cc2t+lambda2t*Pc2t=0;
    alpha*Y2t/(h2t*N2t)-sigman*(1-h2t)^(-eta)/(P2t*lambda2t)=0;
    -W2t*h2t+epsilon*(sigmau*(1-e2)^(1-eta)/(1-eta)-sigman*(1-h2t)^(1-eta)/(1-eta))/lambda2t+(1-epsilon)*(P2t*alpha*Y2t/(h2t*N2t)*h2t+P2t*e2*mu2t*omega2)=0;
    -xi2t*lambda2t+beta*lambda2t(+1)*(P2t(+1)*alpha*Y2t(+1)/(h2t(+1)*N2t(+1))*h2t(+1)-W2t(+1)*h2t(+1)+(1-s)*xi2t(+1))=0;
    -P2t*omega2+xi2t*m2t=0;
    -q2t*lambda2t+beta*lambda2t(+1)*(P2t(+1)*(1-alpha)*Y2t(+1)/Kc2t(+1)+P2t(+1)*Phi/2*(Ic2t(+1)-delta*Kc2t(+1))^2/Kc2t(+1)^2+P2t(+1)*Phi*delta*(Ic2t(+1)-delta*Kc2t(+1))/Kc2t(+1)+(1-delta)*q2t(+1))=0;
    -q2t+Pc2t+P2t*Phi*(Ic2t-delta*Kc2t)/Kc2t=0;
    -m2t+Xi*mu2t^(phi-1)=0;
    -mu2t+V2t/(e2*(1-N2t))=0;
    -Yb1t+Y1t-Phi/2*(Ic1t-delta*Kc1t)^2/Kc1t-omega1*V1t=0;
    -Yb2t+Y2t-Phi/2*(Ic2t-delta*Kc2t)^2/Kc2t-omega2*V2t=0;
    -Pc1t^(1-theta)+gamma*P1t^(1-theta)+(1-gamma)*P2t^(1-theta)=0;
    -Pc2t^(1-theta)+gamma*P2t^(1-theta)+(1-gamma)*P1t^(1-theta)=0;
    -Yb1t+gamma*(P1t/Pc1t)^(-theta)*(Cc1t+Ic1t)+(1-gamma)*(P1t/Pc2t)^(-theta)*(Cc2t+Ic2t)=0;
    -Yb2t+gamma*(P2t/Pc2t)^(-theta)*(Cc2t+Ic2t)+(1-gamma)*(P2t/Pc1t)^(-theta)*(Cc1t+Ic1t)=0;
    -lambda1t+lambda2t=0;
    P1t-1=0;
    a1t=rhoa*(a1t(-1))+rhoas*(a2t(-1))+epsiaa+gg*epsibb;
    a2t=rhoa*(a2t(-1))+rhoas*(a1t(-1))+epsibb+gg*epsiaa;
    LabProd1=Y1t/(N1t*h1t);
    LabShare1=W1t*h1t*N1t/Y1t;
    TotHours1=N1t*h1t;
    LabProd2=Y2t/(N2t*h2t);
    LabShare2=W2t*h2t*N2t/Y2t;
    TotHours2=N2t*h2t;
    lnYb1t=log(Yb1t);
    lnYb2t=log(Yb2t);
    lnN1t=log(N1t);
    lnN2t=log(N2t);
    lnIc1t=log(Ic1t);
    lnIc2t=log(Ic2t);
    lnCc1t=log(Cc1t);
    lnCc2t=log(Cc2t);
    lnV1t=log(V1t);
    lnV2t=log(V2t);
    lnTotHours1=log(TotHours1);
    lnTotHours2=log(TotHours2);
end; 


initval;
Kc1t	=	Kc1s;
N1t	    =	N1s	;
Y1t   	=	Y1s	;
Cc1t	=	Cc1s;
lambda1t=	lambda1s;
Pc1t	=	Pc1s;
h1t 	=	h1s;
W1t 	=	W1s;
P1t 	=	P1s;
mu1t	=	mu1s;
xi1t	=	xi1s;
m1t	    =	m1s	;
q1t	    =	q1s	;
Ic1t	=	Ic1s;
V1t 	=	V1s	;
Yb1t	=	Yb1s;
Kc2t	=	Kc2s;
N2t 	=	N2s	;
Y2t 	=	Y2s	;
Cc2t	=	Cc2s;
lambda2t=	lambda2s;
Pc2t	=	Pc2s;
h2t 	=	h2s	;
W2t 	=	W2s	;
P2t 	=	P2s	;
mu2t	=	mu2s;
xi2t	=	xi2s;
m2t 	=	m2s	;
q2t 	=	q2s	;
Ic2t  	=	Ic2s;
V2t 	=	V2s	;
Yb2t	=	Yb2s;
LabProd1=Y1s/(N1s*h1s);
LabShare1=W1s*h1s*N1s/Y1s;
TotHours1=N1s*h1s;
LabProd2=Y2s/(N2s*h2s);
LabShare2=W2s*h2s*N2s/Y2s;
TotHours2=N2s*h2s;
lnYb1t=log(Yb1t);
lnYb2t=log(Yb2t);
lnN1t=log(N1t);
lnN2t=log(N2t);
lnIc1t=log(Ic1t);
lnIc2t=log(Ic2t);
lnCc1t=log(Cc1t);
lnCc2t=log(Cc2t);
lnV1t=log(V1t);
lnV2t=log(V2t);
lnTotHours1=log(TotHours1);
lnTotHours2=log(TotHours2);
end;
 
shocks;
var epsiaa=0.00852^2;
var epsibb=0.00852^2;
end; 

resid

steady; 

check;

stoch_simul(order=1,irf=40,hp_filter=1600,periods=0) lnN1t lnN2t lnTotHours1 lnTotHours2  
lnV1t lnV2t lnIc1t lnIc2t lnYb1t lnYb2t lnCc1t lnCc2t LabShare1 LabShare2 ;

%% irfs percent deviation
% Ic1=oo_.irfs.Ic1t_epsiaa;
% Ic2=oo_.irfs.Ic2t_epsiaa;
% tmg=1:length(Ic1);
% plot(tmg,Ic1/Ic1s*100,tmg,Ic2/Ic2s*100),grid;
    
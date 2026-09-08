% Modelo SOE-RBC (basado en Mendoza 1991 y Uribe-SG 2018) 
% 
% Danilo Trupkin
% 2018

%----------------------------------------------------------------
% 1. Definiendo variables y parametros
%----------------------------------------------------------------

var y c k i l A y_l r w d tb ca;
varexo e;
parameters alpha delta rho omega beta phi psi dbar rstar sigma sigmae;

%----------------------------------------------------------------
% 2. Calibracion
%----------------------------------------------------------------

alpha  = 0.32;
delta  = .1;
rho  = 0.42;
sigma = 2;
sigmae  = 0.0129; 
rstar = .04;
beta   = 1/(1+rstar);
omega = 1.455;
phi = .08;
dbar = 0.7442;
psi = 0.000742;

%----------------------------------------------------------------
% 3. Modelo
%----------------------------------------------------------------

model;
  l^(omega-1) = (1-alpha)*(y/l);

  (c-(l^omega)/omega)^(-sigma) = beta*((c(1)-(l(1)^omega)/omega)^(-sigma))*(alpha*(y(+1)/k)+1-delta+phi*(k(1)-k))/(1+phi*(k-k(-1)));

(c-(l^omega)/omega)^(-sigma) = beta*((c(1)-(l(1)^omega)/omega)^(-sigma))*
(1+rstar+psi*(exp(d-dbar)-1));
 
 c+i+(phi/2)*(k-k(-1))^2+(1+rstar+psi*(exp(d(-1)-dbar)-1))*d(-1) = y+d;
  y = A*(k(-1)^alpha)*(l^(1-alpha));
  k = i+(1-delta)*k(-1);
  log(A) = rho*log(A(-1))+e;
 tb = 100*(y-c-i-(phi/2)*(k-k(-1))^2);
 ca = tb-(rstar+psi*(exp(d(-1)-dbar)-1))*d(-1);
  y_l = y/l;
  r = rstar+psi*(exp(d(-1)-dbar)-1);
  w = (1-alpha)*(y/l);
end;

%----------------------------------------------------------------
% 4. Computacion
%----------------------------------------------------------------

initval;
  k = 5;
  c = 1.12;
  l = 1.0074;
  d = 0.7442;
  A = 1; 
  e = 0;
end;

shocks;
var e = sigmae^2;
end;

%resid

steady;

%check;

stoch_simul(order = 1, irf = 10);

%----------------------------------------------------------------
% 5. Resultados
%----------------------------------------------------------------

statistic1 = 100*sqrt(diag(oo_.var(1:12,1:12)))./oo_.mean(1:12);
dyntable(options_,'Relative standard deviations in %',strvcat('VARIABLE','REL. S.D.'),M_.endo_names(1:12,:),statistic1,10,8,4);

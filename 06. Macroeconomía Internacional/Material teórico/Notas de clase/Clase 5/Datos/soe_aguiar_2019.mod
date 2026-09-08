% Modelo SOE para paises emergentes I (basado en Aguiar y Gopinath 2007) 
% 
% Danilo Trupkin
% 2019

%----------------------------------------------------------------
% 1. Definiendo variables y parametros
%----------------------------------------------------------------

var y c k i h a g r d tb;
varexo ea eg;
parameters alpha delta rhoa rhog gamma beta phi psi dbar rstar gbar sigma sigmaa sigmag;

%----------------------------------------------------------------
% 2. Calibracion
%----------------------------------------------------------------

alpha  = 0.32;
delta  = .05;
rhoa  = 0.95;
rhog  = 0.05;
sigma = 2;
sigmaa  = 0.005; 
sigmag  = 0.025;
gbar = 1.0066;
gamma = .36;
beta   = .98;
rstar = 1/(beta*(gbar^(gamma*(1-sigma)-1)))-1;
phi = 1.37; 
dbar = .1;
psi = 0.001;

%----------------------------------------------------------------
% 3. Modelo
%----------------------------------------------------------------

model;
((1-gamma)/gamma)*(c/(1-h)) = (1-alpha)*a*g*((k(-1)/(g*h))^alpha);

gamma*(c^(gamma*(1-sigma)-1))*((1-h)^((1-gamma)*(1-sigma))) = beta*(1+r)*(g^(gamma*(1-sigma)-1))*
gamma*(c(1)^(gamma*(1-sigma)-1))*((1-h(1))^((1-gamma)*(1-sigma)));

gamma*(c^(gamma*(1-sigma)-1))*((1-h)^((1-gamma)*(1-sigma)))*(1+phi*(g*k/k(-1)-gbar)) = 
beta*(g^(gamma*(1-sigma)-1))*gamma*(c(1)^(gamma*(1-sigma)-1))*((1-h(1))^((1-gamma)*(1-sigma)))*
(1-delta+alpha*a(1)*((k/(g(1)*h(1)))^(alpha-1))+phi*(g(1)*k(1)/k)*(g(1)*k(1)/k-gbar)-(phi/2)*((g(1)*k(1)/k-gbar)^2));

  c+k*g-(1-delta)*k(-1)+(phi/2)*k(-1)*((k*g/k(-1)-gbar)^2)+d(-1) = y+d*g/(1+r);

 r = rstar+psi*(exp(d-dbar)-1);

  y = a*(k(-1)^alpha)*((g*h)^(1-alpha));

  log(a) = rhoa*log(a(-1))+ea;

  log(g/gbar) = rhog*log(g(-1)/gbar)+eg;

  tb = d(-1)-d*g/(1+r);

  i = k*g-k(-1)*(1-delta);

end;



%----------------------------------------------------------------
% 4. Computacion
%----------------------------------------------------------------

initval;
  k = 3;
  c = .5;
  h = .36;
  d = .1;
  a = 1;
  g = 1.0066; 
  ea = 0;
  eg = 0;
end;

shocks;
var ea = sigmaa^2;
var eg = sigmag^2;
end;

%resid

steady; 

%check;

stoch_simul(hp_filter = 1600, order = 1, irf = 40);

%
%----------------------------------------------------------------
% 5. Resultados
%----------------------------------------------------------------


% Tabla de D.S. % (sintaxis para version 4.5) 
statistic1 = 100*sqrt(diag(oo_.var(1:10,1:10)))./oo_.mean(1:10);
dyntable(options_,'Relative standard deviations in %',strvcat('VARIABLE','REL. S.D.'),M_.endo_names(1:10,:),statistic1,10,8,4);
sigmac_sigmay = statistic1(2)/statistic1(1)
sigmai_sigmay = statistic1(4)/statistic1(1)


% Tabla de D.S. % (sintaxis para version 4.4.3) 
%statistic1 = 100*sqrt(diag(oo_.var(1:10,1:10)))./oo_.mean(1:10);
%dyntable('Relative standard deviations in %',strvcat('VARIABLE','REL. S.D.'),M_.endo_names(1:10,:),statistic1,10,8,4);

% Tabla de D.S. % (sintaxis para version 3) 
%statistic1 = 100*sqrt(diag(oo_.var(1:10,1:10)))./oo_.mean(1:10);
%table('Relative standard deviations in %',strvcat('VARIABLE','REL. S.D.'),lgy_(1:10,:),statistic1,10,8,4);
% Modelo standard RBC (basado en Cooley-Prescott, 1995) 
% 
% Danilo Trupkin
% 2018

%----------------------------------------------------------------
% 1. Definiendo variables y parametros
%----------------------------------------------------------------

var y c k i l A y_l r w;
varexo e;
parameters alpha delta rho theta gamma beta;

%----------------------------------------------------------------
% 2. Calibracion
%----------------------------------------------------------------

% Tecnologia
alpha  = 0.36;
delta  = .02;
rho    = 0.95;
theta = 0.008; 

% Preferencias
beta   = 0.99;
gamma  = 0.37;

%----------------------------------------------------------------
% 3. Modelo
%----------------------------------------------------------------

model;
  (1-alpha)*(y/l) = ((1-gamma)/gamma)*(c/(1-l));
  (1/c) = beta*(1/c(+1))*(alpha*(y(+1)/k)+1-delta);
  c+i = y;
  y = A*(k(-1)^alpha)*(l^(1-alpha));
  k = i+(1-delta)*k(-1);
  log(A) = rho*log(A(-1))+e;
  y_l = y/l;
  r = alpha*(y/k(-1))-delta;
  w = (1-alpha)*(y/l);
end;

%----------------------------------------------------------------
% 4. Computacion
%----------------------------------------------------------------

initval;
  k = 16;
  c = 1;
  l = 0.33;
  A = 1; 
  e = 0;
end;

shocks;
var e = theta^2;
end;

steady;

stoch_simul(hp_filter = 1600, order = 1, irf = 40);

%----------------------------------------------------------------
% 5. Resultados
%----------------------------------------------------------------

% Tabla de D.S. % (sintaxis para version 4.5) 
statistic1 = 100*sqrt(diag(oo_.var(1:9,1:9)))./oo_.mean(1:9);
dyntable(options_,'Relative standard deviations in %',strvcat('VARIABLE','REL. S.D.'),M_.endo_names(1:9,:),statistic1,10,8,4);

% Tabla de D.S. % (sintaxis para version 4.4.3) 
%statistic1 = 100*sqrt(diag(oo_.var(1:9,1:9)))./oo_.mean(1:9);
%dyntable('Relative standard deviations in %',strvcat('VARIABLE','REL. S.D.'),M_.endo_names(1:9,:),statistic1,10,8,4);

% Tabla de D.S. % (sintaxis para version 3) 
%statistic1 = 100*sqrt(diag(oo_.var(1:9,1:9)))./oo_.mean(1:9);
%table('Relative standard deviations in %',strvcat('VARIABLE','REL. S.D.'),lgy_(1:9,:),statistic1,10,8,4);
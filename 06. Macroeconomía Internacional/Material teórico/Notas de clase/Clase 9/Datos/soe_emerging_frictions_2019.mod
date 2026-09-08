% Modelo SOE para paises emergentes II (basado en Garcia-Cicco, Pancrazi y Uribe 2010) 
% 
% Danilo Trupkin
% 2019

%----------------------------------------------------------------
% 1. Definiendo variables y parametros
%----------------------------------------------------------------

var y c k l d i r a g nu mu s tb;
varexo ea eg enu emu es;
parameters alpha delta sigma beta omega phi eta psi dbar rstar gbar ybar sbar rhoa rhog rhonu rhomu rhos sigmaa sigmag sigmanu sigmamu sigmas;

%----------------------------------------------------------------
% 2. Calibracion
%----------------------------------------------------------------

alpha  = 0.32;
delta  = .1255;
beta   = .9286;
omega = 1.6;
sigma = 2;
phi = 5.6;
dbar = 0.037;
psi = 1.3;
gbar = 1.0107;
rstar = (gbar^sigma)/beta-1;
eta = 0.42;
ybar = .788;
sbar = .0788;
rhoa  = 0.84;
rhog  = 0.15;
rhomu  = 0.91;
rhonu  = 0.84;
rhos  = 0.46;
sigmaa  = 0.032; 
sigmag  = 0.0067;
sigmamu  = 0.11;
sigmanu  = 0.51;
sigmas  = 0.062;

%Standard values:
%alpha  = 0.32;
%delta  = .1255;
%beta   = .9286;
%omega = 1.6;
%sigma = 2;
%phi = 5.6;
%dbar = 0.03;
%psi = 1.3;
%gbar = 1.0107;
%rstar = (gbar^sigma)/beta-1;
%eta = 0.42;
%ybar = .788;
%sbar = .0788;
%rhoa  = 0.84;
%rhog  = 0.21;
%rhomu  = 0.91;
%rhoa  = 0.84;
%rhog  = 0.21;
%rhomu  = 0.91;
%rhonu  = 0.85;
%rhos  = 0.46;
%sigmaa  = 0.032; 
%sigmag  = 0.0067;
%sigmamu  = 0.11;
%sigmanu  = 0.51;
%sigmas  = 0.064;

%----------------------------------------------------------------
% 3. Modelo
%----------------------------------------------------------------

model;
 l^(omega-1) = (1-alpha)*a*(g^(1-alpha))*((k(-1)/l)^alpha)/(1+eta*r/(1+r));

 nu*((c-(l^omega)/omega)^(-sigma)) = (beta/(g^sigma))*(1+r)*(nu*(c(1)-(l(1)^omega)/omega)^(-sigma));

 (nu*(c-(l^omega)/omega)^(-sigma))*(1+phi*(g*k/k(-1)-gbar)) = (beta/(g^sigma))*(nu(1)*(c(1)-(l(1)^omega)/omega)^(-sigma))*
 (1-delta+alpha*a(1)*((k/(g(1)*l(1)))^(alpha-1))+phi*(g(1)*k(1)/k)*(g(1)*k(1)/k-gbar)-(phi/2)*(g(1)*k(1)/k-gbar)^2);

  c+i+(phi/2)*k(-1)*((k*g/k(-1)-gbar)^2)+s+d(-1) = y+d*g/(1+r);

  tb = y-c-i-(phi/2)*k(-1)*((k*g/k(-1)-gbar)^2)-s;

  k*g = i+(1-delta)*k(-1);

  r = rstar+psi*(exp((d-dbar)/ybar)-1)+exp(mu-1)-1;

  y = a*(k(-1)^alpha)*((g*l)^(1-alpha));

  log(a) = rhoa*log(a(-1))+ea;

  log(g/gbar) = rhog*log(g(-1)/gbar)+eg;

  log(s/sbar) = rhos*log(s(-1)/sbar)+es;

  log(nu) = rhonu*log(nu(-1))+enu;

  log(mu) = rhomu*log(mu(-1))+emu;
end;

%----------------------------------------------------------------
% 4. Computacion
%----------------------------------------------------------------

initval;
  k = 3;
  c = .7;
  l = .3;
  d = .037;
  a = 1;
  g = 1.0107; 
  mu = 1;
  nu = 1;
  s = .1;
  ea = 0;
  eg = 0;
  emu = 0;
  enu = 0;
  es = 0;
end;

shocks;
var ea = sigmaa^2;
var eg = sigmag^2;
var emu = sigmamu^2;
var enu = sigmanu^2;
var es = sigmas^2;
end;

%resid

steady;

%check;

stoch_simul(hp_filter = 100, order = 1, irf = 10);

%
%----------------------------------------------------------------
% 5. Resultados
%----------------------------------------------------------------

statistic1 = 100*sqrt(diag(oo_.var(1:13,1:13)))./oo_.mean(1:13);
dyntable(options_,'Relative standard deviations in %',strvcat('VARIABLE','REL. S.D.'),M_.endo_names(1:13,:),statistic1,10,8,4);

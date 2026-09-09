%*************************************************************************%
% 1. VARIABLES Y PARÁMETROS %
%*************************************************************************%


var        k y c I N n e w A;
varexo     eps;
parameters alpha beta delta eta tau a b gamma sd_eps
           k_bar y_bar c_bar I_bar N_bar n_bar e_bar w_bar A_bar
           lk_bar ly_bar lc_bar lI_bar lN_bar ln_bar le_bar lw_bar lA_bar;


%*************************************************************************%
% 2. CALIBRACIÓN %
%*************************************************************************%


alpha  = 0.36;
beta   = 0.99;
delta  = 0.025;
eta    = 0.95;
tau    = 0.62;
a      = 6;
b      = 0.87;
gamma  = 1;
sd_eps = 0.825;


%*************************************************************************%
% 3. VALORES INICIALES (en niveles) %
%*************************************************************************%


k_bar = 10;
y_bar = 1;
c_bar = 0.8;
I_bar = 0.2;
N_bar = 0.25;
n_bar = 0.5;
e_bar = 0.5;
w_bar = 2;
A_bar = 1;


%*************************************************************************%
% 4. VALORES INICIALES (en logaritmos) %
%*************************************************************************%


lk_bar = log(k_bar);
ly_bar = log(y_bar);
lc_bar = log(c_bar);
lI_bar = log(I_bar);
lN_bar = log(N_bar);
ln_bar = log(n_bar);
le_bar = log(e_bar);
lw_bar = log(w_bar);
lA_bar = log(A_bar);


%*************************************************************************%
% 5. MODELO %
%*************************************************************************%


model;

  exp(y)   = exp(A)*exp(k(-1))^(alpha)*exp(N)^(1-alpha);
  exp(y)   = exp(c)+exp(I);
  exp(N)   = exp(n)*exp(e);
  exp(I)   = exp(k)-(1-delta)*exp(k(-1));
  exp(w)   = (1-alpha)*exp(y)/exp(N);
  exp(w)   = a*exp(c)*exp(n)^(gamma);
  exp(e)   = (a*gamma*exp(n)^(1+gamma)/(b*(1+gamma)))^(1/tau);
  1/exp(c) = beta*(1/exp(c(+1))*(1-delta+alpha*exp(y(+1))/exp(k)));
  A        = (1-eta)*lA_bar+eta*A(-1)+eps;

end;


%*************************************************************************%
% 6. COMPUTACIÓN %
%*************************************************************************%


initval;

  k = lk_bar;
  y = ly_bar;
  c = lc_bar;
  I = lI_bar;
  N = lN_bar;
  n = ln_bar;
  e = le_bar;
  w = lw_bar;
  A = lA_bar;

end;

shocks;
  var eps = sd_eps^2;
end;

steady;


%*************************************************************************%
% 7. RESULTADOS %
%*************************************************************************%


stoch_simul(order = 1, hp_filter = 1600, irf = 100) k y c I N n e w A;
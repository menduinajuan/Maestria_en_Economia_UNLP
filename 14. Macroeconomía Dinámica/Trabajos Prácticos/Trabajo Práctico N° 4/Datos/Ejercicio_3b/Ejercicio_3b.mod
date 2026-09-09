% MODELO DINERO EN LA FUNCIÓN DE UTILIDAD (sin rigideces de precios)


%*************************************************************************%
% 1. VARIABLES Y PARÁMETROS %
%*************************************************************************%


var        K M Y C I H r w i pi mu Z G;
varexo     e xi;
parameters theta beta B delta gamma phi a sd_e sd_xi
           K_bar M_bar Y_bar C_bar I_bar H_bar r_bar w_bar i_bar pi_bar mu_bar Z_bar G_bar KH_bar
           lK_bar lM_bar lY_bar lC_bar lI_bar lH_bar lr_bar lw_bar li_bar lpi_bar lmu_bar lZ_bar lG_bar;


%*************************************************************************%
% 2. CALIBRACIÓN %
%*************************************************************************%


theta = 0.36;
beta  = 0.99;
B     = 2.5805;
delta = 0.025;
gamma = 0.95;
phi   = 0.48;
a     = 0.01;
sd_e  = 0.721;
sd_xi = 0.1;


%*************************************************************************%
% 3. ESTADO ESTACIONARIO (en niveles) %
%*************************************************************************%


G_bar  = 0.0087;
Z_bar  = 1;
r_bar  = 1/beta+delta-1;
KH_bar = (theta*Z_bar/r_bar)^(1/(1-theta));
w_bar  = (1-theta)*Z_bar*(KH_bar)^(theta);
C_bar  = w_bar/B;
K_bar  = theta*(C_bar+G_bar)/(r_bar-theta*delta);
H_bar  = K_bar/KH_bar;
I_bar  = delta*K_bar;
Y_bar  = C_bar+I_bar+G_bar;
mu_bar = (beta*G_bar-a*C_bar)/(G_bar-a*C_bar);
pi_bar = mu_bar;
i_bar  = (pi_bar-beta)/beta;
M_bar  = a*C_bar*(pi_bar/(pi_bar-beta));


%*************************************************************************%
% 4. ESTADO ESTACIONARIO (en logaritmos) %
%*************************************************************************%


lG_bar  = log(G_bar);
lZ_bar  = log(Z_bar);
lr_bar  = log(r_bar);
lw_bar  = log(w_bar);
lC_bar  = log(C_bar);
lK_bar  = log(K_bar);
lH_bar  = log(H_bar);
lI_bar  = log(I_bar);
lY_bar  = log(Y_bar);
lmu_bar = log(mu_bar);
lpi_bar = log(pi_bar);
li_bar  = log(i_bar);
lM_bar  = log(M_bar);


%*************************************************************************%
% 5. MODELO %
%*************************************************************************%


model;

  exp(Y)   = exp(Z)*(exp(K(-1))^theta)*(exp(H)^(1-theta));
  exp(w)   = (1-theta)*exp(Y)/exp(H);
  exp(r)   = theta*exp(Y)/exp(K(-1));
  exp(I)   = exp(K)-(1-delta)*exp(K(-1));
  exp(Y)   = exp(C)+exp(I)+exp(G);
  exp(C)   = exp(w)/B;
  exp(M)   = a*((1+exp(i))/exp(i))*exp(C);
  exp(M)   = (exp(mu)/exp(pi))*exp(M(-1));
  exp(G)   = (exp(mu)-1)*exp(M(-1))/exp(pi);
  1/exp(C) = beta*(exp(r(+1))+1-delta)/exp(C(+1));
  1/exp(C) = a/exp(M)+beta/(exp(C(+1))*exp(pi(+1)));
  Z        = (1-gamma)*lZ_bar+gamma*Z(-1)+e;
  G        = (1-phi)*lG_bar+phi*G(-1)+xi;

end;


%*************************************************************************%
% 6. COMPUTACIÓN %
%*************************************************************************%


initval;

  K  = lK_bar;
  M  = lM_bar;
  Y  = lY_bar;
  C  = lC_bar;
  I  = lI_bar;
  H  = lH_bar;
  r  = lr_bar;
  w  = lw_bar;
  i  = li_bar;
  pi = lpi_bar;
  mu = lmu_bar;
  Z  = lZ_bar;
  G  = lG_bar;

end;

shocks;
  var e  = sd_e^2;
  var xi = sd_xi^2;
end;

steady;


%*************************************************************************%
% 7. RESULTADOS %
%*************************************************************************%


stoch_simul(order = 1, hp_filter = 1600, irf = 100) K M Y C I H r w i pi mu Z G;
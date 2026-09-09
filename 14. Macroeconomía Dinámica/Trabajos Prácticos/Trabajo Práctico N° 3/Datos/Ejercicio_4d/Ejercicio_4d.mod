% MODELO RBC (basado en Hansen 1985)


%*************************************************************************%
% 1. VARIABLES Y PARÁMETROS %
%*************************************************************************%


var        K Y C I H r w Z;
varexo     e;
parameters theta delta beta A gamma h_cero sd_e
           K_bar Y_bar C_bar I_bar L_bar H_bar r_bar w_bar Z_bar KL_bar
           lK_bar lY_bar lC_bar lI_bar lL_bar lr_bar lw_bar lZ_bar;


%*************************************************************************%
% 2. CALIBRACIÓN %
%*************************************************************************%


theta  = 0.36;
delta  = 0.025;
beta   = 0.99;
A      = 2;
gamma  = 0.95;
h_cero = 0.53;
sd_e   = 0.712;


%*************************************************************************%
% 3. ESTADO ESTACIONARIO (en niveles) %
%*************************************************************************%


Z_bar  = 1;
r_bar  = 1/beta+delta-1;
KL_bar = h_cero*(theta*Z_bar/r_bar)^(1/(1-theta));
w_bar  = (1-theta)*Z_bar*(KL_bar/h_cero)^(theta);
C_bar  = -w_bar*h_cero/(A*log(1-h_cero));
K_bar  = (theta/(r_bar-theta*delta))*C_bar;
L_bar  = K_bar/KL_bar;
H_bar  = L_bar*h_cero;
I_bar  = delta*K_bar;
Y_bar  = C_bar+I_bar;


%*************************************************************************%
% 4. ESTADO ESTACIONARIO (en logaritmos) %
%*************************************************************************%


lZ_bar  = log(Z_bar);
lr_bar  = log(r_bar);
lKL_bar = log(KL_bar);
lw_bar  = log(w_bar);
lC_bar  = log(C_bar);
lK_bar  = log(K_bar);
lL_bar  = log(L_bar);
lH_bar  = log(H_bar);
lI_bar  = log(I_bar);
lY_bar  = log(Y_bar);


%*************************************************************************%
% 5. MODELO %
%*************************************************************************%


model;

  exp(Y)   = exp(Z)*(exp(K(-1))^theta)*(exp(H)^(1-theta));
  exp(w)   = (1-theta)*exp(Y)/exp(H);
  exp(r)   = theta*exp(Y)/exp(K(-1));
  exp(Y)   = exp(C)+exp(I);
  exp(I)   = exp(K)-(1-delta)*exp(K(-1));
  exp(C)   = -exp(w)*h_cero/(A*log(1-h_cero));
  1/exp(C) = beta*(exp(r(+1))+1-delta)/exp(C(+1));
  Z        = (1-gamma)*lZ_bar+gamma*Z(-1)+e;

end;


%*************************************************************************%
% 6. COMPUTACIÓN %
%*************************************************************************%


initval;

  K  = lK_bar;
  Y  = lY_bar;
  C  = lC_bar;
  I  = lI_bar;
  H  = lH_bar;
  r  = lr_bar;
  w  = lw_bar;
  Z  = lZ_bar;

end;

shocks;
  var e = sd_e^2;
end;

steady;


%*************************************************************************%
% 7. RESULTADOS %
%*************************************************************************%


stoch_simul(order = 1, hp_filter = 1600, irf = 100) K Y C I H r w Z;
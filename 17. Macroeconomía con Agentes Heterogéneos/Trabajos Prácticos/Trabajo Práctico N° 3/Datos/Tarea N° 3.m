% Macroeconomía con Agentes Heterogéneos - Tarea N° 3
% Juan Menduiña


clear all


%******************************************************************************%
                                  % EJERCICIO 1 %
%******************************************************************************%


% Parámetros

beta = 0.97;
n_k = 100;
n_z = 5;
rho = 0.75;
sigma2_e = 0.0004;
sigma_e = sigma2_e^0.5;
alpha = 0.35;
tol = 0.00001;
maxiter = 1000;
cover = 3;
c_min = 0.0001;
v_min = -10000;

% Discretización del grid de shocks z, con n_z puntos

z = zeros(1,n_z);

z(1) = -cover*sigma_e/(1-rho^2)^0.5;
step_z = -2*z(1)/(n_z-1);
for (i=2:n_z-1)
  z(i) = z(1)+(i-1)*step_z;
endfor
z(n_z) = -z(1);

P = zeros(n_z,n_z);

for (i=1:n_z)
    P(i,1) = dist_normal(((z(1)-rho*z(i))/sigma_e)+step_z/(2*sigma_e));
  for (j=2:n_z-1)
    P(i,j) = dist_normal(((z(j)-rho*z(i))/sigma_e)+step_z/(2*sigma_e))-dist_normal(((z(j)-rho*z(i))/sigma_e)-step_z/(2*sigma_e));
  endfor
    P(i,n_z) = 1-sum(P(i,:));
endfor

z = z/(e^(sigma2_e/(2*(1-rho^2))));
z = e.^(z);

% Discretización del grid de capital k, con n_k puntos

k_min = 0.01;
k_max = (alpha*beta*z(n_z))^(1/(1-alpha))*1.2;
step_k = (k_max-k_min)/(n_k-1);

k(1) = k_min;
for (i=2:n_k-1)
  k(i) = k(1)+(i-1)*step_k;
endfor
k(n_k) = k_max;

% INCISO (1) - Value Function Iteration %

v0 = ones(n_k,n_z);
v1 = ones(n_k,n_z);
error_vf = 1;
iter = 1;

while (error_vf>tol && iter<maxiter)
  for (i=1:n_k)
    for (iz = 1:n_z)
      y(i,iz) = z(iz)*k(i)^alpha;
      for (j=1:n_k)
        c = y(i,iz)-k(j);
        if (c<0)
          vaux(j) = v_min;
        else
          vaux(j) = log(c)+beta*(P(iz,:)*v0(j,:)');
        endif
      endfor
      [val pos] = max(vaux);
      index_pol(i,iz) = pos;
      kpol(i,iz) = k(pos);
      cpol(i,iz) = y(i,iz)-kpol(i,iz);
      v1(i,iz) = vaux(pos);
    endfor
  endfor
  error_vf = max(max(abs(v1-v0)))
  v0 = v1;
  iter = iter+1;
endwhile

resultados_11 = zeros(500,7);
for (i=1:n_k)
  for (j=1:n_z)
    n = (i-1)*n_z+j;
    resultados_11(n,1) = k(i);
    resultados_11(n,2) = z(j);
    resultados_11(n,3) = y(i,j);
    resultados_11(n,4) = kpol(i,j);
    resultados_11(n,5) = cpol(i,j);
    resultados_11(n,6) = index_pol(i,j);
    resultados_11(n,7) = v1(i,j);
  endfor
endfor

file = fopen('resultados_11.txt', 'w');
dlmwrite('resultados_11.txt', resultados_11);
fclose(file);

% INCISO (2) - Value Function Iteration Improved %

v0 = ones(n_k,n_z);
v1 = ones(n_k,n_z);
error_vf = 1;
iter = 1;

while (error_vf>tol && iter<maxiter)
  for (iz=1:n_z)
    for (i=1:n_k)
      y(i,iz) = z(iz)*k(i)^alpha;
      vaux(:) = v_min;
      if (i == 1)
        ind_j = 1;
      else
        ind_j = pos;
      endif
      for (j=ind_j:n_k)
        c = y(i,iz)-k(j);
        if (c<0)
          vaux(j) = v_min;
        else
          vaux(j) = log(c)+beta*(P(iz,:)*v0(j,:)');
        endif
      endfor
      [val pos] = max(vaux);
      index_pol(i,iz) = pos;
      kpol(i,iz) = k(pos);
      cpol(i,iz) = y(i,iz)-kpol(i,iz);
      v1(i,iz) = vaux(pos);
    endfor
  endfor
  error_vf = max(max(abs(v1-v0)))
  v0 = v1;
  iter = iter+1;
endwhile

resultados_12 = zeros(500,7);
for (i=1:n_k)
  for (j=1:n_z)
    n = (i-1)*n_z+j;
    resultados_12(n,1) = k(i);
    resultados_12(n,2) = z(j);
    resultados_12(n,3) = y(i,j);
    resultados_12(n,4) = kpol(i,j);
    resultados_12(n,5) = cpol(i,j);
    resultados_12(n,6) = index_pol(i,j);
    resultados_12(n,7) = v1(i,j);
  endfor
endfor

file = fopen('resultados_12.txt', 'w');
dlmwrite('resultados_12.txt', resultados_12);
fclose(file);

% INCISO (3) - Policy Function Iteration %

v0 = ones(n_k,n_z);
v1 = ones(n_k,n_z);
error_vf = 1;
iter = 1;

n_pol_iter = 20;
n_iter = 20;

while (error_vf>tol && iter<maxiter)
  for (i=1:n_k)
    for (iz=1:n_z)
      y(i,iz) = z(iz)*k(i)^alpha;
      for (j=1:n_k)
        c = y(i,iz)-k(j);
        if (c<0)
          c = c_min;
        endif
        vaux(j) = log(c)+beta*(P(iz,:)*v0(j,:)');
      endfor
      [val pos] = max(vaux);
      index_pol(i,iz) = pos;
      kpol(i,iz) = k(pos);
      cpol(i,iz) = y(i,iz)-kpol(i,iz);
      v1(i,iz) = vaux(pos);
    endfor
  endfor
  if (iter>n_iter)
    for (n=1:n_pol_iter)
      for (i1=1:n_z)
        for (i2=1:n_k)
          v11(i2,i1) = log(cpol(i2,i1))+beta*(P(i1,:)*v1(index_pol(i2,i1),:)');
        endfor
      endfor
    v1 = v11;
    endfor
  v1 = v11;
  endif
  error_vf = max(max(abs(v1-v0)))
  v0 = v1;
  iter = iter+1;
endwhile

resultados_13 = zeros(500,7);
for (i=1:n_k)
  for (j=1:n_z)
    n = (i-1)*n_z+j;
    resultados_13(n,1) = k(i);
    resultados_13(n,2) = z(j);
    resultados_13(n,3) = y(i,j);
    resultados_13(n,4) = kpol(i,j);
    resultados_13(n,5) = cpol(i,j);
    resultados_13(n,6) = index_pol(i,j);
    resultados_13(n,7) = v1(i,j);
  endfor
endfor

file = fopen('resultados_13.txt', 'w');
dlmwrite('resultados_13.txt', resultados_13);
fclose(file);

% INCISO (4) - Value Function Iteration con interpolación %

n_kk = 1000;
k_min = 0.01;
k_max = (alpha*beta*z(n_z))^(1/(1-alpha))*1.2;
step_k2 = (k_max-k_min)/(n_kk-1);

k2(1) = k_min;
for (i=2:n_kk-1)
  k2(i) = k2(1)+(i-1)*step_k2;
endfor
k2(n_kk) = k_max;

v0 = ones(n_k,n_z);
v1 = ones(n_k,n_z);
error_vf = 1;
iter = 1;

while (error_vf>tol && iter<maxiter)
  for (i=1:n_k)
    for (iz=1:n_z)
      y(i,iz) = z(iz)*k(i)^alpha;
      for (j=1:n_kk)
        c = y(i,iz)-k2(j);
        EVF = 0;
        for (jz=1:n_z)
          EVF(jz) = P(iz,jz)*interp1(k,v0(:,jz),k2(j));
        endfor
        if (c<0)
          vaux(j) = v_min;
        else
          vaux(j) = log(c)+beta*sum(EVF);
        endif
      endfor
      [val pos] = max(vaux);
      index_pol(i,iz) = pos;
      kpol(i,iz) = k2(pos);
      cpol(i,iz) = y(i,iz)-kpol(i,iz);
      v1(i,iz) = vaux(pos);
    endfor
  endfor
  error_vf = max(max(abs(v1-v0)))
  v0 = v1;
  iter = iter+1;
endwhile

resultados_14 = zeros(500,7);
for (i=1:n_k)
  for (j=1:n_z)
    n = (i-1)*n_z+j;
    resultados_14(n,1) = k(i);
    resultados_14(n,2) = z(j);
    resultados_14(n,3) = y(i,j);
    resultados_14(n,4) = kpol(i,j);
    resultados_14(n,5) = cpol(i,j);
    resultados_14(n,6) = index_pol(i,j);
    resultados_14(n,7) = v1(i,j);
  endfor
endfor

file = fopen('resultados_14.txt', 'w');
dlmwrite('resultados_14.txt', resultados_14);
fclose(file);

% INCISO (5) - Endogenous Grid Method %

delta = 1;
error_vf = 1;
iter = 1;

for (iz=1:n_z)
  c0(:,iz) = z(iz)*k(:).^alpha+(1-delta)*k(:);
endfor

while (error_vf>tol && iter<maxiter)
  for (i=1:n_k)
    for (iz=1:n_z)
      for (izp=1:n_z)
        dpu(izp) = 1/c0(i,izp);
      endfor
      EVF(i,iz) = beta*sum(P(iz,:).*dpu(:))*z(:)*alpha*k(i)^(alpha-1);
      c1(i,iz) = (1/EVF(i,iz))^(-1);
      k0(i,iz) = ((c1(i,iz)+k(i))/z(iz))^(1/alpha);
    endfor
  endfor
  for (i=1:n_k)
    for (iz=1:n_z)
      if (k(i)<k0(1,iz))
        y(i,iz) = z(iz)*k(i)^alpha;
        cpol(i,iz) = z(iz)*k(i)^alpha-k(1);
        kpol(i,iz) = k(1);
      elseif (k(i)>k0(n_k,iz))
        y(i,iz) = z(iz)*k(i)^alpha;
        cpol(i,iz) = z(iz)*k(i)^alpha-k(n_k);
        kpol(i,iz) = k(n_k);
      else
        [val pos] = min(k0(:,iz),k0(:,iz)>k(i));
        alpha_int = (k(i)-k0(pos-1,iz))/(k0(pos,iz)-k0(pos-1,iz));
        y(i,iz) = z(iz)*k(i)^alpha;
        cpol(i,iz) = (1-alpha_int)*c1(pos-1,iz)+alpha_int*c1(pos,iz);
        kpol(i,iz) = z(iz)*k(i)^alpha-cpol(i,iz);
      endif
    endfor
  endfor
  error_vf = max(max(abs(cpol-c0)))
  c0 = cpol;
  iter = iter+1;
endwhile

resultados_15 = zeros(500,6);
for (i=1:n_k)
  for (j=1:n_z)
    n = (i-1)*n_z+j;
    resultados_15(n,1) = k(i);
    resultados_15(n,2) = z(j);
    resultados_15(n,3) = y(i,j);
    resultados_15(n,4) = kpol(i,j);
    resultados_15(n,5) = cpol(i,j);
    resultados_15(n,6) = index_pol(i,j);
  endfor
endfor

file = fopen('resultados_15.txt', 'w');
dlmwrite('resultados_15.txt', resultados_15);
fclose(file);


%******************************************************************************%
                                  % EJERCICIO 2 %
%******************************************************************************%


t_sim = 2000;
kk = zeros(t_sim,1);
zz = zeros(t_sim,1);
cc = zeros(t_sim,1);
yy = zeros(t_sim,1);
kp = zeros(t_sim,1);

seed = 12345;
rand('seed',seed);
shocks = rand(n_sim-1,1);

index_k = 50;
index_z = 3;

% INCISOS (1)-(4) %

Pacum = P;

for (i=1:5)
  Pacum(i,1) = P(i,1);
  Pacum(i,2) = P(i,1)+P(i,2);
  Pacum(i,3) = P(i,1)+P(i,2)+P(i,3);
  Pacum(i,4) = P(i,1)+P(i,2)+P(i,3)+P(i,4);
  Pacum(i,5) = P(i,1)+P(i,2)+P(i,3)+P(i,4)+P(i,5);
endfor

for (t=1:t_sim)
  kk(t) = k(index_k);
  zz(t) = z(index_z);
  cc(t) = cpol(index_k,index_z);
  yy(t) = y(index_k,index_z);
  kp(t) = kpol(index_k,index_z);
  index_k = index_pol(index_k,index_z);
  if (t<t_sim)
    if     (shocks(t)<Pacum(3,1))
      index_z = 1;
    elseif (shocks(t)>=Pacum(3,1) && shocks(t)<Pacum(3,2))
      index_z = 2;
    elseif (shocks(t)>=Pacum(3,2) && shocks(t)<Pacum(3,3))
      index_z = 3;
    elseif (shocks(t)>=Pacum(3,3) && shocks(t)<Pacum(3,4))
      index_z = 4;
    elseif (shocks(t)>=Pacum(3,4) && shocks(t)<Pacum(3,5))
      index_z = 5;
    endif
  endif
endfor

% INCISO (5) %

tsim = zeros(t_sim,1);
for (t=1:t_sim)
  tsim(t,1) = t;
endfor

resultados_25 = [tsim kk zz cc yy kp];

file = fopen('resultados_25.txt', 'w');
dlmwrite('resultados_25.txt', resultados_25);
fclose(file);

% INCISO (6)-(7)%

% Ver código 'Tarea N° 3.do'


%******************************************************************************%
                                  % EJERCICIO 3 %
%******************************************************************************%


mu_alpha = 0;
mu_eta = 0;
mu_epsilon = 0;
sigma2_alpha = 0.2105;
sigma2_eta = 0.0166;
sigma2_epsilon = 0.0630;

z_i0 = 0;

n_sim = 1000;
t_sim = 40;

seed = 12345;
rand('seed',seed);

% INCISO (1) %

rho = 0.9989;

for (n=1:n_sim)
  draw_alpha(n) = rand(1,1);
  if (draw_alpha(n)<0.5)
    alpha(n) = -0.459;
  else
    alpha(n) = 0.459;
  endif
  for (t=1:t_sim)
    draw_eta(n,t) = rand(1,1);
    draw_epsilon(n,t) = rand(1,1);
  if (draw_eta(n,t)<0.5)
    eta(n,t) = -0.127;
  else
    eta(n,t) = 0.127;
  endif
  if (draw_epsilon(n,t)<0.5)
    epsilon(n,t) = -0.251;
  else
    epsilon(n,t) = 0.251;
  endif
  if (t == 1)
    zeta = z_i0;
  else
    zeta = z(n,t-1);
  endif
  z(n,t) = rho*zeta+eta(n,t);
  y(n,t) = alpha(n)+z(n,t)+epsilon(n,t);
  endfor
endfor

for (t=1:t_sim)
  suma_y = 0;
  for (n=1:n_sim)
    suma_y = suma_y+y(n,t);
  endfor
  media_y(t) = suma_y/n_sim;
  suma_vy = 0;
  for (n=1:n_sim)
    suma_vy = suma_vy+(y(n,t)-media_y(t))^2;
  endfor
  varianza_y(t) = suma_vy/(t_sim-1);
endfor

tsim = zeros(t_sim,1);
for (t=1:t_sim)
  tsim(t,1) = t;
endfor

resultados_31 = [tsim media_y' varianza_y'];

file = fopen('resultados_31.txt', 'w');
dlmwrite('resultados_31.txt', resultados_31);
fclose(file);

% INCISO (2) %

rho = 0.5;

for (n=1:n_sim)
  draw_alpha(n) = rand(1,1);
  if (draw_alpha(n)<0.5)
    alpha(n) = -0.459;
  else
    alpha(n) = 0.459;
  endif
  for (t=1:t_sim)
    draw_eta(n,t) = rand(1,1);
    draw_epsilon(n,t) = rand(1,1);
  if (draw_eta(n,t)<0.5)
    eta(n,t) = -0.127;
  else
    eta(n,t) = 0.127;
  endif
  if (draw_epsilon(n,t)<0.5)
    epsilon(n,t) = -0.251;
  else
    epsilon(n,t) = 0.251;
  endif
  if (t == 1)
    zeta = z_i0;
  else
    zeta = z(n,t-1);
  endif
  z(n,t) = rho*zeta+eta(n,t);
  y(n,t) = alpha(n)+z(n,t)+epsilon(n,t);
  endfor
endfor

for (t=1:t_sim)
  suma_y = 0;
  for (n=1:n_sim)
    suma_y = suma_y+y(n,t);
  endfor
  media_y(t) = suma_y/n_sim;
  suma_vy = 0;
  for (n=1:n_sim)
    suma_vy = suma_vy+(y(n,t)-media_y(t))^2;
  endfor
  varianza_y(t) = suma_vy/(t_sim-1);
endfor

tsim = zeros(t_sim,1);
for (t=1:t_sim)
  tsim(t,1) = t;
endfor

resultados_32 = [tsim media_y' varianza_y'];

file = fopen('resultados_32.txt', 'w');
dlmwrite('resultados_32.txt', resultados_32);
fclose(file);
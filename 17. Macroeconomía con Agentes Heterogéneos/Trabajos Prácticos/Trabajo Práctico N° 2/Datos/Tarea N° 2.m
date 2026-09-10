% Macroeconomía con Agentes Heterogéneos - Tarea N° 2
% Juan Menduiña


clear all

seed = 12345;
rand('seed',seed);


%******************************************************************************%
                                 % EJERCICIO 1 %
%******************************************************************************%


% INCISO (1) %

a = 0.5;
b = 10;
N = 10;
vec_A = linspace(a,b,N)'

vector = fopen('vector.txt', 'w');
dlmwrite('vector.txt', vec_A);
fclose(vector);

% INCISO (2) %

mat_B = ones(10,10)

% INCISO (3) %

mat_C = vec_A.*mat_B

matriz = fopen('matriz.txt', 'w');
dlmwrite('matriz.txt', mat_C);
fclose(matriz);

% INCISO (4) %

vec_D = vec_A'*mat_B

% INCISO (5) %

vec_E = rand(10,1)

% INCISO (6) %

[M,I] = max(vec_E(:))
[I_row,I_col] = ind2sub(size(vec_E),I)


%******************************************************************************%
                                 % EJERCICIO 2 %
%******************************************************************************%


p = 1/6;

% INCISO (1) %

dado_1 = [0 0 0 0 0 0]'
dado_2 = [0 0 0 0 0 0]'
dado_3 = [0 0 0 0 0 0]'

% INCISO (2) %

N1 = 100;
X = rand(1,N1);
plot(X,'.')
hist(X)

for (i=1:N1)
  if     (X(i)>=0*p && X(i)<1*p)
    dado_1(1,1) = dado_1(1,1)+1
  elseif (X(i)>=1*p && X(i)<2*p)
    dado_1(2,1) = dado_1(2,1)+1
  elseif (X(i)>=2*p && X(i)<3*p)
    dado_1(3,1) = dado_1(3,1)+1
  elseif (X(i)>=3*p && X(i)<4*p)
    dado_1(4,1) = dado_1(4,1)+1
  elseif (X(i)>=4*p && X(i)<5*p)
    dado_1(5,1) = dado_1(5,1)+1
  elseif (X(i)>=5*p && X(i)<6*p)
    dado_1(6,1) = dado_1(6,1)+1
  endif
endfor

dado1 = fopen('dado_1.txt', 'w');
dlmwrite('dado_1.txt', dado_1);
fclose(dado1);

% INCISO (3) %

N2 = 1000;
N3 = 10000;
Y = rand(1,N2);
Z = rand(1,N3);
plot(Y,'.')
plot(Z,'.')
hist(Y)
hist(Z)

for (i=1:N2)
  if     (Y(i)>=0*p && Y(i)<1*p)
    dado_2(1,1) = dado_2(1,1)+1
  elseif (Y(i)>=1*p && Y(i)<2*p)
    dado_2(2,1) = dado_2(2,1)+1
  elseif (Y(i)>=2*p && Y(i)<3*p)
    dado_2(3,1) = dado_2(3,1)+1
  elseif (Y(i)>=3*p && Y(i)<4*p)
    dado_2(4,1) = dado_2(4,1)+1
  elseif (Y(i)>=4*p && Y(i)<5*p)
    dado_2(5,1) = dado_2(5,1)+1
  elseif (Y(i)>=5*p && Y(i)<6*p)
    dado_2(6,1) = dado_2(6,1)+1
  endif
endfor

dado2 = fopen('dado_2.txt', 'w');
dlmwrite('dado_2.txt', dado_2);
fclose(dado2);

for (i=1:N3)
  if     (Z(i)>=0*p && Z(i)<1*p)
    dado_3(1,1) = dado_3(1,1)+1
  elseif (Z(i)>=1*p && Z(i)<2*p)
    dado_3(2,1) = dado_3(2,1)+1
  elseif (Z(i)>=2*p && Z(i)<3*p)
    dado_3(3,1) = dado_3(3,1)+1
  elseif (Z(i)>=3*p && Z(i)<4*p)
    dado_3(4,1) = dado_3(4,1)+1
  elseif (Z(i)>=4*p && Z(i)<5*p)
    dado_3(5,1) = dado_3(5,1)+1
  elseif (Z(i)>=5*p && Z(i)<6*p)
    dado_3(6,1) = dado_3(6,1)+1
  endif
endfor

dado3 = fopen('dado_3.txt', 'w');
dlmwrite('dado_3.txt', dado_3);
fclose(dado3);


%******************************************************************************%
                                 % EJERCICIO 3 %
%******************************************************************************%


pkg list;
pkg load statistics;
pkg install -forge statistics;

% INCISO (1) %

lambda = 3;
sigma2_e = 0.0007;
sigma_e = sigma2_e^0.5;
m = 5;
rho = 0.9;

z = zeros(1,m)

z(1) = -lambda*sigma_e/(1-rho^2)^0.5
salto = -2*z(1)/(m-1)
for (i=2:m-1)
  z(i) = z(1)+(i-1)*salto
endfor
z(m) = -z(1)

P = zeros(m,m)

for (i=1:m)
    P(i,1) = dist_normal(((z(1)-rho*z(i))/sigma_e)+salto/(2*sigma_e))
  for (j = 2:m-1)
    P(i,j) = dist_normal(((z(j)-rho*z(i))/sigma_e)+salto/(2*sigma_e))-dist_normal(((z(j)-rho*z(i))/sigma_e)-salto/(2*sigma_e))
  endfor
    P(i,m) = 1-sum(P(i,:))
endfor

% INCISO (2) %

guess_inv = [0.2 0.2 0.2 0.2 0.2];
error = 1;
tol = 0.00001;
iter = 0;
itermax = 500;

while (error>tol && iter<itermax)
  inv = guess_inv*P;
  error = max(abs(inv-guess_inv));
  guess_inv = inv;
  iter = iter+1;
endwhile

inv
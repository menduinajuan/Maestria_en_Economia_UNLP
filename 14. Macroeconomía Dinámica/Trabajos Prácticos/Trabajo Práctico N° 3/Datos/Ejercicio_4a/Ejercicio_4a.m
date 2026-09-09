% MODELO RBC (basado en Hansen 1985)


%******************************************************************************%
% 1. CALIBRACIÓN %
%******************************************************************************%


theta   = 0.36;
delta   = 0.025;
beta    = 0.99;
A       = 2;
gamma   = 0.95;
sigma_e = 0.712;
Z_bar   = 1;


%******************************************************************************%
% 2. ESTADO ESTACIONARIO %
%******************************************************************************%


r_bar  = 1/beta+delta-1;
KL_bar = (theta*Z_bar/r_bar)^(1/(1-theta));
w_bar  = (1-theta)*Z_bar*(KL_bar)^(theta);
K_bar  = theta*w_bar/((A+1-theta)*r_bar-A*theta*delta);
L_bar  = K_bar/KL_bar;
C_bar  = (r_bar/theta-delta)*K_bar
I_bar  = delta*K_bar;
Y_bar  = C_bar+I_bar;


%******************************************************************************%
% 3. VARIABLES %
%******************************************************************************%


VARNAMES = ['Capital Stock',                                                    %1
            'Output       ',                                                    %2
            'Consumption  ',                                                    %3
            'Investment   ',                                                    %4
            'Labor        ',                                                    %5
            'Rental Rate  ',                                                    %6
            'Wage Rate    ',                                                    %7
            'Technology   '];                                                   %8

% (1) 0      = y(t)-z(t)-theta*k(t)-(1-theta)*l(t)
% (2) 0      = y(t)-l(t)-w(t)
% (3) 0      = y(t)-k(t)-r(t)
% (4) 0      = Y_bar*y(t)-C_bar*c(t)-I_bar*i(t)
% (5) 0      = k(t+1)-(1-delta)*k(t)-delta*i(t)
% (6) 0      = c(t)-w(t)+(L_bar/(1-L_bar))*l(t)
% (7) 0      = E_t [c(t+1)-beta*r_bar*r(t+1)-c(t)]
% (8) z(t+1) = gamma*z(t)+epsilon(t+1)
% Sistema: 8 ecuaciones, 8 variables

% Variables Endógenas de Estado "x(t)": k(t+1)
% Variables Endógenas           "y(t)": y(t), c(t), i(t), l(t), r(t), w(t)
% Variables Exógenas de Estado  "z(t)": z(t)


%******************************************************************************%
% 4. MATRICES %
%******************************************************************************%


% 0      = AA*x(t)+BB*x(t-1)+CC*y(t)+DD*z(t)
% 0      = E_t [FF*x(t+1)+GG*x(t)+HH*x(t-1)+JJ*y(t+1)+KK*y(t)+LL*z(t+1)+MM*z(t)]
% z(t+1) = NN*z(t)+epsilon(t+1) con E_t [epsilon(t+1)] = 0

% Para k(t+1):
AA = [ 0                                                                                   % Ec. 1
       0                                                                                   % Ec. 2
       0                                                                                   % Ec. 3
       0                                                                                   % Ec. 4
       1                                                                                   % Ec. 5
       0 ];                                                                                % Ec. 6

% Para k(t):
BB = [ -theta                                                                              % Ec. 1
       0                                                                                   % Ec. 2
       -1                                                                                  % Ec. 3
       0                                                                                   % Ec. 4
       -(1-delta)                                                                          % Ec. 5
       0 ];                                                                                % Ec. 6

% Orden:   producto     consumo     inversión     trabajo          interés     salario 
CC = [     1            , 0         , 0           , -(1-theta)     , 0         , 0         % Ec. 1
           1            , 0         , 0           , -1             , 0         , -1        % Ec. 2
           1            , 0         , 0           , 0              , -1        , 0         % Ec. 3
           Y_bar        , -C_bar    , -I_bar      , 0              , 0         , 0         % Ec. 4
           0            , 0         , -delta      , 0              , 0         , 0         % Ec. 5
           0            , 1         , 0           , L_bar/(1-L_bar), 0         , -1 ];     % Ec. 6

DD = [ -1                                                                                  % Ec. 1
       0                                                                                   % Ec. 2
       0                                                                                   % Ec. 3
       0                                                                                   % Ec. 4
       0                                                                                   % Ec. 5
       0 ];                                                                                % Ec. 6

FF = [ 0 ];                                                                                % Ec. 7
    
GG = [ 0 ];                                                                                % Ec. 7

HH = [ 0 ];                                                                                % Ec. 7

JJ = [ 0 , 1 , 0 , 0 , -beta*r_bar , 0 ];                                                  % Ec. 7

KK = [ 0 , -1 , 0 , 0 , 0 , 0 ];                                                           % Ec. 7

LL = [ 0 ];                                                                                % Ec. 7

MM = [ 0 ];                                                                                % Ec. 7

NN = [ gamma ];                                                                            % Ec. 8

Sigma = [ sigma_e^2 ];                                                                     % Ec. 8


%******************************************************************************%
% 5. CONFIGURACIÓN DE LAS OPCIONES %
%******************************************************************************%


[l_equ,m_states] = size(AA);
[l_equ,n_endog]  = size(CC);
[l_equ,k_exog]   = size(DD);

DISPLAY_IMMEDIATELY = 0;
DO_QZ               = 0;     % = 1 resuelve la matriz P utilizando el método QZ (método predeterminado)
PERIOD              = 4;     % Número de períodos por año (es decir, 12 mensuales, 4 trimestrales)
HORIZON             = 100;   % Número de períodos (trimestres) para el gráfico
GNP_INDEX           = 2;     % Índice de salida entre las variables seleccionadas para el filtro HP
IMP_SELECT          = [1:8]; % Vector que contiene los índices de las variables a graficar
DO_STATE_RESP       = 0;     % Funciones impulso-respuesta a desviaciones de estado estacionario
IMP_JOINT           = 0;     % Graficar todas las funciones impulso-respuesta conjuntamente
IMP_SUBPLOT         = 1;     % Graficar todas las funciones impulso-respuesta por separado, pero colocarlas en el mismo marco
IMP_SINGLE          = 0;     % Graficar todas las funciones impulso-respuesta (un gráfico separado para cada variable)

DO_SIMUL            = 1;     % Calcular simulaciones
SIM_MODE            = 2;     % Establecer a = 2 si se desea hacer un cálculo de momentos basado en simulación
SIM_N_SERIES        = 100;   % Número de series simuladas para el cálculo de momentos
SIM_LENGTH          = 115;   % Número de períodos de cada simulación
SIM_SUBPLOT         = 1;     % Opciones de gráfico para simulaciones (todas en el mismo marco)

DO_MOMENTS          = 1;     % Calcular momentos basados en métodos de dominio de frecuencia
PRINT_FIG           = 0;     % 
SAVE_FIG_JPG        = 0;     % Guardar las figuras en formato .jpg


%******************************************************************************%
% 6. RESULTADOS %
%******************************************************************************%


do_it;
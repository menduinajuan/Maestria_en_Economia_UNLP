% MODELO DINERO EN LA FUNCIÓN DE UTILIDAD (sin rigideces de precios)


%******************************************************************************%
% 1. CALIBRACIÓN %
%******************************************************************************%


theta    = 0.36;
beta     = 0.99;
B        = 2.5805;
delta    = 0.025;
gamma    = 0.95;
phi      = 0.48;
Z_bar    = 1;
G_bar    = 0.0087;
a        = 0.01;
sigma_e  = 0.721;
sigma_xi = 0.1;


%******************************************************************************%
% 2. ESTADO ESTACIONARIO %
%******************************************************************************%


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


%******************************************************************************%
% 3. VARIABLES
%******************************************************************************%


VARNAMES = ['Capital Stock',                                                    %1
            'Money Supply ',                                                    %2
            'Output       ',                                                    %3
            'Consumption  ',                                                    %4
            'Investment   ',                                                    %5
            'Labor        ',                                                    %6
            'Rental Rate  ',                                                    %7
            'Wage Rate    ',                                                    %8
            'Interest Rate',                                                    %9
            'Inflation    ',                                                    %10
            'Money Growth ',                                                    %11
            'Technology   ',                                                    %12
            'Expenditure  '];                                                   %13

% (1)  0      = y(t)-z(t)-theta*k(t)-(1-theta)*h(t)
% (2)  0      = y(t)-h(t)-w(t)
% (3)  0      = y(t)-k(t)-r(t)
% (4)  0      = k(t+1)-(1-delta)*k(t)-delta*i(t)
% (5)  0      = Y_bar*y(t)-C_bar*c(t)-I_bar*i(t)-G_bar*g(t)
% (6)  0      = c(t)-w(t)
% (7)  0      = mr(t)-c(t)+(beta/mu_bar)*ri(t)
% (8)  0      = mr(t)-mr(t-1)-mu(t)+pi(t)
% (9)  0      = g(t)-mr(t)+pi(t)-(pi_bar*mu(t))/(pi_bar-1)
% (10) 0      = E_t [c(t+1)-beta*r_bar*r(t+1)-c(t)]
% (11) 0      = E_t [beta*c(t+1)-beta*pi(t+1)-mu_bar*c(t)+(mu_bar-beta)*mr(t)]
% (12) z(t+1) = gamma*z(t)+epsilon(t+1)
% (13) g(t+1) = phi*z(t)+xi(t+1)
% Sistema: 13 ecuaciones, 13 variables

% Variables Endógenas de Estado "x(t)": k(t+1) mr(t)
% Variables Endógenas           "y(t)": y(t), c(t), i(t), h(t), r(t), w(t), ri(t), pi(t), mu(t)
% Variables Exógenas de Estado  "z(t)": z(t), g(t)


%******************************************************************************%
% 4. MATRICES %
%******************************************************************************%


% 0      = AA*x(t)+BB*x(t-1)+CC*y(t)+DD*z(t)
% 0      = E_t [FF*x(t+1)+GG*x(t)+HH*x(t-1)+JJ*y(t+1)+KK*y(t)+LL*z(t+1)+MM*z(t)]
% z(t+1) = NN*z(t)+epsilon(t+1) con E_t [epsilon(t+1)] = 0

% Para k(t+1):
AA = [ 0 , 0                                                                                                                             % Ec. 1
       0 , 0                                                                                                                             % Ec. 2
       0 , 0                                                                                                                             % Ec. 3
       1 , 0                                                                                                                             % Ec. 4
       0 , 0                                                                                                                             % Ec. 5
       0 , 0                                                                                                                             % Ec. 6
       0 , 1                                                                                                                             % Ec. 7
       0 , 1                                                                                                                             % Ec. 8
       0 , 0 ];                                                                                                                          % Ec. 9

% Para k(t):
BB = [ -theta     , 0                                                                                                                    % Ec. 1
       0          , 0                                                                                                                    % Ec. 2
       -1         , 0                                                                                                                    % Ec. 3
       -(1-delta) , 0                                                                                                                    % Ec. 4
       0          , 0                                                                                                                    % Ec. 5
       0          , 0                                                                                                                    % Ec. 6
       0          , 0                                                                                                                    % Ec. 7
       0          , -1                                                                                                                   % Ec. 8
       0          , -1 ];                                                                                                                % Ec. 9

%Orden:     Y          C          I          H               r          w          i               pi          mu
CC = [      1          , 0        , 0        , -(1-theta)    , 0        , 0        , 0             , 0         , 0                       % Ec. 1
            1          , 0        , 0        , -1            , 0        , -1       , 0             , 0         , 0                       % Ec. 2
            1          , 0        , 0        , 0             , -1       , 0        , 0             , 0         , 0                       % Ec. 3
            0          , 0        , -delta   , 0             , 0        , 0        , 0             , 0         , 0                       % Ec. 4
            Y_bar      , -C_bar   , -I_bar   , 0             , 0        , 0        , 0             , 0         , 0                       % Ec. 5
            0          , 1        , 0        , 0             , 0        , -1       , 0             , 0         , 0                       % Ec. 6
            0          , -1       , 0        , 0             , 0        , 0        , beta/mu_bar   , 0         , 0                       % Ec. 7
            0          , 0        , 0        , 0             , 0        , 0        , 0             , 1         , -1                      % Ec. 8
            0          , 0        , 0        , 0             , 0        , 0        , 0             , 1         , -pi_bar/(pi_bar-1) ];   % Ec. 9

DD = [ -1 , 0                                                                                                                            % Ec. 1
       0  , 0                                                                                                                            % Ec. 2
       0  , 0                                                                                                                            % Ec. 3
       0  , 0                                                                                                                            % Ec. 4
       0  , -G_bar                                                                                                                       % Ec. 5
       0  , 0                                                                                                                            % Ec. 6
       0  , 0                                                                                                                            % Ec. 7
       0  , 0                                                                                                                            % Ec. 8
       0  , 1 ];                                                                                                                         % Ec. 9

FF = [ 0 , 0                                                                                                                             % Ec. 10
       0 , 0 ];                                                                                                                          % Ec. 11

GG = [ 0 , 0                                                                                                                             % Ec. 10
       0 , mu_bar-beta ];                                                                                                                % Ec. 11

HH = [ 0 , 0                                                                                                                             % Ec. 10
       0 , 0 ];                                                                                                                          % Ec. 11

JJ = [ 0 , 1    , 0 , 0 , -beta*r_bar , 0 , 0 , 0    , 0                                                                                 % Ec. 10
       0 , beta , 0 , 0 , 0           , 0 , 0 , beta , 0] ;                                                                              % Ec. 11

KK = [ 0 , -1      , 0 , 0 , 0 , 0 , 0 , 0 , 0                                                                                           % Ec. 10
       0 , -mu_bar , 0 , 0 , 0 , 0 , 0 , 0 , 0 ];                                                                                        % Ec. 11

LL = [ 0 , 0                                                                                                                             % Ec. 10
       0 , 0 ];                                                                                                                          % Ec. 11

MM = [ 0 , 0                                                                                                                             % Ec. 10
       0 , 0 ];                                                                                                                          % Ec. 11

NN = [ gamma , 0                                                                                                                         % Ec. 12
       0     , phi ];                                                                                                                    % Ec. 13

Sigma = [ sigma_e^2 , 0                                                                                                                  % Ec. 12
          0          , sigma_xi^2 ];                                                                                                     % Ec. 13

          
%******************************************************************************%
% 5. CONFIGURACIÓN DE LAS OPCIONES %
%******************************************************************************%


[l_equ,m_states] = size(AA);
[l_equ,n_endog]  = size(CC);
[l_equ,k_exog]   = size(DD);

DISPLAY_IMMEDIATELY = 0;
DO_QZ               = 0;      % = 1 resuelve la matriz P utilizando el método QZ (método predeterminado)
PERIOD              = 4;      % Número de períodos por año (es decir, 12 mensuales, 4 trimestrales)
HORIZON             = 100;    % Número de períodos (trimestres) para el gráfico
GNP_INDEX           = 2;      % Índice de salida entre las variables seleccionadas para el filtro HP
IMP_SELECT          = [1:13]; % Vector que contiene los índices de las variables a graficar
DO_STATE_RESP       = 0;      % Funciones impulso-respuesta a desviaciones de estado estacionario
IMP_JOINT           = 0;      % Graficar todas las funciones impulso-respuesta conjuntamente
IMP_SUBPLOT         = 1;      % Graficar todas las funciones impulso-respuesta por separado, pero colocarlas en el mismo marco
IMP_SINGLE          = 0;      % Graficar todas las funciones impulso-respuesta (un gráfico separado para cada variable)

DO_SIMUL            = 1;      % Calcular simulaciones
SIM_MODE            = 2;      % Establecer a = 2 si se desea hacer un cálculo de momentos basado en simulación
SIM_N_SERIES        = 1;      % Número de series simuladas para el cálculo de momentos
SIM_LENGTH          = 75;     % Número de períodos de cada simulación
SIM_SUBPLOT         = 1;      % Opciones de gráfico para simulaciones (todas en el mismo marco)

DO_MOMENTS          = 1;      % Calcular momentos basados en métodos de dominio de frecuencia
PRINT_FIG           = 0;      % 
SAVE_FIG_JPG        = 0;      % Guardar las figuras en formato .jpg


%******************************************************************************%
% 6. RESULTADOS %
%******************************************************************************%


do_it;
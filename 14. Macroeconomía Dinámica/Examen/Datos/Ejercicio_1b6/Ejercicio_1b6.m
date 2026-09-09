%******************************************************************************%
% 1. CALIBRACIÓN %
%******************************************************************************%


alpha  = 0.36;
beta   = 0.99;
delta  = 0.025;
eta    = 0.95;
tau    = 0.62;
a      = 6;
b      = 0.87;
gamma  = 1;
sd_eps = 0.825;


%******************************************************************************%
% 2. ESTADO ESTACIONARIO %
%******************************************************************************%


k_bar = 11.5785;
y_bar = 1.1289;
c_bar = 0.8395;
I_bar = 0.2895;
N_bar = 0.3048;
n_bar = 0.4707;
e_bar = 0.6476;
w_bar = 2.3706;
A_bar = 1;


%******************************************************************************%
% 3. VARIABLES %
%******************************************************************************%


VARNAMES = ['Capital Stock  ',                                                  %1
            'Output         ',                                                  %2
            'Consumption    ',                                                  %3
            'Investment     ',                                                  %4
            'Aggregate Hours',                                                  %5
            'Hours          ',                                                  %6
            'Employment     ',                                                  %7
            'Wage Rate      ',                                                  %8
            'Technology     '];                                                 %9

% (1) 0      = y(t)-A(t)-alpha*k(t)-(1-alpha)*N(t)
% (2) 0      = y_bar*y(t)-c_bar*c(t)-I_bar*I(t)
% (3) 0      = N(t)-n(t)-e(t)
% (4) 0      = k(t+1)-(1-delta)*k(t)-delta*I(t)
% (5) 0      = w(t)-y(t)+N(t)
% (6) 0      = w(t)-c(t)-gamma*n(t)
% (7) 0      = e(t)-((1+gamma)/tau)*n(t)
% (8) 0      = E_t [c(t+1)-(1-beta+beta*delta)*y(t+1)+(1-beta+beta*delta)*k(t+1)-c(t)]
% (9) A(t+1) = eta*A(t)+epsilon(t+1)
% Sistema: 9 ecuaciones, 9 variables

% Variables Endógenas de Estado "x(t)": k(t+1)
% Variables Endógenas de Salto  "y(t)": y(t), c(t), I(t), N(t), n(t), e(t), w(t)
% Variables Exógenas de Estado  "z(t)": A(t)


%******************************************************************************%
% 4. MATRICES %
%******************************************************************************%


% 0      = AA*x(t)+BB*x(t-1)+CC*y(t)+DD*z(t)
% 0      = E_t [FF*x(t+1)+GG*x(t)+HH*x(t-1)+JJ*y(t+1)+KK*y(t)+LL*z(t+1)+MM*z(t)]
% z(t+1) = NN*z(t)+epsilon(t+1) con E_t [epsilon(t+1)] = 0

% Para k(t+1):
AA = [ 0                                                                                                        % Ec. 1
       0                                                                                                        % Ec. 2
       0                                                                                                        % Ec. 3
       1                                                                                                        % Ec. 4
       0                                                                                                        % Ec. 5
       0                                                                                                        % Ec. 6
       0 ];                                                                                                     % Ec. 7

% Para k(t):
BB = [ -alpha                                                                                                   % Ec. 1
       0                                                                                                        % Ec. 2
       0                                                                                                        % Ec. 3
       -(1-delta)                                                                                               % Ec. 4
       0                                                                                                        % Ec. 5
       0                                                                                                        % Ec. 6
       0 ];                                                                                                     % Ec. 7

% Orden:   producto     consumo     inversión     horas agregadas     horas              empleo     salario
CC = [     1            , 0         , 0           , -(1-alpha)        , 0                , 0        , 0         % Ec. 1
           y_bar        , -c_bar    , -I_bar      , 0                 , 0                , 0        , 0         % Ec. 2
           0            , 0         , 0           , 1                 , -1               , -1       , 0         % Ec. 3
           0            , 0         , -delta      , 0                 , 0                , 0        , 0         % Ec. 4
           -1           , 0         , 0           , 1                 , 0                , 0        , 1         % Ec. 5
           0            , -1        , 0           , 0                 , -gamma           , 0        , 1         % Ec. 6
           0            , 0         , 0           , 0                 , -(1+gamma)/tau   , 1        , 0 ];      % Ec. 7

DD = [ -1                                                                                                       % Ec. 1
       0                                                                                                        % Ec. 2
       0                                                                                                        % Ec. 3
       0                                                                                                        % Ec. 4
       0                                                                                                        % Ec. 5
       0                                                                                                        % Ec. 6
       0 ];                                                                                                     % Ec. 7

FF = [ 0 ];                                                                                                     % Ec. 8
    
GG = [ 1-beta+beta*delta ];                                                                                     % Ec. 8

HH = [ 0 ];                                                                                                     % Ec. 8

JJ = [ -(1-beta+beta*delta) , 1 , 0 , 0 , 0 , 0 , 0 ];                                                          % Ec. 8

KK = [ 0 , -1, 0 , 0 , 0 , 0 , 0 ];                                                                             % Ec. 8

LL = [ 0 ];                                                                                                     % Ec. 8

MM = [ 0 ];                                                                                                     % Ec. 8

NN = [ eta ];                                                                                                   % Ec. 9

Sigma = [ sd_eps^2 ];                                                                                           % Ec. 9


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
IMP_SELECT          = [1:9];  % Vector que contiene los índices de las variables a graficar
DO_STATE_RESP       = 0;      % Funciones impulso-respuesta a desviaciones de estado estacionario
IMP_JOINT           = 0;      % Graficar todas las funciones impulso-respuesta conjuntamente
IMP_SUBPLOT         = 1;      % Graficar todas las funciones impulso-respuesta por separado, pero colocarlas en el mismo marco
IMP_SINGLE          = 0;      % Graficar todas las funciones impulso-respuesta (un gráfico separado para cada variable)

DO_SIMUL            = 1;      % Calcular simulaciones
SIM_MODE            = 2;      % Establecer a = 2 si se desea hacer un cálculo de momentos basado en simulación
SIM_N_SERIES        = 100;    % Número de series simuladas para el cálculo de momentos
SIM_LENGTH          = 115;    % Número de períodos de cada simulación
SIM_SUBPLOT         = 1;      % Opciones de gráfico para simulaciones (todas en el mismo marco)

DO_MOMENTS          = 1;      % Calcular momentos basados en métodos de dominio de frecuencia
PRINT_FIG           = 0;      % 
SAVE_FIG_JPG        = 0;      % Guardar las figuras en formato .jpg


%******************************************************************************%
% 6. RESULTADOS %
%******************************************************************************%


do_it;
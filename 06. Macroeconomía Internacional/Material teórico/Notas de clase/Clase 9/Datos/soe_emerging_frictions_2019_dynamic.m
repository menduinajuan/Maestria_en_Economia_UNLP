function [residual, g1, g2, g3] = soe_emerging_frictions_2019_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Inputs :
%   y         [#dynamic variables by 1] double    vector of endogenous variables in the order stored
%                                                 in M_.lead_lag_incidence; see the Manual
%   x         [nperiods by M_.exo_nbr] double     matrix of exogenous variables (in declaration order)
%                                                 for all simulation periods
%   steady_state  [M_.endo_nbr by 1] double       vector of steady state values
%   params    [M_.param_nbr by 1] double          vector of parameter values in declaration order
%   it_       scalar double                       time period for exogenous variables for which to evaluate the model
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the dynamic model equations in order of 
%                                          declaration of the equations.
%                                          Dynare may prepend auxiliary equations, see M_.aux_vars
%   g1        [M_.endo_nbr by #dynamic variables] double    Jacobian matrix of the dynamic model equations;
%                                                           rows: equations in order of declaration
%                                                           columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g2        [M_.endo_nbr by (#dynamic variables)^2] double   Hessian matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g3        [M_.endo_nbr by (#dynamic variables)^3] double   Third order derivative matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(13, 1);
T17 = y(16)^(1-params(1));
T18 = (1-params(1))*y(15)*T17;
T21 = (y(1)/y(11))^params(1);
T22 = T18*T21;
T28 = 1+params(7)*y(14)/(1+y(14));
T35 = y(9)-y(11)^params(5)/params(5);
T38 = T35^(-params(3));
T39 = y(17)*T38;
T41 = y(16)^params(3);
T42 = params(4)/T41;
T48 = y(21)-y(23)^params(5)/params(5);
T49 = T48^(-params(3));
T60 = 1+params(6)*(y(16)*y(10)/y(1)-params(11));
T73 = (y(10)/(y(23)*y(25)))^(params(1)-1);
T79 = params(6)*y(25)*y(22)/y(10);
T80 = y(25)*y(22)/y(10)-params(11);
T83 = params(6)/2;
T86 = 1-params(2)+params(1)*y(24)*T73+T79*T80-T83*T80^2;
T92 = (y(16)*y(10)/y(1)-params(11))^2;
T93 = y(1)*T83*T92;
T130 = y(1)^params(1);
T131 = y(15)*T130;
T133 = (y(11)*y(16))^(1-params(1));
lhs =y(11)^(params(5)-1);
rhs =T22/T28;
residual(1)= lhs-rhs;
lhs =T39;
rhs =(1+y(14))*T42*y(17)*T49;
residual(2)= lhs-rhs;
lhs =T39*T60;
rhs =T42*T49*y(26)*T86;
residual(3)= lhs-rhs;
lhs =y(9)+y(13)+T93+y(19)+y(2);
rhs =y(8)+y(16)*y(12)/(1+y(14));
residual(4)= lhs-rhs;
lhs =y(20);
rhs =y(8)-y(9)-y(13)-T93-y(19);
residual(5)= lhs-rhs;
lhs =y(16)*y(10);
rhs =y(13)+y(1)*(1-params(2));
residual(6)= lhs-rhs;
lhs =y(14);
rhs =params(10)+params(8)*(exp((y(12)-params(9))/params(12))-1)+exp(y(18)-1)-1;
residual(7)= lhs-rhs;
lhs =y(8);
rhs =T131*T133;
residual(8)= lhs-rhs;
lhs =log(y(15));
rhs =params(14)*log(y(3))+x(it_, 1);
residual(9)= lhs-rhs;
lhs =log(y(16)/params(11));
rhs =params(15)*log(y(4)/params(11))+x(it_, 2);
residual(10)= lhs-rhs;
lhs =log(y(19)/params(13));
rhs =params(18)*log(y(7)/params(13))+x(it_, 5);
residual(11)= lhs-rhs;
lhs =log(y(17));
rhs =params(16)*log(y(5))+x(it_, 3);
residual(12)= lhs-rhs;
lhs =log(y(18));
rhs =params(17)*log(y(6))+x(it_, 4);
residual(13)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(13, 31);

  %
  % Jacobian matrix
  %

T181 = getPowerDeriv(T35,(-params(3)),1);
T184 = getPowerDeriv(T48,(-params(3)),1);
T193 = getPowerDeriv(y(1)/y(11),params(1),1);
T203 = 2*(y(16)*y(10)/y(1)-params(11));
T218 = getPowerDeriv(y(10)/(y(23)*y(25)),params(1)-1,1);
T223 = (-(y(25)*y(22)))/(y(10)*y(10));
T260 = y(17)*T181*(-(getPowerDeriv(y(11),params(5),1)/params(5)));
T262 = getPowerDeriv(y(11)*y(16),1-params(1),1);
T269 = T184*(-(getPowerDeriv(y(23),params(5),1)/params(5)));
T331 = (-(params(4)*getPowerDeriv(y(16),params(3),1)))/(T41*T41);
  g1(1,1)=(-(T18*1/y(11)*T193/T28));
  g1(1,11)=getPowerDeriv(y(11),params(5)-1,1)-T18*T193*(-y(1))/(y(11)*y(11))/T28;
  g1(1,14)=(-((-(T22*(params(7)*(1+y(14))-params(7)*y(14))/((1+y(14))*(1+y(14)))))/(T28*T28)));
  g1(1,15)=(-(T21*(1-params(1))*T17/T28));
  g1(1,16)=(-(T21*(1-params(1))*y(15)*getPowerDeriv(y(16),1-params(1),1)/T28));
  g1(2,9)=y(17)*T181;
  g1(2,21)=(-((1+y(14))*T42*y(17)*T184));
  g1(2,11)=T260;
  g1(2,23)=(-((1+y(14))*T42*y(17)*T269));
  g1(2,14)=(-(T42*y(17)*T49));
  g1(2,16)=(-(y(17)*T49*(1+y(14))*T331));
  g1(2,17)=T38-(1+y(14))*T42*T49;
  g1(3,9)=T60*y(17)*T181;
  g1(3,21)=(-(T86*T42*y(26)*T184));
  g1(3,1)=T39*params(6)*(-(y(16)*y(10)))/(y(1)*y(1));
  g1(3,10)=T39*params(6)*y(16)/y(1)-T42*T49*y(26)*(params(1)*y(24)*1/(y(23)*y(25))*T218+T80*params(6)*T223+T79*T223-T83*T223*2*T80);
  g1(3,22)=(-(T42*T49*y(26)*(T80*params(6)*y(25)/y(10)+T79*y(25)/y(10)-T83*2*T80*y(25)/y(10))));
  g1(3,11)=T60*T260;
  g1(3,23)=(-(T86*T42*y(26)*T269+T42*T49*y(26)*params(1)*y(24)*T218*(-(y(10)*y(25)))/(y(23)*y(25)*y(23)*y(25))));
  g1(3,24)=(-(T42*T49*y(26)*params(1)*T73));
  g1(3,16)=T39*params(6)*y(10)/y(1)-T86*T49*y(26)*T331;
  g1(3,25)=(-(T42*T49*y(26)*(params(1)*y(24)*T218*(-(y(23)*y(10)))/(y(23)*y(25)*y(23)*y(25))+T80*params(6)*y(22)/y(10)+T79*y(22)/y(10)-T83*2*T80*y(22)/y(10))));
  g1(3,17)=T38*T60;
  g1(3,26)=(-(T86*T42*T49));
  g1(4,8)=(-1);
  g1(4,9)=1;
  g1(4,1)=T83*T92+y(1)*T83*(-(y(16)*y(10)))/(y(1)*y(1))*T203;
  g1(4,10)=y(1)*T83*T203*y(16)/y(1);
  g1(4,2)=1;
  g1(4,12)=(-(y(16)/(1+y(14))));
  g1(4,13)=1;
  g1(4,14)=(-((-(y(16)*y(12)))/((1+y(14))*(1+y(14)))));
  g1(4,16)=y(1)*T83*T203*y(10)/y(1)-y(12)/(1+y(14));
  g1(4,19)=1;
  g1(5,8)=(-1);
  g1(5,9)=1;
  g1(5,1)=T83*T92+y(1)*T83*(-(y(16)*y(10)))/(y(1)*y(1))*T203;
  g1(5,10)=y(1)*T83*T203*y(16)/y(1);
  g1(5,13)=1;
  g1(5,16)=y(1)*T83*T203*y(10)/y(1);
  g1(5,19)=1;
  g1(5,20)=1;
  g1(6,1)=(-(1-params(2)));
  g1(6,10)=y(16);
  g1(6,13)=(-1);
  g1(6,16)=y(10);
  g1(7,12)=(-(params(8)*exp((y(12)-params(9))/params(12))*1/params(12)));
  g1(7,14)=1;
  g1(7,18)=(-exp(y(18)-1));
  g1(8,8)=1;
  g1(8,1)=(-(T133*y(15)*getPowerDeriv(y(1),params(1),1)));
  g1(8,11)=(-(T131*y(16)*T262));
  g1(8,15)=(-(T130*T133));
  g1(8,16)=(-(T131*y(11)*T262));
  g1(9,3)=(-(params(14)*1/y(3)));
  g1(9,15)=1/y(15);
  g1(9,27)=(-1);
  g1(10,4)=(-(params(15)*1/params(11)/(y(4)/params(11))));
  g1(10,16)=1/params(11)/(y(16)/params(11));
  g1(10,28)=(-1);
  g1(11,7)=(-(params(18)*1/params(13)/(y(7)/params(13))));
  g1(11,19)=1/params(13)/(y(19)/params(13));
  g1(11,31)=(-1);
  g1(12,5)=(-(params(16)*1/y(5)));
  g1(12,17)=1/y(17);
  g1(12,29)=(-1);
  g1(13,6)=(-(params(17)*1/y(6)));
  g1(13,18)=1/y(18);
  g1(13,30)=(-1);

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],13,961);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],13,29791);
end
end
end
end

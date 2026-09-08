function [residual, g1, g2, g3] = soe_aguiar_2019_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(10, 1);
T25 = (y(1)/(y(9)*y(11)))^params(1);
T33 = params(5)*y(6)^(params(5)*(1-params(12))-1);
T35 = (1-y(9))^((1-params(5))*(1-params(12)));
T36 = T33*T35;
T41 = y(11)^(params(5)*(1-params(12))-1);
T45 = y(15)^(params(5)*(1-params(12))-1);
T49 = (1-y(17))^((1-params(5))*(1-params(12)));
T59 = 1+params(7)*(y(11)*y(7)/y(1)-params(11));
T73 = (y(7)/(y(17)*y(19)))^(params(1)-1);
T79 = params(7)*y(19)*y(16)/y(7);
T80 = y(19)*y(16)/y(7)-params(11);
T83 = params(7)/2;
T86 = 1-params(2)+params(1)*y(18)*T73+T79*T80-T83*T80^2;
T93 = (y(11)*y(7)/y(1)-params(11))^2;
T113 = y(1)^params(1);
T114 = y(10)*T113;
T115 = (y(9)*y(11))^(1-params(1));
lhs =(1-params(5))/params(5)*y(6)/(1-y(9));
rhs =(1-params(1))*y(10)*y(11)*T25;
residual(1)= lhs-rhs;
lhs =T36;
rhs =params(5)*params(6)*(1+y(12))*T41*T45*T49;
residual(2)= lhs-rhs;
lhs =T36*T59;
rhs =T49*T45*params(5)*params(6)*T41*T86;
residual(3)= lhs-rhs;
lhs =y(6)+y(11)*y(7)-y(1)*(1-params(2))+y(1)*T83*T93+y(4);
rhs =y(5)+y(11)*y(13)/(1+y(12));
residual(4)= lhs-rhs;
lhs =y(12);
rhs =params(10)+params(8)*(exp(y(13)-params(9))-1);
residual(5)= lhs-rhs;
lhs =y(5);
rhs =T114*T115;
residual(6)= lhs-rhs;
lhs =log(y(10));
rhs =params(3)*log(y(2))+x(it_, 1);
residual(7)= lhs-rhs;
lhs =log(y(11)/params(11));
rhs =params(4)*log(y(3)/params(11))+x(it_, 2);
residual(8)= lhs-rhs;
lhs =y(14);
rhs =y(4)-y(11)*y(13)/(1+y(12));
residual(9)= lhs-rhs;
lhs =y(8);
rhs =y(11)*y(7)-y(1)*(1-params(2));
residual(10)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(10, 21);

  %
  % Jacobian matrix
  %

T146 = T35*params(5)*getPowerDeriv(y(6),params(5)*(1-params(12))-1,1);
T148 = getPowerDeriv(y(15),params(5)*(1-params(12))-1,1);
T157 = getPowerDeriv(y(1)/(y(9)*y(11)),params(1),1);
T167 = 2*(y(11)*y(7)/y(1)-params(11));
T181 = getPowerDeriv(y(7)/(y(17)*y(19)),params(1)-1,1);
T186 = (-(y(19)*y(16)))/(y(7)*y(7));
T225 = T33*(-(getPowerDeriv(1-y(9),(1-params(5))*(1-params(12)),1)));
T227 = getPowerDeriv(y(9)*y(11),1-params(1),1);
T232 = (-(getPowerDeriv(1-y(17),(1-params(5))*(1-params(12)),1)));
T270 = getPowerDeriv(y(11),params(5)*(1-params(12))-1,1);
  g1(1,6)=(1-params(5))/params(5)*1/(1-y(9));
  g1(1,1)=(-((1-params(1))*y(10)*y(11)*1/(y(9)*y(11))*T157));
  g1(1,9)=(1-params(5))/params(5)*y(6)/((1-y(9))*(1-y(9)))-(1-params(1))*y(10)*y(11)*T157*(-(y(11)*y(1)))/(y(9)*y(11)*y(9)*y(11));
  g1(1,10)=(-(T25*(1-params(1))*y(11)));
  g1(1,11)=(-((1-params(1))*y(10)*T25+(1-params(1))*y(10)*y(11)*T157*(-(y(9)*y(1)))/(y(9)*y(11)*y(9)*y(11))));
  g1(2,6)=T146;
  g1(2,15)=(-(T49*params(5)*params(6)*(1+y(12))*T41*T148));
  g1(2,9)=T225;
  g1(2,17)=(-(params(5)*params(6)*(1+y(12))*T41*T45*T232));
  g1(2,11)=(-(T49*T45*params(5)*params(6)*(1+y(12))*T270));
  g1(2,12)=(-(T49*T45*params(5)*params(6)*T41));
  g1(3,6)=T59*T146;
  g1(3,15)=(-(T86*T49*params(5)*params(6)*T41*T148));
  g1(3,1)=T36*params(7)*(-(y(11)*y(7)))/(y(1)*y(1));
  g1(3,7)=T36*params(7)*y(11)/y(1)-T49*T45*params(5)*params(6)*T41*(params(1)*y(18)*1/(y(17)*y(19))*T181+T80*params(7)*T186+T79*T186-T83*T186*2*T80);
  g1(3,16)=(-(T49*T45*params(5)*params(6)*T41*(T80*params(7)*y(19)/y(7)+T79*y(19)/y(7)-T83*2*T80*y(19)/y(7))));
  g1(3,9)=T59*T225;
  g1(3,17)=(-(T86*T45*params(5)*params(6)*T41*T232+T49*T45*params(5)*params(6)*T41*params(1)*y(18)*T181*(-(y(7)*y(19)))/(y(17)*y(19)*y(17)*y(19))));
  g1(3,18)=(-(T49*T45*params(5)*params(6)*T41*params(1)*T73));
  g1(3,11)=T36*params(7)*y(7)/y(1)-T86*T49*T45*params(5)*params(6)*T270;
  g1(3,19)=(-(T49*T45*params(5)*params(6)*T41*(params(1)*y(18)*T181*(-(y(17)*y(7)))/(y(17)*y(19)*y(17)*y(19))+T80*params(7)*y(16)/y(7)+T79*y(16)/y(7)-T83*2*T80*y(16)/y(7))));
  g1(4,5)=(-1);
  g1(4,6)=1;
  g1(4,1)=(-(1-params(2)))+T83*T93+y(1)*T83*(-(y(11)*y(7)))/(y(1)*y(1))*T167;
  g1(4,7)=y(11)+y(1)*T83*T167*y(11)/y(1);
  g1(4,11)=y(7)+y(1)*T83*T167*y(7)/y(1)-y(13)/(1+y(12));
  g1(4,12)=(-((-(y(11)*y(13)))/((1+y(12))*(1+y(12)))));
  g1(4,4)=1;
  g1(4,13)=(-(y(11)/(1+y(12))));
  g1(5,12)=1;
  g1(5,13)=(-(params(8)*exp(y(13)-params(9))));
  g1(6,5)=1;
  g1(6,1)=(-(T115*y(10)*getPowerDeriv(y(1),params(1),1)));
  g1(6,9)=(-(T114*y(11)*T227));
  g1(6,10)=(-(T113*T115));
  g1(6,11)=(-(T114*y(9)*T227));
  g1(7,2)=(-(params(3)*1/y(2)));
  g1(7,10)=1/y(10);
  g1(7,20)=(-1);
  g1(8,3)=(-(params(4)*1/params(11)/(y(3)/params(11))));
  g1(8,11)=1/params(11)/(y(11)/params(11));
  g1(8,21)=(-1);
  g1(9,11)=y(13)/(1+y(12));
  g1(9,12)=(-(y(11)*y(13)))/((1+y(12))*(1+y(12)));
  g1(9,4)=(-1);
  g1(9,13)=y(11)/(1+y(12));
  g1(9,14)=1;
  g1(10,1)=1-params(2);
  g1(10,7)=(-y(11));
  g1(10,8)=1;
  g1(10,11)=(-y(7));

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],10,441);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],10,9261);
end
end
end
end

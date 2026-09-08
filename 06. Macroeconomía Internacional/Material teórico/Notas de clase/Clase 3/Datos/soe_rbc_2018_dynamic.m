function [residual, g1, g2, g3] = soe_rbc_2018_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(12, 1);
T21 = y(5)-y(8)^params(4)/params(4);
T24 = T21^(-params(10));
T30 = y(17)-y(19)^params(4)/params(4);
T32 = params(5)*T30^(-params(10));
T44 = 1+params(1)*y(16)/y(6)-params(2)+params(6)*(y(18)-y(6));
T45 = T32*T44;
T68 = params(6)/2*(y(6)-y(1))^2;
T81 = y(1)^params(1);
T82 = y(9)*T81;
T83 = y(8)^(1-params(1));
lhs =y(8)^(params(4)-1);
rhs =(1-params(1))*y(4)/y(8);
residual(1)= lhs-rhs;
lhs =T24;
rhs =T45/(1+params(6)*(y(6)-y(1)));
residual(2)= lhs-rhs;
lhs =T24;
rhs =T32*(1+params(9)+params(7)*(exp(y(13)-params(8))-1));
residual(3)= lhs-rhs;
lhs =y(5)+y(7)+T68+y(3)*(1+params(9)+params(7)*(exp(y(3)-params(8))-1));
rhs =y(4)+y(13);
residual(4)= lhs-rhs;
lhs =y(4);
rhs =T82*T83;
residual(5)= lhs-rhs;
lhs =y(6);
rhs =y(7)+y(1)*(1-params(2));
residual(6)= lhs-rhs;
lhs =log(y(9));
rhs =params(3)*log(y(2))+x(it_, 1);
residual(7)= lhs-rhs;
lhs =y(14);
rhs =100*(y(4)-y(5)-y(7)-T68);
residual(8)= lhs-rhs;
lhs =y(15);
rhs =y(14)-y(3)*(params(9)+params(7)*(exp(y(3)-params(8))-1));
residual(9)= lhs-rhs;
lhs =y(10);
rhs =y(4)/y(8);
residual(10)= lhs-rhs;
lhs =y(11);
rhs =params(9)+params(7)*(exp(y(3)-params(8))-1);
residual(11)= lhs-rhs;
lhs =y(12);
rhs =(1-params(1))*y(4)/y(8);
residual(12)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(12, 20);

  %
  % Jacobian matrix
  %

T126 = getPowerDeriv(T21,(-params(10)),1);
T127 = getPowerDeriv(T30,(-params(10)),1);
T178 = T126*(-(getPowerDeriv(y(8),params(4),1)/params(4)));
T188 = params(5)*T127*(-(getPowerDeriv(y(19),params(4),1)/params(4)));
  g1(1,4)=(-((1-params(1))*1/y(8)));
  g1(1,8)=getPowerDeriv(y(8),params(4)-1,1)-(1-params(1))*(-y(4))/(y(8)*y(8));
  g1(2,16)=(-(T32*params(1)*1/y(6)/(1+params(6)*(y(6)-y(1)))));
  g1(2,5)=T126;
  g1(2,17)=(-(T44*params(5)*T127/(1+params(6)*(y(6)-y(1)))));
  g1(2,1)=(-((-(T45*(-params(6))))/((1+params(6)*(y(6)-y(1)))*(1+params(6)*(y(6)-y(1))))));
  g1(2,6)=(-(((1+params(6)*(y(6)-y(1)))*T32*(params(1)*(-y(16))/(y(6)*y(6))-params(6))-params(6)*T45)/((1+params(6)*(y(6)-y(1)))*(1+params(6)*(y(6)-y(1))))));
  g1(2,18)=(-(T32*params(6)/(1+params(6)*(y(6)-y(1)))));
  g1(2,8)=T178;
  g1(2,19)=(-(T44*T188/(1+params(6)*(y(6)-y(1)))));
  g1(3,5)=T126;
  g1(3,17)=(-((1+params(9)+params(7)*(exp(y(13)-params(8))-1))*params(5)*T127));
  g1(3,8)=T178;
  g1(3,19)=(-((1+params(9)+params(7)*(exp(y(13)-params(8))-1))*T188));
  g1(3,13)=(-(T32*params(7)*exp(y(13)-params(8))));
  g1(4,4)=(-1);
  g1(4,5)=1;
  g1(4,1)=params(6)/2*(-(2*(y(6)-y(1))));
  g1(4,6)=params(6)/2*2*(y(6)-y(1));
  g1(4,7)=1;
  g1(4,3)=1+params(9)+params(7)*(exp(y(3)-params(8))-1)+y(3)*params(7)*exp(y(3)-params(8));
  g1(4,13)=(-1);
  g1(5,4)=1;
  g1(5,1)=(-(T83*y(9)*getPowerDeriv(y(1),params(1),1)));
  g1(5,8)=(-(T82*getPowerDeriv(y(8),1-params(1),1)));
  g1(5,9)=(-(T81*T83));
  g1(6,1)=(-(1-params(2)));
  g1(6,6)=1;
  g1(6,7)=(-1);
  g1(7,2)=(-(params(3)*1/y(2)));
  g1(7,9)=1/y(9);
  g1(7,20)=(-1);
  g1(8,4)=(-100);
  g1(8,5)=100;
  g1(8,1)=(-(100*(-(params(6)/2*(-(2*(y(6)-y(1))))))));
  g1(8,6)=(-(100*(-(params(6)/2*2*(y(6)-y(1))))));
  g1(8,7)=100;
  g1(8,14)=1;
  g1(9,3)=params(9)+params(7)*(exp(y(3)-params(8))-1)+y(3)*params(7)*exp(y(3)-params(8));
  g1(9,14)=(-1);
  g1(9,15)=1;
  g1(10,4)=(-(1/y(8)));
  g1(10,8)=(-((-y(4))/(y(8)*y(8))));
  g1(10,10)=1;
  g1(11,11)=1;
  g1(11,3)=(-(params(7)*exp(y(3)-params(8))));
  g1(12,4)=(-((1-params(1))*1/y(8)));
  g1(12,8)=(-((1-params(1))*(-y(4))/(y(8)*y(8))));
  g1(12,12)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],12,400);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],12,8000);
end
end
end
end

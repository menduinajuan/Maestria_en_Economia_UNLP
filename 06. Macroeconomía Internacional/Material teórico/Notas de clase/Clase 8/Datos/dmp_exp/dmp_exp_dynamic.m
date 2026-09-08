function [residual, g1, g2, g3] = dmp_exp_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(16, 1);
T36 = params(1)*exp(y(20))/exp(y(7));
T99 = params(29)*(1-params(2))^(1-params(8))/(1-params(8))-params(27)*(1-exp(y(10)))^(1-params(8))/(1-params(8));
T136 = params(19)*exp(y(15))^params(6);
T176 = (1-params(3))*params(24)/exp(y(24))+exp(y(23))*(1-params(4))/exp(y(5))-exp(y(21))*exp(y(22));
T184 = exp(y(1))^params(4);
T186 = (exp(y(10))*exp(y(16))*exp(y(2)))^(1-params(4));
T190 = exp(y(11))*exp(y(7))*(1-params(4))/(exp(y(10))*exp(y(2)));
T196 = (params(2)*(1-exp(y(2))))^(1-params(6));
T202 = exp(y(9))*exp(y(10))*exp(y(2))/exp(y(11));
lhs =exp(y(4));
rhs =exp(y(6))+(1-params(9))*exp(y(1));
residual(1)= lhs-rhs;
lhs =exp(y(5));
rhs =exp(y(14))+(1-params(3))*exp(y(2));
residual(2)= lhs-rhs;
lhs =1;
rhs =T36*(1-params(9)+params(4)*exp(y(23))/exp(y(4)));
residual(3)= lhs-rhs;
lhs =params(24)/exp(y(12));
rhs =T36*T176;
residual(4)= lhs-rhs;
lhs =exp(y(7));
rhs =1/exp(y(8));
residual(5)= lhs-rhs;
lhs =exp(y(9))*exp(y(10));
rhs =(1-params(5))*(T99/exp(y(7))+params(30))+params(5)*(params(24)*exp(y(13))/exp(y(12))+(1-params(4))*exp(y(11))/exp(y(2)));
residual(6)= lhs-rhs;
lhs =exp(y(11));
rhs =T184*T186;
residual(7)= lhs-rhs;
lhs =T190;
rhs =params(27)*(1-exp(y(10)))^(-params(8));
residual(8)= lhs-rhs;
lhs =exp(y(8));
rhs =exp(y(11))-exp(y(6))-params(24)*exp(y(15));
residual(9)= lhs-rhs;
lhs =exp(y(12));
rhs =exp(y(14))/exp(y(15));
residual(10)= lhs-rhs;
lhs =exp(y(13));
rhs =exp(y(14))/(1-exp(y(2)));
residual(11)= lhs-rhs;
lhs =exp(y(14));
rhs =T136*T196;
residual(12)= lhs-rhs;
lhs =y(16);
rhs =params(14)*y(3)+x(it_, 1);
residual(13)= lhs-rhs;
lhs =exp(y(17));
rhs =exp(y(11))/(exp(y(10))*exp(y(2)));
residual(14)= lhs-rhs;
lhs =exp(y(18));
rhs =T202;
residual(15)= lhs-rhs;
lhs =exp(y(19));
rhs =exp(y(10))*exp(y(2));
residual(16)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(16, 25);

  %
  % Jacobian matrix
  %

T226 = (-(T184*exp(y(10))*exp(y(16))*exp(y(2))*getPowerDeriv(exp(y(10))*exp(y(16))*exp(y(2)),1-params(4),1)));
T230 = (-(exp(y(11))*exp(y(7))*(1-params(4))*exp(y(10))*exp(y(2))))/(exp(y(10))*exp(y(2))*exp(y(10))*exp(y(2)));
T245 = (-((-(exp(y(11))*exp(y(10))*exp(y(2))))/(exp(y(10))*exp(y(2))*exp(y(10))*exp(y(2)))));
T258 = (-(params(1)*exp(y(20))*exp(y(7))))/(exp(y(7))*exp(y(7)));
  g1(1,1)=(-((1-params(9))*exp(y(1))));
  g1(1,4)=exp(y(4));
  g1(1,6)=(-exp(y(6)));
  g1(2,2)=(-((1-params(3))*exp(y(2))));
  g1(2,5)=exp(y(5));
  g1(2,14)=(-exp(y(14)));
  g1(3,4)=(-(T36*(-(exp(y(4))*params(4)*exp(y(23))))/(exp(y(4))*exp(y(4)))));
  g1(3,7)=(-((1-params(9)+params(4)*exp(y(23))/exp(y(4)))*T258));
  g1(3,20)=(-(T36*(1-params(9)+params(4)*exp(y(23))/exp(y(4)))));
  g1(3,23)=(-(T36*params(4)*exp(y(23))/exp(y(4))));
  g1(4,5)=(-(T36*(-(exp(y(5))*exp(y(23))*(1-params(4))))/(exp(y(5))*exp(y(5)))));
  g1(4,7)=(-(T176*T258));
  g1(4,20)=(-(T36*T176));
  g1(4,21)=(-(T36*(-(exp(y(21))*exp(y(22))))));
  g1(4,22)=(-(T36*(-(exp(y(21))*exp(y(22))))));
  g1(4,23)=(-(T36*exp(y(23))*(1-params(4))/exp(y(5))));
  g1(4,12)=(-(params(24)*exp(y(12))))/(exp(y(12))*exp(y(12)));
  g1(4,24)=(-(T36*(-((1-params(3))*params(24)*exp(y(24))))/(exp(y(24))*exp(y(24)))));
  g1(5,7)=exp(y(7));
  g1(5,8)=(-((-exp(y(8)))/(exp(y(8))*exp(y(8)))));
  g1(6,2)=(-(params(5)*(-((1-params(4))*exp(y(11))*exp(y(2))))/(exp(y(2))*exp(y(2)))));
  g1(6,7)=(-((1-params(5))*(-(exp(y(7))*T99))/(exp(y(7))*exp(y(7)))));
  g1(6,9)=exp(y(9))*exp(y(10));
  g1(6,10)=exp(y(9))*exp(y(10))-(1-params(5))*(-(params(27)*(-exp(y(10)))*getPowerDeriv(1-exp(y(10)),1-params(8),1)/(1-params(8))))/exp(y(7));
  g1(6,11)=(-(params(5)*(1-params(4))*exp(y(11))/exp(y(2))));
  g1(6,12)=(-(params(5)*(-(exp(y(12))*params(24)*exp(y(13))))/(exp(y(12))*exp(y(12)))));
  g1(6,13)=(-(params(5)*params(24)*exp(y(13))/exp(y(12))));
  g1(7,1)=(-(T186*exp(y(1))*getPowerDeriv(exp(y(1)),params(4),1)));
  g1(7,2)=T226;
  g1(7,10)=T226;
  g1(7,11)=exp(y(11));
  g1(7,16)=T226;
  g1(8,2)=T230;
  g1(8,7)=T190;
  g1(8,10)=T230-params(27)*(-exp(y(10)))*getPowerDeriv(1-exp(y(10)),(-params(8)),1);
  g1(8,11)=T190;
  g1(9,6)=exp(y(6));
  g1(9,8)=exp(y(8));
  g1(9,11)=(-exp(y(11)));
  g1(9,15)=params(24)*exp(y(15));
  g1(10,12)=exp(y(12));
  g1(10,14)=(-(exp(y(14))/exp(y(15))));
  g1(10,15)=(-((-(exp(y(14))*exp(y(15))))/(exp(y(15))*exp(y(15)))));
  g1(11,2)=(-((-(exp(y(14))*(-exp(y(2)))))/((1-exp(y(2)))*(1-exp(y(2))))));
  g1(11,13)=exp(y(13));
  g1(11,14)=(-(exp(y(14))/(1-exp(y(2)))));
  g1(12,2)=(-(T136*params(2)*(-exp(y(2)))*getPowerDeriv(params(2)*(1-exp(y(2))),1-params(6),1)));
  g1(12,14)=exp(y(14));
  g1(12,15)=(-(T196*params(19)*exp(y(15))*getPowerDeriv(exp(y(15)),params(6),1)));
  g1(13,3)=(-params(14));
  g1(13,16)=1;
  g1(13,25)=(-1);
  g1(14,2)=T245;
  g1(14,10)=T245;
  g1(14,11)=(-(exp(y(11))/(exp(y(10))*exp(y(2)))));
  g1(14,17)=exp(y(17));
  g1(15,2)=(-T202);
  g1(15,9)=(-T202);
  g1(15,10)=(-T202);
  g1(15,11)=(-((-(exp(y(11))*exp(y(9))*exp(y(10))*exp(y(2))))/(exp(y(11))*exp(y(11)))));
  g1(15,18)=exp(y(18));
  g1(16,2)=(-(exp(y(10))*exp(y(2))));
  g1(16,10)=(-(exp(y(10))*exp(y(2))));
  g1(16,19)=exp(y(19));

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],16,625);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],16,15625);
end
end
end
end

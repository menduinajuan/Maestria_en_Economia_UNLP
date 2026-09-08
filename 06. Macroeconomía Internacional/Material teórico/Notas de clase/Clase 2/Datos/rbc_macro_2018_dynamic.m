function [residual, g1, g2, g3] = rbc_macro_2018_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(9, 1);
T41 = y(1)^params(1);
T42 = y(8)*T41;
T43 = y(7)^(1-params(1));
lhs =(1-params(1))*y(3)/y(7);
rhs =(1-params(5))/params(5)*y(4)/(1-y(7));
residual(1)= lhs-rhs;
lhs =1/y(4);
rhs =params(6)*1/y(13)*(1+params(1)*y(12)/y(5)-params(2));
residual(2)= lhs-rhs;
lhs =y(4)+y(6);
rhs =y(3);
residual(3)= lhs-rhs;
lhs =y(3);
rhs =T42*T43;
residual(4)= lhs-rhs;
lhs =y(5);
rhs =y(6)+y(1)*(1-params(2));
residual(5)= lhs-rhs;
lhs =log(y(8));
rhs =params(3)*log(y(2))+x(it_, 1);
residual(6)= lhs-rhs;
lhs =y(9);
rhs =y(3)/y(7);
residual(7)= lhs-rhs;
lhs =y(10);
rhs =params(1)*y(3)/y(1)-params(2);
residual(8)= lhs-rhs;
lhs =y(11);
rhs =(1-params(1))*y(3)/y(7);
residual(9)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(9, 14);

  %
  % Jacobian matrix
  %

  g1(1,3)=(1-params(1))*1/y(7);
  g1(1,4)=(-((1-params(5))/params(5)*1/(1-y(7))));
  g1(1,7)=(1-params(1))*(-y(3))/(y(7)*y(7))-(1-params(5))/params(5)*y(4)/((1-y(7))*(1-y(7)));
  g1(2,12)=(-(params(6)*1/y(13)*params(1)*1/y(5)));
  g1(2,4)=(-1)/(y(4)*y(4));
  g1(2,13)=(-((1+params(1)*y(12)/y(5)-params(2))*params(6)*(-1)/(y(13)*y(13))));
  g1(2,5)=(-(params(6)*1/y(13)*params(1)*(-y(12))/(y(5)*y(5))));
  g1(3,3)=(-1);
  g1(3,4)=1;
  g1(3,6)=1;
  g1(4,3)=1;
  g1(4,1)=(-(T43*y(8)*getPowerDeriv(y(1),params(1),1)));
  g1(4,7)=(-(T42*getPowerDeriv(y(7),1-params(1),1)));
  g1(4,8)=(-(T41*T43));
  g1(5,1)=(-(1-params(2)));
  g1(5,5)=1;
  g1(5,6)=(-1);
  g1(6,2)=(-(params(3)*1/y(2)));
  g1(6,8)=1/y(8);
  g1(6,14)=(-1);
  g1(7,3)=(-(1/y(7)));
  g1(7,7)=(-((-y(3))/(y(7)*y(7))));
  g1(7,9)=1;
  g1(8,3)=(-(params(1)*1/y(1)));
  g1(8,1)=(-(params(1)*(-y(3))/(y(1)*y(1))));
  g1(8,10)=1;
  g1(9,3)=(-((1-params(1))*1/y(7)));
  g1(9,7)=(-((1-params(1))*(-y(3))/(y(7)*y(7))));
  g1(9,11)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],9,196);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],9,2744);
end
end
end
end

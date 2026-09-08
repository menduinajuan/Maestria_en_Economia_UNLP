function [residual, g1, g2, g3] = rbc_macro_2018_static(y, x, params)
%
% Status : Computes static model for Dynare
%
% Inputs : 
%   y         [M_.endo_nbr by 1] double    vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1] double     vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1] double   vector of parameter values in declaration order
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the static model equations 
%                                          in order of declaration of the equations.
%                                          Dynare may prepend or append auxiliary equations, see M_.aux_vars
%   g1        [M_.endo_nbr by M_.endo_nbr] double    Jacobian matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%   g2        [M_.endo_nbr by (M_.endo_nbr)^2] double   Hessian matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%   g3        [M_.endo_nbr by (M_.endo_nbr)^3] double   Third derivatives matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 9, 1);

%
% Model equations
%

T37 = y(3)^params(1);
T38 = y(6)*T37;
T39 = y(5)^(1-params(1));
lhs =(1-params(1))*y(1)/y(5);
rhs =(1-params(5))/params(5)*y(2)/(1-y(5));
residual(1)= lhs-rhs;
lhs =1/y(2);
rhs =1/y(2)*params(6)*(1+params(1)*y(1)/y(3)-params(2));
residual(2)= lhs-rhs;
lhs =y(2)+y(4);
rhs =y(1);
residual(3)= lhs-rhs;
lhs =y(1);
rhs =T38*T39;
residual(4)= lhs-rhs;
lhs =y(3);
rhs =y(4)+y(3)*(1-params(2));
residual(5)= lhs-rhs;
lhs =log(y(6));
rhs =log(y(6))*params(3)+x(1);
residual(6)= lhs-rhs;
lhs =y(7);
rhs =y(1)/y(5);
residual(7)= lhs-rhs;
lhs =y(8);
rhs =params(1)*y(1)/y(3)-params(2);
residual(8)= lhs-rhs;
lhs =y(9);
rhs =(1-params(1))*y(1)/y(5);
residual(9)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(9, 9);

  %
  % Jacobian matrix
  %

  g1(1,1)=(1-params(1))*1/y(5);
  g1(1,2)=(-((1-params(5))/params(5)*1/(1-y(5))));
  g1(1,5)=(1-params(1))*(-y(1))/(y(5)*y(5))-(1-params(5))/params(5)*y(2)/((1-y(5))*(1-y(5)));
  g1(2,1)=(-(1/y(2)*params(6)*params(1)*1/y(3)));
  g1(2,2)=(-1)/(y(2)*y(2))-(1+params(1)*y(1)/y(3)-params(2))*params(6)*(-1)/(y(2)*y(2));
  g1(2,3)=(-(1/y(2)*params(6)*params(1)*(-y(1))/(y(3)*y(3))));
  g1(3,1)=(-1);
  g1(3,2)=1;
  g1(3,4)=1;
  g1(4,1)=1;
  g1(4,3)=(-(T39*y(6)*getPowerDeriv(y(3),params(1),1)));
  g1(4,5)=(-(T38*getPowerDeriv(y(5),1-params(1),1)));
  g1(4,6)=(-(T37*T39));
  g1(5,3)=1-(1-params(2));
  g1(5,4)=(-1);
  g1(6,6)=1/y(6)-params(3)*1/y(6);
  g1(7,1)=(-(1/y(5)));
  g1(7,5)=(-((-y(1))/(y(5)*y(5))));
  g1(7,7)=1;
  g1(8,1)=(-(params(1)*1/y(3)));
  g1(8,3)=(-(params(1)*(-y(1))/(y(3)*y(3))));
  g1(8,8)=1;
  g1(9,1)=(-((1-params(1))*1/y(5)));
  g1(9,5)=(-((1-params(1))*(-y(1))/(y(5)*y(5))));
  g1(9,9)=1;
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],9,81);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],9,729);
end
end
end
end

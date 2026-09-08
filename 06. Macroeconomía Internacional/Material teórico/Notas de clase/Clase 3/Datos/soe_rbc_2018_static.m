function [residual, g1, g2, g3] = soe_rbc_2018_static(y, x, params)
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

residual = zeros( 12, 1);

%
% Model equations
%

T21 = y(2)-y(5)^params(4)/params(4);
T24 = T21^(-params(10));
T32 = 1+params(1)*y(1)/y(3)-params(2);
T56 = y(3)^params(1);
T57 = y(6)*T56;
T58 = y(5)^(1-params(1));
lhs =y(5)^(params(4)-1);
rhs =(1-params(1))*y(1)/y(5);
residual(1)= lhs-rhs;
lhs =T24;
rhs =T24*params(5)*T32;
residual(2)= lhs-rhs;
lhs =T24;
rhs =T24*params(5)*(1+params(9)+params(7)*(exp(y(10)-params(8))-1));
residual(3)= lhs-rhs;
lhs =y(2)+y(4)+y(10)*(1+params(9)+params(7)*(exp(y(10)-params(8))-1));
rhs =y(1)+y(10);
residual(4)= lhs-rhs;
lhs =y(1);
rhs =T57*T58;
residual(5)= lhs-rhs;
lhs =y(3);
rhs =y(4)+y(3)*(1-params(2));
residual(6)= lhs-rhs;
lhs =log(y(6));
rhs =log(y(6))*params(3)+x(1);
residual(7)= lhs-rhs;
lhs =y(11);
rhs =100*(y(1)-y(2)-y(4));
residual(8)= lhs-rhs;
lhs =y(12);
rhs =y(11)-y(10)*(params(9)+params(7)*(exp(y(10)-params(8))-1));
residual(9)= lhs-rhs;
lhs =y(7);
rhs =y(1)/y(5);
residual(10)= lhs-rhs;
lhs =y(8);
rhs =params(9)+params(7)*(exp(y(10)-params(8))-1);
residual(11)= lhs-rhs;
lhs =y(9);
rhs =(1-params(1))*y(1)/y(5);
residual(12)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(12, 12);

  %
  % Jacobian matrix
  %

T97 = getPowerDeriv(T21,(-params(10)),1);
T122 = T97*(-(getPowerDeriv(y(5),params(4),1)/params(4)));
  g1(1,1)=(-((1-params(1))*1/y(5)));
  g1(1,5)=getPowerDeriv(y(5),params(4)-1,1)-(1-params(1))*(-y(1))/(y(5)*y(5));
  g1(2,1)=(-(T24*params(5)*params(1)*1/y(3)));
  g1(2,2)=T97-T32*params(5)*T97;
  g1(2,3)=(-(T24*params(5)*params(1)*(-y(1))/(y(3)*y(3))));
  g1(2,5)=T122-T32*params(5)*T122;
  g1(3,2)=T97-(1+params(9)+params(7)*(exp(y(10)-params(8))-1))*params(5)*T97;
  g1(3,5)=T122-(1+params(9)+params(7)*(exp(y(10)-params(8))-1))*params(5)*T122;
  g1(3,10)=(-(T24*params(5)*params(7)*exp(y(10)-params(8))));
  g1(4,1)=(-1);
  g1(4,2)=1;
  g1(4,4)=1;
  g1(4,10)=1+params(9)+params(7)*(exp(y(10)-params(8))-1)+y(10)*params(7)*exp(y(10)-params(8))-1;
  g1(5,1)=1;
  g1(5,3)=(-(T58*y(6)*getPowerDeriv(y(3),params(1),1)));
  g1(5,5)=(-(T57*getPowerDeriv(y(5),1-params(1),1)));
  g1(5,6)=(-(T56*T58));
  g1(6,3)=1-(1-params(2));
  g1(6,4)=(-1);
  g1(7,6)=1/y(6)-params(3)*1/y(6);
  g1(8,1)=(-100);
  g1(8,2)=100;
  g1(8,4)=100;
  g1(8,11)=1;
  g1(9,10)=params(9)+params(7)*(exp(y(10)-params(8))-1)+y(10)*params(7)*exp(y(10)-params(8));
  g1(9,11)=(-1);
  g1(9,12)=1;
  g1(10,1)=(-(1/y(5)));
  g1(10,5)=(-((-y(1))/(y(5)*y(5))));
  g1(10,7)=1;
  g1(11,8)=1;
  g1(11,10)=(-(params(7)*exp(y(10)-params(8))));
  g1(12,1)=(-((1-params(1))*1/y(5)));
  g1(12,5)=(-((1-params(1))*(-y(1))/(y(5)*y(5))));
  g1(12,9)=1;
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],12,144);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],12,1728);
end
end
end
end

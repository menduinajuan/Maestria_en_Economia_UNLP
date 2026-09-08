function [residual, g1, g2, g3] = dmp_exp_static(y, x, params)
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

residual = zeros( 16, 1);

%
% Model equations
%

T30 = params(1)*exp(y(4))/exp(y(4));
T47 = exp(y(8))*(1-params(4))/exp(y(2));
T76 = params(29)*(1-params(2))^(1-params(8))/(1-params(8))-params(27)*(1-exp(y(7)))^(1-params(8))/(1-params(8));
T89 = exp(y(1))^params(4);
T94 = (exp(y(2))*exp(y(7))*exp(y(13)))^(1-params(4));
T100 = exp(y(8))*exp(y(4))*(1-params(4))/(exp(y(2))*exp(y(7)));
T119 = params(19)*exp(y(12))^params(6);
T122 = (params(2)*(1-exp(y(2))))^(1-params(6));
T137 = exp(y(2))*exp(y(6))*exp(y(7))/exp(y(8));
lhs =exp(y(1));
rhs =exp(y(3))+exp(y(1))*(1-params(9));
residual(1)= lhs-rhs;
lhs =exp(y(2));
rhs =exp(y(11))+exp(y(2))*(1-params(3));
residual(2)= lhs-rhs;
lhs =1;
rhs =T30*(1-params(9)+params(4)*exp(y(8))/exp(y(1)));
residual(3)= lhs-rhs;
lhs =params(24)/exp(y(9));
rhs =T30*((1-params(3))*params(24)/exp(y(9))+T47-exp(y(6))*exp(y(7)));
residual(4)= lhs-rhs;
lhs =exp(y(4));
rhs =1/exp(y(5));
residual(5)= lhs-rhs;
lhs =exp(y(6))*exp(y(7));
rhs =(1-params(5))*(T76/exp(y(4))+params(30))+params(5)*(T47+params(24)*exp(y(10))/exp(y(9)));
residual(6)= lhs-rhs;
lhs =exp(y(8));
rhs =T89*T94;
residual(7)= lhs-rhs;
lhs =T100;
rhs =params(27)*(1-exp(y(7)))^(-params(8));
residual(8)= lhs-rhs;
lhs =exp(y(5));
rhs =exp(y(8))-exp(y(3))-params(24)*exp(y(12));
residual(9)= lhs-rhs;
lhs =exp(y(9));
rhs =exp(y(11))/exp(y(12));
residual(10)= lhs-rhs;
lhs =exp(y(10));
rhs =exp(y(11))/(1-exp(y(2)));
residual(11)= lhs-rhs;
lhs =exp(y(11));
rhs =T119*T122;
residual(12)= lhs-rhs;
lhs =y(13);
rhs =y(13)*params(14)+x(1);
residual(13)= lhs-rhs;
lhs =exp(y(14));
rhs =exp(y(8))/(exp(y(2))*exp(y(7)));
residual(14)= lhs-rhs;
lhs =exp(y(15));
rhs =T137;
residual(15)= lhs-rhs;
lhs =exp(y(16));
rhs =exp(y(2))*exp(y(7));
residual(16)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(16, 16);

  %
  % Jacobian matrix
  %

T157 = (-(exp(y(2))*exp(y(8))*(1-params(4))))/(exp(y(2))*exp(y(2)));
T165 = (-(T89*exp(y(2))*exp(y(7))*exp(y(13))*getPowerDeriv(exp(y(2))*exp(y(7))*exp(y(13)),1-params(4),1)));
T169 = (-(exp(y(8))*exp(y(4))*(1-params(4))*exp(y(2))*exp(y(7))))/(exp(y(2))*exp(y(7))*exp(y(2))*exp(y(7)));
T184 = (-((-(exp(y(8))*exp(y(2))*exp(y(7))))/(exp(y(2))*exp(y(7))*exp(y(2))*exp(y(7)))));
  g1(1,1)=exp(y(1))-exp(y(1))*(1-params(9));
  g1(1,3)=(-exp(y(3)));
  g1(2,2)=exp(y(2))-exp(y(2))*(1-params(3));
  g1(2,11)=(-exp(y(11)));
  g1(3,1)=(-(T30*(-(exp(y(1))*params(4)*exp(y(8))))/(exp(y(1))*exp(y(1)))));
  g1(3,8)=(-(T30*params(4)*exp(y(8))/exp(y(1))));
  g1(4,2)=(-(T30*T157));
  g1(4,6)=(-(T30*(-(exp(y(6))*exp(y(7))))));
  g1(4,7)=(-(T30*(-(exp(y(6))*exp(y(7))))));
  g1(4,8)=(-(T30*T47));
  g1(4,9)=(-(params(24)*exp(y(9))))/(exp(y(9))*exp(y(9)))-T30*(-(exp(y(9))*(1-params(3))*params(24)))/(exp(y(9))*exp(y(9)));
  g1(5,4)=exp(y(4));
  g1(5,5)=(-((-exp(y(5)))/(exp(y(5))*exp(y(5)))));
  g1(6,2)=(-(params(5)*T157));
  g1(6,4)=(-((1-params(5))*(-(exp(y(4))*T76))/(exp(y(4))*exp(y(4)))));
  g1(6,6)=exp(y(6))*exp(y(7));
  g1(6,7)=exp(y(6))*exp(y(7))-(1-params(5))*(-(params(27)*(-exp(y(7)))*getPowerDeriv(1-exp(y(7)),1-params(8),1)/(1-params(8))))/exp(y(4));
  g1(6,8)=(-(T47*params(5)));
  g1(6,9)=(-(params(5)*(-(exp(y(9))*params(24)*exp(y(10))))/(exp(y(9))*exp(y(9)))));
  g1(6,10)=(-(params(5)*params(24)*exp(y(10))/exp(y(9))));
  g1(7,1)=(-(T94*exp(y(1))*getPowerDeriv(exp(y(1)),params(4),1)));
  g1(7,2)=T165;
  g1(7,7)=T165;
  g1(7,8)=exp(y(8));
  g1(7,13)=T165;
  g1(8,2)=T169;
  g1(8,4)=T100;
  g1(8,7)=T169-params(27)*(-exp(y(7)))*getPowerDeriv(1-exp(y(7)),(-params(8)),1);
  g1(8,8)=T100;
  g1(9,3)=exp(y(3));
  g1(9,5)=exp(y(5));
  g1(9,8)=(-exp(y(8)));
  g1(9,12)=params(24)*exp(y(12));
  g1(10,9)=exp(y(9));
  g1(10,11)=(-(exp(y(11))/exp(y(12))));
  g1(10,12)=(-((-(exp(y(11))*exp(y(12))))/(exp(y(12))*exp(y(12)))));
  g1(11,2)=(-((-(exp(y(11))*(-exp(y(2)))))/((1-exp(y(2)))*(1-exp(y(2))))));
  g1(11,10)=exp(y(10));
  g1(11,11)=(-(exp(y(11))/(1-exp(y(2)))));
  g1(12,2)=(-(T119*params(2)*(-exp(y(2)))*getPowerDeriv(params(2)*(1-exp(y(2))),1-params(6),1)));
  g1(12,11)=exp(y(11));
  g1(12,12)=(-(T122*params(19)*exp(y(12))*getPowerDeriv(exp(y(12)),params(6),1)));
  g1(13,13)=1-params(14);
  g1(14,2)=T184;
  g1(14,7)=T184;
  g1(14,8)=(-(exp(y(8))/(exp(y(2))*exp(y(7)))));
  g1(14,14)=exp(y(14));
  g1(15,2)=(-T137);
  g1(15,6)=(-T137);
  g1(15,7)=(-T137);
  g1(15,8)=(-((-(exp(y(8))*exp(y(2))*exp(y(6))*exp(y(7))))/(exp(y(8))*exp(y(8)))));
  g1(15,15)=exp(y(15));
  g1(16,2)=(-(exp(y(2))*exp(y(7))));
  g1(16,7)=(-(exp(y(2))*exp(y(7))));
  g1(16,16)=exp(y(16));
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],16,256);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],16,4096);
end
end
end
end

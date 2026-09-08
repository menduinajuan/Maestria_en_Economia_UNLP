function [residual, g1, g2, g3] = soe_aguiar_2019_static(y, x, params)
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

residual = zeros( 10, 1);

%
% Model equations
%

T24 = y(3)/(y(5)*y(7));
T25 = T24^params(1);
T32 = y(2)^(params(5)*(1-params(12))-1);
T35 = (1-y(5))^((1-params(5))*(1-params(12)));
T41 = y(7)^(params(5)*(1-params(12))-1);
T51 = y(7)*y(3)/y(3)-params(11);
T53 = 1+params(7)*T51;
T63 = T24^(params(1)-1);
T70 = T51^2;
T72 = 1-params(2)+params(1)*y(6)*T63+T51*params(7)*y(7)*y(3)/y(3)-params(7)/2*T70;
T97 = y(3)^params(1);
T98 = y(6)*T97;
T99 = (y(5)*y(7))^(1-params(1));
lhs =(1-params(5))/params(5)*y(2)/(1-y(5));
rhs =(1-params(1))*y(6)*y(7)*T25;
residual(1)= lhs-rhs;
lhs =params(5)*T32*T35;
rhs =T35*T32*params(5)*params(6)*(1+y(8))*T41;
residual(2)= lhs-rhs;
lhs =params(5)*T32*T35*T53;
rhs =T35*T32*params(5)*params(6)*T41*T72;
residual(3)= lhs-rhs;
lhs =y(2)+y(7)*y(3)-y(3)*(1-params(2))+T70*y(3)*params(7)/2+y(9);
rhs =y(1)+y(7)*y(9)/(1+y(8));
residual(4)= lhs-rhs;
lhs =y(8);
rhs =params(10)+params(8)*(exp(y(9)-params(9))-1);
residual(5)= lhs-rhs;
lhs =y(1);
rhs =T98*T99;
residual(6)= lhs-rhs;
lhs =log(y(6));
rhs =log(y(6))*params(3)+x(1);
residual(7)= lhs-rhs;
lhs =log(y(7)/params(11));
rhs =log(y(7)/params(11))*params(4)+x(2);
residual(8)= lhs-rhs;
lhs =y(10);
rhs =y(9)-y(7)*y(9)/(1+y(8));
residual(9)= lhs-rhs;
lhs =y(4);
rhs =y(7)*y(3)-y(3)*(1-params(2));
residual(10)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(10, 10);

  %
  % Jacobian matrix
  %

T123 = getPowerDeriv(y(2),params(5)*(1-params(12))-1,1);
T135 = getPowerDeriv(T24,params(1),1);
T140 = getPowerDeriv(T24,params(1)-1,1);
T163 = (-(getPowerDeriv(1-y(5),(1-params(5))*(1-params(12)),1)));
T175 = getPowerDeriv(y(5)*y(7),1-params(1),1);
T198 = getPowerDeriv(y(7),params(5)*(1-params(12))-1,1);
T228 = 1/params(11)/(y(7)/params(11));
  g1(1,2)=(1-params(5))/params(5)*1/(1-y(5));
  g1(1,3)=(-((1-params(1))*y(6)*y(7)*1/(y(5)*y(7))*T135));
  g1(1,5)=(1-params(5))/params(5)*y(2)/((1-y(5))*(1-y(5)))-(1-params(1))*y(6)*y(7)*T135*(-(y(7)*y(3)))/(y(5)*y(7)*y(5)*y(7));
  g1(1,6)=(-(T25*(1-params(1))*y(7)));
  g1(1,7)=(-((1-params(1))*y(6)*T25+(1-params(1))*y(6)*y(7)*T135*(-(y(5)*y(3)))/(y(5)*y(7)*y(5)*y(7))));
  g1(2,2)=T35*params(5)*T123-T35*params(5)*params(6)*(1+y(8))*T41*T123;
  g1(2,5)=params(5)*T32*T163-T32*params(5)*params(6)*(1+y(8))*T41*T163;
  g1(2,7)=(-(T35*T32*params(5)*params(6)*(1+y(8))*T198));
  g1(2,8)=(-(T35*T32*params(5)*params(6)*T41));
  g1(3,2)=T53*T35*params(5)*T123-T72*T35*params(5)*params(6)*T41*T123;
  g1(3,3)=(-(T35*T32*params(5)*params(6)*T41*params(1)*y(6)*1/(y(5)*y(7))*T140));
  g1(3,5)=T53*params(5)*T32*T163-(T72*T32*params(5)*params(6)*T41*T163+T35*T32*params(5)*params(6)*T41*params(1)*y(6)*T140*(-(y(7)*y(3)))/(y(5)*y(7)*y(5)*y(7)));
  g1(3,6)=(-(T35*T32*params(5)*params(6)*T41*params(1)*T63));
  g1(3,7)=params(5)*T32*T35*params(7)-(T72*T35*T32*params(5)*params(6)*T198+T35*T32*params(5)*params(6)*T41*(params(1)*y(6)*T140*(-(y(5)*y(3)))/(y(5)*y(7)*y(5)*y(7))+params(7)*T51+params(7)*y(7)*y(3)/y(3)-params(7)/2*2*T51));
  g1(4,1)=(-1);
  g1(4,2)=1;
  g1(4,3)=params(7)/2*T70+y(7)-(1-params(2));
  g1(4,7)=y(3)+y(3)*params(7)/2*2*T51-y(9)/(1+y(8));
  g1(4,8)=(-((-(y(7)*y(9)))/((1+y(8))*(1+y(8)))));
  g1(4,9)=1-y(7)/(1+y(8));
  g1(5,8)=1;
  g1(5,9)=(-(params(8)*exp(y(9)-params(9))));
  g1(6,1)=1;
  g1(6,3)=(-(T99*y(6)*getPowerDeriv(y(3),params(1),1)));
  g1(6,5)=(-(T98*y(7)*T175));
  g1(6,6)=(-(T97*T99));
  g1(6,7)=(-(T98*y(5)*T175));
  g1(7,6)=1/y(6)-params(3)*1/y(6);
  g1(8,7)=T228-params(4)*T228;
  g1(9,7)=y(9)/(1+y(8));
  g1(9,8)=(-(y(7)*y(9)))/((1+y(8))*(1+y(8)));
  g1(9,9)=(-(1-y(7)/(1+y(8))));
  g1(9,10)=1;
  g1(10,3)=(-(y(7)-(1-params(2))));
  g1(10,4)=1;
  g1(10,7)=(-y(3));
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],10,100);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],10,1000);
end
end
end
end

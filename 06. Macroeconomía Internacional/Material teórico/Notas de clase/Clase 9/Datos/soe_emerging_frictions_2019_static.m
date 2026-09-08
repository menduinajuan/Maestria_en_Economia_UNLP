function [residual, g1, g2, g3] = soe_emerging_frictions_2019_static(y, x, params)
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

residual = zeros( 13, 1);

%
% Model equations
%

T17 = y(9)^(1-params(1));
T18 = (1-params(1))*y(8)*T17;
T21 = (y(3)/y(4))^params(1);
T22 = T18*T21;
T28 = 1+params(7)*y(7)/(1+y(7));
T35 = y(2)-y(4)^params(5)/params(5);
T38 = T35^(-params(3));
T39 = y(10)*T38;
T41 = y(9)^params(3);
T42 = params(4)/T41;
T50 = y(9)*y(3)/y(3)-params(11);
T52 = 1+params(6)*T50;
T61 = (y(3)/(y(4)*y(9)))^(params(1)-1);
T68 = T50^2;
T70 = 1-params(2)+params(1)*y(8)*T61+T50*params(6)*y(9)*y(3)/y(3)-params(6)/2*T68;
T112 = y(3)^params(1);
T113 = y(8)*T112;
T114 = (y(4)*y(9))^(1-params(1));
lhs =y(4)^(params(5)-1);
rhs =T22/T28;
residual(1)= lhs-rhs;
lhs =T39;
rhs =T39*(1+y(7))*T42;
residual(2)= lhs-rhs;
lhs =T39*T52;
rhs =T39*T42*T70;
residual(3)= lhs-rhs;
lhs =y(2)+y(6)+T68*y(3)*params(6)/2+y(12)+y(5);
rhs =y(1)+y(9)*y(5)/(1+y(7));
residual(4)= lhs-rhs;
lhs =y(13);
rhs =y(1)-y(2)-y(6)-T68*y(3)*params(6)/2-y(12);
residual(5)= lhs-rhs;
lhs =y(9)*y(3);
rhs =y(6)+y(3)*(1-params(2));
residual(6)= lhs-rhs;
lhs =y(7);
rhs =params(10)+params(8)*(exp((y(5)-params(9))/params(12))-1)+exp(y(11)-1)-1;
residual(7)= lhs-rhs;
lhs =y(1);
rhs =T113*T114;
residual(8)= lhs-rhs;
lhs =log(y(8));
rhs =log(y(8))*params(14)+x(1);
residual(9)= lhs-rhs;
lhs =log(y(9)/params(11));
rhs =log(y(9)/params(11))*params(15)+x(2);
residual(10)= lhs-rhs;
lhs =log(y(12)/params(13));
rhs =log(y(12)/params(13))*params(18)+x(5);
residual(11)= lhs-rhs;
lhs =log(y(10));
rhs =log(y(10))*params(16)+x(3);
residual(12)= lhs-rhs;
lhs =log(y(11));
rhs =log(y(11))*params(17)+x(4);
residual(13)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(13, 13);

  %
  % Jacobian matrix
  %

T150 = getPowerDeriv(T35,(-params(3)),1);
T151 = y(10)*T150;
T159 = getPowerDeriv(y(3)/y(4),params(1),1);
T166 = getPowerDeriv(y(3)/(y(4)*y(9)),params(1)-1,1);
T189 = y(10)*T150*(-(getPowerDeriv(y(4),params(5),1)/params(5)));
T203 = getPowerDeriv(y(4)*y(9),1-params(1),1);
T247 = (-(params(4)*getPowerDeriv(y(9),params(3),1)))/(T41*T41);
T275 = 1/params(11)/(y(9)/params(11));
T292 = 1/params(13)/(y(12)/params(13));
  g1(1,3)=(-(T18*1/y(4)*T159/T28));
  g1(1,4)=getPowerDeriv(y(4),params(5)-1,1)-T18*T159*(-y(3))/(y(4)*y(4))/T28;
  g1(1,7)=(-((-(T22*(params(7)*(1+y(7))-params(7)*y(7))/((1+y(7))*(1+y(7)))))/(T28*T28)));
  g1(1,8)=(-(T21*(1-params(1))*T17/T28));
  g1(1,9)=(-(T21*(1-params(1))*y(8)*getPowerDeriv(y(9),1-params(1),1)/T28));
  g1(2,2)=T151-(1+y(7))*T42*T151;
  g1(2,4)=T189-(1+y(7))*T42*T189;
  g1(2,7)=(-(T39*T42));
  g1(2,9)=(-(T39*(1+y(7))*T247));
  g1(2,10)=T38-T38*(1+y(7))*T42;
  g1(3,2)=T52*T151-T70*T42*T151;
  g1(3,3)=(-(T39*T42*params(1)*y(8)*1/(y(4)*y(9))*T166));
  g1(3,4)=T52*T189-(T70*T42*T189+T39*T42*params(1)*y(8)*T166*(-(y(9)*y(3)))/(y(4)*y(9)*y(4)*y(9)));
  g1(3,8)=(-(T39*T42*params(1)*T61));
  g1(3,9)=T39*params(6)-(T70*T39*T247+T39*T42*(params(1)*y(8)*T166*(-(y(4)*y(3)))/(y(4)*y(9)*y(4)*y(9))+params(6)*T50+params(6)*y(9)*y(3)/y(3)-params(6)/2*2*T50));
  g1(3,10)=T38*T52-T70*T38*T42;
  g1(4,1)=(-1);
  g1(4,2)=1;
  g1(4,3)=params(6)/2*T68;
  g1(4,5)=1-y(9)/(1+y(7));
  g1(4,6)=1;
  g1(4,7)=(-((-(y(9)*y(5)))/((1+y(7))*(1+y(7)))));
  g1(4,9)=y(3)*params(6)/2*2*T50-y(5)/(1+y(7));
  g1(4,12)=1;
  g1(5,1)=(-1);
  g1(5,2)=1;
  g1(5,3)=params(6)/2*T68;
  g1(5,6)=1;
  g1(5,9)=y(3)*params(6)/2*2*T50;
  g1(5,12)=1;
  g1(5,13)=1;
  g1(6,3)=y(9)-(1-params(2));
  g1(6,6)=(-1);
  g1(6,9)=y(3);
  g1(7,5)=(-(params(8)*exp((y(5)-params(9))/params(12))*1/params(12)));
  g1(7,7)=1;
  g1(7,11)=(-exp(y(11)-1));
  g1(8,1)=1;
  g1(8,3)=(-(T114*y(8)*getPowerDeriv(y(3),params(1),1)));
  g1(8,4)=(-(T113*y(9)*T203));
  g1(8,8)=(-(T112*T114));
  g1(8,9)=(-(T113*y(4)*T203));
  g1(9,8)=1/y(8)-params(14)*1/y(8);
  g1(10,9)=T275-params(15)*T275;
  g1(11,12)=T292-params(18)*T292;
  g1(12,10)=1/y(10)-params(16)*1/y(10);
  g1(13,11)=1/y(11)-params(17)*1/y(11);
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],13,169);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],13,2197);
end
end
end
end

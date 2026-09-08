function [residual, g1, g2, g3] = dmp_2c_xu_static(y, x, params)
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

residual = zeros( 52, 1);

%
% Model equations
%

T51 = exp(y(35))*y(3)^(1-params(5));
T54 = (y(5)*y(15))^params(5);
T72 = params(52)*(1-y(15))^(-params(2));
T93 = params(9)*(params(57)*(1-params(21))^(1-params(2))/(1-params(2))-params(52)*(1-y(15))^(1-params(2))/(1-params(2)));
T139 = (y(29)-y(3)*params(6))^2;
T141 = y(3)^2;
T148 = (1-params(6))*y(27)+y(7)*(1-params(5))*y(19)/y(3)+y(19)*params(8)/2*T139/T141+(y(29)-y(3)*params(6))*params(6)*y(19)*params(8)/y(3);
T176 = exp(y(36))*y(4)^(1-params(5));
T179 = (y(6)*y(16))^params(5);
T194 = params(52)*(1-y(16))^(-params(2));
T212 = params(9)*(params(57)*(1-params(24))^(1-params(2))/(1-params(2))-params(52)*(1-y(16))^(1-params(2))/(1-params(2)));
T255 = (y(30)-params(6)*y(4))^2;
T257 = y(4)^2;
T264 = (1-params(6))*y(28)+y(8)*(1-params(5))*y(20)/y(4)+params(8)*y(20)/2*T255/T257+(y(30)-params(6)*y(4))*params(6)*params(8)*y(20)/y(4);
T286 = params(8)/2;
T306 = y(19)^(1-params(4));
T310 = y(20)^(1-params(4));
T325 = params(3)*(y(19)/y(13))^(-params(4));
T331 = (1-params(3))*(y(19)/y(14))^(-params(4));
T339 = params(3)*(y(20)/y(14))^(-params(4));
T344 = (1-params(3))*(y(20)/y(13))^(-params(4));
residual(1) = y(29)+(-y(3))+y(3)*(1-params(6));
residual(2) = y(25)*y(1)+(-y(5))+y(5)*(1-params(7));
residual(3) = y(30)+(-y(4))+(1-params(6))*y(4);
residual(4) = y(26)*y(2)+(-y(6))+(1-params(7))*y(6);
residual(5) = (-y(7))+T51*T54;
residual(6) = (-1)/y(9)+y(11)*y(13);
residual(7) = y(7)*params(5)/(y(5)*y(15))-T72/(y(11)*y(19));
residual(8) = y(15)*(-y(17))+T93/y(11)+(1-params(9))*(y(19)*params(21)*y(21)*params(44)+y(15)*y(7)*params(5)*y(19)/(y(5)*y(15)));
residual(9) = y(11)*(-y(23))+y(11)*params(1)*((1-params(7))*y(23)+y(15)*y(7)*params(5)*y(19)/(y(5)*y(15))-y(15)*y(17));
residual(10) = params(44)*(-y(19))+y(25)*y(23);
residual(11) = y(11)*(-y(27))+y(11)*params(1)*T148;
residual(12) = y(13)-y(27)+y(19)*params(8)*(y(29)-y(3)*params(6))/y(3);
residual(13) = (-y(25))+params(30)*y(21)^(params(10)-1);
residual(14) = (-y(21))+y(1)/(params(21)*(1-y(5)));
residual(15) = (-y(8))+T176*T179;
residual(16) = (-1)/y(10)+y(12)*y(14);
residual(17) = params(5)*y(8)/(y(6)*y(16))-T194/(y(12)*y(20));
residual(18) = y(16)*(-y(18))+T212/y(12)+(1-params(9))*(y(20)*params(24)*y(22)*params(45)+y(16)*y(8)*params(5)*y(20)/(y(6)*y(16)));
residual(19) = y(12)*(-y(24))+params(1)*y(12)*((1-params(7))*y(24)+y(16)*y(8)*params(5)*y(20)/(y(6)*y(16))-y(16)*y(18));
residual(20) = params(45)*(-y(20))+y(26)*y(24);
residual(21) = y(12)*(-y(28))+params(1)*y(12)*T264;
residual(22) = y(14)-y(28)+params(8)*y(20)*(y(30)-params(6)*y(4))/y(4);
residual(23) = (-y(26))+params(30)*y(22)^(params(10)-1);
residual(24) = (-y(22))+y(2)/(params(24)*(1-y(6)));
residual(25) = y(7)-y(31)-T139*T286/y(3)-y(1)*params(44);
residual(26) = y(8)-y(32)-T255*T286/y(4)-y(2)*params(45);
residual(27) = (-(y(13)^(1-params(4))))+params(3)*T306+(1-params(3))*T310;
residual(28) = (-(y(14)^(1-params(4))))+params(3)*T310+T306*(1-params(3));
residual(29) = (-y(31))+T325*(y(29)+y(9))+T331*(y(30)+y(10));
residual(30) = (-y(32))+(y(30)+y(10))*T339+(y(29)+y(9))*T344;
residual(31) = y(12)-y(11);
residual(32) = y(19)-1;
lhs =y(35);
rhs =y(35)*params(13)+y(36)*params(14)+x(1)+params(59)*x(2);
residual(33)= lhs-rhs;
lhs =y(36);
rhs =x(2)+y(36)*params(13)+y(35)*params(14)+x(1)*params(59);
residual(34)= lhs-rhs;
lhs =y(37);
rhs =y(7)/(y(5)*y(15));
residual(35)= lhs-rhs;
lhs =y(43);
rhs =y(5)*y(15)*y(17)/y(7);
residual(36)= lhs-rhs;
lhs =y(39);
rhs =y(5)*y(15);
residual(37)= lhs-rhs;
lhs =y(38);
rhs =y(8)/(y(6)*y(16));
residual(38)= lhs-rhs;
lhs =y(44);
rhs =y(6)*y(16)*y(18)/y(8);
residual(39)= lhs-rhs;
lhs =y(40);
rhs =y(6)*y(16);
residual(40)= lhs-rhs;
lhs =y(45);
rhs =log(y(31));
residual(41)= lhs-rhs;
lhs =y(46);
rhs =log(y(32));
residual(42)= lhs-rhs;
lhs =y(47);
rhs =log(y(5));
residual(43)= lhs-rhs;
lhs =y(48);
rhs =log(y(6));
residual(44)= lhs-rhs;
lhs =y(49);
rhs =log(y(29));
residual(45)= lhs-rhs;
lhs =y(50);
rhs =log(y(30));
residual(46)= lhs-rhs;
lhs =y(51);
rhs =log(y(9));
residual(47)= lhs-rhs;
lhs =y(52);
rhs =log(y(10));
residual(48)= lhs-rhs;
lhs =y(33);
rhs =log(y(1));
residual(49)= lhs-rhs;
lhs =y(34);
rhs =log(y(2));
residual(50)= lhs-rhs;
lhs =y(41);
rhs =log(y(39));
residual(51)= lhs-rhs;
lhs =y(42);
rhs =log(y(40));
residual(52)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(52, 52);

  %
  % Jacobian matrix
  %

T498 = getPowerDeriv(y(5)*y(15),params(5),1);
T525 = getPowerDeriv(y(6)*y(16),params(5),1);
T614 = getPowerDeriv(y(19)/y(13),(-params(4)),1);
T619 = getPowerDeriv(y(20)/y(13),(-params(4)),1);
T627 = getPowerDeriv(y(19)/y(14),(-params(4)),1);
T632 = getPowerDeriv(y(20)/y(14),(-params(4)),1);
T658 = y(7)*params(5)*y(19)/(y(5)*y(15))+y(15)*(-(y(5)*y(7)*params(5)*y(19)))/(y(5)*y(15)*y(5)*y(15));
T692 = y(8)*params(5)*y(20)/(y(6)*y(16))+y(16)*(-(y(6)*y(8)*params(5)*y(20)))/(y(6)*y(16)*y(6)*y(16));
T731 = getPowerDeriv(y(19),1-params(4),1);
T763 = getPowerDeriv(y(20),1-params(4),1);
  g1(1,3)=(-1)+1-params(6);
  g1(1,29)=1;
  g1(2,1)=y(25);
  g1(2,5)=(-1)+1-params(7);
  g1(2,25)=y(1);
  g1(3,4)=(-1)+1-params(6);
  g1(3,30)=1;
  g1(4,2)=y(26);
  g1(4,6)=(-1)+1-params(7);
  g1(4,26)=y(2);
  g1(5,3)=T54*exp(y(35))*getPowerDeriv(y(3),1-params(5),1);
  g1(5,5)=T51*y(15)*T498;
  g1(5,7)=(-1);
  g1(5,15)=T51*y(5)*T498;
  g1(5,35)=T51*T54;
  g1(6,9)=1/(y(9)*y(9));
  g1(6,11)=y(13);
  g1(6,13)=y(11);
  g1(7,5)=(-(y(15)*y(7)*params(5)))/(y(5)*y(15)*y(5)*y(15));
  g1(7,7)=params(5)/(y(5)*y(15));
  g1(7,11)=(-((-(T72*y(19)))/(y(11)*y(19)*y(11)*y(19))));
  g1(7,15)=(-(y(5)*y(7)*params(5)))/(y(5)*y(15)*y(5)*y(15))-params(52)*(-(getPowerDeriv(1-y(15),(-params(2)),1)))/(y(11)*y(19));
  g1(7,19)=(-((-(y(11)*T72))/(y(11)*y(19)*y(11)*y(19))));
  g1(8,5)=(1-params(9))*y(15)*(-(y(15)*y(7)*params(5)*y(19)))/(y(5)*y(15)*y(5)*y(15));
  g1(8,7)=(1-params(9))*y(15)*params(5)*y(19)/(y(5)*y(15));
  g1(8,11)=(-T93)/(y(11)*y(11));
  g1(8,15)=(-y(17))+params(9)*(-(params(52)*(-(getPowerDeriv(1-y(15),1-params(2),1)))/(1-params(2))))/y(11)+(1-params(9))*T658;
  g1(8,17)=(-y(15));
  g1(8,19)=(1-params(9))*(params(44)*params(21)*y(21)+y(15)*y(7)*params(5)/(y(5)*y(15)));
  g1(8,21)=(1-params(9))*y(19)*params(21)*params(44);
  g1(9,5)=y(11)*params(1)*y(15)*(-(y(15)*y(7)*params(5)*y(19)))/(y(5)*y(15)*y(5)*y(15));
  g1(9,7)=y(11)*params(1)*y(15)*params(5)*y(19)/(y(5)*y(15));
  g1(9,11)=(-y(23))+params(1)*((1-params(7))*y(23)+y(15)*y(7)*params(5)*y(19)/(y(5)*y(15))-y(15)*y(17));
  g1(9,15)=y(11)*params(1)*(T658-y(17));
  g1(9,17)=y(11)*params(1)*(-y(15));
  g1(9,19)=y(11)*params(1)*y(15)*y(7)*params(5)/(y(5)*y(15));
  g1(9,23)=(-y(11))+(1-params(7))*y(11)*params(1);
  g1(10,19)=(-params(44));
  g1(10,23)=y(25);
  g1(10,25)=y(23);
  g1(11,3)=y(11)*params(1)*((-(y(7)*(1-params(5))*y(19)))/(y(3)*y(3))+(T141*y(19)*params(8)/2*(-params(6))*2*(y(29)-y(3)*params(6))-y(19)*params(8)/2*T139*2*y(3))/(T141*T141)+(y(3)*params(6)*y(19)*params(8)*(-params(6))-(y(29)-y(3)*params(6))*params(6)*y(19)*params(8))/(y(3)*y(3)));
  g1(11,7)=y(11)*params(1)*(1-params(5))*y(19)/y(3);
  g1(11,11)=(-y(27))+params(1)*T148;
  g1(11,19)=y(11)*params(1)*(y(7)*(1-params(5))/y(3)+T139*T286/T141+(y(29)-y(3)*params(6))*params(6)*params(8)/y(3));
  g1(11,27)=(-y(11))+(1-params(6))*y(11)*params(1);
  g1(11,29)=y(11)*params(1)*(y(19)*params(8)/2*2*(y(29)-y(3)*params(6))/T141+params(6)*y(19)*params(8)/y(3));
  g1(12,3)=(y(3)*y(19)*params(8)*(-params(6))-y(19)*params(8)*(y(29)-y(3)*params(6)))/(y(3)*y(3));
  g1(12,13)=1;
  g1(12,19)=params(8)*(y(29)-y(3)*params(6))/y(3);
  g1(12,27)=(-1);
  g1(12,29)=y(19)*params(8)/y(3);
  g1(13,21)=params(30)*getPowerDeriv(y(21),params(10)-1,1);
  g1(13,25)=(-1);
  g1(14,1)=1/(params(21)*(1-y(5)));
  g1(14,5)=(-(y(1)*(-params(21))))/(params(21)*(1-y(5))*params(21)*(1-y(5)));
  g1(14,21)=(-1);
  g1(15,4)=T179*exp(y(36))*getPowerDeriv(y(4),1-params(5),1);
  g1(15,6)=T176*y(16)*T525;
  g1(15,8)=(-1);
  g1(15,16)=T176*y(6)*T525;
  g1(15,36)=T176*T179;
  g1(16,10)=1/(y(10)*y(10));
  g1(16,12)=y(14);
  g1(16,14)=y(12);
  g1(17,6)=(-(y(16)*params(5)*y(8)))/(y(6)*y(16)*y(6)*y(16));
  g1(17,8)=params(5)/(y(6)*y(16));
  g1(17,12)=(-((-(T194*y(20)))/(y(12)*y(20)*y(12)*y(20))));
  g1(17,16)=(-(y(6)*params(5)*y(8)))/(y(6)*y(16)*y(6)*y(16))-params(52)*(-(getPowerDeriv(1-y(16),(-params(2)),1)))/(y(12)*y(20));
  g1(17,20)=(-((-(y(12)*T194))/(y(12)*y(20)*y(12)*y(20))));
  g1(18,6)=(1-params(9))*y(16)*(-(y(16)*y(8)*params(5)*y(20)))/(y(6)*y(16)*y(6)*y(16));
  g1(18,8)=(1-params(9))*y(16)*params(5)*y(20)/(y(6)*y(16));
  g1(18,12)=(-T212)/(y(12)*y(12));
  g1(18,16)=(-y(18))+params(9)*(-(params(52)*(-(getPowerDeriv(1-y(16),1-params(2),1)))/(1-params(2))))/y(12)+(1-params(9))*T692;
  g1(18,18)=(-y(16));
  g1(18,20)=(1-params(9))*(params(45)*params(24)*y(22)+y(16)*params(5)*y(8)/(y(6)*y(16)));
  g1(18,22)=(1-params(9))*y(20)*params(24)*params(45);
  g1(19,6)=params(1)*y(12)*y(16)*(-(y(16)*y(8)*params(5)*y(20)))/(y(6)*y(16)*y(6)*y(16));
  g1(19,8)=params(1)*y(12)*y(16)*params(5)*y(20)/(y(6)*y(16));
  g1(19,12)=(-y(24))+params(1)*((1-params(7))*y(24)+y(16)*y(8)*params(5)*y(20)/(y(6)*y(16))-y(16)*y(18));
  g1(19,16)=params(1)*y(12)*(T692-y(18));
  g1(19,18)=params(1)*y(12)*(-y(16));
  g1(19,20)=params(1)*y(12)*y(16)*params(5)*y(8)/(y(6)*y(16));
  g1(19,24)=(-y(12))+(1-params(7))*params(1)*y(12);
  g1(20,20)=(-params(45));
  g1(20,24)=y(26);
  g1(20,26)=y(24);
  g1(21,4)=params(1)*y(12)*((-(y(8)*(1-params(5))*y(20)))/(y(4)*y(4))+(T257*params(8)*y(20)/2*(-params(6))*2*(y(30)-params(6)*y(4))-params(8)*y(20)/2*T255*2*y(4))/(T257*T257)+(y(4)*params(6)*params(8)*y(20)*(-params(6))-(y(30)-params(6)*y(4))*params(6)*params(8)*y(20))/(y(4)*y(4)));
  g1(21,8)=params(1)*y(12)*(1-params(5))*y(20)/y(4);
  g1(21,12)=(-y(28))+params(1)*T264;
  g1(21,20)=params(1)*y(12)*((1-params(5))*y(8)/y(4)+T255*T286/T257+(y(30)-params(6)*y(4))*params(6)*params(8)/y(4));
  g1(21,28)=(-y(12))+(1-params(6))*params(1)*y(12);
  g1(21,30)=params(1)*y(12)*(params(8)*y(20)/2*2*(y(30)-params(6)*y(4))/T257+params(6)*params(8)*y(20)/y(4));
  g1(22,4)=(y(4)*params(8)*y(20)*(-params(6))-params(8)*y(20)*(y(30)-params(6)*y(4)))/(y(4)*y(4));
  g1(22,14)=1;
  g1(22,20)=params(8)*(y(30)-params(6)*y(4))/y(4);
  g1(22,28)=(-1);
  g1(22,30)=params(8)*y(20)/y(4);
  g1(23,22)=params(30)*getPowerDeriv(y(22),params(10)-1,1);
  g1(23,26)=(-1);
  g1(24,2)=1/(params(24)*(1-y(6)));
  g1(24,6)=(-(y(2)*(-params(24))))/(params(24)*(1-y(6))*params(24)*(1-y(6)));
  g1(24,22)=(-1);
  g1(25,1)=(-params(44));
  g1(25,3)=(-((y(3)*T286*(-params(6))*2*(y(29)-y(3)*params(6))-T139*T286)/(y(3)*y(3))));
  g1(25,7)=1;
  g1(25,29)=(-(T286*2*(y(29)-y(3)*params(6))/y(3)));
  g1(25,31)=(-1);
  g1(26,2)=(-params(45));
  g1(26,4)=(-((y(4)*T286*(-params(6))*2*(y(30)-params(6)*y(4))-T255*T286)/(y(4)*y(4))));
  g1(26,8)=1;
  g1(26,30)=(-(T286*2*(y(30)-params(6)*y(4))/y(4)));
  g1(26,32)=(-1);
  g1(27,13)=(-(getPowerDeriv(y(13),1-params(4),1)));
  g1(27,19)=params(3)*T731;
  g1(27,20)=(1-params(3))*T763;
  g1(28,14)=(-(getPowerDeriv(y(14),1-params(4),1)));
  g1(28,19)=(1-params(3))*T731;
  g1(28,20)=params(3)*T763;
  g1(29,9)=T325;
  g1(29,10)=T331;
  g1(29,13)=(y(29)+y(9))*params(3)*(-y(19))/(y(13)*y(13))*T614;
  g1(29,14)=(y(30)+y(10))*(1-params(3))*(-y(19))/(y(14)*y(14))*T627;
  g1(29,19)=(y(29)+y(9))*params(3)*T614*1/y(13)+(y(30)+y(10))*(1-params(3))*T627*1/y(14);
  g1(29,29)=T325;
  g1(29,30)=T331;
  g1(29,31)=(-1);
  g1(30,9)=T344;
  g1(30,10)=T339;
  g1(30,13)=(y(29)+y(9))*(1-params(3))*(-y(20))/(y(13)*y(13))*T619;
  g1(30,14)=(y(30)+y(10))*params(3)*(-y(20))/(y(14)*y(14))*T632;
  g1(30,20)=(y(30)+y(10))*params(3)*T632*1/y(14)+(y(29)+y(9))*(1-params(3))*T619*1/y(13);
  g1(30,29)=T344;
  g1(30,30)=T339;
  g1(30,32)=(-1);
  g1(31,11)=(-1);
  g1(31,12)=1;
  g1(32,19)=1;
  g1(33,35)=1-params(13);
  g1(33,36)=(-params(14));
  g1(34,35)=(-params(14));
  g1(34,36)=1-params(13);
  g1(35,5)=(-((-(y(7)*y(15)))/(y(5)*y(15)*y(5)*y(15))));
  g1(35,7)=(-(1/(y(5)*y(15))));
  g1(35,15)=(-((-(y(5)*y(7)))/(y(5)*y(15)*y(5)*y(15))));
  g1(35,37)=1;
  g1(36,5)=(-(y(15)*y(17)/y(7)));
  g1(36,7)=(-((-(y(5)*y(15)*y(17)))/(y(7)*y(7))));
  g1(36,15)=(-(y(5)*y(17)/y(7)));
  g1(36,17)=(-(y(5)*y(15)/y(7)));
  g1(36,43)=1;
  g1(37,5)=(-y(15));
  g1(37,15)=(-y(5));
  g1(37,39)=1;
  g1(38,6)=(-((-(y(8)*y(16)))/(y(6)*y(16)*y(6)*y(16))));
  g1(38,8)=(-(1/(y(6)*y(16))));
  g1(38,16)=(-((-(y(6)*y(8)))/(y(6)*y(16)*y(6)*y(16))));
  g1(38,38)=1;
  g1(39,6)=(-(y(16)*y(18)/y(8)));
  g1(39,8)=(-((-(y(6)*y(16)*y(18)))/(y(8)*y(8))));
  g1(39,16)=(-(y(6)*y(18)/y(8)));
  g1(39,18)=(-(y(6)*y(16)/y(8)));
  g1(39,44)=1;
  g1(40,6)=(-y(16));
  g1(40,16)=(-y(6));
  g1(40,40)=1;
  g1(41,31)=(-(1/y(31)));
  g1(41,45)=1;
  g1(42,32)=(-(1/y(32)));
  g1(42,46)=1;
  g1(43,5)=(-(1/y(5)));
  g1(43,47)=1;
  g1(44,6)=(-(1/y(6)));
  g1(44,48)=1;
  g1(45,29)=(-(1/y(29)));
  g1(45,49)=1;
  g1(46,30)=(-(1/y(30)));
  g1(46,50)=1;
  g1(47,9)=(-(1/y(9)));
  g1(47,51)=1;
  g1(48,10)=(-(1/y(10)));
  g1(48,52)=1;
  g1(49,1)=(-(1/y(1)));
  g1(49,33)=1;
  g1(50,2)=(-(1/y(2)));
  g1(50,34)=1;
  g1(51,39)=(-(1/y(39)));
  g1(51,41)=1;
  g1(52,40)=(-(1/y(40)));
  g1(52,42)=1;
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],52,2704);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],52,140608);
end
end
end
end

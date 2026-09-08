function [residual, g1, g2, g3] = dmp_2c_xu_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(52, 1);
T76 = params(52)*(1-y(21))^(-params(2));
T97 = params(9)*(params(57)*(1-params(21))^(1-params(2))/(1-params(2))-params(52)*(1-y(21))^(1-params(2))/(1-params(2)));
T214 = params(52)*(1-y(22))^(-params(2));
T232 = params(9)*(params(57)*(1-params(24))^(1-params(2))/(1-params(2))-params(52)*(1-y(22))^(1-params(2))/(1-params(2)));
T323 = params(8)/2;
T346 = y(25)^(1-params(4));
T350 = y(26)^(1-params(4));
T364 = params(3)*(y(25)/y(19))^(-params(4));
T370 = (1-params(3))*(y(25)/y(20))^(-params(4));
T377 = params(3)*(y(26)/y(20))^(-params(4));
T382 = (1-params(3))*(y(26)/y(19))^(-params(4));
T493 = exp(y(41))*y(1)^(1-params(5));
T495 = (y(21)*y(3))^params(5);
T518 = (y(73)-params(6)*y(9))^2;
T519 = y(67)*params(8)/2*T518;
T520 = y(9)^2;
T526 = (1-params(6))*y(71)+y(59)*(1-params(5))*y(67)/y(9)+T519/T520+params(6)*y(67)*params(8)*(y(73)-params(6)*y(9))/y(9);
T543 = exp(y(42))*y(2)^(1-params(5));
T545 = (y(22)*y(4))^params(5);
T568 = (y(74)-params(6)*y(10))^2;
T569 = params(8)*y(68)/2*T568;
T570 = y(10)^2;
T576 = (1-params(6))*y(72)+y(60)*(1-params(5))*y(68)/y(10)+T569/T570+params(6)*params(8)*y(68)*(y(74)-params(6)*y(10))/y(10);
T594 = T323*(y(35)-params(6)*y(1))^2;
T601 = T323*(y(36)-params(6)*y(2))^2;
residual(1) = y(35)+(-y(9))+(1-params(6))*y(1);
residual(2) = y(31)*y(7)+(-y(11))+(1-params(7))*y(3);
residual(3) = y(36)+(-y(10))+(1-params(6))*y(2);
residual(4) = y(32)*y(8)+(-y(12))+(1-params(7))*y(4);
residual(5) = (-y(13))+T493*T495;
residual(6) = (-1)/y(15)+y(17)*y(19);
residual(7) = y(13)*params(5)/(y(21)*y(3))-T76/(y(17)*y(25));
residual(8) = y(21)*(-y(23))+T97/y(17)+(1-params(9))*(y(25)*params(21)*y(27)*params(44)+y(21)*y(13)*params(5)*y(25)/(y(21)*y(3)));
residual(9) = y(17)*(-y(29))+params(1)*y(61)*((1-params(7))*y(69)+y(63)*params(5)*y(67)*y(59)/(y(11)*y(63))-y(63)*y(65));
residual(10) = params(44)*(-y(25))+y(31)*y(29);
residual(11) = y(17)*(-y(33))+params(1)*y(61)*T526;
residual(12) = y(19)-y(33)+y(25)*params(8)*(y(35)-params(6)*y(1))/y(1);
residual(13) = (-y(31))+params(30)*y(27)^(params(10)-1);
residual(14) = (-y(27))+y(7)/(params(21)*(1-y(3)));
residual(15) = (-y(14))+T543*T545;
residual(16) = (-1)/y(16)+y(18)*y(20);
residual(17) = params(5)*y(14)/(y(22)*y(4))-T214/(y(18)*y(26));
residual(18) = y(22)*(-y(24))+T232/y(18)+(1-params(9))*(y(26)*params(24)*y(28)*params(45)+y(22)*y(14)*params(5)*y(26)/(y(22)*y(4)));
residual(19) = y(18)*(-y(30))+params(1)*y(62)*((1-params(7))*y(70)+y(64)*params(5)*y(68)*y(60)/(y(12)*y(64))-y(64)*y(66));
residual(20) = params(45)*(-y(26))+y(32)*y(30);
residual(21) = y(18)*(-y(34))+params(1)*y(62)*T576;
residual(22) = y(20)-y(34)+params(8)*y(26)*(y(36)-params(6)*y(2))/y(2);
residual(23) = (-y(32))+params(30)*y(28)^(params(10)-1);
residual(24) = (-y(28))+y(8)/(params(24)*(1-y(4)));
residual(25) = y(13)-y(37)-T594/y(1)-y(7)*params(44);
residual(26) = y(14)-y(38)-T601/y(2)-y(8)*params(45);
residual(27) = (-(y(19)^(1-params(4))))+params(3)*T346+(1-params(3))*T350;
residual(28) = (-(y(20)^(1-params(4))))+params(3)*T350+T346*(1-params(3));
residual(29) = (-y(37))+T364*(y(35)+y(15))+T370*(y(36)+y(16));
residual(30) = (-y(38))+(y(36)+y(16))*T377+(y(35)+y(15))*T382;
residual(31) = y(18)-y(17);
residual(32) = y(25)-1;
lhs =y(41);
rhs =params(13)*y(5)+params(14)*y(6)+x(it_, 1)+params(59)*x(it_, 2);
residual(33)= lhs-rhs;
lhs =y(42);
rhs =x(it_, 2)+params(13)*y(6)+y(5)*params(14)+x(it_, 1)*params(59);
residual(34)= lhs-rhs;
lhs =y(43);
rhs =y(13)/(y(21)*y(3));
residual(35)= lhs-rhs;
lhs =y(49);
rhs =y(21)*y(23)*y(3)/y(13);
residual(36)= lhs-rhs;
lhs =y(45);
rhs =y(21)*y(3);
residual(37)= lhs-rhs;
lhs =y(44);
rhs =y(14)/(y(22)*y(4));
residual(38)= lhs-rhs;
lhs =y(50);
rhs =y(22)*y(24)*y(4)/y(14);
residual(39)= lhs-rhs;
lhs =y(46);
rhs =y(22)*y(4);
residual(40)= lhs-rhs;
lhs =y(51);
rhs =log(y(37));
residual(41)= lhs-rhs;
lhs =y(52);
rhs =log(y(38));
residual(42)= lhs-rhs;
lhs =y(53);
rhs =log(y(3));
residual(43)= lhs-rhs;
lhs =y(54);
rhs =log(y(4));
residual(44)= lhs-rhs;
lhs =y(55);
rhs =log(y(35));
residual(45)= lhs-rhs;
lhs =y(56);
rhs =log(y(36));
residual(46)= lhs-rhs;
lhs =y(57);
rhs =log(y(15));
residual(47)= lhs-rhs;
lhs =y(58);
rhs =log(y(16));
residual(48)= lhs-rhs;
lhs =y(39);
rhs =log(y(7));
residual(49)= lhs-rhs;
lhs =y(40);
rhs =log(y(8));
residual(50)= lhs-rhs;
lhs =y(47);
rhs =log(y(45));
residual(51)= lhs-rhs;
lhs =y(48);
rhs =log(y(46));
residual(52)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(52, 76);

  %
  % Jacobian matrix
  %

T701 = getPowerDeriv(y(21)*y(3),params(5),1);
T733 = getPowerDeriv(y(22)*y(4),params(5),1);
T827 = getPowerDeriv(y(25)/y(19),(-params(4)),1);
T832 = getPowerDeriv(y(26)/y(19),(-params(4)),1);
T840 = getPowerDeriv(y(25)/y(20),(-params(4)),1);
T845 = getPowerDeriv(y(26)/y(20),(-params(4)),1);
T948 = getPowerDeriv(y(25),1-params(4),1);
T985 = getPowerDeriv(y(26),1-params(4),1);
  g1(1,1)=1-params(6);
  g1(1,9)=(-1);
  g1(1,35)=1;
  g1(2,7)=y(31);
  g1(2,3)=1-params(7);
  g1(2,11)=(-1);
  g1(2,31)=y(7);
  g1(3,2)=1-params(6);
  g1(3,10)=(-1);
  g1(3,36)=1;
  g1(4,8)=y(32);
  g1(4,4)=1-params(7);
  g1(4,12)=(-1);
  g1(4,32)=y(8);
  g1(5,1)=T495*exp(y(41))*getPowerDeriv(y(1),1-params(5),1);
  g1(5,3)=T493*y(21)*T701;
  g1(5,13)=(-1);
  g1(5,21)=T493*y(3)*T701;
  g1(5,41)=T493*T495;
  g1(6,15)=1/(y(15)*y(15));
  g1(6,17)=y(19);
  g1(6,19)=y(17);
  g1(7,3)=(-(y(21)*y(13)*params(5)))/(y(21)*y(3)*y(21)*y(3));
  g1(7,13)=params(5)/(y(21)*y(3));
  g1(7,17)=(-((-(T76*y(25)))/(y(17)*y(25)*y(17)*y(25))));
  g1(7,21)=(-(y(13)*params(5)*y(3)))/(y(21)*y(3)*y(21)*y(3))-params(52)*(-(getPowerDeriv(1-y(21),(-params(2)),1)))/(y(17)*y(25));
  g1(7,25)=(-((-(y(17)*T76))/(y(17)*y(25)*y(17)*y(25))));
  g1(8,3)=(1-params(9))*y(21)*(-(y(21)*y(13)*params(5)*y(25)))/(y(21)*y(3)*y(21)*y(3));
  g1(8,13)=(1-params(9))*y(21)*params(5)*y(25)/(y(21)*y(3));
  g1(8,17)=(-T97)/(y(17)*y(17));
  g1(8,21)=(-y(23))+params(9)*(-(params(52)*(-(getPowerDeriv(1-y(21),1-params(2),1)))/(1-params(2))))/y(17)+(1-params(9))*(y(13)*params(5)*y(25)/(y(21)*y(3))+y(21)*(-(y(13)*params(5)*y(25)*y(3)))/(y(21)*y(3)*y(21)*y(3)));
  g1(8,23)=(-y(21));
  g1(8,25)=(1-params(9))*(params(44)*params(21)*y(27)+y(21)*y(13)*params(5)/(y(21)*y(3)));
  g1(8,27)=(1-params(9))*y(25)*params(21)*params(44);
  g1(9,11)=params(1)*y(61)*y(63)*(-(params(5)*y(67)*y(59)*y(63)))/(y(11)*y(63)*y(11)*y(63));
  g1(9,59)=params(1)*y(61)*y(63)*params(5)*y(67)/(y(11)*y(63));
  g1(9,17)=(-y(29));
  g1(9,61)=params(1)*((1-params(7))*y(69)+y(63)*params(5)*y(67)*y(59)/(y(11)*y(63))-y(63)*y(65));
  g1(9,63)=params(1)*y(61)*(params(5)*y(67)*y(59)/(y(11)*y(63))+y(63)*(-(y(11)*params(5)*y(67)*y(59)))/(y(11)*y(63)*y(11)*y(63))-y(65));
  g1(9,65)=params(1)*y(61)*(-y(63));
  g1(9,67)=params(1)*y(61)*y(63)*params(5)*y(59)/(y(11)*y(63));
  g1(9,29)=(-y(17));
  g1(9,69)=(1-params(7))*params(1)*y(61);
  g1(10,25)=(-params(44));
  g1(10,29)=y(31);
  g1(10,31)=y(29);
  g1(11,9)=params(1)*y(61)*((-(y(59)*(1-params(5))*y(67)))/(y(9)*y(9))+(T520*y(67)*params(8)/2*(-params(6))*2*(y(73)-params(6)*y(9))-T519*2*y(9))/(T520*T520)+(y(9)*params(6)*y(67)*params(8)*(-params(6))-params(6)*y(67)*params(8)*(y(73)-params(6)*y(9)))/(y(9)*y(9)));
  g1(11,59)=params(1)*y(61)*(1-params(5))*y(67)/y(9);
  g1(11,17)=(-y(33));
  g1(11,61)=params(1)*T526;
  g1(11,67)=params(1)*y(61)*((1-params(5))*y(59)/y(9)+T323*T518/T520+(y(73)-params(6)*y(9))*params(6)*params(8)/y(9));
  g1(11,33)=(-y(17));
  g1(11,71)=(1-params(6))*params(1)*y(61);
  g1(11,73)=params(1)*y(61)*(y(67)*params(8)/2*2*(y(73)-params(6)*y(9))/T520+params(6)*y(67)*params(8)/y(9));
  g1(12,1)=(y(1)*y(25)*params(8)*(-params(6))-y(25)*params(8)*(y(35)-params(6)*y(1)))/(y(1)*y(1));
  g1(12,19)=1;
  g1(12,25)=params(8)*(y(35)-params(6)*y(1))/y(1);
  g1(12,33)=(-1);
  g1(12,35)=y(25)*params(8)/y(1);
  g1(13,27)=params(30)*getPowerDeriv(y(27),params(10)-1,1);
  g1(13,31)=(-1);
  g1(14,7)=1/(params(21)*(1-y(3)));
  g1(14,3)=(-(y(7)*(-params(21))))/(params(21)*(1-y(3))*params(21)*(1-y(3)));
  g1(14,27)=(-1);
  g1(15,2)=T545*exp(y(42))*getPowerDeriv(y(2),1-params(5),1);
  g1(15,4)=T543*y(22)*T733;
  g1(15,14)=(-1);
  g1(15,22)=T543*y(4)*T733;
  g1(15,42)=T543*T545;
  g1(16,16)=1/(y(16)*y(16));
  g1(16,18)=y(20);
  g1(16,20)=y(18);
  g1(17,4)=(-(y(22)*params(5)*y(14)))/(y(22)*y(4)*y(22)*y(4));
  g1(17,14)=params(5)/(y(22)*y(4));
  g1(17,18)=(-((-(T214*y(26)))/(y(18)*y(26)*y(18)*y(26))));
  g1(17,22)=(-(params(5)*y(14)*y(4)))/(y(22)*y(4)*y(22)*y(4))-params(52)*(-(getPowerDeriv(1-y(22),(-params(2)),1)))/(y(18)*y(26));
  g1(17,26)=(-((-(y(18)*T214))/(y(18)*y(26)*y(18)*y(26))));
  g1(18,4)=(1-params(9))*y(22)*(-(y(22)*y(14)*params(5)*y(26)))/(y(22)*y(4)*y(22)*y(4));
  g1(18,14)=(1-params(9))*y(22)*params(5)*y(26)/(y(22)*y(4));
  g1(18,18)=(-T232)/(y(18)*y(18));
  g1(18,22)=(-y(24))+params(9)*(-(params(52)*(-(getPowerDeriv(1-y(22),1-params(2),1)))/(1-params(2))))/y(18)+(1-params(9))*(y(14)*params(5)*y(26)/(y(22)*y(4))+y(22)*(-(y(14)*params(5)*y(26)*y(4)))/(y(22)*y(4)*y(22)*y(4)));
  g1(18,24)=(-y(22));
  g1(18,26)=(1-params(9))*(params(45)*params(24)*y(28)+y(22)*params(5)*y(14)/(y(22)*y(4)));
  g1(18,28)=(1-params(9))*y(26)*params(24)*params(45);
  g1(19,12)=params(1)*y(62)*y(64)*(-(params(5)*y(68)*y(60)*y(64)))/(y(12)*y(64)*y(12)*y(64));
  g1(19,60)=params(1)*y(62)*y(64)*params(5)*y(68)/(y(12)*y(64));
  g1(19,18)=(-y(30));
  g1(19,62)=params(1)*((1-params(7))*y(70)+y(64)*params(5)*y(68)*y(60)/(y(12)*y(64))-y(64)*y(66));
  g1(19,64)=params(1)*y(62)*(params(5)*y(68)*y(60)/(y(12)*y(64))+y(64)*(-(y(12)*params(5)*y(68)*y(60)))/(y(12)*y(64)*y(12)*y(64))-y(66));
  g1(19,66)=params(1)*y(62)*(-y(64));
  g1(19,68)=params(1)*y(62)*y(64)*params(5)*y(60)/(y(12)*y(64));
  g1(19,30)=(-y(18));
  g1(19,70)=(1-params(7))*params(1)*y(62);
  g1(20,26)=(-params(45));
  g1(20,30)=y(32);
  g1(20,32)=y(30);
  g1(21,10)=params(1)*y(62)*((-(y(60)*(1-params(5))*y(68)))/(y(10)*y(10))+(T570*params(8)*y(68)/2*(-params(6))*2*(y(74)-params(6)*y(10))-T569*2*y(10))/(T570*T570)+(y(10)*params(6)*params(8)*y(68)*(-params(6))-params(6)*params(8)*y(68)*(y(74)-params(6)*y(10)))/(y(10)*y(10)));
  g1(21,60)=params(1)*y(62)*(1-params(5))*y(68)/y(10);
  g1(21,18)=(-y(34));
  g1(21,62)=params(1)*T576;
  g1(21,68)=params(1)*y(62)*((1-params(5))*y(60)/y(10)+T323*T568/T570+(y(74)-params(6)*y(10))*params(6)*params(8)/y(10));
  g1(21,34)=(-y(18));
  g1(21,72)=(1-params(6))*params(1)*y(62);
  g1(21,74)=params(1)*y(62)*(params(8)*y(68)/2*2*(y(74)-params(6)*y(10))/T570+params(6)*params(8)*y(68)/y(10));
  g1(22,2)=(y(2)*params(8)*y(26)*(-params(6))-params(8)*y(26)*(y(36)-params(6)*y(2)))/(y(2)*y(2));
  g1(22,20)=1;
  g1(22,26)=params(8)*(y(36)-params(6)*y(2))/y(2);
  g1(22,34)=(-1);
  g1(22,36)=params(8)*y(26)/y(2);
  g1(23,28)=params(30)*getPowerDeriv(y(28),params(10)-1,1);
  g1(23,32)=(-1);
  g1(24,8)=1/(params(24)*(1-y(4)));
  g1(24,4)=(-(y(8)*(-params(24))))/(params(24)*(1-y(4))*params(24)*(1-y(4)));
  g1(24,28)=(-1);
  g1(25,7)=(-params(44));
  g1(25,1)=(-((y(1)*T323*(-params(6))*2*(y(35)-params(6)*y(1))-T594)/(y(1)*y(1))));
  g1(25,13)=1;
  g1(25,35)=(-(T323*2*(y(35)-params(6)*y(1))/y(1)));
  g1(25,37)=(-1);
  g1(26,8)=(-params(45));
  g1(26,2)=(-((y(2)*T323*(-params(6))*2*(y(36)-params(6)*y(2))-T601)/(y(2)*y(2))));
  g1(26,14)=1;
  g1(26,36)=(-(T323*2*(y(36)-params(6)*y(2))/y(2)));
  g1(26,38)=(-1);
  g1(27,19)=(-(getPowerDeriv(y(19),1-params(4),1)));
  g1(27,25)=params(3)*T948;
  g1(27,26)=(1-params(3))*T985;
  g1(28,20)=(-(getPowerDeriv(y(20),1-params(4),1)));
  g1(28,25)=(1-params(3))*T948;
  g1(28,26)=params(3)*T985;
  g1(29,15)=T364;
  g1(29,16)=T370;
  g1(29,19)=(y(35)+y(15))*params(3)*(-y(25))/(y(19)*y(19))*T827;
  g1(29,20)=(y(36)+y(16))*(1-params(3))*(-y(25))/(y(20)*y(20))*T840;
  g1(29,25)=(y(35)+y(15))*params(3)*T827*1/y(19)+(y(36)+y(16))*(1-params(3))*T840*1/y(20);
  g1(29,35)=T364;
  g1(29,36)=T370;
  g1(29,37)=(-1);
  g1(30,15)=T382;
  g1(30,16)=T377;
  g1(30,19)=(y(35)+y(15))*(1-params(3))*(-y(26))/(y(19)*y(19))*T832;
  g1(30,20)=(y(36)+y(16))*params(3)*(-y(26))/(y(20)*y(20))*T845;
  g1(30,26)=(y(36)+y(16))*params(3)*T845*1/y(20)+(y(35)+y(15))*(1-params(3))*T832*1/y(19);
  g1(30,35)=T382;
  g1(30,36)=T377;
  g1(30,38)=(-1);
  g1(31,17)=(-1);
  g1(31,18)=1;
  g1(32,25)=1;
  g1(33,5)=(-params(13));
  g1(33,41)=1;
  g1(33,6)=(-params(14));
  g1(33,75)=(-1);
  g1(33,76)=(-params(59));
  g1(34,5)=(-params(14));
  g1(34,6)=(-params(13));
  g1(34,42)=1;
  g1(34,75)=(-params(59));
  g1(34,76)=(-1);
  g1(35,3)=(-((-(y(13)*y(21)))/(y(21)*y(3)*y(21)*y(3))));
  g1(35,13)=(-(1/(y(21)*y(3))));
  g1(35,21)=(-((-(y(13)*y(3)))/(y(21)*y(3)*y(21)*y(3))));
  g1(35,43)=1;
  g1(36,3)=(-(y(21)*y(23)/y(13)));
  g1(36,13)=(-((-(y(21)*y(23)*y(3)))/(y(13)*y(13))));
  g1(36,21)=(-(y(23)*y(3)/y(13)));
  g1(36,23)=(-(y(21)*y(3)/y(13)));
  g1(36,49)=1;
  g1(37,3)=(-y(21));
  g1(37,21)=(-y(3));
  g1(37,45)=1;
  g1(38,4)=(-((-(y(14)*y(22)))/(y(22)*y(4)*y(22)*y(4))));
  g1(38,14)=(-(1/(y(22)*y(4))));
  g1(38,22)=(-((-(y(14)*y(4)))/(y(22)*y(4)*y(22)*y(4))));
  g1(38,44)=1;
  g1(39,4)=(-(y(22)*y(24)/y(14)));
  g1(39,14)=(-((-(y(22)*y(24)*y(4)))/(y(14)*y(14))));
  g1(39,22)=(-(y(24)*y(4)/y(14)));
  g1(39,24)=(-(y(22)*y(4)/y(14)));
  g1(39,50)=1;
  g1(40,4)=(-y(22));
  g1(40,22)=(-y(4));
  g1(40,46)=1;
  g1(41,37)=(-(1/y(37)));
  g1(41,51)=1;
  g1(42,38)=(-(1/y(38)));
  g1(42,52)=1;
  g1(43,3)=(-(1/y(3)));
  g1(43,53)=1;
  g1(44,4)=(-(1/y(4)));
  g1(44,54)=1;
  g1(45,35)=(-(1/y(35)));
  g1(45,55)=1;
  g1(46,36)=(-(1/y(36)));
  g1(46,56)=1;
  g1(47,15)=(-(1/y(15)));
  g1(47,57)=1;
  g1(48,16)=(-(1/y(16)));
  g1(48,58)=1;
  g1(49,7)=(-(1/y(7)));
  g1(49,39)=1;
  g1(50,8)=(-(1/y(8)));
  g1(50,40)=1;
  g1(51,45)=(-(1/y(45)));
  g1(51,47)=1;
  g1(52,46)=(-(1/y(46)));
  g1(52,48)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],52,5776);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],52,438976);
end
end
end
end

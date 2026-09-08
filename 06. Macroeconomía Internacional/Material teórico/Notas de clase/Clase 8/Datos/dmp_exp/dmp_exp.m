%
% Status : main Dynare file
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

if isoctave || matlab_ver_less_than('8.6')
    clear all
else
    clearvars -global
    clear_persistent_variables(fileparts(which('dynare')), false)
end
tic0 = tic;
% Save empty dates and dseries objects in memory.
dates('initialize');
dseries('initialize');
% Define global variables.
global M_ options_ oo_ estim_params_ bayestopt_ dataset_ dataset_info estimation_info ys0_ ex0_
options_ = [];
M_.fname = 'dmp_exp';
M_.dynare_version = '4.5.7';
oo_.dynare_version = '4.5.7';
options_.dynare_version = '4.5.7';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('dmp_exp.log');
M_.exo_names = 'epsia';
M_.exo_names_tex = 'epsia';
M_.exo_names_long = 'epsia';
M_.endo_names = 'k';
M_.endo_names_tex = 'k';
M_.endo_names_long = 'k';
M_.endo_names = char(M_.endo_names, 'n');
M_.endo_names_tex = char(M_.endo_names_tex, 'n');
M_.endo_names_long = char(M_.endo_names_long, 'n');
M_.endo_names = char(M_.endo_names, 'i');
M_.endo_names_tex = char(M_.endo_names_tex, 'i');
M_.endo_names_long = char(M_.endo_names_long, 'i');
M_.endo_names = char(M_.endo_names, 'lambda');
M_.endo_names_tex = char(M_.endo_names_tex, 'lambda');
M_.endo_names_long = char(M_.endo_names_long, 'lambda');
M_.endo_names = char(M_.endo_names, 'c');
M_.endo_names_tex = char(M_.endo_names_tex, 'c');
M_.endo_names_long = char(M_.endo_names_long, 'c');
M_.endo_names = char(M_.endo_names, 'w');
M_.endo_names_tex = char(M_.endo_names_tex, 'w');
M_.endo_names_long = char(M_.endo_names_long, 'w');
M_.endo_names = char(M_.endo_names, 'h');
M_.endo_names_tex = char(M_.endo_names_tex, 'h');
M_.endo_names_long = char(M_.endo_names_long, 'h');
M_.endo_names = char(M_.endo_names, 'y');
M_.endo_names_tex = char(M_.endo_names_tex, 'y');
M_.endo_names_long = char(M_.endo_names_long, 'y');
M_.endo_names = char(M_.endo_names, 'q');
M_.endo_names_tex = char(M_.endo_names_tex, 'q');
M_.endo_names_long = char(M_.endo_names_long, 'q');
M_.endo_names = char(M_.endo_names, 'f');
M_.endo_names_tex = char(M_.endo_names_tex, 'f');
M_.endo_names_long = char(M_.endo_names_long, 'f');
M_.endo_names = char(M_.endo_names, 'm');
M_.endo_names_tex = char(M_.endo_names_tex, 'm');
M_.endo_names_long = char(M_.endo_names_long, 'm');
M_.endo_names = char(M_.endo_names, 'v');
M_.endo_names_tex = char(M_.endo_names_tex, 'v');
M_.endo_names_long = char(M_.endo_names_long, 'v');
M_.endo_names = char(M_.endo_names, 'a');
M_.endo_names_tex = char(M_.endo_names_tex, 'a');
M_.endo_names_long = char(M_.endo_names_long, 'a');
M_.endo_names = char(M_.endo_names, 'LabProd');
M_.endo_names_tex = char(M_.endo_names_tex, 'LabProd');
M_.endo_names_long = char(M_.endo_names_long, 'LabProd');
M_.endo_names = char(M_.endo_names, 'LabShare');
M_.endo_names_tex = char(M_.endo_names_tex, 'LabShare');
M_.endo_names_long = char(M_.endo_names_long, 'LabShare');
M_.endo_names = char(M_.endo_names, 'TotHours');
M_.endo_names_tex = char(M_.endo_names_tex, 'TotHours');
M_.endo_names_long = char(M_.endo_names_long, 'TotHours');
M_.endo_partitions = struct();
M_.param_names = 'beta';
M_.param_names_tex = 'beta';
M_.param_names_long = 'beta';
M_.param_names = char(M_.param_names, 'e');
M_.param_names_tex = char(M_.param_names_tex, 'e');
M_.param_names_long = char(M_.param_names_long, 'e');
M_.param_names = char(M_.param_names, 's');
M_.param_names_tex = char(M_.param_names_tex, 's');
M_.param_names_long = char(M_.param_names_long, 's');
M_.param_names = char(M_.param_names, 'alpha');
M_.param_names_tex = char(M_.param_names_tex, 'alpha');
M_.param_names_long = char(M_.param_names_long, 'alpha');
M_.param_names = char(M_.param_names, 'xi');
M_.param_names_tex = char(M_.param_names_tex, 'xi');
M_.param_names_long = char(M_.param_names_long, 'xi');
M_.param_names = char(M_.param_names, 'nu');
M_.param_names_tex = char(M_.param_names_tex, 'nu');
M_.param_names_long = char(M_.param_names_long, 'nu');
M_.param_names = char(M_.param_names, 'sigma');
M_.param_names_tex = char(M_.param_names_tex, 'sigma');
M_.param_names_long = char(M_.param_names_long, 'sigma');
M_.param_names = char(M_.param_names, 'epsilon');
M_.param_names_tex = char(M_.param_names_tex, 'epsilon');
M_.param_names_long = char(M_.param_names_long, 'epsilon');
M_.param_names = char(M_.param_names, 'delta');
M_.param_names_tex = char(M_.param_names_tex, 'delta');
M_.param_names_long = char(M_.param_names_long, 'delta');
M_.param_names = char(M_.param_names, 'nss');
M_.param_names_tex = char(M_.param_names_tex, 'nss');
M_.param_names_long = char(M_.param_names_long, 'nss');
M_.param_names = char(M_.param_names, 'qss');
M_.param_names_tex = char(M_.param_names_tex, 'qss');
M_.param_names_long = char(M_.param_names_long, 'qss');
M_.param_names = char(M_.param_names, 'hss');
M_.param_names_tex = char(M_.param_names_tex, 'hss');
M_.param_names_long = char(M_.param_names_long, 'hss');
M_.param_names = char(M_.param_names, 'ess');
M_.param_names_tex = char(M_.param_names_tex, 'ess');
M_.param_names_long = char(M_.param_names_long, 'ess');
M_.param_names = char(M_.param_names, 'rho');
M_.param_names_tex = char(M_.param_names_tex, 'rho');
M_.param_names_long = char(M_.param_names_long, 'rho');
M_.param_names = char(M_.param_names, 'mss');
M_.param_names_tex = char(M_.param_names_tex, 'mss');
M_.param_names_long = char(M_.param_names_long, 'mss');
M_.param_names = char(M_.param_names, 'fss');
M_.param_names_tex = char(M_.param_names_tex, 'fss');
M_.param_names_long = char(M_.param_names_long, 'fss');
M_.param_names = char(M_.param_names, 'thetass');
M_.param_names_tex = char(M_.param_names_tex, 'thetass');
M_.param_names_long = char(M_.param_names_long, 'thetass');
M_.param_names = char(M_.param_names, 'vss');
M_.param_names_tex = char(M_.param_names_tex, 'vss');
M_.param_names_long = char(M_.param_names_long, 'vss');
M_.param_names = char(M_.param_names, 'chi');
M_.param_names_tex = char(M_.param_names_tex, 'chi');
M_.param_names_long = char(M_.param_names_long, 'chi');
M_.param_names = char(M_.param_names, 'kss');
M_.param_names_tex = char(M_.param_names_tex, 'kss');
M_.param_names_long = char(M_.param_names_long, 'kss');
M_.param_names = char(M_.param_names, 'iss');
M_.param_names_tex = char(M_.param_names_tex, 'iss');
M_.param_names_long = char(M_.param_names_long, 'iss');
M_.param_names = char(M_.param_names, 'yss');
M_.param_names_tex = char(M_.param_names_tex, 'yss');
M_.param_names_long = char(M_.param_names_long, 'yss');
M_.param_names = char(M_.param_names, 'kappavsy');
M_.param_names_tex = char(M_.param_names_tex, 'kappavsy');
M_.param_names_long = char(M_.param_names_long, 'kappavsy');
M_.param_names = char(M_.param_names, 'kappa');
M_.param_names_tex = char(M_.param_names_tex, 'kappa');
M_.param_names_long = char(M_.param_names_long, 'kappa');
M_.param_names = char(M_.param_names, 'css');
M_.param_names_tex = char(M_.param_names_tex, 'css');
M_.param_names_long = char(M_.param_names_long, 'css');
M_.param_names = char(M_.param_names, 'lambdass');
M_.param_names_tex = char(M_.param_names_tex, 'lambdass');
M_.param_names_long = char(M_.param_names_long, 'lambdass');
M_.param_names = char(M_.param_names, 'eta1');
M_.param_names_tex = char(M_.param_names_tex, 'eta1');
M_.param_names_long = char(M_.param_names_long, 'eta1');
M_.param_names = char(M_.param_names, 'wss');
M_.param_names_tex = char(M_.param_names_tex, 'wss');
M_.param_names_long = char(M_.param_names_long, 'wss');
M_.param_names = char(M_.param_names, 'eta2');
M_.param_names_tex = char(M_.param_names_tex, 'eta2');
M_.param_names_long = char(M_.param_names_long, 'eta2');
M_.param_names = char(M_.param_names, 'b');
M_.param_names_tex = char(M_.param_names_tex, 'b');
M_.param_names_long = char(M_.param_names_long, 'b');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 1;
M_.endo_nbr = 16;
M_.param_nbr = 30;
M_.orig_endo_nbr = 16;
M_.aux_vars = [];
M_.predetermined_variables = [ 1 2 ];
M_.Sigma_e = zeros(1, 1);
M_.Correlation_matrix = eye(1, 1);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
M_.det_shocks = [];
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
M_.hessian_eq_zero = 1;
erase_compiled_function('dmp_exp_static');
erase_compiled_function('dmp_exp_dynamic');
M_.orig_eq_nbr = 16;
M_.eq_nbr = 16;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./' M_.fname '_set_auxiliary_variables.m'], 'file') == 2;
M_.lead_lag_incidence = [
 1 4 0;
 2 5 0;
 0 6 0;
 0 7 20;
 0 8 0;
 0 9 21;
 0 10 22;
 0 11 23;
 0 12 24;
 0 13 0;
 0 14 0;
 0 15 0;
 3 16 0;
 0 17 0;
 0 18 0;
 0 19 0;]';
M_.nstatic = 8;
M_.nfwrd   = 5;
M_.npred   = 3;
M_.nboth   = 0;
M_.nsfwrd   = 5;
M_.nspred   = 3;
M_.ndynamic   = 8;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:1];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(16, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(1, 1);
M_.params = NaN(30, 1);
M_.NNZDerivatives = [64; -1; -1];
close all;
M_.params( 1 ) = 0.99;
beta = M_.params( 1 );
M_.params( 8 ) = 2;
epsilon = M_.params( 8 );
M_.params( 4 ) = 0.36;
alpha = M_.params( 4 );
M_.params( 9 ) = 0.025;
delta = M_.params( 9 );
M_.params( 3 ) = 0.15;
s = M_.params( 3 );
M_.params( 6 ) = 0.6;
nu = M_.params( 6 );
M_.params( 5 ) = 1-M_.params(6);
xi = M_.params( 5 );
M_.params( 14 ) = 0.95;
rho = M_.params( 14 );
M_.params( 23 ) = 0.01;
kappavsy = M_.params( 23 );
M_.params( 10 ) = 0.57;
nss = M_.params( 10 );
M_.params( 12 ) = 0.33;
hss = M_.params( 12 );
M_.params( 13 ) = 0.5*M_.params(12);
ess = M_.params( 13 );
M_.params( 11 ) = 0.9;
qss = M_.params( 11 );
M_.params( 15 ) = M_.params(3)*M_.params(10);
mss = M_.params( 15 );
M_.params( 18 ) = M_.params(15)/M_.params(11);
vss = M_.params( 18 );
M_.params( 16 ) = M_.params(15)/(1-M_.params(10));
fss = M_.params( 16 );
M_.params( 30 ) = 0.0;
b = M_.params( 30 );
M_.params( 19 ) = M_.params(15)/(M_.params(18)^M_.params(6)*((1-M_.params(10))*M_.params(13))^(1-M_.params(6)));
chi = M_.params( 19 );
M_.params( 20 ) = ((1/M_.params(1)-1+M_.params(9))/(M_.params(4)*(M_.params(12)*M_.params(10))^(1-M_.params(4))))^(1/(M_.params(4)-1));
kss = M_.params( 20 );
M_.params( 22 ) = (M_.params(12)*M_.params(10))^(1-M_.params(4))*M_.params(20)^M_.params(4);
yss = M_.params( 22 );
kappavss=kappavsy*yss;
M_.params( 24 ) = kappavss/M_.params(18);
kappa = M_.params( 24 );
M_.params( 21 ) = M_.params(9)*M_.params(20);
iss = M_.params( 21 );
M_.params( 25 ) = M_.params(22)-M_.params(21)-kappavss;
css = M_.params( 25 );
M_.params( 26 ) = 1/M_.params(25);
lambdass = M_.params( 26 );
M_.params( 27 ) = M_.params(22)*(1-M_.params(4))*M_.params(26)/(M_.params(12)*M_.params(10))/(1-M_.params(12))^(-M_.params(8));
eta1 = M_.params( 27 );
csy=css/yss;
ksy=kss/yss;
whss=(1-alpha)*yss/nss+(1-s)*kappa/qss-1/beta*kappa/qss;
M_.params( 28 ) = whss/M_.params(12);
wss = M_.params( 28 );
M_.params( 29 ) = (1-M_.params(8))*M_.params(26)*(whss-M_.params(5)*((1-M_.params(4))*M_.params(22)/M_.params(10)+M_.params(16)*M_.params(24)/M_.params(11))+(1-M_.params(5))*(1/M_.params(26)*M_.params(27)*(1-M_.params(12))^(1-M_.params(8))/(1-M_.params(8))-M_.params(30)))/(1-M_.params(5))/(1-M_.params(13))^(1-M_.params(8));
eta2 = M_.params( 29 );
M_.params( 2 ) = M_.params(13);
e = M_.params( 2 );
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 1 ) = log(M_.params(20));
oo_.steady_state( 2 ) = log(M_.params(10));
oo_.steady_state( 3 ) = log(M_.params(21));
oo_.steady_state( 4 ) = log(M_.params(26));
oo_.steady_state( 5 ) = log(M_.params(25));
oo_.steady_state( 6 ) = log(M_.params(28));
oo_.steady_state( 7 ) = log(M_.params(12));
oo_.steady_state( 8 ) = log(M_.params(22));
oo_.steady_state( 9 ) = log(M_.params(11));
oo_.steady_state( 11 ) = log(M_.params(15));
oo_.steady_state( 12 ) = log(M_.params(18));
oo_.steady_state( 10 ) = log(M_.params(16));
oo_.steady_state( 14 ) = log(exp(oo_.steady_state(8))/(exp(oo_.steady_state(2))*exp(oo_.steady_state(7))));
oo_.steady_state( 15 ) = log(exp(oo_.steady_state(2))*exp(oo_.steady_state(7))*exp(oo_.steady_state(6))/exp(oo_.steady_state(8)));
oo_.steady_state( 16 ) = log(exp(oo_.steady_state(2))*exp(oo_.steady_state(7)));
if M_.exo_nbr > 0
	oo_.exo_simul = ones(M_.maximum_lag,1)*oo_.exo_steady_state';
end
if M_.exo_det_nbr > 0
	oo_.exo_det_simul = ones(M_.maximum_lag,1)*oo_.exo_det_steady_state';
end
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = 0.00021025;
resid
oo_.dr.eigval = check(M_,options_,oo_);
steady;
options_.hp_filter = 1600;
options_.irf = 30;
options_.order = 1;
options_.periods = 0;
var_list_ = char();
info = stoch_simul(var_list_);
save('dmp_exp_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('dmp_exp_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('dmp_exp_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('dmp_exp_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('dmp_exp_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('dmp_exp_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('dmp_exp_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off

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
M_.fname = 'soe_emerging_frictions_2019';
M_.dynare_version = '4.5.7';
oo_.dynare_version = '4.5.7';
options_.dynare_version = '4.5.7';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('soe_emerging_frictions_2019.log');
M_.exo_names = 'ea';
M_.exo_names_tex = 'ea';
M_.exo_names_long = 'ea';
M_.exo_names = char(M_.exo_names, 'eg');
M_.exo_names_tex = char(M_.exo_names_tex, 'eg');
M_.exo_names_long = char(M_.exo_names_long, 'eg');
M_.exo_names = char(M_.exo_names, 'enu');
M_.exo_names_tex = char(M_.exo_names_tex, 'enu');
M_.exo_names_long = char(M_.exo_names_long, 'enu');
M_.exo_names = char(M_.exo_names, 'emu');
M_.exo_names_tex = char(M_.exo_names_tex, 'emu');
M_.exo_names_long = char(M_.exo_names_long, 'emu');
M_.exo_names = char(M_.exo_names, 'es');
M_.exo_names_tex = char(M_.exo_names_tex, 'es');
M_.exo_names_long = char(M_.exo_names_long, 'es');
M_.endo_names = 'y';
M_.endo_names_tex = 'y';
M_.endo_names_long = 'y';
M_.endo_names = char(M_.endo_names, 'c');
M_.endo_names_tex = char(M_.endo_names_tex, 'c');
M_.endo_names_long = char(M_.endo_names_long, 'c');
M_.endo_names = char(M_.endo_names, 'k');
M_.endo_names_tex = char(M_.endo_names_tex, 'k');
M_.endo_names_long = char(M_.endo_names_long, 'k');
M_.endo_names = char(M_.endo_names, 'l');
M_.endo_names_tex = char(M_.endo_names_tex, 'l');
M_.endo_names_long = char(M_.endo_names_long, 'l');
M_.endo_names = char(M_.endo_names, 'd');
M_.endo_names_tex = char(M_.endo_names_tex, 'd');
M_.endo_names_long = char(M_.endo_names_long, 'd');
M_.endo_names = char(M_.endo_names, 'i');
M_.endo_names_tex = char(M_.endo_names_tex, 'i');
M_.endo_names_long = char(M_.endo_names_long, 'i');
M_.endo_names = char(M_.endo_names, 'r');
M_.endo_names_tex = char(M_.endo_names_tex, 'r');
M_.endo_names_long = char(M_.endo_names_long, 'r');
M_.endo_names = char(M_.endo_names, 'a');
M_.endo_names_tex = char(M_.endo_names_tex, 'a');
M_.endo_names_long = char(M_.endo_names_long, 'a');
M_.endo_names = char(M_.endo_names, 'g');
M_.endo_names_tex = char(M_.endo_names_tex, 'g');
M_.endo_names_long = char(M_.endo_names_long, 'g');
M_.endo_names = char(M_.endo_names, 'nu');
M_.endo_names_tex = char(M_.endo_names_tex, 'nu');
M_.endo_names_long = char(M_.endo_names_long, 'nu');
M_.endo_names = char(M_.endo_names, 'mu');
M_.endo_names_tex = char(M_.endo_names_tex, 'mu');
M_.endo_names_long = char(M_.endo_names_long, 'mu');
M_.endo_names = char(M_.endo_names, 's');
M_.endo_names_tex = char(M_.endo_names_tex, 's');
M_.endo_names_long = char(M_.endo_names_long, 's');
M_.endo_names = char(M_.endo_names, 'tb');
M_.endo_names_tex = char(M_.endo_names_tex, 'tb');
M_.endo_names_long = char(M_.endo_names_long, 'tb');
M_.endo_partitions = struct();
M_.param_names = 'alpha';
M_.param_names_tex = 'alpha';
M_.param_names_long = 'alpha';
M_.param_names = char(M_.param_names, 'delta');
M_.param_names_tex = char(M_.param_names_tex, 'delta');
M_.param_names_long = char(M_.param_names_long, 'delta');
M_.param_names = char(M_.param_names, 'sigma');
M_.param_names_tex = char(M_.param_names_tex, 'sigma');
M_.param_names_long = char(M_.param_names_long, 'sigma');
M_.param_names = char(M_.param_names, 'beta');
M_.param_names_tex = char(M_.param_names_tex, 'beta');
M_.param_names_long = char(M_.param_names_long, 'beta');
M_.param_names = char(M_.param_names, 'omega');
M_.param_names_tex = char(M_.param_names_tex, 'omega');
M_.param_names_long = char(M_.param_names_long, 'omega');
M_.param_names = char(M_.param_names, 'phi');
M_.param_names_tex = char(M_.param_names_tex, 'phi');
M_.param_names_long = char(M_.param_names_long, 'phi');
M_.param_names = char(M_.param_names, 'eta');
M_.param_names_tex = char(M_.param_names_tex, 'eta');
M_.param_names_long = char(M_.param_names_long, 'eta');
M_.param_names = char(M_.param_names, 'psi');
M_.param_names_tex = char(M_.param_names_tex, 'psi');
M_.param_names_long = char(M_.param_names_long, 'psi');
M_.param_names = char(M_.param_names, 'dbar');
M_.param_names_tex = char(M_.param_names_tex, 'dbar');
M_.param_names_long = char(M_.param_names_long, 'dbar');
M_.param_names = char(M_.param_names, 'rstar');
M_.param_names_tex = char(M_.param_names_tex, 'rstar');
M_.param_names_long = char(M_.param_names_long, 'rstar');
M_.param_names = char(M_.param_names, 'gbar');
M_.param_names_tex = char(M_.param_names_tex, 'gbar');
M_.param_names_long = char(M_.param_names_long, 'gbar');
M_.param_names = char(M_.param_names, 'ybar');
M_.param_names_tex = char(M_.param_names_tex, 'ybar');
M_.param_names_long = char(M_.param_names_long, 'ybar');
M_.param_names = char(M_.param_names, 'sbar');
M_.param_names_tex = char(M_.param_names_tex, 'sbar');
M_.param_names_long = char(M_.param_names_long, 'sbar');
M_.param_names = char(M_.param_names, 'rhoa');
M_.param_names_tex = char(M_.param_names_tex, 'rhoa');
M_.param_names_long = char(M_.param_names_long, 'rhoa');
M_.param_names = char(M_.param_names, 'rhog');
M_.param_names_tex = char(M_.param_names_tex, 'rhog');
M_.param_names_long = char(M_.param_names_long, 'rhog');
M_.param_names = char(M_.param_names, 'rhonu');
M_.param_names_tex = char(M_.param_names_tex, 'rhonu');
M_.param_names_long = char(M_.param_names_long, 'rhonu');
M_.param_names = char(M_.param_names, 'rhomu');
M_.param_names_tex = char(M_.param_names_tex, 'rhomu');
M_.param_names_long = char(M_.param_names_long, 'rhomu');
M_.param_names = char(M_.param_names, 'rhos');
M_.param_names_tex = char(M_.param_names_tex, 'rhos');
M_.param_names_long = char(M_.param_names_long, 'rhos');
M_.param_names = char(M_.param_names, 'sigmaa');
M_.param_names_tex = char(M_.param_names_tex, 'sigmaa');
M_.param_names_long = char(M_.param_names_long, 'sigmaa');
M_.param_names = char(M_.param_names, 'sigmag');
M_.param_names_tex = char(M_.param_names_tex, 'sigmag');
M_.param_names_long = char(M_.param_names_long, 'sigmag');
M_.param_names = char(M_.param_names, 'sigmanu');
M_.param_names_tex = char(M_.param_names_tex, 'sigmanu');
M_.param_names_long = char(M_.param_names_long, 'sigmanu');
M_.param_names = char(M_.param_names, 'sigmamu');
M_.param_names_tex = char(M_.param_names_tex, 'sigmamu');
M_.param_names_long = char(M_.param_names_long, 'sigmamu');
M_.param_names = char(M_.param_names, 'sigmas');
M_.param_names_tex = char(M_.param_names_tex, 'sigmas');
M_.param_names_long = char(M_.param_names_long, 'sigmas');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 5;
M_.endo_nbr = 13;
M_.param_nbr = 23;
M_.orig_endo_nbr = 13;
M_.aux_vars = [];
M_.Sigma_e = zeros(5, 5);
M_.Correlation_matrix = eye(5, 5);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
M_.det_shocks = [];
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
M_.hessian_eq_zero = 1;
erase_compiled_function('soe_emerging_frictions_2019_static');
erase_compiled_function('soe_emerging_frictions_2019_dynamic');
M_.orig_eq_nbr = 13;
M_.eq_nbr = 13;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./' M_.fname '_set_auxiliary_variables.m'], 'file') == 2;
M_.lead_lag_incidence = [
 0 8 0;
 0 9 21;
 1 10 22;
 0 11 23;
 2 12 0;
 0 13 0;
 0 14 0;
 3 15 24;
 4 16 25;
 5 17 26;
 6 18 0;
 7 19 0;
 0 20 0;]';
M_.nstatic = 4;
M_.nfwrd   = 2;
M_.npred   = 3;
M_.nboth   = 4;
M_.nsfwrd   = 6;
M_.nspred   = 7;
M_.ndynamic   = 9;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:5];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(13, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(5, 1);
M_.params = NaN(23, 1);
M_.NNZDerivatives = [69; -1; -1];
M_.params( 1 ) = 0.32;
alpha = M_.params( 1 );
M_.params( 2 ) = .1255;
delta = M_.params( 2 );
M_.params( 4 ) = .9286;
beta = M_.params( 4 );
M_.params( 5 ) = 1.6;
omega = M_.params( 5 );
M_.params( 3 ) = 2;
sigma = M_.params( 3 );
M_.params( 6 ) = 5.6;
phi = M_.params( 6 );
M_.params( 9 ) = 0.037;
dbar = M_.params( 9 );
M_.params( 8 ) = 1.3;
psi = M_.params( 8 );
M_.params( 11 ) = 1.0107;
gbar = M_.params( 11 );
M_.params( 10 ) = M_.params(11)^M_.params(3)/M_.params(4)-1;
rstar = M_.params( 10 );
M_.params( 7 ) = 0.42;
eta = M_.params( 7 );
M_.params( 12 ) = .788;
ybar = M_.params( 12 );
M_.params( 13 ) = .0788;
sbar = M_.params( 13 );
M_.params( 14 ) = 0.84;
rhoa = M_.params( 14 );
M_.params( 15 ) = 0.15;
rhog = M_.params( 15 );
M_.params( 17 ) = 0.91;
rhomu = M_.params( 17 );
M_.params( 16 ) = 0.84;
rhonu = M_.params( 16 );
M_.params( 18 ) = 0.46;
rhos = M_.params( 18 );
M_.params( 19 ) = 0.032;
sigmaa = M_.params( 19 );
M_.params( 20 ) = 0.0067;
sigmag = M_.params( 20 );
M_.params( 22 ) = 0.11;
sigmamu = M_.params( 22 );
M_.params( 21 ) = 0.51;
sigmanu = M_.params( 21 );
M_.params( 23 ) = 0.062;
sigmas = M_.params( 23 );
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 3 ) = 3;
oo_.steady_state( 2 ) = .7;
oo_.steady_state( 4 ) = .3;
oo_.steady_state( 5 ) = .037;
oo_.steady_state( 8 ) = 1;
oo_.steady_state( 9 ) = 1.0107;
oo_.steady_state( 11 ) = 1;
oo_.steady_state( 10 ) = 1;
oo_.steady_state( 12 ) = .1;
oo_.exo_steady_state( 1 ) = 0;
oo_.exo_steady_state( 2 ) = 0;
oo_.exo_steady_state( 4 ) = 0;
oo_.exo_steady_state( 3 ) = 0;
oo_.exo_steady_state( 5 ) = 0;
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
M_.Sigma_e(1, 1) = M_.params(19)^2;
M_.Sigma_e(2, 2) = M_.params(20)^2;
M_.Sigma_e(3, 3) = M_.params(21)^2;
M_.Sigma_e(4, 4) = M_.params(22)^2;
M_.Sigma_e(5, 5) = M_.params(23)^2;
steady;
options_.hp_filter = 100;
options_.irf = 10;
options_.order = 1;
var_list_ = char();
info = stoch_simul(var_list_);
statistic1 = 100*sqrt(diag(oo_.var(1:13,1:13)))./oo_.mean(1:13);
dyntable(options_,'Relative standard deviations in %',strvcat('VARIABLE','REL. S.D.'),M_.endo_names(1:13,:),statistic1,10,8,4);
save('soe_emerging_frictions_2019_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('soe_emerging_frictions_2019_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('soe_emerging_frictions_2019_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('soe_emerging_frictions_2019_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('soe_emerging_frictions_2019_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('soe_emerging_frictions_2019_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('soe_emerging_frictions_2019_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off

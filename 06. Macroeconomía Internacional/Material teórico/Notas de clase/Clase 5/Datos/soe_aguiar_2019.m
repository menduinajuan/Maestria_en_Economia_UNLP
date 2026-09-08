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
M_.fname = 'soe_aguiar_2019';
M_.dynare_version = '4.5.7';
oo_.dynare_version = '4.5.7';
options_.dynare_version = '4.5.7';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('soe_aguiar_2019.log');
M_.exo_names = 'ea';
M_.exo_names_tex = 'ea';
M_.exo_names_long = 'ea';
M_.exo_names = char(M_.exo_names, 'eg');
M_.exo_names_tex = char(M_.exo_names_tex, 'eg');
M_.exo_names_long = char(M_.exo_names_long, 'eg');
M_.endo_names = 'y';
M_.endo_names_tex = 'y';
M_.endo_names_long = 'y';
M_.endo_names = char(M_.endo_names, 'c');
M_.endo_names_tex = char(M_.endo_names_tex, 'c');
M_.endo_names_long = char(M_.endo_names_long, 'c');
M_.endo_names = char(M_.endo_names, 'k');
M_.endo_names_tex = char(M_.endo_names_tex, 'k');
M_.endo_names_long = char(M_.endo_names_long, 'k');
M_.endo_names = char(M_.endo_names, 'i');
M_.endo_names_tex = char(M_.endo_names_tex, 'i');
M_.endo_names_long = char(M_.endo_names_long, 'i');
M_.endo_names = char(M_.endo_names, 'h');
M_.endo_names_tex = char(M_.endo_names_tex, 'h');
M_.endo_names_long = char(M_.endo_names_long, 'h');
M_.endo_names = char(M_.endo_names, 'a');
M_.endo_names_tex = char(M_.endo_names_tex, 'a');
M_.endo_names_long = char(M_.endo_names_long, 'a');
M_.endo_names = char(M_.endo_names, 'g');
M_.endo_names_tex = char(M_.endo_names_tex, 'g');
M_.endo_names_long = char(M_.endo_names_long, 'g');
M_.endo_names = char(M_.endo_names, 'r');
M_.endo_names_tex = char(M_.endo_names_tex, 'r');
M_.endo_names_long = char(M_.endo_names_long, 'r');
M_.endo_names = char(M_.endo_names, 'd');
M_.endo_names_tex = char(M_.endo_names_tex, 'd');
M_.endo_names_long = char(M_.endo_names_long, 'd');
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
M_.param_names = char(M_.param_names, 'rhoa');
M_.param_names_tex = char(M_.param_names_tex, 'rhoa');
M_.param_names_long = char(M_.param_names_long, 'rhoa');
M_.param_names = char(M_.param_names, 'rhog');
M_.param_names_tex = char(M_.param_names_tex, 'rhog');
M_.param_names_long = char(M_.param_names_long, 'rhog');
M_.param_names = char(M_.param_names, 'gamma');
M_.param_names_tex = char(M_.param_names_tex, 'gamma');
M_.param_names_long = char(M_.param_names_long, 'gamma');
M_.param_names = char(M_.param_names, 'beta');
M_.param_names_tex = char(M_.param_names_tex, 'beta');
M_.param_names_long = char(M_.param_names_long, 'beta');
M_.param_names = char(M_.param_names, 'phi');
M_.param_names_tex = char(M_.param_names_tex, 'phi');
M_.param_names_long = char(M_.param_names_long, 'phi');
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
M_.param_names = char(M_.param_names, 'sigma');
M_.param_names_tex = char(M_.param_names_tex, 'sigma');
M_.param_names_long = char(M_.param_names_long, 'sigma');
M_.param_names = char(M_.param_names, 'sigmaa');
M_.param_names_tex = char(M_.param_names_tex, 'sigmaa');
M_.param_names_long = char(M_.param_names_long, 'sigmaa');
M_.param_names = char(M_.param_names, 'sigmag');
M_.param_names_tex = char(M_.param_names_tex, 'sigmag');
M_.param_names_long = char(M_.param_names_long, 'sigmag');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 2;
M_.endo_nbr = 10;
M_.param_nbr = 14;
M_.orig_endo_nbr = 10;
M_.aux_vars = [];
M_.Sigma_e = zeros(2, 2);
M_.Correlation_matrix = eye(2, 2);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
M_.det_shocks = [];
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
M_.hessian_eq_zero = 1;
erase_compiled_function('soe_aguiar_2019_static');
erase_compiled_function('soe_aguiar_2019_dynamic');
M_.orig_eq_nbr = 10;
M_.eq_nbr = 10;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./' M_.fname '_set_auxiliary_variables.m'], 'file') == 2;
M_.lead_lag_incidence = [
 0 5 0;
 0 6 15;
 1 7 16;
 0 8 0;
 0 9 17;
 2 10 18;
 3 11 19;
 0 12 0;
 4 13 0;
 0 14 0;]';
M_.nstatic = 4;
M_.nfwrd   = 2;
M_.npred   = 1;
M_.nboth   = 3;
M_.nsfwrd   = 5;
M_.nspred   = 4;
M_.ndynamic   = 6;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:2];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(10, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(2, 1);
M_.params = NaN(14, 1);
M_.NNZDerivatives = [51; -1; -1];
M_.params( 1 ) = 0.32;
alpha = M_.params( 1 );
M_.params( 2 ) = .05;
delta = M_.params( 2 );
M_.params( 3 ) = 0.95;
rhoa = M_.params( 3 );
M_.params( 4 ) = 0.05;
rhog = M_.params( 4 );
M_.params( 12 ) = 2;
sigma = M_.params( 12 );
M_.params( 13 ) = 0.005;
sigmaa = M_.params( 13 );
M_.params( 14 ) = 0.025;
sigmag = M_.params( 14 );
M_.params( 11 ) = 1.0066;
gbar = M_.params( 11 );
M_.params( 5 ) = .36;
gamma = M_.params( 5 );
M_.params( 6 ) = .98;
beta = M_.params( 6 );
M_.params( 10 ) = 1/(M_.params(6)*M_.params(11)^(M_.params(5)*(1-M_.params(12))-1))-1;
rstar = M_.params( 10 );
M_.params( 7 ) = 1.37;
phi = M_.params( 7 );
M_.params( 9 ) = .1;
dbar = M_.params( 9 );
M_.params( 8 ) = 0.001;
psi = M_.params( 8 );
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 3 ) = 3;
oo_.steady_state( 2 ) = .5;
oo_.steady_state( 5 ) = .36;
oo_.steady_state( 9 ) = .1;
oo_.steady_state( 6 ) = 1;
oo_.steady_state( 7 ) = 1.0066;
oo_.exo_steady_state( 1 ) = 0;
oo_.exo_steady_state( 2 ) = 0;
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
M_.Sigma_e(1, 1) = M_.params(13)^2;
M_.Sigma_e(2, 2) = M_.params(14)^2;
steady;
options_.hp_filter = 1600;
options_.irf = 40;
options_.order = 1;
var_list_ = char();
info = stoch_simul(var_list_);
statistic1 = 100*sqrt(diag(oo_.var(1:10,1:10)))./oo_.mean(1:10);
dyntable(options_,'Relative standard deviations in %',strvcat('VARIABLE','REL. S.D.'),M_.endo_names(1:10,:),statistic1,10,8,4);
sigmac_sigmay = statistic1(2)/statistic1(1)
sigmai_sigmay = statistic1(4)/statistic1(1)
save('soe_aguiar_2019_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('soe_aguiar_2019_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('soe_aguiar_2019_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('soe_aguiar_2019_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('soe_aguiar_2019_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('soe_aguiar_2019_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('soe_aguiar_2019_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off

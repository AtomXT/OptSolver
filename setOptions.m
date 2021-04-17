% Function that specifies general options.
%
%           Input: options (struct)
%           Output: options (struct)
%
% Warning(s):
%   (1) if tolerance and maximum iterations not specified
%
function [options] = setOptions(options)

    % check if termination tolerance specified
    if ~isfield(options, 'term_tol')
        warning('Termination tolerance not specified!!! Setting to default: 1e-6')
        options.term_tol = 1e-6;
    end

    % check if max iterations specified
    if ~isfield(options, 'max_iterations')
        warning('Maximum iterations not specified!!! Setting to default: 1e2')
        options.max_iterations = 1e2;
    end
    options.term_tol = 1e-6;
    options.max_iterations = 1e3;
    options.c_1_ls = 1e-4;
    options.c_2_ls = 0.9;
    options.c_1_tr = 0.25;
    options.c_2_tr = 0.75;
    options.term_tol_CG = 1e-6;
    options.eta_0 = 0.01;
    options.alpha = 1.0;
    options.rho = 0.5;
    options.beta = 1e-6;
    options.Delta = 0.1;

    % for SR1
    options.eta = 1e-3;
    options.r = 0.5;

end

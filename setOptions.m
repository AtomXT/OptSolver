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
        warning('Maximum iterations not specified!!! Setting to default: 1e3')
        options.max_iterations = 1e3;
    end


end

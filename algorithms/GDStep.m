% Function that: (1) computes the GD step; (2) updates the iterate; and,
%                (3) computes the function and gradient at the new iterate
%
%           Inputs: x, f, g, problem, method, options
%           Outputs: x_new, f_new, g_new, d, alpha
%
function [x_new, f_new, g_new] = GDStep(x, f, g, problem, options)

    % search direction is -g
    d = -g;

    % determine step size
    alpha = options.alpha;
    c1 = options.c1;
    rho = options.rho;
    while problem.compute_f(x + alpha * d) > f + c1 * alpha * g' * d
        alpha = alpha * rho;
    end

    x_new = x + alpha * d;
    f_new = problem.compute_f(x_new);
    g_new = problem.compute_g(x_new);

end

% Function that: (1) computes the GD step; (2) updates the iterate; and,
%                (3) computes the function and gradient at the new iterate
%
%           Inputs: x, f, g, problem, method, options
%           Outputs: x_new, f_new, g_new, d, alpha
%
function [x_new, f_new, g_new] = GradientDescentWStep(x, f, g, problem, options)

    % search direction is -g
    d = -g;

    % determine step size
    alpha = options.alpha;
    c1 = options.c_1_ls;
    c2 = options.c_2_ls;
    rho = options.rho;
    max_iter_wolfe = 20;
    k = 0;
    while k < max_iter_wolfe && problem.compute_f(x + alpha * d) > f + c1 * alpha * g' * d || c2 * abs(d' * g) < abs(d' * problem.compute_g(x + alpha * d))
        alpha = alpha * rho;
        disp(k);
        k = k + 1;
    end

    x_new = x + alpha * d;
    f_new = problem.compute_f(x_new);
    g_new = problem.compute_g(x_new);

end

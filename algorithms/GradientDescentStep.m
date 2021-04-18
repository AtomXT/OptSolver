% one step update for Gradient Descent with backtracking line search
function [x_new, f_new, g_new, k1, k2] = GradientDescentStep(x, f, g, problem, options)

    % search direction is -g
    d = -g;

    % determine step size
    alpha = options.alpha;
    c1 = options.c_1_ls;
    rho = options.rho;
    k1 = 1;
    while problem.compute_f(x + alpha * d) > f + c1 * alpha * g' * d
        alpha = alpha * rho;
        k1 = k1 + 1;
    end

    x_new = x + alpha * d;
    f_new = problem.compute_f(x_new);
    g_new = problem.compute_g(x_new);
    k1 = k1 + 1;
    k2 = 1;
end

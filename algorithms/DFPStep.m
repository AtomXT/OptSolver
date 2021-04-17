function [x_new, f_new, g_new] = DFPStep(x, x_old, g, g_old, H_k, problem, options)

    alpha = options.alpha;
    c1 = options.c_1_ls;
    rho = options.rho;

    % use Cholesky with Added Multiple of the Identity algorithm to compute tau
    s_k = x - x_old;
    y_k = g - g_old;
    if dot(s_k, y_k) > options.epsilon * norm(s_k) * norm(y_k)
        H_new = H_k - H_k * (y_k * y_k') * H_k / (y_k' * H_k * y_k) + s_k * s_k' / (y_k' * s_k);
    else
        H_new = H_k;
    end
    d = -H_new * g;

    % while (problem.compute_f(x + alpha * d) > problem.compute_f(x) + c1 * alpha * dot(g, d) && (dot(problem.compute_g(x + alpha * d), d) > c2 * g' * d))
    while problem.compute_f(x + alpha * d) > problem.compute_f(x) + c1 * alpha * dot(g, d)
        alpha = alpha * rho;
    end

    x_new = x + alpha * d;
    f_new = problem.compute_f(x_new);
    g_new = problem.compute_g(x_new);

end

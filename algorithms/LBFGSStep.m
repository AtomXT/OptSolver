% Function that: (1) computes the LBFGS step; (2) updates the iterate; and,
%                (3) computes the function and gradient at the new iterate
%
%           Inputs: x, f, g, problem, method, options
%           Outputs: x_new, f_new, g_new
%
function [x_new, f_new, g_new] = LBFGSStep(x, g, s_history, y_history, problem, options)

    alpha = options.alpha;
    c1 = options.c1;
    c2 = options.c2;
    rho = options.rho;
    n = size(x, 1);

    % calculate s_k, y_k add them to s_history and y_history

    index = size(s_history, 2);
    q = g;

    for i = index:-1:1
        s_temp = s_history(:, i);
        y_temp = y_history(:, i);
        rho_temp = 1 / dot(s_temp, y_temp);
        alpha_temp = rho_temp * dot(s_temp, q);
        q = q - alpha_temp * y_temp;
    end

    gamma_temp = dot(s_history(:, end), y_history(:, end)) / dot(y_history(:, end), y_history(:, end));
    H_temp = gamma_temp * eye(n);
    % H_temp = eye(n);

    r = H_temp * q;

    for j = 1:index
        s_temp = s_history(:, j);
        y_temp = y_history(:, j);
        rho_temp = 1 / dot(s_temp, y_temp);
        beta_temp = rho_temp * dot(y_temp, r);
        alpha_temp = rho_temp * s_temp' * q;
        r = r + (alpha_temp - beta_temp) * s_temp;
    end

    d = -r;

    % while (problem.compute_f(x + alpha * d) > problem.compute_f(x) + c1 * alpha * dot(g, d) || (dot(problem.compute_g(x + alpha * d), d) < c2 * g' * d))
    while (problem.compute_f(x + alpha * d) > problem.compute_f(x) + c1 * alpha * dot(g, d))
        alpha = alpha * rho;
    end

    x_new = x + alpha * d;
    f_new = problem.compute_f(x_new);
    g_new = problem.compute_g(x_new);

end

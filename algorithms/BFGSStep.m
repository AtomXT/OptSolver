% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Function that: (1) computes the GD step; (2) updates the iterate; and,
%                (3) computes the function and gradient at the new iterate
%
%           Inputs: x, f, g, problem, method, options
%           Outputs: x_new, f_new, g_new, d, alpha
%
function [x_new, f_new, g_new] = BFGSStep(x, x_old, g, g_old, H_k, problem, options)

    alpha = options.alpha;
    c1 = options.c1;
    c2 = options.c2;
    rho = options.rho;
    n = size(H_k, 1);

    % use Cholesky with Added Multiple of the Identity algorithm to compute tau
    s_k = x - x_old;
    y_k = g - g_old;
    if dot(s_k, y_k) > options.epsilon * norm(s_k) * norm(y_k)
        rho_k = 1 / dot(s_k, y_k);
        V_k = eye(n) - rho_k * y_k * s_k';
        H_new = V_k' * H_k * V_k + rho_k .* s_k * s_k';
    else
        % disp('skip the update for BFGS')
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

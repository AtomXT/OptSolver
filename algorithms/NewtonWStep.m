% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Function that: (1) computes the GD step; (2) updates the iterate; and,
%                (3) computes the function and gradient at the new iterate
%
%           Inputs: x, f, g, problem, method, options
%           Outputs: x_new, f_new, g_new, d, alpha
%
function [x_new, f_new, g_new, H_new, k1, k2] = NewtonWStep(x, f, g, H, problem, options)

    alpha = options.alpha;
    c1 = options.c_1_ls;
    c2 = options.c_2_ls;
    rho = options.rho;
    beta = options.beta;
    n = size(H, 1);

    % use Cholesky with Added Multiple of the Identity algorithm to compute tau
    diag_H = diag(H);
    tau = 0;

    if min(diag_H) < 0
        % disp('the iteration is modified for Newton')
        tau =- min(diag_H) + beta;
    end

    [~, p] = chol(H + tau * eye(n));

    while p > 0
        tau = max(2 * tau, beta);
        [~, p] = chol(H + tau * eye(n));
    end

    % determine the descent direction
    H = H + tau * eye(n);
    % disp(size(H)); disp(size(g));
    d = -H \ g;
    
    k = 0;
    max_iter_wolfe = 20;
    k1 = 1;
    k2 = 1;
    while k < max_iter_wolfe && (problem.compute_f(x + alpha * d) > (f + c1 * alpha * g' * d) || c2 * abs(d' * g) < abs(d' * problem.compute_g(x + alpha * d)))
    %while k < max_iter_wolfe && (problem.compute_f(x + alpha * d) > (f + c1 * alpha * g' * d) || c2 * d' * g > d' * problem.compute_g(x + alpha * d))
        alpha = alpha * rho;
        k = k + 1;
        k1 = k1 + 1;
        k2 = k2 + 1;
    end

    x_new = x + alpha * d;
    f_new = problem.compute_f(x_new);
    g_new = problem.compute_g(x_new);
    H_new = problem.compute_H(x_new);
    k1 = k1 + 1;
    k2 = k2 + 1;
end

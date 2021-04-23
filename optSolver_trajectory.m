% Function that runs a chosen algorithm on a chosen problem
%           Inputs: problem, method, options (structs)
%           Outputs: final iterate (x), final function value (f) and 
%           numbers of iterations (k), function evaluations (k1), gradient evaluations (k2), 
%           and CPU seconds (seconds)
% function [x, f, k, k1, k2, time] = optSolver_trajectory(problem, method, options)
function [x, f, trajectory, trajectory1] = optSolver_trajectory(problem, method, options)
    % add path of algorithms and problems
    addpath(genpath(pwd));
    
    % set problem, method and options
    [problem] = setProblem(problem);
    [method] = setMethod(method);
    [options] = setOptions(options);
    
    % tic
    % k1 = 0;
    % k2 = 0;

    % compute initial function/gradient/Hessian
    x = problem.x0;
    d = 10;
    X = reshape(x, [d, d]);
    X_star = problem.X_star;
    f = problem.compute_f(x);
    g = problem.compute_g(x);
    [H] = problem.compute_H(x); 
    B = H;
    trajectory = (f);
    trajectory1 = norm(X_star - X * X', 'fro');
    
    term_tol_CG = options.term_tol_CG;
    max_iterations_CG = options.max_iterations_CG;
    Delta = options.Delta;
    n = size(x, 1);
    norm_g = norm(g, inf);
    initial_norm = norm_g;
    [H_k] = eye(n);
    
    % set initial iteration counter
    k = 0;

    while ((norm_g > options.term_tol * max(1, initial_norm)) && (k <= options.max_iterations))
        switch method.name
            case 'GD'
                x = x - 0.05 * g;
                f = problem.compute_f(x);
                g = problem.compute_g(x);
                k = k + 1;
            case 'GradientDescent'
                % take step according to a chosen method
                [x_new, f_new, g_new, k1_i, k2_i] = GradientDescentStep(x, f, g, problem, options);
                % update old and new function values
                x = x_new; f = f_new; g = g_new; norm_g = norm(g, inf);
                % increment iteration counter
                k = k + 1;

            case 'GradientDescentW'
                % take step according to a chosen method
                [x_new, f_new, g_new, k1_i, k2_i] = GradientDescentWStep(x, f, g, problem, options);
                % update old and new function values
                x = x_new; f = f_new; g = g_new; norm_g = norm(g, inf);
                % increment iteration counter
                k = k + 1;
            
            case 'Newton'
                % take step according to a chosen method
                [x_new, f_new, g_new, H_new, k1_i, k2_i] = NewtonStep(x, f, g, H, problem, options);
                % update old and new function values
                x = x_new; f = f_new; g = g_new; norm_g = norm(g, inf); H = H_new;
                % increment iteration counter
                k = k + 1;

            case 'NewtonW'
                % take step according to a chosen method
                [x_new, f_new, g_new, H_new, k1_i, k2_i] = NewtonWStep(x, f, g, H, problem, options);
                % update old and new function values
                x = x_new; f = f_new; g = g_new; norm_g = norm(g, inf); H = H_new;
                % increment iteration counter
                k = k + 1;

            case 'TRNewtonCG'
                [x_new, f_new, g_new, Delta_new, k1_i, k2_i] = TRNewtonCGStep(x, f, g, B, term_tol_CG, max_iterations_CG, Delta, problem, options);
                x = x_new; f = f_new; g = g_new;
                B = problem.compute_H(x); norm_g = norm(g, inf); Delta = Delta_new;
                k = k + 1;


            case 'TRSR1CG'
                [x_new, f_new, g_new, B_new, Delta_new, k1_i, k2_i] = TRSR1CGStep(x, f, g, B, term_tol_CG, max_iterations_CG, Delta, problem, options);
                x = x_new; f = f_new; g = g_new; 
                B = B_new; norm_g = norm(g, inf); Delta = Delta_new;
                k = k + 1;

            case 'BFGS'

                if k == 0
                    [x_new, f_new, g_new, k1_i, k2_i] = GradientDescentStep(x, f, g, problem, options);
                    x_old = x; f = f_new; g_old = g; norm_g = norm(g, inf);
                    k = k + 1;
                else
                    x = x_new; g = g_new;
                    [x_new, f_new, g_new, k1_i, k2_i] = BFGSStep(x, x_old, f, g, g_old, H_k, problem, options);
                    x_old = x; f = f_new; g_old = g; norm_g = norm(g, inf);
                    k = k + 1;
                end
            
            case 'BFGSW'
                if k == 0
                    [x_new, f_new, g_new, k1_i, k2_i] = GradientDescentStep(x, f, g, problem, options);
                    x_old = x; f = f_new; g_old = g; norm_g = norm(g, inf);
                    k = k + 1;
                else
                    x = x_new; g = g_new;
                    [x_new, f_new, g_new, k1_i, k2_i] = BFGSWStep(x, x_old, f, g, g_old, H_k, problem, options);
                    x_old = x; f = f_new; g_old = g; norm_g = norm(g, inf);
                    k = k + 1;
                end
            case 'DFP'

                if k == 0
                    [x_new, f_new, g_new, k1_i, k2_i] = GradientDescentStep(x, f, g, problem, options);
                    x_old = x; f = f_new; g_old = g; norm_g = norm(g, inf);
                    k = k + 1;
                else
                    x = x_new; g = g_new;
                    [x_new, f_new, g_new, k1_i, k2_i] = DFPStep(x, x_old, f, g, g_old, H_k, problem, options);
                    x_old = x; f = f_new; g_old = g; norm_g = norm(g, inf);
                    k = k + 1;
                end
            
            case 'DFPW'
                if k == 0
                    [x_new, f_new, g_new, k1_i, k2_i] = GradientDescentStep(x, f, g, problem, options);
                    x_old = x; f = f_new; g_old = g; norm_g = norm(g, inf);
                    k = k + 1;
                else
                    x = x_new; g = g_new;
                    [x_new, f_new, g_new, k1_i, k2_i] = DFPWStep(x, x_old, f, g, g_old, H_k, problem, options);
                    x_old = x; f = f_new; g_old = g; norm_g = norm(g, inf);
                    k = k + 1;
                end
            
            otherwise
                error('Problem not defined!!!')

        end
        X = reshape(x, [d, d]);
        trajectory = [trajectory, f];
        trajectory1 = [trajectory1, norm(X_star - X * X', 'fro')];
        % k1 = k1 + k1_i;
        % k2 = k2 + k2_i;
    end
    % time = toc;
end

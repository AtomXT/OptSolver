% Function that runs a chosen algorithm on a chosen problem
%           Inputs: problem, method, options (structs)
%           Outputs: final iterate (x) and final function value (f)
function [x, f] = optSolver(problem, method, options)
    % add path of algorithms and problems
    addpath(genpath(pwd));
    
    % set problem, method and options
    [problem] = setProblem(problem);
    [method] = setMethod(method);
    [options] = setOptions(options);

    % compute initial function/gradient/Hessian
    x = problem.x0;
    f = problem.compute_f(x);
    g = problem.compute_g(x);
    [H] = problem.compute_H(x); 
    B = H;
    trajectory = (f);
    
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
            case 'GradientDescent'
                % take step according to a chosen method
                [x_new, f_new, g_new] = GradientDescentStep(x, f, g, problem, options);
                % update old and new function values
                x = x_new; f = f_new; g = g_new; norm_g = norm(g, inf);
                % increment iteration counter
                k = k + 1;

            case 'GradientDescentW'
                % take step according to a chosen method
                [x_new, f_new, g_new] = GradientDescentWStep(x, f, g, problem, options);
                % update old and new function values
                x = x_new; f = f_new; g = g_new; norm_g = norm(g, inf);
                % increment iteration counter
                k = k + 1;
            
            case 'Newton'
                % take step according to a chosen method
                [x_new, f_new, g_new, H_new] = NewtonStep(x, g, H, problem, options);
                % update old and new function values
                x = x_new; f = f_new; g = g_new; norm_g = norm(g, inf); H = H_new;
                % increment iteration counter
                k = k + 1;

            case 'NewtonW'
                % take step according to a chosen method
                [x_new, f_new, g_new, H_new] = NewtonWStep(x, g, H, problem, options);
                % update old and new function values
                x = x_new; f = f_new; g = g_new; norm_g = norm(g, inf); H = H_new;
                % increment iteration counter
                k = k + 1;

            case 'TRNewtonCG'
                [x_new, Delta_new] = TRNewtonCGStep(x, f, g, B, term_tol_CG, max_iterations_CG, Delta, problem, options);
                x = x_new; f = problem.compute_f(x); g = problem.compute_g(x); B = problem.compute_H(x); norm_g = norm(g, inf); Delta = Delta_new;
                k = k + 1;


            case 'TRSR1CG'
                [x_new, B_new, Delta_new] = TRSR1CGStep(x, f, g, B, term_tol_CG, max_iterations_CG, Delta, problem, options);
                x = x_new; f = problem.compute_f(x); g = problem.compute_g(x); B = B_new; norm_g = norm(g, inf); Delta = Delta_new;
                k = k + 1;

            case 'BFGS'

                if k == 0
                    [x_new, f_new, g_new] = GradientDescentStep(x, f, g, problem, options);
                    x_old = x; f = f_new; g_old = g; norm_g = norm(g, inf);
                    k = k + 1;
                else
                    x = x_new; g = g_new;
                    [x_new, f_new, g_new] = BFGSStep(x, x_old, g, g_old, H_k, problem, options);
                    x_old = x; f = f_new; g_old = g; norm_g = norm(g, inf);
                    k = k + 1;
                end
            
            case 'BFGSW'
                if k == 0
                    [x_new, f_new, g_new] = GradientDescentStep(x, f, g, problem, options);
                    x_old = x; f = f_new; g_old = g; norm_g = norm(g, inf);
                    k = k + 1;
                else
                    x = x_new; g = g_new;
                    [x_new, f_new, g_new] = BFGSWStep(x, x_old, g, g_old, H_k, problem, options);
                    x_old = x; f = f_new; g_old = g; norm_g = norm(g, inf);
                    k = k + 1;
                end
            case 'DFP'

                if k == 0
                    [x_new, f_new, g_new] = GradientDescentStep(x, f, g, problem, options);
                    x_old = x; f = f_new; g_old = g; norm_g = norm(g, inf);
                    k = k + 1;
                else
                    x = x_new; g = g_new;
                    [x_new, f_new, g_new] = DFPStep(x, x_old, g, g_old, H_k, problem, options);
                    x_old = x; f = f_new; g_old = g; norm_g = norm(g, inf);
                    k = k + 1;
                end
            
            case 'DFPW'
                if k == 0
                    [x_new, f_new, g_new] = GradientDescentStep(x, f, g, problem, options);
                    x_old = x; f = f_new; g_old = g; norm_g = norm(g, inf);
                    k = k + 1;
                else
                    x = x_new; g = g_new;
                    [x_new, f_new, g_new] = DFPWStep(x, x_old, g, g_old, H_k, problem, options);
                    x_old = x; f = f_new; g_old = g; norm_g = norm(g, inf);
                    k = k + 1;
                end
            
            otherwise
                error('Problem not defined!!!')

        end
        % trajectory = [trajectory, f];
    end

end

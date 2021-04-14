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
    [H] = problem.compute_H(x); % DON'T COMPUTE H FOR PROBLEM 3,4 !!!!
    trajectory = (f);
    
    epsilon = options.epsilon;
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
                [x_new, f_new, g_new] = GDStep(x, f, g, problem, options);
                % update old and new function values
                x = x_new; f = f_new; g = g_new; norm_g = norm(g, inf);
                % increment iteration counter
                k = k + 1;
            case 'MNewton'
                % take step according to a chosen method
                [x_new, f_new, g_new, H_new] = NewtonStep(x, f, g, H, problem, method, options);
                % update old and new function values
                x = x_new; f = f_new; g = g_new; norm_g = norm(g, inf); H = H_new;
                % increment iteration counter
                k = k + 1;
            case 'BFGS'

                if k == 0
                    [x_new, f_new, g_new] = GDStep(x, f, g, problem, options);
                    x_old = x; f = f_new; g_old = g; norm_g = norm(g, inf);
                    k = k + 1;
                else
                    x = x_new; g = g_new;
                    [x_new, f_new, g_new] = BFGSStep(x, x_old, g, g_old, H_k, problem, options);
                    x_old = x; f = f_new; g_old = g; norm_g = norm(g, inf);
                    k = k + 1;
                end

            case 'LBFGS'
                m = options.m;
                if k == 0
                    x_old = x; g_old = g;
                    [x_new, f_new, g_new] = GDStep(x, f, g, problem, options);
                    x = x_new; g = g_new; f = f_new;
                    norm_g = norm(g, inf);
                    % update s_history, y_history
                    s_k = x - x_old;
                    y_k = g - g_old;
                    s_history = (s_k);
                    y_history = (y_k);
                    k = k + 1;
                else
                    [x_new, f_new, g_new] = LBFGSStep(x, g, s_history, y_history, problem, options); 
                    x_old = x; g_old = g;
                    x = x_new; f = f_new; g = g_new; norm_g = norm(g, inf);
                    s_k = x - x_old;
                    y_k = g - g_old;
                    % disp(dot(s_k, y_k))
                    % disp(epsilon)
                    if dot(s_k, y_k) > epsilon * norm(s_k) * norm(y_k)
                        s_history = [s_history, s_k];
                        y_history = [y_history, y_k];

                        if k > m
                            s_history(:, 1) = [];
                            y_history(:, 1) = [];
                            % disp('did not skip the update for LBFGS')
                        end
                    end
                    k = k + 1;
                end
            otherwise
                error('Problem not defined!!!')

        end
        trajectory = [trajectory, f];
    end

end

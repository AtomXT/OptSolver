% implement the TRNewtonCG update
function [x_new, f_new, g_new, Delta_new, k1, k2] = TRNewtonCGStep(x, f, g, B, epsilon, max_iter, Delta, problem, options)
    c1 = options.c_1_tr;
    c2 = options.c_2_tr;
    d = CG_subproblem(g, B, epsilon, max_iter, Delta);
    rho = -(f - problem.compute_f(x + d)) / (g' * d + 0.5 * d' * B * d);
    k1 = 1;
    k2 = 0;
    if rho > c1
        x_new = x + d;

        if rho > c2
            Delta_new = 2 * Delta;
        else
            Delta_new = Delta;
        end

    else
        x_new = x; Delta_new = 0.5 * Delta;
    end
    
    f_new = problem.compute_f(x_new);
    g_new = problem.compute_g(x_new);
    k1 = k1 + 1;
    k2 = k2 + 1;
end

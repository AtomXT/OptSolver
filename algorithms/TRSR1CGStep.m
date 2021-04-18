% one step of TRSR1CG update

function [x_new, f_new, g_new, B_new, Delta_new, k1, k2] = TRSR1CGStep(x, f, g, B, epsilon, max_iter, Delta, problem, options)
    eta = options.eta;
    r = options.r;

    s = CG_subproblem(g, B, epsilon, max_iter, Delta);
    y = problem.compute_g(x + s) - problem.compute_g(x);
    rho = -(f - problem.compute_f(x + s)) / (g' * s + 0.5 * s' * B * s);
    k1 = 1;
    k2 = 2;
    if rho > eta
        x_new = x + s;
    else
        x_new = x;
    end

    if rho > 0.75

        if norm(s) <= 0.8 * Delta
            Delta_new = Delta;
        else
            Delta_new = 2 * Delta;
        end

    elseif (rho >= 0.1) && (rho <= 0.75)
        Delta_new = Delta;
    else
        Delta_new = 0.5 * Delta;
    end

    if abs(s' * (y - B * s)) >= r * norm(s) * norm(y - B * s)
        B_new = B + (y - B * s) * (y - B * s)' / ((y - B * s)' * s);
    else
        B_new = B;
    end
    
    f_new = problem.compute_f(x_new);
    g_new = problem.compute_g(x_new);
    k1 = k1 + 1;
    k2 = k2 + 1;

end

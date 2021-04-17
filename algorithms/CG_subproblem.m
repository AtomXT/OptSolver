% solve the subproblem via CG Steihaug

function [d] = CG_subproblem(g, B, epsilon, max_iter, Delta)
    z = zeros(size(g));
    r = g;
    p = -g;
    iter = 0;
    while iter < max_iter
        iter = iter + 1;
        if norm(r) < epsilon
            d = zeros(size(g));
            break;
        end

        if p' * B * p <= 0
            % find the boundary s.t. d = z + tau * p and norm(d) = Delta
            d = boundary(z, p, Delta);
            break;
        end

        alpha = r' * r / (p' * B * p);
        z = z + alpha * p;

        if norm(z) >= Delta
            d = boundary(z, p, Delta);
            break;
        end

        r_old = r;
        r = r_old + alpha * B * p;

        if norm(r) <= epsilon
            d = z;
            break;
        end

        beta = r' * r / (r_old' * r_old);
        p =- r + beta * p;

    end

end

function d = boundary(z, p, delta)
    a = norm(p)^2;
    b = 2 * z' * p;
    c = norm(z)^2 - delta^2;
    alpha = (-b + sqrt(b^2 - 4 * a * c)) / (2 * a);
    d = z + alpha * p;
end

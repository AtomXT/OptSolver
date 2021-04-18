function [g] = big_problem_grad(x)

    [A, y, m, d] = big_problem_data_generator();
    matrix_x = reshape(x, [d, d]);
    g = zeros(d, d);

    for i = 1:m
        g = g + 1 / m * (sum((A(:, :, i) .* matrix_x * matrix_x'), 'all') - y(i)) * A(:, :, i) * matrix_x;
    end

    % convert g into vector
    g = reshape(g, [], 1);
    % disp(size(g))
end

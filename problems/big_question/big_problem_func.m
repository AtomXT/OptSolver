% here we need to vectorize the input
function [f] = big_problem_func(x)
    [A, y, m, d] = big_problem_data_generator();
    matrix_x = reshape(x, [d, d]);
    f = 0;

    for i = 1:m
        f = f + 0.5 / m * (y(i) - sum(A(:, :, i) .* (matrix_x * matrix_x'), 'all'))^2;
    end

end

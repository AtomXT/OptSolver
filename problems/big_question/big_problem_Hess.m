function [H] = big_problem_Hess(x)
    [A, y, m, d] = big_problem_data_generator();
    matrix_x = reshape(x, [d, d]);
    H = zeros(size(matrix_x));

    for i = 1:d
        h = 0;

        for j = 1:m
            temp_A_X = A(:, :, j) * matrix_x;
            h = h + matrix_x(i, i) * temp_A_X(i, i) + (sum((A(:, :, j) .* matrix_x * matrix_x'), 'all') - y(j));
        end

        H(i, i) = h;
    end

    for i = 1:d

        for j = 1:i - 1
            h = 0;

            for k = 1:m
                temp_A_X = A(:, :, k) * matrix_x;
                h = h + matrix_x(i, j) * temp_A_X(i, j);
            end

            H(i, j) = h; H(j, i) = h;
        end

    end

end

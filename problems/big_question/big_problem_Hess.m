function [H] = big_problem_Hess(x)
    [A, y, m, d, ~] = big_problem_data_generator();
    matrix_x = reshape(x, [d, d]);
    H = zeros(size(d^2, d^2));

    for i = 1:d

        for j = 1:d

            for i_prime = 1:d

                for j_prime = 1:d
                    h = 0;

                    for k = 1:m
                        A_X = A{k} * matrix_x;
                        A_XX_y = sum(A{i} .* (matrix_x * matrix_x'), 'all') - y(k);
                        h = h + A_X(i, j) * A_X(i_prime, j_prime);

                        if j == j_prime
                            h = h + A_XX_y * A{k}(i, i_prime);
                        end

                    end

                    H((i - 1) * d + j, (i_prime - 1) * d + j_prime) = h;
                end

            end

        end

    end

    H = H / m;

end

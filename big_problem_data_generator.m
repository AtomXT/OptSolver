%% generate the data for big question

function [A, y, m, d, X_star] = big_problem_data_generator()
    rng(1);
    m = 200; d = 10; r = 2;
    % m the measurement number
    % A consist a series of gaussian matrices
    % d the dimension; r the rank
    V = orth(randn(d, r));
    Sigma = eye(r);
    X_star = V * Sigma * V';
    A = {};
    y = [];

    for i = 1:m
        temp_A = randn(d, d);
        A{i} = temp_A;
        y = [y, sum(temp_A .* X_star, 'all') + 0.0 * randn(1)];
    end

end

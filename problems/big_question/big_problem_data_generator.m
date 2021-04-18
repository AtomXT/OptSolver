%% generate the data for big question

function [A, y, m, d] = big_problem_data_generator()
    % m the measurement number
    % A consist a series of gaussian matrices
    % d the dimension; r the rank
    m = 500; d = 50; r = 1;
    V = orth(randn(d, r));
    Sigma = diag(ones(r));
    X_star = V * Sigma * V';
    A = randn(d, d, m);
    y = [];

    for i = 1:m
        temp_A = A(:, :, i);
        y = [y, dot(temp_A, X_star)];
    end

end

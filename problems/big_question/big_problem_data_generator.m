%% generate the data for big question

function [A, y] = big_problem_data_generator(m, d, r)
    % m the measurement number
    % A consist a series of gaussian matrices
    % d the dimension; r the rank
    V = orth(randn(d, r));
    Sigma = diag(ones(r));
    X_star = V * Sigma * V';
    A = [];
    y = [];
    for i = 1:m
        temp_A = random(d, d);
        A = [A, temp_A];
        y = [y, dot(A, X_star)];
    end

end

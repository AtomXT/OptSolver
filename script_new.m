m = 1; d = 10; r = 1;
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
    y = [y, dot(temp_A, X_star)];
    disp(y)
end

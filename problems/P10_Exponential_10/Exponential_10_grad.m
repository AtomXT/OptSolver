% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Problem Number: 10
% Problem Name: Exponential_10
% Problem Description: Dimension n = 10

% Function that computes the gradient of the Exponential_10 function

function [g] = Exponential_10_grad(x)
    n = 10;
    g = zeros(n, 1);
    g(1) = 2 / (exp(x(1)) + 1)^2 - 0.1 * exp(-x(1));
    g(2:n) = 4*(x(2:n)-1).^3;

end

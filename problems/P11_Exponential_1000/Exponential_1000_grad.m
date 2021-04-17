% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Problem Number: 11
% Problem Name: Exponential_1000
% Problem Description: Dimension n = 1000

% Function that computes the gradient of the Exponential_1000 function

function [g] = Exponential_1000_grad(x)
    n = 1000;
    g = zeros(n, 1);
    g(1) = 2*exp(x(1)) / (exp(x(1)) + 1)^2 - 0.1 * exp(-x(1));
    
    g(2:n) = 4 * (x(2:n) - 1).^3;
end
% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Problem Number: 11
% Problem Name: Exponential_1000
% Problem Description: Dimension n = 1000

% Function that computes the Hessian of the Exponential_1000 function

function [H] = Exponential_1000_Hess(x)
    n = 1000;
    diag_H = zeros(n, 1);
    diag_H(1) = -4 / (exp(x(1)) + 1)^3 + 0.1 * exp(-x(1));
    diag_H(2:n) = 12 * (x(2:n) - 1).^2;

    H = diag(diag_H);
end

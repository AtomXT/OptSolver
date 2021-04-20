% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Problem Number: 11
% Problem Name: Exponential_100
% Problem Description: Dimension n = 100

% Function that computes the Hessian of the Exponential_100 function

function [H] = Exponential_100_Hess(x)
    n = 100;
    diag_H = zeros(n, 1);
    diag_H(1) = 2*exp(x(1))/(exp(x(1))+1)^2 -4 * exp(x(1))^2 / (exp(x(1)) + 1)^3 + 0.1 * exp(-x(1));
    diag_H(2:n) = 12 * (x(2:n) - 1).^2;

    H = diag(diag_H);
end

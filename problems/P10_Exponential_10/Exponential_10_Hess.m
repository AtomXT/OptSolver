% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Problem Number: 10
% Problem Name: Exponential_10
% Problem Description: Dimension n = 10

% Function that computes the Hessian of the Exponential_10 function
%
function [H] = Exponential_10_Hess(x)
    n = 10;
    diag_H = zeros(n, 1);
    diag_H(1) = 2*exp(x(1))/(exp(x(1))+1)^2 -4 * exp(x(1))^2 / (exp(x(1)) + 1)^3 + 0.1 * exp(-x(1));
    
    diag_H(2:n) = 12 * (x(2:n) - 1).^2;

    H = diag(diag_H);
end

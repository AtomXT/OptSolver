% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Problem Number: 11
% Problem Name: Exponential_100
% Problem Description: Dimension n = 100

% Function that computes the function value of the Exponential_100 function

function [f] = Exponential_100_func(x)
    f = (exp(x(1)) - 1) / (exp(x(1)) + 1) + 0.1 * exp(-x(1));
    
    f = f + sum((x(2:100) - 1).^4);

end

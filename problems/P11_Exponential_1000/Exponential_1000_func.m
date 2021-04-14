% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Problem Number: 11
% Problem Name: Exponential_1000
% Problem Description: Dimension n = 1000

% Function that computes the function value of the Exponential_1000 function

function [f] = Exponential_1000_func(x)
    f = (exp(x(1)) - 1) / (exp(x(1)) + 1) + 0.1 * exp(-x(1));
    
    f = f + sum((x(2:1000) - 1).^4);

end

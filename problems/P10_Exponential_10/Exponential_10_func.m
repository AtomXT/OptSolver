% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Problem Number: 10
% Problem Name: Exponential_10
% Problem Description: Dimension n = 10

% Function that computes the function value of the Exponential_10 function

function [f] = Exponential_10_func(x)
    f = (exp(x(1)) - 1) / (exp(x(1)) + 1) + 0.1 * exp(-x(1));
    
    f = f + sum((x(2:10)- 1).^4);

end

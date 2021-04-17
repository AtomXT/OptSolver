% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Problem Number: 8
% Problem Name: Rosenbrock_100
% Problem Description: A rosenbrock function. Dimension n = 100

% Function that computes the function value for the Rosenbrock function

function [f] = rosen100_func(x)

y = 1 - x(1:99);
z = (x(2:100) - x(1:99).^2).^2;
f = sum(y.^2 + 100*z);

end
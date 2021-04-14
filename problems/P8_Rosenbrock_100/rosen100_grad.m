% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Problem Number: 8
% Problem Name: Rosenbrock_100
% Problem Description: A rosenbrock function. Dimension n = 100

% Function that computes the gradient of the Rosenbrock function
function [g] = rosen100_grad(x)
g = zeros(100,1);
g(1:99) = 400*x(1:99).^3 + (2-400*x(2:100)).*x(1:99) - 2;
g(100) = 200*(x(100) - x(99)^2);
end
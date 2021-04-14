% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Problem Number: 7
% Problem Name: Rosenbrock_2
% Problem Description: A rosenbrock function. Dimension n = 2

% Function that computes the gradient of the Rosenbrock function
function [g] = rosen2_grad(x)

g = [-2 + 2*x(1) - 400*x(1)*x(2) + 400*x(1)^3; 200*(x(2)-x(1)^2)];

end
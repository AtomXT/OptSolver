% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Problem Number: 7
% Problem Name: Rosenbrock_2
% Problem Description: A rosenbrock function. Dimension n = 2

% Function that computes the Hessian of the Rosenbrock function

function [H] = rosen2_Hess(x)

H = [2 - 400*(x(2)-x(1)^2) + 800*x(1)^2, -400*x(1); -400*x(1), 200];

end
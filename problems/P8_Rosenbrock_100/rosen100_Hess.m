% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Problem Number: 8
% Problem Name: Rosenbrock_100
% Problem Description: A rosenbrock function. Dimension n = 100

% Function that computes the Hessian of the Rosenbrock function
function [H] = rosen100_Hess(x)
d = 1200*x(1:99).^2 + (2-400*x(2:100));
d(2:99) = d(2:99) + 200 - 400*x(1:98);
H = diag(d);
H(100,100) = 200;
d1 = -400*x(1:99);
H = H + diag(d1,1) + diag(d1, -1);

end
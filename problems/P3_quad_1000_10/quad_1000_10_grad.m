% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Problem Number: 3
% Problem Name: quad_1000_10
% Problem Description: A randomly generated convex quadratic function; the 
%                      random seed is set so that the results are 
%                      reproducable. Dimension n = 1000; Condition number
%                      kappa = 10

% function that computes the gradient of the quad_1000_10 function
function [g] = quad_1000_10_grad(x)

global q Q

% compute function value
g = Q*x + q;

end
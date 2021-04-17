% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Problem Number: 4
% Problem Name: quad_1000_1000
% Problem Description: A randomly generated convex quadratic function; the 
%                      random seed is set so that the results are 
%                      reproducable. Dimension n = 1000; Condition number
%                      kappa = 1000

% function that computes the Hessian of the quad_1000_1000 function
function [H] = quad_1000_1000_Hess(x)
global q Q

% compute function value
H = Q;

end
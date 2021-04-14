% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Problem Number: 12
% Problem Name: genhumps_5
% Problem Description: A multi-dimensional problem with a lot of humps.
%                      This problem is from the well-known CUTEr test set.

% function that computes the gradient of the genhumps_5 function
function [g] = genhumps_5_grad(x)

g = [4*sin(2*x(1))*cos(2*x(1))* sin(2*x(2))^2                  + 0.1*x(1);
     4*sin(2*x(2))*cos(2*x(2))*(sin(2*x(1))^2 + sin(2*x(3))^2) + 0.2*x(2);
     4*sin(2*x(3))*cos(2*x(3))*(sin(2*x(2))^2 + sin(2*x(4))^2) + 0.2*x(3);
     4*sin(2*x(4))*cos(2*x(4))*(sin(2*x(3))^2 + sin(2*x(5))^2) + 0.2*x(4);
     4*sin(2*x(5))*cos(2*x(5))* sin(2*x(4))^2                  + 0.1*x(5);];

end
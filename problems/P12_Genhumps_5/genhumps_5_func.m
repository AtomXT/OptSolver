% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Problem Number: 12
% Problem Name: genhumps_5
% Problem Description: A multi-dimensional problem with a lot of humps.
%                      This problem is from the well-known CUTEr test set.

% function that computes the function value of the genhumps_5 function
function [f] = genhumps_5_func(x)

f = 0;
for i = 1:4
    f = f + sin(2*x(i))^2*sin(2*x(i+1))^2 + 0.05*(x(i)^2 + x(i+1)^2);
end

end
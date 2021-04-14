% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Problem Number: 9
% Problem Name: DataFit_2
% Problem Description: Dimension n = 2

% Function that computes the function value for the DataFit_2 function

function [f] = DataFit_2_func(x)
    f = (1.5 - x(1) * (1 - x(2)))^2 + (2.25 - x(1) * (1 - x(2)^2))^2 + (2.625 - x(1) * (1 - x(2)^3))^2;
end

% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Problem Number: 9
% Problem Name: DataFit_2
% Problem Description: Dimension n = 2

% Function that computes the gradient of the DataFit_2 function
function [g] = DataFit_2_grad(x)
    g1 = -2 * ((1.5 - x(1) * (1 - x(2))) * (1 - x(2)) + (2.25 - x(1) * (1 - x(2)^2)) * (1 - x(2)^2) + (2.625 - x(1) * (1 - x(2)^3)) * (1 - x(2)^3));
    g2 = 2 * ((1.5 - x(1) * (1 - x(2))) * x(1) + (2.25 - x(1) * (1 - x(2)^2)) * 2 * x(1) * x(2) + (2.625 - x(1) * (1 - x(2)^3)) * 3 * x(1) * x(2)^2);
    g = [g1; g2];
end

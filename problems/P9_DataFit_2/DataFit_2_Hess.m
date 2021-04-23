% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Problem Number: 9
% Problem Name: DataFit_2
% Problem Description: Dimension n = 2

% Function that computes the Hessian of the DataFit_2 function
function [H] = DataFit_2_Hess(x)
    h11 = 2 * ((x(2) - 1)^2 + (x(2)^2 - 1)^2 + (x(2)^3 - 1)^2);
    h22 = x(1)*(12*x(1)*x(2)^2 + 9 - 2*x(1)) + x(1)*x(2)*(30*x(1)*x(2)^3 + 31.5 - 12*x(1));
    h12 = 2 * (1.5 + 2 * x(1) * (x(2) - 1) + 2 * 2.25 * x(2) + 4 * x(1) * (x(2)^2 - 1) * x(2) + 3 * 2.625 * x(2)^2 + 6 * x(1) * (x(2)^3 - 1) * x(2)^2);
    H = [h11 h12; h12 h22];
end

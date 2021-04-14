% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Problem Number: 12
% Problem Name: genhumps_5
% Problem Description: A multi-dimensional problem with a lot of humps.
%                      This problem is from the well-known CUTEr test set.

% function that computes the Hessian of the genhumps_5 function
function [H] = genhumps_5_Hess(x)

H = zeros(5,5);

H(1,1) =  8* sin(2*x(2))^2*(cos(2*x(1))^2 - sin(2*x(1))^2) + 0.1;
H(1,2) = 16* sin(2*x(1))*cos(2*x(1))*sin(2*x(2))*cos(2*x(2));
H(2,2) =  8*(sin(2*x(1))^2 + sin(2*x(3))^2)*(cos(2*x(2))^2 - sin(2*x(2))^2) + 0.2;
H(2,3) = 16* sin(2*x(2))*cos(2*x(2))*sin(2*x(3))*cos(2*x(3));
H(3,3) =  8*(sin(2*x(2))^2 + sin(2*x(4))^2)*(cos(2*x(3))^2 - sin(2*x(3))^2) + 0.2;
H(3,4) = 16* sin(2*x(3))*cos(2*x(3))*sin(2*x(4))*cos(2*x(4));
H(4,4) =  8*(sin(2*x(3))^2 + sin(2*x(5))^2)*(cos(2*x(4))^2 - sin(2*x(4))^2) + 0.2;
H(4,5) = 16* sin(2*x(4))*cos(2*x(4))*sin(2*x(5))*cos(2*x(5));
H(5,5) =  8* sin(2*x(4))^2*(cos(2*x(5))^2 - sin(2*x(5))^2) + 0.1;
H(2,1) = H(1,2);
H(3,2) = H(2,3);
H(4,3) = H(3,4);
H(5,4) = H(4,5);

end
% Script to run code

% close all figures, clear all variables from workspace and clear command
% window
close all
clear
clc
%% Change parameters to run different problems with each algorithm
% set problem (minimal requirement: name of problem)
problem.name = 'P9';

rng(0);
%problem.x0 = [cos(70) sin(70) cos(70) sin(70)]';
%problem.x0 = 20*rand(10,1)-10;
%problem.x0 = 20*rand(1000,1)-10;
%problem.x0 = [-1.2;1];
%problem.x0 = [-1.2;ones(99,1)];
problem.x0 = [1; 1];
%problem.x0 = [1; zeros(9,1)];
%problem.x0 = 506.2*[-1;ones(4,1)];

% set method (minimal requirement: name of method)
% method.name = 'GradientDescent';
% method.name = 'NewtonW';
% method.name = 'BFGSW';
% method.name = 'TRNewtonCG';
% method.name = 'TRSR1CG';
% method.name = 'DFPW';
%% Constants
% set options
options.term_tol = 1e-8;
options.max_iterations = 5e3;

% run method and return x^* and f^*
[x,f] = optSolver(problem,method,options);
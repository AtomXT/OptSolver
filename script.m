% Script to run code

% close all figures, clear all variables from workspace and clear command
% window
% close all
% clear
clc
%% Change parameters to run different problems with each algorithm
% set problem (minimal requirement: name of problem)
problem.name = 'P8';

rng(0);
%problem.x0 = [cos(70) sin(70) cos(70) sin(70)]';
%problem.x0 = 20*rand(10,1)-10;
%problem.x0 = 20*rand(1000,1)-10;
%problem.x0 = [-1.2;1];
problem.x0 = [-1.2;ones(99,1)];
%problem.x0 = [1; 1];
% problem.x0 = [1; zeros(9,1)];
% problem.x0 = 506.2*[-1;ones(4,1)];
% problem.x0 = ones(4, 1);

% X0 = 1e-3 * eye(50);
% problem.x0 = reshape(X0, [], 1);
% problem = setProblem(problem);

% set method (minimal requirement: name of method)
method.name = 'GradientDescent';
% method.name = 'Newton';
%  method.name = 'BFGSW';
% method.name = 'TRNewtonCG';
% method.name = 'TRSR1CG';
% method.name = 'DFPW';
%% Set Options
options.c_1_ls = 1e-4;
options.c_2_ls = 0.9;
options.c_1_tr = 0.25;
options.c_2_tr = 0.75;
options.term_tol_CG = 1e-6;
options.max_iterations_CG = 1e3;
options.eta_0 = 0.01;
options.alpha = 2.0;
options.rho = 0.5;
options.beta = 1e-2;
options.Delta = 0.1;
options.epsilon = 1e-6;

% for SR1
options.eta = 1e-3;
options.r = 0.5;
%% run method and return x^* and f^*
[x,f] = optSolver(problem,method,options);
% script to run algorithm of choice

close all
clear
clc
% PROBLEM: Rosenbrock_100
problem.name = 'P8';
problem.x0 = [-1.2;ones(99,1)];

% ALGORITHM: TRNewtonCG
method.name = 'TRNewtonCG';
options.max_iterations = 1e3;
options.term_tol = 1e-6;
options.c_1_tr = 0.25;
options.c_2_tr = 0.75;
options.term_tol_CG = 1e-6;
options.max_iterations_CG = 1e3;
options.Delta = 0.1;
options.epsilon = 1e-6;

[x,f] = optSolver(problem,method,options);
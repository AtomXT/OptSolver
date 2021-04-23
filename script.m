% Script to run code

% close all figures, clear all variables from workspace and clear command
% window
% close all
% clear
clc
%% Change parameters to run different problems with each algorithm
% set problem (minimal requirement: name of problem)
problem.name = 'big_problem';

rng(0);
%problem.x0 = [cos(70) sin(70) cos(70) sin(70)]';
%problem.x0 = 20*rand(10,1)-10;
%problem.x0 = 20*rand(1000,1)-10;
%problem.x0 = [-1.2;1];
%problem.x0 = [-1.2;ones(99,1)];
%problem.x0 = [1; 1];
% problem.x0 = [1; zeros(9,1)];
% problem.x0 = 506.2*[-1;ones(4,1)];
% problem.x0 = ones(4, 1);
problem = setProblem(problem);
d = 10;
X0 = 1e-5 * eye(d);
problem.x0 = reshape(X0, [], 1);
% disp(problem.compute_f(problem.x0));

% set method (minimal requirement: name of method)
method.name = 'GradientDescentW';
%% Constants
% set options
options.term_tol = 1e-6;
options.max_iterations = 100;
% run method and return x^* and f^*

%% plot the f
[x,f, trajectory1, traj1] = optSolver_trajectory(problem,method,options);
method.name = 'NewtonW';
[x,f, trajectory2, traj2] = optSolver_trajectory(problem,method,options);
 method.name = 'BFGSW';
 [x,f, trajectory3, traj3] = optSolver_trajectory(problem,method,options);
method.name = 'DFPW';
[x,f, trajectory4, traj4] = optSolver_trajectory(problem,method,options);
% method.name = 'TRSR1CG';
% [x,f, trajectory5, traj5] = optSolver_trajectory(problem,method,options);
% method.name = 'DFP';
% [x,f, trajectory6, traj6] = optSolver_trajectory(problem,method,options);


plot(trajectory1, 'LineWidth', 3)
hold on 
plot(trajectory2, 'LineWidth', 3)
hold on 
plot(trajectory3, 'LineWidth', 3)
hold on 
plot(trajectory4, 'LineWidth', 3)
hold off 
% plot(trajectory5, 'LineWidth', 3)
% hold on 
% plot(trajectory6, 'LineWidth', 3)
% hold off
% plot(trajectory, 'LineWidth', 3)
% hold off
% title('Comparison of $H_k$ for Problem 2', 'Interpreter', 'latex')
xlabel('number of iterations $t$', 'Interpreter', 'latex')
ylabel('$f(U_t)$', 'Interpreter', 'latex')
set(gca, 'YScale', 'log')
legend('GDW', 'NewtonW', 'BFGSW', 'DFPW', 'Interpreter', 'latex')
saveas(gcf, 'f_noiseless_W.png')

%% plot the distance between optimal distance
plot(traj1, 'LineWidth', 3)
hold on 
plot(traj2, 'LineWidth', 3)
hold on 
plot(traj3, 'LineWidth', 3)
hold on 
plot(traj4, 'LineWidth', 3)
hold off 
% plot(traj5, 'LineWidth', 3)
% hold on 
% plot(traj6, 'LineWidth', 3)
% hold off
% title('Comparison of $H_k$ for Problem 2', 'Interpreter', 'latex')
xlabel('number of iterations $t$', 'Interpreter', 'latex')
ylabel('$\Vert U_tU_t^{\top}-X^{\star}\Vert_F$', 'Interpreter', 'latex')
set(gca, 'YScale', 'log')
legend('GDW', 'NewtonW', 'BFGSW', 'DFPW', 'Interpreter', 'latex')
saveas(gcf, 'x_noiseless_W.png')
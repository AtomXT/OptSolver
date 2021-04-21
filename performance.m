% Test algorithms on all test problems

% close all figures, clear all variables from workspace and clear command
% window
close all
clear
clc

%% set problem (minimal requirement: name of problem)
x0_string = ["x0 = 20*rand(10,1)-10","x0 = 20*rand(10,1)-10",...
             "x0 = 20*rand(1000,1)-10","x0 = 20*rand(1000,1)-10",...
             "x0 = [cos(70) sin(70) cos(70) sin(70)]'", "x0 = [cos(70) sin(70) cos(70) sin(70)]'",...
             "x0 = [-1.2; 1]", "x0 = [-1.2;ones(99,1)]", "x0 = [1; 1]", "x0 = [1; zeros(9,1)]",...
             "x0 = [1; zeros(99,1)]", "x0 = 506.2*[-1;ones(4,1)]"];
problems = cell(1,12);
for i=1:12
    rng(0);
    eval(x0_string(i));
    problems{i} = struct("name","P"+string(i),"x0", x0);
end
clc

methods = {'GradientDescent', 'GradientDescentW', 'Newton', 'NewtonW', 'BFGS', 'BFGSW', 'DFP', 'DFPW','TRNewtonCG', 'TRSR1CG'};

% set options
options.term_tol = 1e-6;
options.max_iterations = 1e3;
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


results = [];
f_trajectory = {};
count = 1;
for i=1:12
    for j=1:length(methods)
        method.name = methods{j};
        disp("solving problem " + i + " with algorithm " + method.name)
        problem.name = problems{i}.name;
        problem.x0 = problems{i}.x0;

        [x, F, k, k1, k2, time] = optSolver_trajectory(problem,method,options);
        results = [results; [k, k1, k2, time]];
        f_trajectory{count} = F;
        count = count + 1;
    end
end

need_k = zeros(12,10);
for i=1:10
    need_k(:,i) = results(i:10:end, 1);
end

need_k1 = zeros(12,10);
for i=1:10
    need_k1(:,i) = results(i:10:end, 2);
end

need_time = zeros(12,10);
for i=1:10
    need_time(:,i) = results(i:10:end, 4);
end

profile = zeros(1000,10);
for i=1:1000
    profile(i,:) = sum(need_k < i);
end

profile_k1 = zeros(1000,10);
for i=1:1000
    profile_k1(i,:) = sum(need_k1 < i);
end

profile_time = zeros(1000,10);
for i=1:1000
    profile_time(i,:) = sum(need_time < i*1e-4);
end

color = ['r','g','b','c','m','y','m--',"r--","g--","b--"];
for i=1:10
    plot(1:1000, profile(:,i)'/12,color(i), 'linewidth',1);
    hold on
end
title('Performance Profile: iterations')
xlabel('iterations(k)')
ylabel('ratio of problems solved')
legend('GradientDescent', 'GradientDescentW', 'Newton', 'NewtonW', 'BFGS',...
'BFGSW', 'DFP', 'DFPW','TRNewtonCG', 'TRSR1CG','Location','southeast')


color = ['r','g','b','c','m','y','m--',"r--","g--","b--"];
for i=1:10
    plot(1:1000, profile_k1(:,i)'/12,color(i), 'linewidth',1);
    hold on
end
title('Performance Profile: function evaluations')
xlabel('numbers')
ylabel('ratio of problems solved')
legend('GradientDescent', 'GradientDescentW', 'Newton', 'NewtonW', 'BFGS',...
'BFGSW', 'DFP', 'DFPW','TRNewtonCG', 'TRSR1CG','Location','southeast')

color = ['r','g','b','c','m','y','m--',"r--","g--","b--"];
for i=1:10
    plot(1:1000, profile_time(:,i)'/12,color(i), 'linewidth',1);
    hold on
end
title('Performance Profile: time')
xlabel('$10^{-4}$ seconds','Interpreter','latex')
ylabel('ratio of problems solved')
legend('GradientDescent', 'GradientDescentW', 'Newton', 'NewtonW', 'BFGS',...
'BFGSW', 'DFP', 'DFPW','TRNewtonCG', 'TRSR1CG','Location','southeast')

% split the results into each problem
a = mat2cell(results,10*ones(12,1),4);

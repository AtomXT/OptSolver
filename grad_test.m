% Script to test gradient

% close all figures, clear all variables from workspace and clear command
% window
close all
clear
clc
%% Change parameters to run different problems with each algorithm
% set problem (minimal requirement: name of problem)
x0_string = ["x0 = 20*rand(10,1)-10","x0 = 20*rand(10,1)-10",...
             "x0 = 20*rand(1000,1)-10","x0 = 20*rand(1000,1)-10",...
             "x0 = [cos(70) sin(70) cos(70) sin(70)]'", "x0 = [cos(70) sin(70) cos(70) sin(70)]'",...
             "x0 = [-1.2; 1]", "x0 = [-1.2;ones(99,1)]", "x0 = [1; 1]", "x0 = [1; zeros(9,1)]",...
             "x0 = [1; zeros(999,1)]", "x0 = 506.2*[-1;ones(4,1)]"];
problems = cell(1,12);

for i=1:12
    rng(0);
    eval(x0_string(i));
    problems{i} = struct("name","P"+string(i),"x0", x0);
end
clc
for j=1:12
    problem.name = problems{j}.name;
    problem.x0 = problems{j}.x0;
    [problem] = setProblem(problem);
    
    x = problem.x0;
    d = size(x, 1);
    W = eye(d);
    E = W/1e8;
    difference = zeros(d, 1);
    for i=1:d
        w = W(:,i);
        w1 = w + E(:,i);
        y1 = problem.compute_f(w1);
        y = problem.compute_f(w);
        g = (y1 - y)*1e8;
        G = problem.compute_g(w);
        g_true = G(i);
        difference(i) = g - g_true;
    end
    disp(j)
    disp(max(abs(difference)))
end
%% Test




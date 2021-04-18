% here we need to vectorize the input
function [f] = big_question_func(x)
    [A, y, m] = big_problem_data_generator();
    matrix_x = reshape(x, [d, d]);
    f = 0;

    for i = 1:m
        f = f + 0.5 / m * (y(i) - dot(A(i), matrix_x));
    end

end

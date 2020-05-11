data = load("Q4_data.mat");
W = data.W;
us = data.us;
xs = data.xs;
A = zeros(size(xs,1),size(xs,1));
B = zeros(size(xs,1),size(us,1));
X_t = xs(:,1:size(xs,2)-1);
X_t1 = xs(:,2:size(xs,2));

%cvx_begin
%    variable Ac(size(xs,1),size(xs,1))
%    variable Bc(size(xs,1),size(us,1))
%    minimize(sum(square_pos(norms(X_t1 - Ac*X_t - Bc*us,2,2))))
%cvx_end

array_opt_val = [];
sum_card = [];
for lambda=10:2:70
    cvx_begin
        variable Ac(size(xs,1),size(xs,1));
        variable Bc(size(xs,1),size(us,1));
        minimize(sum(square_pos(norms(X_t1 - Ac*X_t - Bc*us,2,2)))+lambda*(sum(norms(Ac,1,1)))+lambda*sum(norms(Bc,1,1)))
    cvx_end
    array_opt_val = [array_opt_val cvx_optval];
    Ac(abs(Ac)<0.01) = 0;
    Bc(abs(Bc)<0.01) = 0;
    sum_card = [sum_card (nnz(Ac)+nnz(Bc))];
end

plot(array_opt_val, sum_card,'b-o')



boolean
cvx_begin
    variable lambda(4)
    maximize(-1*dot(b,lambda)+min(0,c(1)+dot(A(:,1),lambda))+min(0,c(2)+dot(A(:,2),lambda)))
    subject to
        lambda >= 0;
cvx_end
lambda
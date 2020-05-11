m = 16; n = 8;
A = randn(m,n);
b = randn(m,1);

cvx_begin
    variable x
    variable y
    variable z
    minimize(x+y)
    subject to
        %variable t
        %variable t2
        %inv_pos(y) + inv_pos(x) <= 1
        %x>=inv_pos(y)
        %pow_pos(x,3)+pow_pos(y,3)<=1 %... 1.5874
        %quad_pos_over_lin(square(x),x) + quad_pos_over_lin(square(y),y) <= 1
        %t >= max(x,1)
        %t2 >= max(x,2)
        %norm([t, t2]) <= 3*x + y
        %quad_pos_over_lin()
        %quad_pos_over_lin(x+y,sqrt(y)) <= x-y+5
        quad_pos_over_lin((x+z-1),y-quad_pos_over_lin(z,y)) <= y
        x>=0
        y>=0
cvx_end


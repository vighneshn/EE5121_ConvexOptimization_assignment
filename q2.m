x0 = [-1;0.7];

%%GD with Fixed Step Size
t = 0.1;
x1 = x0;
x = [x1];
while dot(gradient(x1),gradient(x1))>=0.01
    x1 = x1-t*gradient(x1);%*objective(x1)UnNormalize or NOT??
    x = [x x1];
end
x1

plot(x(1,1),x(2,1),'rx')
xlabel("x(1)")
ylabel("x(2)")
title("2a) GD with Fixed Step Size")
hold on
for i = 2:length(x)
    plot(x(1,i),x(2,i),'rx')
    draw_line(x(:,i-1),x(:,i))
    hold on
end

%%GD with Backtracking line search
alpha = 0.1;
beta = 0.5;
x2 = x0;
x = x2;
while dot(gradient(x2),gradient(x2))>=0.01
    dir = -gradient(x2);%*objective(x2)UnNormalize or NOT??
    t = 1;
    while objective(x2+t*dir)>objective(x2)+alpha*t*dot(gradient(x2),dir)
        t = beta*t;
    end
    x2 = x2+t*dir;
    x = [x x2];
end
x2

figure()
plot(x(1,1),x(2,1),'rx')
xlabel("x(1)")
ylabel("x(2)")
title("2b) GD with Backtracking line search")
hold on
for i = 2:length(x)
    plot(x(1,i),x(2,i),'rx')
    draw_line(x(:,i-1),x(:,i))
    hold on
end

%%Newtons method with Backtracking line search
alpha = 0.1;
beta = 0.5;
x3 = x0;
x = x3;
while dot(gradient(x3),gradient(x3))>=0.01
    nt_dir = -inv(hessian(x3))*gradient(x3);%*objective(x3)UnNormalize or NOT??
    t = 1;
    while objective(x3+t*nt_dir)>objective(x3)+alpha*t*dot(gradient(x3),nt_dir)
        t = beta*t;
    end
    x3 = x3+t*nt_dir;
    x = [x x3];
end
x3

figure()
plot(x(1,1),x(2,1),'rx')
xlabel("x(1)")
ylabel("x(2)")
title("2c) Newtons method with Backtracking line search")
hold on
for i = 2:length(x)
    plot(x(1,i),x(2,i),'rx')
    draw_line(x(:,i-1),x(:,i))
    hold on
end

function obj = objective(x)
    obj = exp(x(1)+3*x(2)-0.1)+exp(x(1)-3*x(2)-0.1)+exp(-x(1)-0.1);
end

function grad = gradient(x)
    grad = [exp(x(1)+3*x(2)-0.1)+exp(x(1)-3*x(2)-0.1)-exp(-x(1)-0.1); 3*exp(x(1)+3*x(2)-0.1)-3*exp(x(1)-3*x(2)-0.1)]/objective(x);
end

function hess = hessian(x)
    hess = [objective(x), 3*exp(x(1)+3*x(2)-0.1)-3*exp(x(1)-3*x(2)-0.1); 3*exp(x(1)+3*x(2)-0.1)-3*exp(x(1)-3*x(2)-0.1), 9*exp(x(1)+3*x(2)-0.1)+9*exp(x(1)-3*x(2)-0.1)];
end

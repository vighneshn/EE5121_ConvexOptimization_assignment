data = load("Q5_data.mat");
N = 100;
x = linspace(-pi,pi,N);
k = 5;
A = [];
for i=0:1:k
    A = [A; x.^i];
end
a = zeros(k+1,1);
cvx_begin
    variable a(k+1)
    minimize(norm(A'*a-sin(x)',2))
cvx_end
figure(1)
plot(x,A'*a,'b',x,sin(x),'g')

A = data.A;
k = data.K;
N = data.N;
y = data.a;
data
cvx_begin
    variable a(k+1)
    minimize(norm(A*a-sin(y)',2))
cvx_end

figure(2)
plot(y,A*a,'b',y,sin(y),'g')


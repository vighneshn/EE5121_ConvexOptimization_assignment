Cn = [1 -0.76 0.07 -0.96; 
      -0.76 1 0.18 0.07; 
      0.07 0.18 1 0.41; 
      -0.96 0.07 0.41 1];
N = size(Cn,1);
cvx_begin sdp
    variable C(N,N) symmetric
    minimize(norm(C-Cn,'fro'))
    subject to
        C >= 0;
        for i=1:N
            C(i,i) == 1;
        end
cvx_end
C
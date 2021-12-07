clear;
N_f = 100;
blockSize = 1000;
E_b = 1;

for SNR = 0:1:10
     N_0 = (10.^(SNR/10)).^(-1);
     N_ei = zeros(1,length(N_f));
     for i = 1:N_f
         N_a = randi(2,1,blockSize) -1;
         v_n = zeros(1,blockSize);
         for j = 1:blockSize
             if(N_a(j) == 1)
                v_n(j) = sqrt(E_b);
             else
                 v_n(j) = 0;
             end
         end
         
         
         X1 = rand(1,blockSize);
         X2 = rand(1,blockSize);
         Y1 = (sqrt(N_0/2))*sqrt(-2*log(X1)).*cos(2*pi*X2);
         Y2 = (sqrt(N_0/2))*sqrt(-2*log(X1)).*sin(2*pi*X2);
         r_n = v_n + Y1;
         a_n = zeros(1,blockSize);
         for j = 1:blockSize
             if(r_n(j) >= E_b/2)
                a_n(j) = 1;
             else
                a_n(j) = 0;
             end
         end
         N_e = 0;
         for j = 1:blockSize
             if(a_n(j) ~= N_a(j))
                N_e = N_e + 1;
             end
             if((sum(N_ei(:)) + N_e) == 50)
                Error50(SNR+1) = 50 /((i-1)*blockSize + j);
             end
         end
         N_ei(i) = N_e;
     end
     P_e(SNR+1) = sum(N_ei(:))/(N_f * blockSize);
     syms y;
     Theoretical_P_e(SNR+1) = (0.5/sqrt(pi*N_0))*double(int(exp((-1/(N_0))*((y - sqrt(E_b)).^2)),y,-inf,0.5))+(0.5/sqrt(pi*N_0))*double(int(exp((-1/(N_0))*(y.^2)),y,0.5,inf));
end

hold on;
plot(Theoretical_P_e);
plot(P_e);
plot(Error50);
hold off;
title("Bit Error Probability of OOK");
xlabel("SNR (dB)");
ylabel("Probability");
legend("Theoretical Probability","Estimated Probability","Probability at 50^t^h Error Occurence");
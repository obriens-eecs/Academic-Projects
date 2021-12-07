clear;
N_f = 100;
blockSize = 1000;
E_b = 1;

for SNR = 0:1:10
     N_0 = (10.^(SNR/10)).^(-1);
     N_ei = zeros(2,length(N_f));
     for i = 1:N_f
         N_a = randi(2,2,blockSize) -1;
         v_n = zeros(2,blockSize);
         for j = 1:blockSize
             if(N_a(1,j) == 0 && N_a(2,j) == 0)
                v_n(1,j) = -sqrt(E_b);
                v_n(2,j) = -sqrt(E_b);
             elseif(N_a(1,j) == 0 && N_a(2,j) == 1)
                v_n(1,j) = -sqrt(E_b);
                v_n(2,j) = sqrt(E_b);
             elseif(N_a(1,j) == 1 && N_a(2,j) == 0)
                v_n(1,j) = sqrt(E_b);
                v_n(2,j) = -sqrt(E_b);
             else
                v_n(1,j) = sqrt(E_b);
                v_n(2,j) = sqrt(E_b);
             end
         end
         X1 = rand(1,blockSize);
         X2 = rand(1,blockSize);
         Y1 = (sqrt(N_0/2))*sqrt(-2*log(X1)).*cos(2*pi*X2);
         Y2 = (sqrt(N_0/2))*sqrt(-2*log(X1)).*sin(2*pi*X2);
         r_n(1,:) = v_n(1,:) + Y1;
         r_n(2,:) = v_n(2,:) + Y2;
         a_n = zeros(2,blockSize);
         for j = 1:blockSize
             if(r_n(1,j) < 0 && r_n(2,j) < 0)
             a_n(1,j) = 0;
             a_n(2,j) = 0;
             elseif(r_n(1,j) < 0 && r_n(2,j) >= 0)
             a_n(1,j) = 0;
             a_n(2,j) = 1;
             elseif(r_n(1,j) >= 0 && r_n(2,j) < 0)
             a_n(1,j) = 1;
             a_n(2,j) = 0;
             else
             a_n(1,j) = 1;
             a_n(2,j) = 1;
             end
         end
         N_e = 0;
         for j = 1:(blockSize*2)
             if(a_n((rem(j,2)*-1)+2,ceil(j/2)) ~= N_a((rem(j,2)*-1)+2,ceil(j/2)))
             N_e = N_e + 1;
             end
             if((sum(N_ei(:,:)) + N_e) == 50)
             Error50(SNR+1) = 50 /((i-1)*2*blockSize + j);
             end
         end
         N_ei(i) = N_e;
     end
     P_e(SNR+1) = sum(N_ei(:))/(N_f * blockSize*2);
     syms y;
     Theoretical_P_e(SNR+1) = (1/sqrt(pi*N_0)) * double(int(exp( (-1/(N_0)) *(( y + sqrt(E_b)).^2)),y,0,inf));
end

hold on;
plot(Theoretical_P_e);
plot(P_e);
plot(Error50);
hold off;
title("Bit Error Probability of QPSK");
xlabel("SNR (dB)");
ylabel("Probability");
legend("Theoretical Probability","Estimated Probability","Probability at 50^t^h Error Occurence");
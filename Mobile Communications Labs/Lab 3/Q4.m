clear;
N_f = 100;
blockSize = 1000;
E_b = 1;

for SNR = 100
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
         [theta,rho] = cart2pol(r_n(1,:),r_n(2,:));
         a = [];
         b = [];
         c = [];
         d = [];
         for j = 1:blockSize
             if(theta(j) <= 1.5708 && theta(j) > 0)
                a = [a;r_n(1,j),r_n(2,j)];
             elseif(theta(j) <= 3.1416 && theta(j) > 1.5708)
                b = [b;r_n(1,j),r_n(2,j)];
             elseif(theta(j) <= 0 && theta(j) > -1.5708)
                c = [c;r_n(1,j),r_n(2,j)];
             else
                d = [d;r_n(1,j),r_n(2,j)];
             end
         end
     end
end

hold on;
s1=scatter(a(:,1),a(:,2),10);
s2=scatter(b(:,1),b(:,2),10);
s3=scatter(c(:,1),c(:,2),10);
s4=scatter(d(:,1),d(:,2),10);
plot(0,linspace(-4,4));
hold off;
title("QPSK with AWGN (20dB)");
xlabel("Bit 0");
ylabel("Bit 1");
legend([s1 s2 s3 s4],"Q = 1, I = 0","Q = 1, I = 1","Q = 0, I = 0","Q = 0, I = 1");
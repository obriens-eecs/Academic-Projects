function  beta = A2Q1d(im,betamin,betamax,nbeta)
%Estimate value of beta for which convolution in the frequency domain
%becomes more efficient

%Sample beta logarithmically
dlogbeta = (log(betamax)-log(betamin))/(nbeta-1);
betas = exp(log(betamin):dlogbeta:log(betamax));
nreps = 5;

for i = 1:nbeta
    for j = 1:nreps
        [ts(i,j),tf(i,j)] = A2Q1(im,betas(i),0);
    end
end
tsm = mean(ts,2);
tfm = mean(tf,2);

figure;
semilogx(betas,tsm,'LineWidth',3);
hold on;
semilogx(betas,tfm,'r','LineWidth',3);
legend('Space','Frequency');
xlabel('\beta');
ylabel('Execution time (sec)');
set(gca,'FontSize',18);

%Find intersection
err = @(beta)(interp1(betas,tsm,beta)-interp1(betas,tfm,beta))^2;
beta = fminsearch(err, sqrt(betamin*betamax));

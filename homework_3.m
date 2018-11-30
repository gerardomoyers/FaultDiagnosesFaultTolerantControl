%%
% This code is made by:
% Jorge Bonekamp
% Gerardo Moyers
% Casper Spronk
%% Deterministic Limit Checks
limit = 0.5;
mean_change = 0.1;
x = rand(1,1000) - 0.5;
x = [x mean_change+rand(1,1000)];
k = 10; 


out = deterministic_limit(x,limit);
% plot(x)
% hold on
plot(out)
hold on
plot(limit*ones(1,length(x)))
hold on
plot(-limit*ones(1,length(x)))


[new_out, average] = new_deterministic_limit(x,limit,k);
figure
% plot(x)
% hold on
plot(new_out)
hold on
plot(limit*ones(1,length(x)))
hold on
plot(-limit*ones(1,length(x)))
hold on
plot(average)


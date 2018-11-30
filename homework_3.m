%%
% This code is made by:
% Jorge Bonekamp
% Gerardo Moyers
% Casper Spronk
%% Deterministic Limit Checks
limit = 0.5;
mean_change = 2;
x = rand(1,1000) - 0.5;
x = [x mean_change+rand(1,1000)];
  


out = deterministic_limit(x,limit);
plot(x)
hold on
plot(out)
hold on
plot(limit*ones(1,length(x)))
hold on
plot(-limit*ones(1,length(x)))



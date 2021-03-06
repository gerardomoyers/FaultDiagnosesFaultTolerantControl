%%
% This code is made by:
% Jorge Bonekamp
% Gerardo Moyers
% Casper Spronk
clear all
close all
clc
%% Setting up signal with noise and mean change
k0                     = 1001;                                             % Time instant when the mean of the signal changes
Mean1                  = 10;
Mean_Change            = 10;
Mean2                  = Mean1 + Mean_Change;
Noise                  = wgn(1,(k0-1)*2,1);                                % White Gaussian Noise with variance 1
z1                     = Mean1 + Noise(1:k0-1);
z2                     = Mean2 + Noise(1+length(Noise)/2:end);
z                      = [z1 z2];                                          % The discrete time signal

% plotting the discrete time signal z
figure
plot(z)
hold on
Mean1_Vec              = Mean1 * ones(1,k0-1);
Mean2_Vec              = Mean2 * ones(1,k0-1);
Mean                   = [Mean1_Vec Mean2_Vec];
stairs(Mean, 'color','k')
hold off


%% Deterministic Limit Check

%Setting up Deterministic Limit check
Limit_Size             = Mean_Change / 2;
Upper_Limit            = Mean1 + Limit_Size;
Lower_Limit            = Mean1 - Limit_Size;
Output_Test1           = (z > Upper_Limit) | (z < Lower_Limit);

% Plotting Results of test
figure
plot( z )
hold on
grid on
stairs( Mean                           , 'color', 'k' )
stairs( Output_Test1 )
plot( Upper_Limit * ones(1,length(z)), 'color', 'r' )
plot( Lower_Limit * ones(1,length(z)), 'color', 'r' )
hold off

%% Averaged Deterministic Limit Check

W = 30;

Average = movmean(z,[W 0],'omitnan');                                   % Averaging signal
Output_Test2 = (Average > Upper_Limit) | (Average < Lower_Limit);   % Checking against limits

figure
plot( z )
hold on
stairs(Output_Test2)
stairs( Mean                         , 'color', 'k' )
plot( Upper_Limit * ones(1,length(z)), 'color', 'r' )
plot( Lower_Limit * ones(1,length(z)), 'color', 'r' )
plot(Average, 'linewidth', 2, 'color', 'm')
%legend TODO
hold off

%% Probabilistic Method
k                      = 100000
k0                     = 1001;                                             % Time instant when the mean of the signal changes
Mean1                  = 10;
Mean_Change            = 10;
Mean2                  = Mean1 + Mean_Change;
Noise                  = wgn(1,(k)*2,1);                                % White Gaussian Noise with variance 1
z1                     = Mean1 + Noise(1:k);
z2                     = Mean2 + Noise(1:k0);
z                      = [z1 z2];                                          % The discrete time signal


alpha = 2;
MeanEst = zeros(1,length(z));
MeanEst(1) = z(1);
for i = 2:length(z)
    MeanEst(i) = MeanEst(i-1) + 1/i * (z(i) - MeanEst(i-1)); 
end

VarianceSquared = zeros(1,length(z));

for i = 3:length(z)
   VarianceSquared(i) = (i-2)/(i-1) * VarianceSquared(i-1) + (1/i) * ((z(i) - MeanEst(i-1))^2);
end
out = probabilistic_test(z, MeanEst, VarianceSquared, alpha);

figure
plot(z)
hold on
plot(MeanEst)
plot(VarianceSquared)
plot(out)
clc
clear all
% Sampling time, stop time
Ts = 0.01;
Tstop = 1000;

% Real, physical parameters

tankCross = [0.156 0.156 0.156];
tankInit = [0 2.5 5];
tankMax = [10 10 10];
tankMin = [0 0 0];

pipeCross = [5 5 5]*1e-4;
pipeCoeff = [1 1 1];

% Inputs

pumpDCMag = [1.5 1.5]*1e-3;
pumpACPeriod = [10 50];
pumpACMagRelative = [0.1 0.25];

%Faults

faultTime = [1e6 400 1e6];
faultMag = [0 0.01 0];

% Measurement noise

peakNoise = tankMax*1e-2; % one percent on maximum
noiseRange = [-peakNoise ; +peakNoise];


% Nominal parameters

uncRelative = 10e-2; % ten percent on actual values

tankCrossN = makeParUncertain(tankCross,uncRelative);
tankInitN = makeParUncertain(tankInit,uncRelative);
tankMaxN = makeParUncertain(tankMax,uncRelative);
tankMinN = tankMin;

pipeCrossN = makeParUncertain(pipeCross,uncRelative);
pipeCoeffN = makeParUncertain(pipeCoeff,uncRelative);

% FD estimator parameters

Lambda = diag([0.91 0.91 0.91]);


simOut = sim("centralized_FD_basic_01.slx");
%% plots
figure("name","real system vs observer")
hold on
grid on
plot(y.time,y.data)
plot(y_hat.time,y_hat.data)
legend("Tank 1 true level","Tank 2 true level","Tank 3 true level","Tank 1 observer level","Tank 2 observer level","Tank 3 observer level")


figure("name","real system vs LFD without delay")
hold on
grid on
plot(y.time,y.data)
plot(y_hat_LFD_no_delays_minus_y_hat.time,y_hat_LFD_no_delays_minus_y_hat.data)
legend("Tank 1 true level","Tank 2 true level","Tank 3 true level","Tank 1 observer level","Tank 2 observer level","Tank 3 observer level")

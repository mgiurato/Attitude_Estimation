%% Attitude Estimation     %
% Author: Mattia Giurato   %
% Last review: 2016/02/25  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all 
clc

%% Data import
load('IMUoutput.mat')

%% Filtering loop
IMUsample = 0.01;
sigma_acc = 0.01;
sigma_mag = 0.01;
sigma_u = 0.001;
sigma_v = 0.01;
P = 1*eye(6);

AHRS = KalmanAHRS('SamplePeriod', IMUsample, 'sigma_acc', sigma_acc, 'sigma_mag', sigma_mag, 'sigma_u', sigma_u, 'sigma_v', sigma_v,'P', P);
IMUquaternion = zeros(length(IMUtime), 4);
IMUomega = zeros(length(IMUtime), 3);
IMUbias = zeros(length(IMUtime), 3);
dalpha = zeros(length(IMUtime), 3);
for t = 1:length(IMUtime)
    AHRS.UpdateIMU(Gyroscope(t,:)', Accelerometer(t,:)', Magnetometer(t,:)');	% gyroscope units must be radians
    IMUquaternion(t, :) = AHRS.Quaternion;
    IMUomega(t, :) = AHRS.omehat;
    IMUbias(t, :) = AHRS.bias;
    dalpha(t, :) = AHRS.dAlpha;
end    

figure('name', 'Quaternion')
plot(IMUtime, IMUquaternion)
title('$$\hat{q}$$','Interpreter','latex')
grid minor
xlabel('[s]')
ylabel('[ ]')

figure('name', 'Angular speeds')
plot(IMUtime, IMUomega)
title('$$\hat{\omega}$$','Interpreter','latex')
grid minor
xlabel('[s]')
ylabel('[rad/s]')

figure('name', 'Bias')
plot(IMUtime, IMUbias)
title('$$\beta$$','Interpreter','latex')
grid minor
xlabel('[s]')
ylabel('[rad/s]')

figure('name', 'dalpha')
plot(IMUtime, dalpha)
title('$$\delta\alpha$$','Interpreter','latex')
grid minor
xlabel('[s]')
ylabel('[rad]')

%% End of code
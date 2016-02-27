%% Attitude Estimation     %
% Author: Mattia Giurato   %
% Last review: 2016/02/25  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all 
clc

%% Data import
load('IMUoutput_involo2.mat')
% load('OPTIoutput_involo.mat')

%% Filtering loop
IMUsample = 0.01;
sigma_acc = 0.001;
sigma_mag = 0.01;
sigma_u = 0.00001;
sigma_v = 0.0001;
P = 0.1*eye(6);

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

[Y, P, R] = quat2angle([IMUquaternion(:,4) IMUquaternion(:,1) IMUquaternion(:,2) IMUquaternion(:,3)]);	% use conjugate for sensor frame relative to Earth and convert to degrees.
IMUeuler = [R -P -Y];

% figure('name', 'Quaternion')
% plot(IMUtime, IMUquaternion)
% title('$$\hat{q}$$','Interpreter','latex')
% grid minor
% xlabel('[s]')
% ylabel('[ ]')
% legend('q_1', 'q_2', 'q_3', 'q_4')

figure('name', 'Euler')
subplot(3,1,1)
plot(IMUtime, IMUeuler(:,1))
hold on
plot(IMUtime, RPY(:,1))
% plot(OPTItime, OPTIeuler(:,1))
hold off
grid minor
title('Euler Angles')
legend('\phi_{Kalman}', '\phi_{Madgwick}')
subplot(3,1,2)
plot(IMUtime, IMUeuler(:,2))
hold on
plot(IMUtime, RPY(:,2))
% plot(OPTItime, OPTIeuler(:,2))
hold off
grid minor
legend('\theta_{Kalman}', '\theta_{Madgwick}')
subplot(3,1,3)
plot(IMUtime, IMUeuler(:,3))
hold on
plot(IMUtime, RPY(:,3))
% plot(OPTItime, OPTIeuler(:,3))
hold off
grid minor
legend('\psi_{Kalman}', '\psi_{Madgwick}')
xlabel('[s]')

% figure('name', 'Angular speeds')
% plot(IMUtime, IMUomega)
% title('$$\hat{\omega}$$','Interpreter','latex')
% grid minor
% xlabel('[s]')
% ylabel('[rad/s]')
% 
% figure('name', 'Bias')
% plot(IMUtime, IMUbias)
% title('$$\beta$$','Interpreter','latex')
% grid minor
% xlabel('[s]')
% ylabel('[rad/s]')
% 
% figure('name', 'dalpha')
% plot(IMUtime, dalpha)
% title('$$\delta\alpha$$','Interpreter','latex')
% grid minor
% xlabel('[s]')
% ylabel('[rad]')

%% End of code
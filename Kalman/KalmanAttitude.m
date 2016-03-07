%% Attitude Estimation     %
% Author: Mattia Giurato   %
% Last review: 2016/03/07  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all 
clc

%% Data import
load('logsync_calib.mat')

%% Filtering loop
IMUsample = 0.01;
sigma_acc = diag([0.77418 0.66936 0.71485])/10;
sigma_mag = diag([0.053667 0.034382 0.071054])*100;
sigma_u = diag([0.13807 0.11053 0.063833])/100;
sigma_v = 0.0001;
Po = 1*eye(6);

Kalman = KalmanAHRS('SamplePeriod', IMUsample, 'sigma_acc', sigma_acc, 'sigma_mag', sigma_mag, 'sigma_u', sigma_u, 'sigma_v', sigma_v,'P', Po);
IMUquaternion = zeros(length(IMUtime), 4);
IMUomega = zeros(length(IMUtime), 3);
IMUbias = zeros(length(IMUtime), 3);
dalpha = zeros(length(IMUtime), 3);
for t = 1:length(IMUtime)
    Kalman.UpdateIMU((Gyroscope(t,:)-ones(1, 3)*diag(mean(Gyroscope(1:100,:))))', Accelerometer(t,:)', Magnetometer(t,:)');	% gyroscope units must be radians
    IMUquaternion(t, :) = Kalman.Quaternion;
    IMUomega(t, :) = Kalman.omehat;
    IMUbias(t, :) = Kalman.bias;
    dalpha(t, :) = Kalman.deltaX(1:3);
%     AHRS.P
end    

% beta = 0.0028;
beta = 0.0002;
zeta = 0;
AHRS = MadgwickAHRS('SamplePeriod', IMUsample, 'Beta', beta,  'Zeta', zeta);
MADquaternion = zeros(length(IMUtime), 4);
GYRObias = zeros(length(IMUtime), 3);
for t = 1:length(IMUtime)
%     AHRS.UpdateIMU(Gyroscope(t,:)-ones(1, 3)*diag(mean(Gyroscope(1:100,:))), Accelerometer(t,:));	% gyroscope units must be radians
    AHRS.Update(Gyroscope(t,:)-ones(1, 3)*diag(mean(Gyroscope(1:100,:))), Accelerometer(t,:), Magnetometer(t,:));	% gyroscope units must be radians
    MADquaternion(t, :) = AHRS.Quaternion;
end

[Y, P, R] = quat2angle([IMUquaternion(:,4) IMUquaternion(:,1) IMUquaternion(:,2) IMUquaternion(:,3)]);
RPYkal = [R -P -Y].*180/pi;

[Y, P, R] = quat2angle([-MADquaternion(:,4) -MADquaternion(:,3) MADquaternion(:,2) MADquaternion(:,1)]);
RPYmad = [R -P -Y].*180/pi;

% figure('name', 'Quaternion')
% plot(IMUtime, IMUquaternion)
% title('$$\hat{q}$$','Interpreter','latex')
% grid minor
% xlabel('[s]')
% ylabel('[ ]')
% legend('q_1', 'q_2', 'q_3', 'q_4')

figure('name', 'Euler_phi')
plot(IMUtime, RPYkal(:,1))
hold on
plot(IMUtime, RPYmad(:,1))
plot(OPTItime, OPTIeuler_f(:,1)*180/pi)
hold off
grid minor
title('Euler Angles')
legend('\phi_{Kalman}', '\phi_{Madgwick}','\phi_{OptiTrack}')

figure('name', 'Euler_theta')
plot(IMUtime, RPYkal(:,2))
hold on
plot(IMUtime, RPYmad(:,2))
plot(OPTItime, OPTIeuler_f(:,2)*180/pi)
hold off
grid minor
legend('\theta_{Kalman}', '\theta_{Madgwick}','\theta_{OptiTrack}')

figure('name', 'Euler_psi')
yaw_k = unwrap(RPYkal(:,3));
plot(IMUtime, yaw_k)
hold on
yaw_m = unwrap(RPYmad(:,3));
plot(IMUtime, yaw_m)
plot(OPTItime, OPTIeuler_f(:,3)*180/pi);
hold off
grid minor
legend('\psi_{Kalman}', '\psi_{Madgwick}','\psi_{OptiTrack}')
xlabel('[s]')

% figure('name', 'Angular speeds')
% plot(IMUtime, IMUomega)
% title('$$\hat{\omega}$$','Interpreter','latex')
% grid minor
% xlabel('[s]')
% ylabel('[rad/s]')

figure('name', 'Bias')
plot(IMUtime, IMUbias);
title('$$\beta$$','Interpreter','latex')
grid minor
xlabel('[s]')
ylabel('[rad/s]')

% figure('name', 'dalpha')
% plot(IMUtime, dalpha)
% title('$$\delta\alpha$$','Interpreter','latex')
% grid minor
% xlabel('[s]')
% ylabel('[rad]')

%% End of code
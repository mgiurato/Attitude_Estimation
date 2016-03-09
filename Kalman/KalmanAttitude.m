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
%Motors working
% sigma_acc = diag([0.77418 0.66936 0.71485]);
% sigma_mag = diag([0.053667 0.034382 0.071054])*100;
% sigma_u = diag([0.13807 0.11053 0.063833]);
% sigma_v = 0.0001;
%Motors not working
sigma_acc = diag([0.019184 0.012992 0.032874]);
sigma_mag = diag([0.0038115 0.0059517 0.016515])*500;
sigma_u = diag([0.0023973 0.0021975 0.0013524])/10;
sigma_v = 0.0001;
%Brutal guess
% sigma_acc = 0.01;
% sigma_mag = 1;
% sigma_u = 0.00001;
% sigma_v = 0.0001;

Po = 0.1*eye(6);

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

beta = 0.0028;
% beta = 0.0002;
zeta = 0;
AHRS = MadgwickAHRS('SamplePeriod', IMUsample, 'Beta', beta,  'Zeta', zeta);
MADquaternion = zeros(length(IMUtime), 4);
GYRObias = zeros(length(IMUtime), 3);
for t = 1:length(IMUtime)
    AHRS.UpdateIMU(Gyroscope(t,:)-ones(1, 3)*diag(mean(Gyroscope(1:100,:))), Accelerometer(t,:));	% gyroscope units must be radians
%     AHRS.Update(Gyroscope(t,:)-ones(1, 3)*diag(mean(Gyroscope(1:100,:))), Accelerometer(t,:), Magnetometer(t,:));	% gyroscope units must be radians
    MADquaternion(t, :) = AHRS.Quaternion;
end

[Y, P, R] = quat2angle([IMUquaternion(:,4) IMUquaternion(:,1) IMUquaternion(:,2) IMUquaternion(:,3)]);
RPYkal = [R -P -Y];

RPYmad = quatern2euler(MADquaternion);
RPYmad = RPYmad *diag([-1 1 1]);

OPTIeuler_f = OPTIeuler_f + ones(length(OPTIeuler_f), 3)*diag([0.5*pi/180 0.5*pi/180 -0.1*pi/180]);

%% Comparison
errorKal_R = RPYkal(:,1) - OPTIeuler_f(:,1);
errorKal_P = RPYkal(:,2) - OPTIeuler_f(:,2);
errorKal_Y = RPYkal(:,3) - OPTIeuler_f(:,3);
errorKal = [rms(errorKal_R) rms(errorKal_P) rms(errorKal_Y)]

errorMad_R = RPYmad(:,1) - OPTIeuler_f(:,1);
errorMad_P = RPYmad(:,2) - OPTIeuler_f(:,2);
errorMad_Y = RPYmad(:,3) - OPTIeuler_f(:,3);
errorMad = [rms(errorMad_R) rms(errorMad_P) rms(errorMad_Y)]

%% Plot results
% figure('name', 'Quaternion')
% plot(IMUtime, IMUquaternion)
% title('$$\hat{q}$$','Interpreter','latex')
% grid minor
% xlabel('[s]')
% ylabel('[ ]')
% legend('q_1', 'q_2', 'q_3', 'q_4')

figure('name', 'Euler_phi')
plot(IMUtime, OPTIeuler_f(:,1)*180/pi,'linestyle','-','linewidth',.5,'color','black')
hold on
plot(IMUtime, RPYmad(:,1)*180/pi,'linestyle','--','linewidth',2,'color','r')
plot(OPTItime, RPYkal(:,1)*180/pi,'linestyle','-.','linewidth',2,'color','b')
hold off
grid minor
title('Euler Angle \phi')
xlabel('[s]')
ylabel('[deg]')
legend('OptiTrack','Madgwick','Kalman')

figure('name', 'Euler_theta')
plot(IMUtime, OPTIeuler_f(:,2)*180/pi,'linestyle','-','linewidth',.5,'color','black')
hold on
plot(IMUtime, RPYmad(:,2)*180/pi,'linestyle','--','linewidth',2,'color','r')
plot(OPTItime, RPYkal(:,2)*180/pi,'linestyle','-.','linewidth',2,'color','b')
hold off
grid minor
title('Euler Angle \theta')
xlabel('[s]')
ylabel('[deg]')
legend('OptiTrack','Madgwick','Kalman')

figure('name', 'Euler_psi')
plot(IMUtime, OPTIeuler_f(:,3)*180/pi,'linestyle','-','linewidth',.5,'color','black')
hold on
plot(IMUtime, RPYmad(:,3)*180/pi,'linestyle','--','linewidth',2,'color','r')
plot(OPTItime, RPYkal(:,3)*180/pi,'linestyle','-.','linewidth',2,'color','b')
hold off
grid minor
title('Euler Angle \psi')
xlabel('[s]')
ylabel('[deg]')
legend('OptiTrack','Madgwick','Kalman')

% figure('name', 'Angular speeds')
% plot(IMUtime, IMUomega)
% title('$$\hat{\omega}$$','Interpreter','latex')
% grid minor
% xlabel('[s]')
% ylabel('[rad/s]')

% figure('name', 'Bias')
% plot(IMUtime, IMUbias);
% title('$$\beta$$','Interpreter','latex')
% grid minor
% xlabel('[s]')
% ylabel('[rad/s]')

% figure('name', 'dalpha')
% plot(IMUtime, dalpha)
% title('$$\delta\alpha$$','Interpreter','latex')
% grid minor
% xlabel('[s]')
% ylabel('[rad]')

%% End of code
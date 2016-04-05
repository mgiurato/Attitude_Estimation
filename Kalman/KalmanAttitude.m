%% Attitude Estimation     %
% Author: Mattia Giurato   %
% Last review: 2016/03/07  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all 
% clc

%% Data import
load('logsync_0309_1.mat');

%% Filtering loop
IMUsample = 0.01;
%Motors working
sigma_acc = diag([0.77418 0.66936 0.71485]);
sigma_mag = 500*diag([0.053667 0.034382 0.071054]);
sigma_u = diag([0.13807 0.11053 0.063833/10])/100;
sigma_v = diag([0.00001 0.00001 0.05]);
% sigma_acc = diag([0.77418 0.66936 0.71485]);
% sigma_mag = diag([0.053667 0.034382 0.071054]);
% sigma_u = diag([0.13807 0.11053 0.063833]);
% sigma_v = diag([0.00001 0.00001 0.001]);
%Motors not working
% sigma_acc = diag([0.019184 0.012992 0.032874]);
% sigma_mag = diag([0.0038115 0.0059517 0.016515])*500;
% sigma_u = diag([0.0023973 0.0021975 0.0013524])/10;
% sigma_v = 0.0001;
%Brutal guess
% sigma_acc = 0.01;
% sigma_mag = 1;
% sigma_u = 0.00001;
% sigma_v = 0.0001;

Kalman = KalmanAHRS('SamplePeriod', IMUsample, 'sigma_acc', sigma_acc, 'sigma_mag', sigma_mag, 'sigma_u', sigma_u, 'sigma_v', sigma_v);
IMUquaternion = zeros(length(IMUtime), 4);
RPYkal = zeros(length(IMUtime), 3);
IMUomega = zeros(length(IMUtime), 3);
IMUbias = zeros(length(IMUtime), 3);
dalpha = zeros(length(IMUtime), 3);
ep = zeros(length(IMUtime), 3);
for t = 1:length(IMUtime)
    Kalman.UpdateIMU((Gyroscope(t,:)-ones(1, 3)*diag(mean(Gyroscope(1:100,:))))', (Accelerometer(t,:)-[1 1 0]*diag(mean(Accelerometer(1:100,:))))', Magnetometer(t,:)');	% gyroscope units must be radians
    IMUquaternion(t, :) = Kalman.Quaternion;
    RPYkal(t, :) = Kalman.RPYkal;
    IMUomega(t, :) = Kalman.omehat;
    IMUbias(t, :) = Kalman.bias;
    dalpha(t, :) = Kalman.dalpha(1:3);
    ep(t,:) = Kalman.e(1:3);
end    

beta = 0.026;
% beta = 0.0002;
zeta = 0;
AHRS = MadgwickAHRS('SamplePeriod', IMUsample, 'Beta', beta,  'Zeta', zeta);
MADquaternion = zeros(length(IMUtime), 4);
GYRObias = zeros(length(IMUtime), 3);
for t = 1:length(IMUtime)
    AHRS.UpdateIMU(Gyroscope(t,:)-ones(1, 3)*diag(mean(Gyroscope(1:100,:))), (Accelerometer(t,:)-[1 1 0]*diag(mean(Accelerometer(1:100,:))))');	% gyroscope units must be radians
%     AHRS.Update(Gyroscope(t,:)-ones(1, 3)*diag(mean(Gyroscope(1:100,:))), Accelerometer(t,:), Magnetometer(t,:));	% gyroscope units must be radians
    MADquaternion(t, :) = AHRS.Quaternion;
end

IMUtime = (0:IMUsample:(length(Gyroscope)-1)*IMUsample)';

RPYmad = quatern2euler(MADquaternion);
RPYmad = RPYmad *diag([-1 1 1]);

OPTIeuler_f = OPTIeuler_f + ones(length(OPTIeuler_f), 3)*diag([0*pi/180 0*pi/180 0*pi/180]);

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
plot(OPTItime, OPTIeuler_f(:,1)*180/pi,'linestyle','-','linewidth',.5,'color','black')
hold on
plot(IMUtime, RPYmad(:,1)*180/pi,'linestyle','--','linewidth',2,'color','r')
plot(IMUtime, RPYkal(:,1)*180/pi,'linestyle','-.','linewidth',2,'color','b')
hold off
grid minor
title('Euler Angle \phi')
xlabel('[s]')
ylabel('[deg]')
legend('OptiTrack','Madgwick','Kalman')

figure('name', 'Euler_theta')
plot(OPTItime, OPTIeuler_f(:,2)*180/pi,'linestyle','-','linewidth',.5,'color','black')
hold on
plot(IMUtime, RPYmad(:,2)*180/pi,'linestyle','--','linewidth',2,'color','r')
plot(IMUtime, RPYkal(:,2)*180/pi,'linestyle','-.','linewidth',2,'color','b')
hold off
grid minor
title('Euler Angle \theta')
xlabel('[s]')
ylabel('[deg]')
legend('OptiTrack','Madgwick','Kalman')

figure('name', 'Euler_psi')
plot(OPTItime, OPTIeuler_f(:,3)*180/pi,'linestyle','-','linewidth',.5,'color','black')
hold on
plot(IMUtime, RPYmad(:,3)*180/pi,'linestyle','--','linewidth',2,'color','r')
plot(IMUtime, RPYkal(:,3)*180/pi,'linestyle','-.','linewidth',2,'color','b')
hold off
grid minor
title('Euler Angle \psi')
xlabel('[s]')
ylabel('[deg]')
legend('OptiTrack','Madgwick','Kalman')

figure('name', 'Angular speeds')
plot(IMUtime, IMUomega)
title('$$\hat{\omega}$$','Interpreter','latex')
grid minor
xlabel('[s]')
ylabel('[rad/s]')

figure('name', 'Bias')
plot(IMUtime, IMUbias);
title('$$\beta$$','Interpreter','latex')
grid minor
legend('\beta_p', '\beta_q', '\beta_r')
xlabel('[s]')
ylabel('[rad/s]')

figure('name', 'dalpha')
subplot(3,1,1)
plot(IMUtime, dalpha(:,1))
grid minor
xlabel('[s]')
ylabel('[rad]')
legend('\delta\phi')
subplot(3,1,2)
plot(IMUtime, dalpha(:,2))
grid minor
xlabel('[s]')
ylabel('[rad]')
legend('\delta\theta')
subplot(3,1,3)
plot(IMUtime, dalpha(:,3))
grid minor
xlabel('[s]')
ylabel('[rad]')
legend('\delta\psi')

%% End of code
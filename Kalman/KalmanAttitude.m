%% Attitude Estimation     %
% Author: Mattia Giurato   %
% Last review: 2016/03/07  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc

%% Data import
load('logsync_0309_1.mat');
GyroBias = ones(1, 3)*diag(mean(Gyroscope(1:100,:)));
AccBias = [1 1 0]*diag(mean(Accelerometer(1:100,:)));

IMUsample = 0.01;
IMUtime = (0:IMUsample:(length(Gyroscope)-1)*IMUsample)';

% Optitrack reference
OPTIeuler_f = OPTIeuler_f + ones(length(OPTIeuler_f), 3)*diag([0*pi/180 0*pi/180 0*pi/180]);

%% Filtering loop
% Kalman tuning
sigma_acc = diag([0.77418 0.66936 0.71485]);
sigma_mag = 500*diag([0.053667 0.034382 0.071054]);
sigma_u = diag([0.13807 0.11053 0.063833/10])/100;
sigma_v = diag([0.00001 0.00001 0.05]);
% Mahony tuning
Kacc = 5;
Kmag = 0.1;
Kp = 0.1;
Ki = 0.01;
% Madgwick tuing
beta = 0.022;   %w/o magnetometer
% beta = 0.00098;    %w/ magnetometer
zeta = 0;

% Multiplicative Extended Kalman Filter
Kalman = KalmanAHRS('SamplePeriod', IMUsample, ...
    'sigma_acc', sigma_acc, 'sigma_mag', sigma_mag, ...
    'sigma_u', sigma_u, 'sigma_v', sigma_v, ...
    'bias', [0 0 0]');
KALquaternion = zeros(length(IMUtime), 4);
KALRPY = zeros(length(IMUtime), 3);
KALomega = zeros(length(IMUtime), 3);
KALbias = zeros(length(IMUtime), 3);
KALdalpha = zeros(length(IMUtime), 3);
KALep = zeros(length(IMUtime), 3);
for t = 1:length(IMUtime)
    Kalman.Update(Gyroscope(t,:)'-GyroBias', Accelerometer(t,:)'-AccBias', Magnetometer(t,:)');	% gyroscope units must be radians
    KALquaternion(t, :) = Kalman.Quaternion;
    KALRPY(t, :) = Kalman.R_P_Y;
    KALomega(t, :) = Kalman.omehat;
    KALbias(t, :) = Kalman.bias;
    KALdalpha(t, :) = Kalman.dalpha(1:3);
    KALep(t,:) = Kalman.e(1:3);
end

% Mahony Nonlinear Complementary Filter
Mahony = MahonyAHRS('SamplePeriod', IMUsample, ...
    'Kacc', Kacc, 'Kmag', Kmag, ...
    'Kp', Kp, 'Ki', Ki, ...
    'bias', [0 0 0]');
MAHquaternion = zeros(length(IMUtime), 4);
MAHRPY = zeros(length(IMUtime), 3);
MAHomega = zeros(length(IMUtime), 3);
MAHbias = zeros(length(IMUtime), 3);
for t = 1:length(IMUtime)
    Mahony.Update(Gyroscope(t,:)'-GyroBias', Accelerometer(t,:)'-AccBias', Magnetometer(t,:)');	% gyroscope units must be radians
    MAHquaternion(t, :) = Mahony.Quaternion;
    MAHRPY(t, :) = Mahony.R_P_Y;
    MAHomega(t, :) = Mahony.omehat;
    MAHbias(t, :) = Mahony.bias;
end

% Madgwick Attitude Estimator
Madgwick = MadgwickAHRS('SamplePeriod', IMUsample, ...
    'Beta', beta,  'Zeta', zeta);
MADquaternion = zeros(length(IMUtime), 4);
GYRObias = zeros(length(IMUtime), 3);
for t = 1:length(IMUtime)
    Madgwick.UpdateIMU(Gyroscope(t,:)-GyroBias, Accelerometer(t,:)-AccBias);	% gyroscope units must be radians
%     Madgwick.Update(Gyroscope(t,:)-GyroBias, Accelerometer(t,:)-AccBias, Magnetometer(t,:));	% gyroscope units must be radians
    MADquaternion(t, :) = Madgwick.Quaternion;
end
MADRPY = quatern2euler(MADquaternion);
MADRPY = MADRPY *diag([-1 1 1]);

%% Comparison
errorKal_R = KALRPY(:,1) - OPTIeuler_f(:,1);
errorKal_P = KALRPY(:,2) - OPTIeuler_f(:,2);
errorKal_Y = KALRPY(:,3) - OPTIeuler_f(:,3);
errorKal = [rms(errorKal_R) rms(errorKal_P) rms(errorKal_Y)]

errorMah_R = MAHRPY(:,1) - OPTIeuler_f(:,1);
errorMah_P = MAHRPY(:,2) - OPTIeuler_f(:,2);
errorMah_Y = MAHRPY(:,3) - OPTIeuler_f(:,3);
errorMah = [rms(errorMah_R) rms(errorMah_P) rms(errorMah_Y)]

errorMad_R = MADRPY(:,1) - OPTIeuler_f(:,1);
errorMad_P = MADRPY(:,2) - OPTIeuler_f(:,2);
errorMad_Y = MADRPY(:,3) - OPTIeuler_f(:,3);
errorMad = [rms(errorMad_R) rms(errorMad_P) rms(errorMad_Y)]

%% Plot results
figure('name', 'Euler_phi')
plot(OPTItime, OPTIeuler_f(:,1)*180/pi,'linestyle','-','linewidth',.5,'color','black')
hold on
plot(IMUtime, MADRPY(:,1)*180/pi,'linestyle','--','linewidth',2,'color','g')
plot(IMUtime, MAHRPY(:,1)*180/pi,'linestyle','--','linewidth',2,'color','r')
plot(IMUtime, KALRPY(:,1)*180/pi,'linestyle','-.','linewidth',2,'color','b')
hold off
grid minor
title('Euler Angle \phi')
xlabel('[s]')
ylabel('[deg]')
legend('OptiTrack','Madgwick','Mahony','Kalman')
savefig('Euler_phi.fig')

figure('name', 'Euler_theta')
plot(OPTItime, OPTIeuler_f(:,2)*180/pi,'linestyle','-','linewidth',.5,'color','black')
hold on
plot(IMUtime, MADRPY(:,2)*180/pi,'linestyle','--','linewidth',2,'color','g')
plot(IMUtime, MAHRPY(:,2)*180/pi,'linestyle','--','linewidth',2,'color','r')
plot(IMUtime, KALRPY(:,2)*180/pi,'linestyle','-.','linewidth',2,'color','b')
hold off
grid minor
title('Euler Angle \theta')
xlabel('[s]')
ylabel('[deg]')
legend('OptiTrack','Madgwick','Mahony','Kalman')
savefig('Euler_theta.fig')

figure('name', 'Euler_psi')
plot(OPTItime, OPTIeuler_f(:,3)*180/pi,'linestyle','-','linewidth',.5,'color','black')
hold on
plot(IMUtime, MADRPY(:,3)*180/pi,'linestyle','--','linewidth',2,'color','g')
plot(IMUtime, MAHRPY(:,3)*180/pi,'linestyle','--','linewidth',2,'color','r')
plot(IMUtime, KALRPY(:,3)*180/pi,'linestyle','-.','linewidth',2,'color','b')
hold off
grid minor
title('Euler Angle \psi')
xlabel('[s]')
ylabel('[deg]')
legend('OptiTrack','Madgwick','Mahony','Kalman')
savefig('Euler_psi.fig')
% 
% figure('name', 'Angular speeds')
% subplot(2,1,1)
% plot(IMUtime, MAHomega)
% title('$$Mahony-\hat{\omega}$$','Interpreter','latex')
% grid minor
% xlabel('[s]')
% ylabel('[rad/s]')
% subplot(2,1,2)
% plot(IMUtime, KALomega)
% title('$$Kalman-\hat{\omega}$$','Interpreter','latex')
% grid minor
% xlabel('[s]')
% ylabel('[rad/s]')
% savefig('Angular speeds.fig')
% 
% figure('name', 'Bias')
% subplot(2,1,1)
% plot(IMUtime, MAHbias)
% title('$$Mahony-\hat{\omega}$$','Interpreter','latex')
% grid minor
% xlabel('[s]')
% ylabel('[rad/s]')
% subplot(2,1,2)
% plot(IMUtime, KALbias)
% title('$$Kalman-\hat{\omega}$$','Interpreter','latex')
% grid minor
% xlabel('[s]')
% ylabel('[rad/s]')
% savefig('Bias.fig')

%% End of code
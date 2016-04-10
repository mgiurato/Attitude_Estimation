%% Attitude Estimation     %
% Author: Mattia Giurato   %
% Last review: 2015/09/30  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all 
clc

%% Import logged data

load('logsync_0309_1.mat');

GyroBias = ones(1, 3)*diag(mean(Gyroscope(1:100,:)));
AccBias = [1 1 0]*diag(mean(Accelerometer(1:100,:)));

%% Tuning iterations
for i = 0:100
    % Process sensor data through Madgwick algorithm
    beta(i+1) = i/50000;
    zeta = 0;
    AHRS = MadgwickAHRS('SamplePeriod', IMUsample, 'Beta', beta(i+1),  'Zeta', zeta);
    IMUquaternion = zeros(length(IMUtime), 4);
    for t = 1:length(IMUtime)
%         AHRS.UpdateIMU(Gyroscope(t,:)-GyroBias, Accelerometer(t,:)-AccBias);	% gyroscope units must be radians
        AHRS.Update(Gyroscope(t,:)-GyroBias, Accelerometer(t,:)-AccBias, Magnetometer(t,:));	% gyroscope units must be radians
        IMUquaternion(t, :) = AHRS.Quaternion;
    % Let's find the ERROR
    error = OPTIquaternion - IMUquaternion;
    FiltRMS(i+1) = mean(rms(error));
    end
end
[M, I] = min(FiltRMS);
bet = (I-1)/50000;

%% Plot Filter RMS

figure('Name', 'Filter RMS');
hold on;
plot(beta, FiltRMS);
title('RMS of the error with reference to \beta');
xlabel('\beta');
ylabel('Quaternion Average RMS');
legend('RMS');
grid minor
y1=get(gca,'ylim');
plot([bet bet],y1, 'r--')
strmin = ['\beta = ',num2str(bet)];
text(bet+0.001,y1(2)*19/20,strmin,'HorizontalAlignment','left');
hold off;

%% Plot Optimal tuning
zet = 0;
AHRS = MadgwickAHRS('SamplePeriod', IMUsample, 'Beta', bet,  'Zeta', zet);
IMUquaternion = zeros(length(IMUtime), 4);
GYRObias = zeros(length(IMUtime), 3);
for t = 1:length(IMUtime)
%     AHRS.UpdateIMU(Gyroscope(t,:)-GyroBias, Accelerometer(t,:)-AccBias);	% gyroscope units must be radians
    AHRS.Update(Gyroscope(t,:)-GyroBias, Accelerometer(t,:)-AccBias, Magnetometer(t,:));	% gyroscope units must be radians
    IMUquaternion(t, :) = AHRS.Quaternion;
    GYRObias(t,:) = AHRS.GyrBias;
end

IMUeuler = quatern2euler(quaternConj(IMUquaternion)) * (180/pi);	% use conjugate for sensor frame relative to Earth and convert to degrees.
OPTIeuler = quatern2euler(quaternConj(OPTIquaternion)) * (180/pi);

FinalError = (OPTIeuler - IMUeuler);

%% Plot 
% figure('Name', 'Quaternions');
% hold on;
% plot(IMUtime, IMUquaternion(:,1),'y');
% plot(IMUtime, IMUquaternion(:,2),'r');
% plot(IMUtime, IMUquaternion(:,3),'g');
% plot(IMUtime, IMUquaternion(:,4),'b');
% plot(IMUtime, OPTIquaternion(:,1),'y-.');
% plot(IMUtime, OPTIquaternion(:,2),'r-.');
% plot(IMUtime, OPTIquaternion(:,3),'g-.');
% plot(IMUtime, OPTIquaternion(:,4),'b-.');
% title('Quaternions');
% xlabel('IMUtime [s]');
% ylabel('Quaternion');
% legend('q_{0,IMU}','q_{1,IMU}','q_{2,IMU}','q_{3,IMU}','q_{0,opti}','q_{1,opti}','q_{2,opti}','q_{3,opti}');
% hold off;

figure('Name', 'Euler Angles-phi');
hold on;
plot(IMUtime, IMUeuler(:,1), 'r');
plot(IMUtime, OPTIeuler(:,1), 'r-.');
title('Euler angle: \phi');
xlabel('IMUtime [s]');
ylabel('Angle [deg]');
legend('\phi_{IMU}', '\phi_{Opti}');
grid minor
hold off;

figure('Name', 'Euler Angles-theta');
hold on;
plot(IMUtime, IMUeuler(:,2), 'g');
plot(IMUtime, OPTIeuler(:,2), 'g-.');
title('Euler angle: \theta');
xlabel('IMUtime [s]');
ylabel('Angle [deg]');
legend('\theta_{IMU}', '\theta_{Opti}');
grid minor
hold off;

figure('Name', 'Euler Angles');
hold on;
plot(IMUtime, IMUeuler(:,3), 'b');
plot(IMUtime, OPTIeuler(:,3), 'b-.');
title('Euler angle: \psi');
xlabel('IMUtime [s]');
ylabel('Angle [deg]');
legend('\psi_{IMU}', '\psi_{Opti}');
grid minor
hold off;

figure('Name', 'Relative Error-phi');
hold on;
plot(IMUtime, FinalError(:,1), 'r');
title('error: \phi');
xlabel('IMUtime [s]');
ylabel('Angle [deg]');
legend('\phi_{error}');
grid minor
hold off;

figure('Name', 'Relative Error-theta');
hold on;
plot(IMUtime, FinalError(:,2), 'g');
title('error: \theta');
xlabel('IMUtime [s]');
ylabel('Angle [deg]');
legend('\theta_{error}');
grid minor
hold off;

figure('Name', 'Relative Error-psi');
hold on;
plot(IMUtime, FinalError(:,3), 'b');
title('error: \psi');
xlabel('IMUtime [s]');
ylabel('Angle [deg]');
legend('\psi_{error}');
grid minor
hold off;

%% End of code
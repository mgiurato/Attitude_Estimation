%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Attitude Estimator - Run Filters    %
% Author: M. Giurato                  %
% Date: 19/07/12                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clearvars
clc

%% General variables
ts = 0.01;                                                                  %[s] Sample time
% logfile = 'Calibration';
% logfile = 'NearHovering';
logfile = 'Aggressive';

%Usefull variables
deg2rad = pi/180;
rad2deg = 180/pi;

%% Import data logged
load([pwd filesep 'Data' filesep logfile]);

%Import data from 9DOF IMU (body frame measurements)
Gyro = [imu_raw_gyro_x imu_raw_gyro_y imu_raw_gyro_z];                      %[rad/s]
Acc = [imu_raw_acc_x imu_raw_acc_y imu_raw_acc_z];                          %[m/s^2]
Mag = [imu_raw_mag_x imu_raw_mag_y imu_raw_mag_z];                          %[1]

%Import data from optitrack (inertial NED frame)
Attitude = [ground_attitude_roll ground_attitude_pitch ground_attitude_yaw]*deg2rad;

%Remove first and last data to avoid logging-sync problems
Gyro = Gyro(3:end-500,:);
Acc = Acc(3:end-500,:);
Mag = Mag(3:end-500,:);
Attitude = Attitude(3:end-500,:);

%Define time vector
N = length(Gyro);
time = 0:ts:(N - 1)*ts;

%% Multiplicative Extended Kalman Filter
disp('Multiplicative Extended Kalman Filter');
timerVal = tic;

% Tuning
%Sigma accelerometer
sigma_acc = 1;
%Sigma magnetometer
sigma_mag = 15;
%Sigma rate random walk
sigma_u = 0.01;
%Sigma angle random walk
sigma_v = 0.001;

%Attitude Estimator
KALRPY = zeros(N, 3);
Kalman = KalmanAHRS('SamplePeriod',ts,...
                    'sigma_acc',sigma_acc,'sigma_mag',sigma_mag,...
                    'sigma_u',sigma_u,'sigma_v',sigma_v);
for t = 1:N
    Kalman.Update(Gyro(t,:)',Acc(t,:)',Mag(t,:)');
    KALRPY(t, :) = Kalman.R_P_Y;
end

f1 = figure('name','Kalman','units','normalized','outerposition',[0 0 1 1]);
subplot(311)
hold on
plot(time, KALRPY(:,1))
plot(time, Attitude(:,1))
grid minor
hold off
subplot(312)
hold on
plot(time, KALRPY(:,2))
plot(time, Attitude(:,2))
grid minor
hold off
subplot(313)
hold on
plot(time, KALRPY(:,3))
plot(time, Attitude(:,3))
grid minor
hold off

disp(['Done! Elapsed time:' num2str(toc(timerVal))]);

%% Mahony Nonlinear Complementary Filter
disp('Mahony Nonlinear Complementary Filter');
timerVal = tic;

%Tuning
Kacc = 1; 
Kmag = 0.01;
Kp = 1;
Ki = 0.05;

%Attitude Estimator
MAHRPY = zeros(N, 3);
Mahony = MahonyAHRS('SamplePeriod',ts,...
                    'Kacc',Kacc,'Kmag',Kmag,...
                    'Kp', Kp, 'Ki', Ki);
for t = 1:N
    Mahony.Update(Gyro(t,:)', Acc(t,:)', Mag(t,:)');
    MAHRPY(t, :) = Mahony.R_P_Y;
end

f2 = figure('name','Mahony','units','normalized','outerposition',[0 0 1 1]);
subplot(311)
hold on
plot(time, MAHRPY(:,1))
plot(time, Attitude(:,1))
grid minor
hold off
subplot(312)
hold on
plot(time, MAHRPY(:,2))
plot(time, Attitude(:,2))
grid minor
hold off
subplot(313)
hold on
plot(time, MAHRPY(:,3))
plot(time, Attitude(:,3))
grid minor
hold off

disp(['Done! Elapsed time:' num2str(toc(timerVal))]);

%% Madgwick AHRS Filter
disp('Madgwick AHRS Filter');
timerVal = tic;

%Tuning
beta = 0.05; 
zeta = 0.01;

Acc_mad = Acc * diag([1 -1 -1]);
Mag_mad = Mag * diag([1 -1 -1]);
Gyro_mad = Gyro * diag([1 -1 -1]);

%Attitude Estimator
MADRPY = zeros(N, 3);
Madgwick = MadgwickAHRS('SamplePeriod',ts,'Beta',beta,'Zeta',zeta);
for t = 1:N
    Madgwick.Update(Gyro_mad(t,:), Acc_mad(t,:), Mag_mad(t,:));
    MADquaternion = Madgwick.Quaternion;
    MADRPY(t, :) = quatern2euler(MADquaternion) * diag([-1 1 1]);
end

f3 = figure('name','Madgwick','units','normalized','outerposition',[0 0 1 1]);
subplot(311)
hold on
plot(time, MADRPY(:,1))
plot(time, Attitude(:,1))
grid minor
hold off
subplot(312)
hold on
plot(time, MADRPY(:,2))
plot(time, Attitude(:,2))
grid minor
hold off
subplot(313)
hold on
plot(time, MADRPY(:,3))
plot(time, Attitude(:,3))
grid minor
hold off

disp(['Done! Elapsed time:' num2str(toc(timerVal))]);

%% Plot results

%% END OF CODE

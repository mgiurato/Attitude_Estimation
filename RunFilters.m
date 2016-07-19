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
logfile = 'NearHovering';
% logfile = 'Aggressive';

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
disp('Multiplicative Extended Kalman Filter tuning');
timerVal = tic;

%Tuning
sigma_acc = 0.2518; 
sigma_mag = 3.4810;
sigma_u = 0.0012;
sigma_v = 0.0001;

%Attitude Estimator
KALRPY = zeros(N, 3);
Kalman = KalmanAHRS('SamplePeriod',ts,...
                    'sigma_acc',sigma_acc,'sigma_mag',sigma_mag,...
                    'sigma_u',sigma_u,'sigma_v',sigma_v);
for t = 1:N
    Kalman.Update(Gyro(t,:)',Acc(t,:)',Mag(t,:)');
    KALRPY(t, :) = Kalman.R_P_Y;
end

disp(['Done! Elapsed time:' num2str(toc(timerVal))]);

%% Mahony Nonlinear Complementary Filter
disp('Mahony Nonlinear Complementary Filter tuning');
timerVal = tic;

%Tuning
Kacc = 4; 
Kmag = 0.1;
Kp = 0.1;
Ki = 0.01;

%Attitude Estimator
MAHRPY = zeros(N, 3);
Mahony = MahonyAHRS('SamplePeriod',ts,...
                    'Kacc',Kacc,'Kmag',Kmag,...
                    'Kp', Kp, 'Ki', Ki);
for t = 1:N
    Mahony.Update(Gyro(t,:)', Acc(t,:)', Mag(t,:)');
    MAHRPY(t, :) = Mahony.R_P_Y;
end

disp(['Done! Elapsed time:' num2str(toc(timerVal))]);

%% Madgwick AHRS Filter
disp('Madgwick AHRS Filter tuning');
timerVal = tic;

%Tuning
beta = -0.1; 
zeta = -0.00001;

%Attitude Estimator
MADRPY = zeros(N, 3);
Madgwick = MadgwickAHRS('SamplePeriod',ts,'Beta',beta,'Zeta',zeta);
for t = 1:N
    Madgwick.Update(Gyro(t,:), Acc(t,:), Mag(t,:));
    MADquaternion = Madgwick.Quaternion;
    MADRPY(t, :) = - quatern2euler(MADquaternion);
end

disp(['Done! Elapsed time:' num2str(toc(timerVal))]);

%% Plot results

%% END OF CODE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Attitude Estimator - Run Filters    %
% Author: M. Giurato                  %
% Date: 19/07/12                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clearvars
clc

%% General variables
IMUsample = 0.01;                                                           %[s] Sample time
% LOG_NAME = 'Calibration';
% LOG_NAME = 'NearHovering';
% LOG_NAME = 'Aggressive';
LOG_NAME = 'att_compl3';

%Usefull variables
deg2rad = pi/180;
rad2deg = 180/pi;

%% Import data logged
load([pwd filesep 'Data' filesep LOG_NAME]);

%Import data from 9DOF IMU (body frame measurements rotated back to IMU frame)
Gyro = [imu_raw_gyro_y imu_raw_gyro_x -imu_raw_gyro_z];                      %[rad/s]
Acc = [imu_raw_acc_y imu_raw_acc_x -imu_raw_acc_z];                          %[m/s^2]
Mag = [imu_raw_mag_y imu_raw_mag_x -imu_raw_mag_z];                          %[1]

%Import data from optitrack (inertial NED frame)
g_attitude_yaw = g_attitude_yaw + o_attitude_yaw(5,:); %ground to init mag angle
attitude = [g_attitude_roll g_attitude_pitch g_attitude_yaw] * deg2rad;

%Remove first and last data to avoid logging-sync problems
Gyro = Gyro(3:end-1,:);
Acc = Acc(3:end-1,:);
Mag = Mag(3:end-1,:);
attitude = attitude(3:end-1,:);

%Define time vector
N = length(Gyro);
time = 0:IMUsample:(N - 1)*IMUsample;

%Quaternion initialization
% quat = [0 0 0 1]';
quat = initQuat( Acc(1,:)', Mag(1,:)' );

%% Multiplicative Extended Kalman Filter
disp('Multiplicative Extended Kalman Filter');
timerVal = tic;

% Tuning
%Sigma accelerometer
sigma_acc = 0.01;
%Sigma magnetometer
sigma_mag = 0.01;
%Sigma rate random walk
sigma_u = 0.01;
%Sigma angle random walk
sigma_v = 0.001;

%Attitude Estimator
kalman_quaternion = zeros(4,length(time));

AHRS = KalmanAHRS('SamplePeriod', IMUsample, 'Quaternion', quat, ...
                  'Sigma_acc', sigma_acc, 'Sigma_mag', sigma_mag,...
                  'Sigma_u', sigma_u, 'Sigma_v', sigma_v);
for t = 1:N
    AHRS.Update(Gyro(t,:)', Acc(t,:)', Mag(t,:)');
%     AHRS.UpdateIMU(Gyro(t,:)', Acc(t,:)');
    kalman_quaternion(:,t) = AHRS.Quaternion;
end

kalman_euler = quatToEuler(kalman_quaternion);

f1 = figure('name','Kalman','units','normalized','outerposition',[0 0 1 1]);
subplot(311)
hold on
plot(time, kalman_euler(2,:))
plot(time, attitude(:,1))
ylabel('Roll [rad]')
grid minor
hold off
subplot(312)
hold on
plot(time, kalman_euler(1,:))
plot(time, attitude(:,2))
ylabel('Pitch [rad]')
grid minor
hold off
subplot(313)
hold on
plot(time, -kalman_euler(3,:))
plot(time, attitude(:,3))
grid minor
ylabel('Yaw [rad]')
hold off

disp(['Done! Elapsed time:' num2str(toc(timerVal))]);

%% Mahony Nonlinear Complementary Filter
disp('Mahony Nonlinear Complementary Filter');
timerVal = tic;

%Tuning
Kacc = 2; 
Kmag = 2;
Kp = 20;
Ki = 5;

%Attitude Estimator
mahony_quaternion = zeros(4,length(time));

AHRS = MahonyAHRS('SamplePeriod', IMUsample, 'Quaternion', quat, ...
                  'Kp', Kp,'Ki', Ki, 'Kacc', Kacc, 'Kmag', Kmag);
for t = 1:N
    AHRS.Update(Gyro(t,:)', Acc(t,:)', Mag(t,:)');
%     AHRS.UpdateIMU(Gyro(t,:)', Acc(t,:)');
    mahony_quaternion(:,t) = AHRS.Quaternion;
end

mahony_euler = quatToEuler(mahony_quaternion);

f2 = figure('name','Mahony','units','normalized','outerposition',[0 0 1 1]);
subplot(311)
hold on
plot(time, mahony_euler(2,:))
plot(time, attitude(:,1))
ylabel('Roll [rad]')
grid minor
hold off
subplot(312)
hold on
plot(time, mahony_euler(1,:))
plot(time, attitude(:,2))
ylabel('Pitch [rad]')
grid minor
hold off
subplot(313)
hold on
plot(time, -mahony_euler(3,:))
plot(time, attitude(:,3))
grid minor
ylabel('Yaw [rad]')
hold off

disp(['Done! Elapsed time:' num2str(toc(timerVal))]);

%% Madgwick AHRS Filter
disp('Madgwick AHRS Filter');
timerVal = tic;

%Tuning
beta = 0.5; 
zeta = 0.1;

%Attitude Estimator
madgwick_quaternion = zeros(4,length(time)); 

AHRS = MadgwickAHRS('SamplePeriod', IMUsample, 'Quaternion', quat, ...
                    'Beta', beta, 'Zeta', zeta);
for t = 1:N
    AHRS.Update(Gyro(t,:)', Acc(t,:)', Mag(t,:)');
%     AHRS.UpdateIMU(Gyro(t,:)', Acc(t,:)');
    madgwick_quaternion(:,t) = AHRS.Quaternion;
end

madgwick_euler = quatToEuler(madgwick_quaternion);

f3 = figure('name','Madgwick','units','normalized','outerposition',[0 0 1 1]);
subplot(311)
hold on
plot(time, madgwick_euler(2,:))
plot(time, attitude(:,1))
ylabel('Roll [rad]')
grid minor
hold off
subplot(312)
hold on
plot(time, madgwick_euler(1,:))
plot(time, attitude(:,2))
ylabel('Pitch [rad]')
grid minor
hold off
subplot(313)
hold on
plot(time, -madgwick_euler(3,:))
plot(time, attitude(:,3))
ylabel('Yaw [rad]')
grid minor
hold off

disp(['Done! Elapsed time:' num2str(toc(timerVal))]);

%% Plot results

%% END OF CODE
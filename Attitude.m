%% Attitude Estimation     %
% Author: Mattia Giurato   %
% Last review: 2015/08/25  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all 
clc

%% Parameters definition
bias_a = [0.045165 0.021291 0.44478];
gain_a = [0.0093891 0.0096445 0.0099385];
bias_m = [0.29706 0.20455 -0.23463];
gain_m = [0.002654 0.002648 0.0027387];

%% Import logged data
%Import IMU data
RAW = dlmread('log_IMU.txt',',',1,0);
IMUtime = (RAW(:,1) - RAW(1,1))*10e-10;
acc = RAW(:,2:4);
gyro = RAW(:,5:7);
mag = RAW(:,8:10);

%Calibrate sensors
Accelerometer(:,1) = gain_a(1) * acc(:,1) - bias_a(1);
Accelerometer(:,2) = gain_a(2) * acc(:,2) - bias_a(2);
Accelerometer(:,3) = gain_a(3) * acc(:,3) - bias_a(3);
Gyroscope(:,1) = (gyro(:,1) - gyro(1,1))/1000;
Gyroscope(:,2) = (gyro(:,2) - gyro(1,2))/1000;
Gyroscope(:,3) = (gyro(:,3) - gyro(1,3))/1000;
Magnetometer(:,1) = gain_m(1) * mag(:,1) - bias_m(1);
Magnetometer(:,2) = gain_m(2) * mag(:,2) - bias_m(2);
Magnetometer(:,3) = gain_m(3) * mag(:,3) - bias_m(3);

%Import Optitrack data
filename = '/home/pela/Documents/MATLAB/Attitude_Estimation/log_opti.txt';
delimiter = ',';
startRow = 2;
formatSpec = '%f%f%f%s%f%f%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);
fclose(fileID);
seq = dataArray{:, 2};
stamp = dataArray{:, 3};
OPTItime = (stamp - stamp(1))*10e-10;
frame_id = dataArray{:, 4};
positionx = dataArray{:, 5};
positiony = dataArray{:, 6};
positionz = dataArray{:, 7};
orientationx = dataArray{:, 8};
orientationy = dataArray{:, 9};
orientationz = dataArray{:, 10};
orientationw = dataArray{:, 11};
OPTIquaternion = [orientationw orientationx orientationy orientationz];

clearvars RAW filename delimiter startRow formatSpec fileID dataArray ans stamp;

%% ifhnn2f 
IMUsample = mean(diff(IMUtime));
OPTIsample = mean(diff(OPTItime));
IMUstart = 136;
OPTIstart = 530;
IMUend = length(IMUtime);
OPTIend = length(OPTItime);

IMUtime = IMUtime(IMUstart:IMUend) - IMUtime(IMUstart);
Accelerometer = Accelerometer(IMUstart:IMUend, :);
Gyroscope = Gyroscope(IMUstart:IMUend, :);
Magnetometer = Magnetometer(IMUstart:IMUend, :);

OPTItime = downsample(OPTItime(OPTIstart:OPTIend),floor(IMUsample/OPTIsample)) - OPTItime(OPTIstart);
OPTIquaternion = downsample(OPTIquaternion(OPTIstart:OPTIend, :),floor(IMUsample/OPTIsample));

%% Process sensor data through Madgwick algorithm

AHRS = MadgwickAHRS('SamplePeriod', IMUsample, 'Beta', 0.12);

IMUquaternion = zeros(length(IMUtime), 4);
for t = 1:length(IMUtime)
    AHRS.UpdateIMU(Gyroscope(t,:) * (pi/180), Accelerometer(t,:));	% gyroscope units must be radians
    %AHRS.Update(Gyroscope(t,:) * (pi/180), Accelerometer(t,:), Magnetometer(t,:));	% gyroscope units must be radians
    IMUquaternion(t, :) = AHRS.Quaternion;
end

%% Plot algorithm output as Euler angles
% The first and third Euler angles in the sequence (phi and psi) become
% unreliable when the middle angles of the sequence (theta) approaches �90
% degrees. This problem commonly referred to as Gimbal Lock.
% See: http://en.wikipedia.org/wiki/Gimbal_lock

IMUeuler = quatern2euler(quaternConj(IMUquaternion)) * (180/pi);	% use conjugate for sensor frame relative to Earth and convert to degrees.
OPTIeuler = quatern2euler(quaternConj(OPTIquaternion)) * (180/pi);

% figure('Name', 'IMU - Euler Angles');
% hold on;
% plot(IMUtime, IMUeuler(:,1), 'r');
% plot(IMUtime, IMUeuler(:,2), 'g');
% plot(IMUtime, IMUeuler(:,3), 'b');
% title('IMU - Euler angles');
% xlabel('Time (s)');
% ylabel('Angle (deg)');
% legend('\phi', '\theta', '\psi');
% hold off;
% 
% figure('Name', 'OPTITRACK - Euler Angles');
% hold on;
% plot(OPTItime, OPTIeuler(:,1), 'r');
% plot(OPTItime, OPTIeuler(:,2), 'g');
% plot(OPTItime, OPTIeuler(:,3), 'b');
% title('OPTI - Euler angles');
% xlabel('Time (s)');
% ylabel('Angle (deg)');
% legend('\phi', '\theta', '\psi');
% hold off;

figure('Name', 'IMU - Quaternions');
hold on;
plot(IMUtime, IMUquaternion(:,1));
plot(IMUtime, IMUquaternion(:,2));
plot(IMUtime, IMUquaternion(:,3));
plot(IMUtime, IMUquaternion(:,4));
title('IMU - Quaternions');
xlabel('Time (s)');
ylabel('Quaternion');
legend('w','x','y','z');
hold off;

figure('Name', 'OPTITRACK - Quaternions');
hold on;
plot(OPTItime, OPTIquaternion(:,1));
plot(OPTItime, OPTIquaternion(:,2));
plot(OPTItime, OPTIquaternion(:,3));
plot(OPTItime, OPTIquaternion(:,4));
title('OPTI - Quaternions');
xlabel('Time (s)');
ylabel('Quaternion');
legend('w','x','y','z');
hold off;

%% End of code
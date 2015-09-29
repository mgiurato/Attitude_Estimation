%% Attitude Estimation     %
% Author: Mattia Giurato   %
% Last review: 2015/09/29  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all 
clc

%% Parameters definition
bias_a = [-0.014362 -0.037594 0.49479];
gain_a = [0.0093594 0.0096416 0.0099621];
bias_m = [0.19873 0.13792 -0.40715];
gain_m = [0.002409 0.0024659 0.0027394];
bias_g = [-0.15782 -0.046567 -0.011595];
gain_g = [0.00032202 0.00033516 0.00031422];

%% Import logged data
%Import IMU data
RAW = dlmread('log_IMU3.txt');
acc = RAW(:,1:3);
gyr = RAW(:,4:6);
mag = RAW(:,7:9);

%Calibrate sensors
Accelerometer(:,1) = gain_a(1) * acc(:,1) - bias_a(1);
Accelerometer(:,2) = gain_a(2) * acc(:,2) - bias_a(2);
Accelerometer(:,3) = gain_a(3) * acc(:,3) - bias_a(3);
Magnetometer(:,1) = gain_m(1) * mag(:,1) - bias_m(1);
Magnetometer(:,2) = gain_m(2) * mag(:,2) - bias_m(2);
Magnetometer(:,3) = gain_m(3) * mag(:,3) - bias_m(3);
Gyroscope(:,1) = +(gain_g(2) * (gyr(:,2) - gyr(1,2)));
Gyroscope(:,2) = -(gain_g(1) * (gyr(:,1) - gyr(1,1)));
Gyroscope(:,3) = +(gain_g(3) * (gyr(:,3) - gyr(1,3)));

%Import Optitrack data
filename = '/home/pela/Documents/MATLAB/Attitude_Estimation/log_opti3.txt';
delimiter = ',';
startRow = 2;
formatSpec = '%f%f%f%s%f%f%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);
fclose(fileID);
seq = dataArray{:, 2};
stamp = dataArray{:, 3};
OPTItime = (stamp - stamp(1))*10e-10;
orientationx = dataArray{:, 8};
orientationy = dataArray{:, 9};
orientationz = dataArray{:, 10};
orientationw = dataArray{:, 11};
OPTIquaternion_c = [orientationw orientationx orientationy orientationz];

clearvars RAW filename delimiter startRow formatSpec fileID dataArray ans stamp;

%% Resizing vectors
IMUsample = 1/100;
OPTIsample = mean(diff(OPTItime));

dddel = 1650;
IMUstart = 640;
IMUend = IMUstart + dddel;
OPTIstart = 430;
OPTIend = OPTIstart + dddel;

Accelerometer = Accelerometer(IMUstart:IMUend, :);
Gyroscope = Gyroscope(IMUstart:IMUend, :);
Magnetometer = Magnetometer(IMUstart:IMUend, :);
IMUtime = (0:IMUsample:(length(Accelerometer)-1)*IMUsample)';

OPTIquaternion = OPTIquaternion_c(OPTIstart:OPTIend,:);

%% Tuning iterations

for i = 0:60
    % Process sensor data through Madgwick algorithm
    beta(i+1) = i/100;
    AHRS = MadgwickAHRS('SamplePeriod', IMUsample, 'Beta', beta(i+1));IMUquaternion = zeros(length(IMUtime), 4);
    for t = 1:length(IMUtime)
        %AHRS.UpdateIMU(Gyroscope(t,:), Accelerometer(t,:));	% gyroscope units must be radians
        AHRS.Update(Gyroscope(t,:), Accelerometer(t,:), Magnetometer(t,:));	% gyroscope units must be radians
        IMUquaternion(t, :) = AHRS.Quaternion;
    end
    % Let's find the ERROR
    error = OPTIquaternion - IMUquaternion;
    FiltRMS(i+1) = mean(rms(error));
end

%% Plot Filter RMS
figure('Name', 'Filter RMS');
hold on;
plot(beta, FiltRMS);
title('Filter RMS with reference to \beta');
xlabel('\beta');
ylabel('Quaternion Average RMS');
legend('RMS');
hold off;

%% Plot 
bet = 0.15;
AHRS = MadgwickAHRS('SamplePeriod', IMUsample, 'Beta', bet);IMUquaternion = zeros(length(IMUtime), 4);
for t = 1:length(IMUtime)
    %AHRS.UpdateIMU(Gyroscope(t,:), Accelerometer(t,:));	% gyroscope units must be radians
    AHRS.Update(Gyroscope(t,:), Accelerometer(t,:), Magnetometer(t,:));	% gyroscope units must be radians
    IMUquaternion(t, :) = AHRS.Quaternion;
end

%% Plot algorithm output as Euler angles
% The first and third Euler angles in the sequence (phi and psi) become
% unreliable when the middle angles of the sequence (theta) approaches �90
% degrees. This problem commonly referred to as Gimbal Lock.
% See: http://en.wikipedia.org/wiki/Gimbal_lock

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
plot(IMUtime, OPTIquaternion(:,1));
plot(IMUtime, OPTIquaternion(:,2));
plot(IMUtime, OPTIquaternion(:,3));
plot(IMUtime, OPTIquaternion(:,4));
title('OPTI - Quaternions');
xlabel('Time (s)');
ylabel('Quaternion');
legend('w','x','y','z');
hold off;

IMUeuler = quatern2euler(IMUquaternion) * (180/pi);	% use conjugate for sensor frame relative to Earth and convert to degrees.
OPTIeuler = quatern2euler(quaternConj(OPTIquaternion)) * (180/pi);

figure('Name', 'IMU - Euler Angles');
hold on;
plot(IMUtime, IMUeuler(:,1), 'r');
plot(IMUtime, IMUeuler(:,2), 'g');
plot(IMUtime, IMUeuler(:,3), 'b');
title('IMU - Euler angles');
xlabel('Time (s)');
ylabel('Angle (deg)');
legend('\phi', '\theta', '\psi');
hold off;

figure('Name', 'OPTITRACK - Euler Angles');
hold on;
plot(IMUtime, OPTIeuler(:,1), 'r');
plot(IMUtime, OPTIeuler(:,2), 'g');
plot(IMUtime, OPTIeuler(:,3), 'b');
title('OPTI - Euler angles');
xlabel('Time (s)');
ylabel('Angle (deg)');
legend('\phi', '\theta', '\psi');
hold off;

%% End of code
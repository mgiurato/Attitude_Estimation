%% Attitude Estimation     %
% Author: Mattia Giurato   %
% Last review: 2015/09/30  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all 
clc

%% Parameters definition
%Calibration
bias_a = [-0.033101 -0.026818 0.55087];
gain_a = [0.0093816 0.0096461 0.0099341];
bias_m = [0.1995 0.12946 -0.40552];
gain_m = [0.0023094 0.0023691 0.0026049];
bias_g = [-0.13963 -0.048177 0.053517];
gain_g = [0.00032508 0.0003161 0.00032548];

%Import
RAW = dlmread('log_imuraw3.txt');
%test0
% IMUstart = 500;
% dddel = 3900;
% OPTIstart = 812;
%test1
% IMUstart = 470;
% dddel = 4500;
% OPTIstart = 682;
%test1-ident
% IMUstart = 470;
% dddel = 2000;
% OPTIstart = 682;
%test3
IMUstart = 2350;
dddel = 5340;
OPTIstart = 1961;

IMUend = IMUstart + dddel;
OPTIend = OPTIstart + dddel;

IMUsample = 1/100;

%% Import logged data
%Import IMU data
acc = RAW(:,1:3);
gyr = RAW(:,4:6);
mag = RAW(:,7:9);

%Calibrate sensors
Accelerometer_c(:,1) = gain_a(1) * acc(:,1) - bias_a(1);
Accelerometer_c(:,2) = gain_a(2) * acc(:,2) - bias_a(2);
Accelerometer_c(:,3) = gain_a(3) * acc(:,3) - bias_a(3);
Magnetometer_c(:,1) = gain_m(1) * mag(:,1) - bias_m(1);
Magnetometer_c(:,2) = gain_m(2) * mag(:,2) - bias_m(2);
Magnetometer_c(:,3) = gain_m(3) * mag(:,3) - bias_m(3);
Gyroscope_c(:,1) = gain_g(1) * (gyr(:,1) - mean(gyr(1:IMUstart-1,1)));
Gyroscope_c(:,2) = gain_g(2) * (gyr(:,2) - mean(gyr(1:IMUstart-1,2)));
Gyroscope_c(:,3) = gain_g(3) * (gyr(:,3) - mean(gyr(1:IMUstart-1,3)));
% Gyroscope_c(:,1) = gain_g(1) * gyr(:,1);
% Gyroscope_c(:,2) = gain_g(2) * gyr(:,2);
% Gyroscope_c(:,3) = gain_g(3) * gyr(:,3);

%Import Optitrack data
filename = 'C:\Users\Mattia\Documents\MATLAB\Attitude_Estimation/log_opti3.txt';
delimiter = ',';
startRow = 2;
formatSpec = '%f%f%f%s%f%f%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);
fclose(fileID);
seq = dataArray{:, 2};
stamp = dataArray{:, 3};
OPTItime = (stamp - stamp(1))*10e-10;
orientation3 = dataArray{:, 8};
orientation2 = dataArray{:, 9};
orientation1 = dataArray{:, 10};
orientation0 = dataArray{:, 11};
OPTIquaternion_c = [orientation0 orientation3 orientation2 orientation1];

OPTIsample = mean(diff(OPTItime));

clearvars RAW filename delimiter startRow formatSpec fileID dataArray ans stamp;

%% Resizing vectors
Accelerometer = Accelerometer_c(IMUstart:IMUend, :);
Gyroscope = Gyroscope_c(IMUstart:IMUend, :);
Magnetometer = Magnetometer_c(IMUstart:IMUend, :);
time = (0:IMUsample:(length(Accelerometer)-1)*IMUsample)';

OPTIquaternion = OPTIquaternion_c(OPTIstart:OPTIend,:);

%% Tuning iterations
for i = 0:100
    % Process sensor data through Madgwick algorithm
    beta(i+1) = i/500;
    zeta = 0;
    AHRS = MadgwickAHRS('SamplePeriod', IMUsample, 'Beta', beta(i+1),  'Zeta', zeta);
    IMUquaternion = zeros(length(time), 4);
    for t = 1:length(time)
        AHRS.UpdateIMU(Gyroscope(t,:), Accelerometer(t,:));	% gyroscope units must be radians
        %AHRS.Update(Gyroscope(t,:), Accelerometer(t,:), Magnetometer(t,:));	% gyroscope units must be radians
        IMUquaternion(t, :) = AHRS.Quaternion;
    % Let's find the ERROR
    error = OPTIquaternion - IMUquaternion;
    FiltRMS(i+1) = mean(rms(error));
    end
end
[M, I] = min(FiltRMS);
bet = (I-1)/500;

%Uncomment only in case of AHRS algorithm
% for i = 0:100
%     % Process sensor data through Madgwick algorithm
%     zeta(i+1) = i/50000;
%     AHRS = MadgwickAHRS('SamplePeriod', IMUsample, 'Beta', bet,  'Zeta', zeta(i+1));
%     IMUquaternion = zeros(length(time), 4);
%     for t = 1:length(time)
%         AHRS.Update(Gyroscope(t,:), Accelerometer(t,:), Magnetometer(t,:));	% gyroscope units must be radians
%         IMUquaternion(t, :) = AHRS.Quaternion;
%     % Let's find the ERROR
%     error = OPTIquaternion - IMUquaternion;
%     FiltRMSzeta(i+1) = mean(rms(error));
%     end
% end
% [M, I] = min(FiltRMSzeta);
% zet = (I-1)/50000;

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

%Uncomment only in case of AHRS algorithm
% figure('Name', 'Filter RMS');
% hold on;
% plot(zeta, FiltRMSzeta);
% title('RMS of the error with reference to \zeta');
% xlabel('\zeta');
% ylabel('Quaternion Average RMS');
% legend('RMS');
% grid minor
% y2=get(gca,'ylim');
% plot([zet zet],y2, 'r--')
% strmin = ['\zeta = ',num2str(zet)];
% text(zet+0.0001,y2(2)*19/20,strmin,'HorizontalAlignment','left');
% hold off;

%% Plot Optimal tuning
zet = 0;
AHRS = MadgwickAHRS('SamplePeriod', IMUsample, 'Beta', bet,  'Zeta', zet);
IMUquaternion = zeros(length(time), 4);
GYRObias = zeros(length(time), 3);
for t = 1:length(time)
    AHRS.UpdateIMU(Gyroscope(t,:), Accelerometer(t,:));	% gyroscope units must be radians
    %AHRS.Update(Gyroscope(t,:), Accelerometer(t,:), Magnetometer(t,:));	% gyroscope units must be radians
    IMUquaternion(t, :) = AHRS.Quaternion;
    GYRObias(t,:) = AHRS.GyrBias;
end

IMUeuler = quatern2euler(quaternConj(IMUquaternion)) * (180/pi);	% use conjugate for sensor frame relative to Earth and convert to degrees.
OPTIeuler = quatern2euler(quaternConj(OPTIquaternion)) * (180/pi);

FinalError = (OPTIeuler - IMUeuler);

%% Plot 
% figure('Name', 'Quaternions');
% hold on;
% plot(time, IMUquaternion(:,1),'y');
% plot(time, IMUquaternion(:,2),'r');
% plot(time, IMUquaternion(:,3),'g');
% plot(time, IMUquaternion(:,4),'b');
% plot(time, OPTIquaternion(:,1),'y-.');
% plot(time, OPTIquaternion(:,2),'r-.');
% plot(time, OPTIquaternion(:,3),'g-.');
% plot(time, OPTIquaternion(:,4),'b-.');
% title('Quaternions');
% xlabel('Time [s]');
% ylabel('Quaternion');
% legend('q_{0,IMU}','q_{1,IMU}','q_{2,IMU}','q_{3,IMU}','q_{0,opti}','q_{1,opti}','q_{2,opti}','q_{3,opti}');
% hold off;

figure('Name', 'Euler Angles-phi');
hold on;
plot(time, IMUeuler(:,1), 'r');
plot(time, OPTIeuler(:,1), 'r-.');
title('Euler angle: \phi');
xlabel('Time [s]');
ylabel('Angle [deg]');
legend('\phi_{IMU}', '\phi_{Opti}');
grid minor
hold off;

figure('Name', 'Euler Angles-theta');
hold on;
plot(time, IMUeuler(:,2), 'g');
plot(time, OPTIeuler(:,2), 'g-.');
title('Euler angle: \theta');
xlabel('Time [s]');
ylabel('Angle [deg]');
legend('\theta_{IMU}', '\theta_{Opti}');
grid minor
hold off;

figure('Name', 'Euler Angles');
hold on;
plot(time, IMUeuler(:,3), 'b');
plot(time, OPTIeuler(:,3), 'b-.');
title('Euler angle: \psi');
xlabel('Time [s]');
ylabel('Angle [deg]');
legend('\psi_{IMU}', '\psi_{Opti}');
grid minor
hold off;

figure('Name', 'Relative Percentual Error-phi');
hold on;
plot(time, FinalError(:,1), 'r');
title('error: \phi');
xlabel('Time [s]');
ylabel('Angle [deg]');
legend('\phi_{error}');
grid minor
hold off;

figure('Name', 'Relative Percentual Error-theta');
hold on;
plot(time, FinalError(:,2), 'g');
title('error: \theta');
xlabel('Time [s]');
ylabel('Angle [deg]');
legend('\theta_{error}');
grid minor
hold off;

figure('Name', 'Relative Percentual Error-psi');
hold on;
plot(time, FinalError(:,3), 'b');
title('error: \psi');
xlabel('Time [s]');
ylabel('Angle [deg]');
legend('\psi_{error}');
grid minor
hold off;

%% End of code
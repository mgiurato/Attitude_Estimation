%% Sigma Estimation        %
% Author: Mattia Giurato   %
% Last review: 2016/03/07  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all 
clc

%% Data import
load('IMUoutput_sigma.mat')

Gyroscope = Gyroscope(2:length(Gyroscope)-1,:);
Accelerometer = Accelerometer(2:length(Accelerometer)-1,:);
Magnetometer = Magnetometer(2:length(Magnetometer)-1,:);

IMUtime = IMUtime(1:length(IMUtime)-2);

%% Sigma estimation
sigma_gyr = std(Gyroscope(:,:));
sigma_acc = std(Accelerometer(:,:));
sigma_mag = std(Magnetometer(:,:));

mean_gyr = mean(Gyroscope(:,:));
mean_acc = mean(Accelerometer(:,:));
mean_mag = mean(Magnetometer(:,:));

%% Output
disp('The estimated Gyroscope standard deviations are:')
disp(['X:', num2str(sigma_gyr(1))])
disp(['Y:', num2str(sigma_gyr(2))])
disp(['Z:', num2str(sigma_gyr(3))])

disp('The estimated Accelerometer standard deviations are:')
disp(['X:', num2str(sigma_acc(1))])
disp(['Y:', num2str(sigma_acc(2))])
disp(['Z:', num2str(sigma_acc(3))])

disp('The estimated Magnetometer standard deviations are:')
disp(['X:', num2str(sigma_mag(1))])
disp(['Y:', num2str(sigma_mag(2))])
disp(['Z:', num2str(sigma_mag(3))])

%% Plot
figure('name','Accelerometer_X')
plot(IMUtime, Accelerometer(:,1),'color','r')
grid minor
title('Accelerometer')
xlabel('time [s]')
ylabel('[g]')
legend('Acc_x')
hold on
y=mean_acc(1) + sigma_acc(1);
line('XData', [0 max(IMUtime)], 'YData',  [y y], 'LineStyle', '-.')
y=mean_acc(1) - sigma_acc(1);
line('XData', [0 max(IMUtime)], 'YData',  [y y], 'LineStyle', '-.')
hold off

figure('name','Accelerometer_Y')
plot(IMUtime, Accelerometer(:,2),'color','g')
grid minor
title('Accelerometer')
xlabel('time [s]')
ylabel('[g]')
legend('Acc_y')
hold on
y=mean_acc(2) + sigma_acc(2);
line('XData', [0 max(IMUtime)], 'YData',  [y y], 'LineStyle', '-.')
y=mean_acc(2) - sigma_acc(2);
line('XData', [0 max(IMUtime)], 'YData',  [y y], 'LineStyle', '-.')
hold off

figure('name','Accelerometer_Z')
plot(IMUtime, Accelerometer(:,3),'color','b')
grid minor
title('Accelerometer')
xlabel('time [s]')
ylabel('[g]')
legend('Acc_y')
hold on
y=mean_acc(3) + sigma_acc(3);
line('XData', [0 max(IMUtime)], 'YData',  [y y], 'LineStyle', '-.')
y=mean_acc(3) - sigma_acc(3);
line('XData', [0 max(IMUtime)], 'YData',  [y y], 'LineStyle', '-.')
hold off

figure('name','Gyroscope_X')
plot(IMUtime, Gyroscope(:,1),'color','r')
grid minor
title('Gyroscope')
xlabel('time [s]')
ylabel('[rad/s]')
legend('Gyro_x')
hold on
y=mean_gyr(1) + sigma_gyr(1);
line('XData', [0 max(IMUtime)], 'YData',  [y y], 'LineStyle', '-.')
y=mean_gyr(1) - sigma_gyr(1);
line('XData', [0 max(IMUtime)], 'YData',  [y y], 'LineStyle', '-.')
hold off

figure('name','Gyroscope_Y')
plot(IMUtime, Gyroscope(:,2),'color','g')
grid minor
title('Gyroscope')
xlabel('time [s]')
ylabel('[rad/s]')
legend('Gyro_y')
hold on
y=mean_gyr(2) + sigma_gyr(2);
line('XData', [0 max(IMUtime)], 'YData',  [y y], 'LineStyle', '-.')
y=mean_gyr(2) - sigma_gyr(2);
line('XData', [0 max(IMUtime)], 'YData',  [y y], 'LineStyle', '-.')
hold off

figure('name','Gyroscope_Z')
plot(IMUtime, Gyroscope(:,3),'color','b')
grid minor
title('Gyroscope')
xlabel('time [s]')
ylabel('[rad/s]')
legend('Gyro_z')
hold on
y=mean_gyr(3) + sigma_gyr(3);
line('XData', [0 max(IMUtime)], 'YData',  [y y], 'LineStyle', '-.')
y=mean_gyr(3) - sigma_gyr(3);
line('XData', [0 max(IMUtime)], 'YData',  [y y], 'LineStyle', '-.')
hold off

figure('name','Magnetometer_X')
plot(IMUtime, Magnetometer(:,1),'color','r')
grid minor
title('Magnetometer')
xlabel('time [s]')
ylabel('[1]')
legend('Mag_x')
hold on
y=mean_mag(1) + sigma_mag(1);
line('XData', [0 max(IMUtime)], 'YData',  [y y], 'LineStyle', '-.')
y=mean_mag(1) - sigma_mag(1);
line('XData', [0 max(IMUtime)], 'YData',  [y y], 'LineStyle', '-.')
hold off

figure('name','Magnetometer_Y')
plot(IMUtime, Magnetometer(:,2),'color','g')
grid minor
title('Magnetometer')
xlabel('time [s]')
ylabel('[1]')
legend('Mag_y')
hold on
y=mean_mag(2) + sigma_mag(2);
line('XData', [0 max(IMUtime)], 'YData',  [y y], 'LineStyle', '-.')
y=mean_mag(2) - sigma_mag(2);
line('XData', [0 max(IMUtime)], 'YData',  [y y], 'LineStyle', '-.')
hold off

figure('name','Magnetometer_Z')
plot(IMUtime, Magnetometer(:,3),'color','b')
grid minor
title('Magnetometer')
xlabel('time [s]')
ylabel('[1]')
legend('Mag_z')
hold on
y=mean_mag(3) + sigma_mag(3);
line('XData', [0 max(IMUtime)], 'YData',  [y y], 'LineStyle', '-.')
y=mean_mag(3) - sigma_mag(3);
line('XData', [0 max(IMUtime)], 'YData',  [y y], 'LineStyle', '-.')
hold off

%% END OF CODE
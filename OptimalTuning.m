%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Attitude Estimator - Optimal tuning %
% Author: M. Giurato                  %
% Date: 19/07/12                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clearvars
clc

%% General variables
ts = 0.01;                                                                  %[s] Sample time
logfile = 'Calibration';

%Weight tuning
w_roll = 1;
w_pitch = 1;
w_yaw = 0.5;

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
Gyro = Gyro(3:end-1,:);
Acc = Acc(3:end-1,:);
Mag = Mag(3:end-1,:);
Attitude = Attitude(3:end-1,:);

%Define time vector
N = length(Gyro);
time = 0:ts:(N - 1)*ts;

%% Multiplicative Extended Kalman Filter tuning
disp('Multiplicative Extended Kalman Filter tuning');
timerVal = tic;

%Tuning guess
sigma_acc = 0.2518; 
sigma_mag = 3.4810;
sigma_u = 0.0012;
sigma_v = 0.0001;
x0 = [sigma_acc sigma_mag sigma_u sigma_v]';

%Estimator tuning
fun = @(U) OptMahonyfun(U,Gyro(:,1),Gyro(:,2),Gyro(:,3),...
                          Acc(:,1),Acc(:,2),Acc(:,3),...
                          Mag(:,1),Mag(:,2),Mag(:,3),...
                          Attitude(:,1),Attitude(:,2),Attitude(:,3),...
                          w_roll, w_pitch, w_yaw,...
                          ts);
options = optimoptions('fsolve','algorithm','levenberg-marquardt');
x = fsolve(fun,x0,options);

%Optimal parameters
sigma_acc_optimal = x(1);
sigma_mag_optimal = x(2);
sigma_u_optimal = x(3);
sigma_v_optimal = x(4);
disp('Optimal parameters:');
disp(['-sigma_acc: ' num2str(sigma_acc_optimal)]);
disp(['-sigma_mag: ' num2str(sigma_mag_optimal)]);
disp(['-sigma_u: ' num2str(sigma_u_optimal)]);
disp(['-sigma_v: ' num2str(sigma_v_optimal)]);

%Results
KALRPY = zeros(N, 3);
Kalman = KalmanAHRS('SamplePeriod',ts,...
                    'sigma_acc',sigma_acc_optimal,'sigma_mag',sigma_mag_optimal,...
                    'sigma_u',sigma_u_optimal,'sigma_v',sigma_v_optimal);
for t = 1:N
    Kalman.Update(Gyro(t,:)', Acc(t,:)', Mag(t,:)');
    KALRPY(t, :) = Kalman.R_P_Y;
end

disp(['Done! Elapsed time:' num2str(toc(timerVal))]);

%% Mahony Nonlinear Complementary Filter
disp('Mahony Nonlinear Complementary Filter tuning');
timerVal = tic;

%Tuning guess
Kacc = 2; 
Kmag = 0.1;
Kp = 1;
Ki = 0.1;
x0 = [Kacc Kmag Kp Ki]';

%Estimator tuning
fun = @(U) OptMahonyfun(U,Gyro(:,1),Gyro(:,2),Gyro(:,3),...
                          Acc(:,1),Acc(:,2),Acc(:,3),...
                          Mag(:,1),Mag(:,2),Mag(:,3),...
                          Attitude(:,1),Attitude(:,2),Attitude(:,3),...
                          w_roll, w_pitch, w_yaw,...
                          ts);
options = optimoptions('fsolve','algorithm','levenberg-marquardt');
x = fsolve(fun,x0,options);

%Optimal parameters
Kacc_optimal = x(1);
Kmag_optimal = x(2);
Kp_optimal = x(3);
Ki_optimal = x(4);
disp('Optimal parameters:');
disp(['-Kacc: ' num2str(Kacc_optimal)]);
disp(['-Kmag: ' num2str(Kmag_optimal)]);
disp(['-Kp: ' num2str(Kp_optimal)]);
disp(['-Ki: ' num2str(Ki_optimal)]);

%Results
MAHRPY = zeros(N, 3);
Mahony = MahonyAHRS('SamplePeriod',ts,...
                    'Kacc',Kacc_optimal,'Kmag',Kmag_optimal,...
                    'Kp', Kp_optimal, 'Ki', Ki_optimal);
for t = 1:N
    Mahony.Update(Gyro(t,:)', Acc(t,:)', Mag(t,:)');
    MAHRPY(t, :) = Mahony.R_P_Y;
end

disp(['Done! Elapsed time:' num2str(toc(timerVal))]);

%% Madgwick AHRS Filter
disp('Madgwick AHRS Filter tuning');
timerVal = tic;

%Tuning guess
beta = 0.01; 
zeta = 0.0001;
x0 = [beta zeta]';

%Estimator tuning
fun = @(U) OptMadgwickfun(U,Gyro(:,1),Gyro(:,2),Gyro(:,3),...
                            Acc(:,1),Acc(:,2),Acc(:,3),...
                            Mag(:,1),Mag(:,2),Mag(:,3),...
                            Attitude(:,1),Attitude(:,2),Attitude(:,3),...
                            w_roll, w_pitch, w_yaw,...
                            ts);
options = optimoptions('fsolve','algorithm','levenberg-marquardt');
x = fsolve(fun,x0,options);

%Optimal parameters
beta_optimal = x(1);
zeta_optimal = x(2);
disp('Optimal parameters:');
disp(['-beta: ' num2str(beta_optimal)]);
disp(['-zeta: ' num2str(zeta_optimal)]);

%Results
MADRPY = zeros(N, 3);
Madgwick = MadgwickAHRS('SamplePeriod',ts,...
                        'Beta',beta_optimal,'Zeta',zeta_optimal);
for t = 1:N
    Madgwick.Update(Gyro(t,:), Acc(t,:), Mag(t,:));
    MADquaternion = Madgwick.Quaternion;
    MADRPY(t, :) = - quatern2euler(MADquaternion);
end

disp(['Done! Elapsed time:' num2str(toc(timerVal))]);

%% Plot results


%% END OF CODE

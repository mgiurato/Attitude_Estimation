%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Attitude Estimator - Optimal tuning %
% Author: M. Giurato                  %
% Date: 19/07/12                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clearvars
clc

%% General variables
IMUsample = 0.01;                                                            %[s] Sample time
LOG_NAME = 'att_compl3';

%Weight tuning
w_roll = 1;
w_pitch = 1;
w_yaw = 0.5;

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
attitude = [g_attitude_pitch g_attitude_roll -g_attitude_yaw] * deg2rad;

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

%% Multiplicative Extended Kalman Filter tuning
disp('Multiplicative Extended Kalman Filter tuning');
timerVal = tic;

%Tuning guess
%Sigma accelerometer
sigma_acc = 0.01;
%Sigma magnetometer
sigma_mag = 0.01;
%Sigma rate random walk
sigma_u = 0.01;
%Sigma angle random walk
sigma_v = 0.001;

x0 = [sigma_acc sigma_mag sigma_u sigma_v]';

%Estimator tuning
fun = @(U) OptKalmanfun(U,Gyro(:,1),Gyro(:,2),Gyro(:,3),...
                          Acc(:,1),Acc(:,2),Acc(:,3),...
                          Mag(:,1),Mag(:,2),Mag(:,3),...
                          attitude(:,1),attitude(:,2),attitude(:,3),...
                          w_roll, w_pitch, w_yaw,...
                          IMUsample);
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
kalman_quaternion = zeros(4,length(time));

AHRS = KalmanAHRS('SamplePeriod', IMUsample, 'Quaternion', quat, ...
                  'Sigma_acc', sigma_acc_optimal, 'Sigma_mag', sigma_mag_optimal,...
                  'Sigma_u', sigma_u_optimal, 'Sigma_v', sigma_v_optimal);
for t = 1:N
    AHRS.Update(Gyro(t,:)', Acc(t,:)', Mag(t,:)');
%     AHRS.UpdateIMU(Gyro(t,:)', Acc(t,:)');
    kalman_quaternion(:,t) = AHRS.Quaternion;
end

kalman_euler = quatToEuler(kalman_quaternion);

disp(['Done! Elapsed time:' num2str(toc(timerVal))]);

%% Mahony Nonlinear Complementary Filter
disp('Mahony Nonlinear Complementary Filter tuning');
timerVal = tic;

%Tuning guess
Kacc = 2; 
Kmag = 2;
Kp = 20;
Ki = 5;

x0 = [Kacc Kmag Kp Ki]';

%Estimator tuning
fun = @(U) OptMahonyfun(U,Gyro(:,1),Gyro(:,2),Gyro(:,3),...
                          Acc(:,1),Acc(:,2),Acc(:,3),...
                          Mag(:,1),Mag(:,2),Mag(:,3),...
                          attitude(:,1),attitude(:,2),attitude(:,3),...
                          w_roll, w_pitch, w_yaw,...
                          IMUsample);
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
mahony_quaternion = zeros(4,length(time));

AHRS = MahonyAHRS('SamplePeriod', IMUsample, 'Quaternion', quat, ...
                  'Kp', Kp_optimal,'Ki', Ki_optimal, 'Kacc', Kacc_optimal, 'Kmag', Kmag_optimal);
for t = 1:N
    AHRS.Update(Gyro(t,:)', Acc(t,:)', Mag(t,:)');
%     AHRS.UpdateIMU(Gyro(t,:)', Acc(t,:)');
    mahony_quaternion(:,t) = AHRS.Quaternion;
end

mahony_euler = quatToEuler(mahony_quaternion);

disp(['Done! Elapsed time:' num2str(toc(timerVal))]);

%% Madgwick AHRS Filter
disp('Madgwick AHRS Filter tuning');
timerVal = tic;

%Tuning guess
beta = 0.5; 
zeta = 0.1;

x0 = [beta zeta]';

%Estimator tuning
fun = @(U) OptMadgwickfun(U,Gyro(:,1),Gyro(:,2),Gyro(:,3),...
                            Acc(:,1),Acc(:,2),Acc(:,3),...
                            Mag(:,1),Mag(:,2),Mag(:,3),...
                            attitude(:,1),attitude(:,2),attitude(:,3),...
                            w_roll, w_pitch, w_yaw,...
                            IMUsample);
options = optimoptions('fsolve','algorithm','levenberg-marquardt');
x = fsolve(fun,x0,options);

%Optimal parameters
beta_optimal = x(1);
zeta_optimal = x(2);
disp('Optimal parameters:');
disp(['-beta: ' num2str(beta_optimal)]);
disp(['-zeta: ' num2str(zeta_optimal)]);

%Results
madgwick_quaternion = zeros(4,length(time)); 
AHRS = MadgwickAHRS('SamplePeriod', IMUsample, 'Quaternion', quat, ...
                    'Beta', beta_optimal, 'Zeta', zeta_optimal);
for t = 1:N
    AHRS.Update(Gyro(t,:)', Acc(t,:)', Mag(t,:)');
%     AHRS.UpdateIMU(Gyro(t,:)', Acc(t,:)');
    madgwick_quaternion(:,t) = AHRS.Quaternion;
end

madgwick_euler = quatToEuler(madgwick_quaternion);

disp(['Done! Elapsed time:' num2str(toc(timerVal))]);

%% Plot results


%% END OF CODE

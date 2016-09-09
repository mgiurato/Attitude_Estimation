%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Attitude Estimator - Run Filters    %
% Author: M. Giurato                  %
% Date: 19/07/12                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clearvars
clc

%% Parameters
ts = 0.01;                

%Tuning
Kacc = 2; 
Kmag = 2;
Kp = 10;
Ki = 1;

%% Dynamical model
%Roll and Pitch angles use the accelerometer measurement
AArp = [-Kp*Kacc/2 -1 ;
            Ki      0];
BBrp = [1  Kp*Kacc/2 ;
        0    -Ki    ];
CCrp = eye(2);
DDrp = zeros(2);

states = {'Theta_{hat}' 'b_{hat}'};
inputs = {'gyro' 'acc'};
outputs = {'Theta_{hat}' 'b_{hat}'};

% MahRP_ss = ss(AArp,BBrp,CCrp,DDrp,'statename',states,'inputname',inputs,'outputname',outputs);
MahRP_ss = ss(AArp,BBrp,CCrp,DDrp);
MahRP_tf = tf(MahRP_ss);

theta_tfgyro = MahRP_tf(1,1);
theta_tfacc = MahRP_tf(1,2);

%Yaw angle uses the magnetometer measurement
AAy = [-Kp*Kmag/2 -1 ;
           Ki      0];
BBy = [1  Kp*Kmag/2 ;
       0    -Ki    ];
CCy = eye(2);
DDy = zeros(2);

states = {'Theta_{hat}' 'b_{hat}'};
inputs = {'gyro' 'mag'};
outputs = {'Theta_{hat}' 'b_{hat}'};

% MahY_ss = ss(AAy,BBy,CCy,DDy,'statename',states,'inputname',inputs,'outputname',outputs);
MahY_ss = ss(AAy,BBy,CCy,DDy);
MahY_tf = tf(MahY_ss);

theta_tfmag = MahY_tf(1,2);

%% Plot results
figure
hold on
bodemag(theta_tfgyro)
bodemag(theta_tfacc)
bodemag(theta_tfmag)
title('Transfer functions from sensors to attitude')
legend('Gyroscope','Accelerometer','Magnetometer')
xlim([1e-2 1e2])
grid minor
hold off
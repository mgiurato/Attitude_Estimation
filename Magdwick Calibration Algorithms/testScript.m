fprintf('\r***************** START OF RUN *****************\r');
clear;
close all;

%--------------------------------------------------------------------------  
% Calibrate all sensors

calibrateAccelMag('accelMagData.csv', 'accelResults.csv', 1, 9.8, 50, 0.0015)
calibrateAccelMag('accelMagData.csv', 'magResults.csv', 0, 1, 2.5, 0.0013)
calibrateGyro('gyroxData.csv', 'gyroxResults.csv', 1, pi, 1/128, 0.001)
calibrateGyro('gyroyData.csv', 'gyroyResults.csv', 2, pi, 1/128, 0.001)
calibrateGyro('gyrozData.csv', 'gyrozResults.csv', 3, pi, 1/128, 0.001)

%--------------------------------------------------------------------------  
% End of file
 
fprintf('\r****************** END OF RUN ******************\r');
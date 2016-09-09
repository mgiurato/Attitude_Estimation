function KalRMS = OptKalmanfun(U,gx,gy,gz,ax,ay,az,mx,my,mz,optiR,optiP,optiY,w1,w2,w3,IMUsample)
sigma_acc = U(1);
sigma_mag = U(2);
sigma_v = U(3);
sigma_u = U(4);

attitude = [optiR optiP optiY];

Gyroscope = [gx gy gz];
Accelerometer = [ax ay az];
Magnetometer = [mx my mz];

%Quaternion initialization
% quat = [0 0 0 1]';
quat = initQuat( Accelerometer(1,:)', Magnetometer(1,:)' );

kalman_quaternion = zeros(4,length(Gyroscope));

AHRS = KalmanAHRS('SamplePeriod', IMUsample, 'Quaternion', quat, ...
                  'Sigma_acc', sigma_acc, 'Sigma_mag', sigma_mag,...
                  'Sigma_u', sigma_u, 'Sigma_v', sigma_v);
for t = 1:length(Accelerometer)
    AHRS.Update(Gyroscope(t,:)', Accelerometer(t,:)', Magnetometer(t,:)');
%     AHRS.UpdateIMU(Gyroscope(t,:)',Accelerometer(t,:)');
    kalman_quaternion(:,t) = AHRS.Quaternion;
end

kalman_euler = quatToEuler(kalman_quaternion);

errorKal = kalman_euler' - attitude;

KalRMS = sum([w1*rms(errorKal(:,1)) w2*rms(errorKal(:,2)) w3*rms(errorKal(:,3))])/sum([w1 w2 w3]);
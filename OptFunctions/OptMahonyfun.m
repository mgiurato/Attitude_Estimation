function MahRMS = OptMahonyfun(U,gx,gy,gz,ax,ay,az,mx,my,mz,optiR,optiP,optiY,w1,w2,w3,IMUsample)
Kacc = U(1);
Kmag = U(2);
Kp = U(3);
Ki = U(4);

attitude = [optiR optiP optiY];

Gyroscope = [gx gy gz];
Accelerometer = [ax ay az];
Magnetometer = [mx my mz];

%Quaternion initialization
% quat = [0 0 0 1]';
quat = initQuat( Accelerometer(1,:)', Magnetometer(1,:)' );

mahony_quaternion = zeros(4,length(Gyroscope));

AHRS = MahonyAHRS('SamplePeriod', IMUsample, 'Quaternion', quat, ...
                  'Kp', Kp,'Ki', Ki, 'Kacc', Kacc, 'Kmag', Kmag);
for t = 1:length(Accelerometer)
    AHRS.Update(Gyroscope(t,:)', Accelerometer(t,:)', Magnetometer(t,:)');
%     AHRS.UpdateIMU(Gyroscope(t,:)',Accelerometer(t,:)');
    mahony_quaternion(:,t) = AHRS.Quaternion;
end

mahony_euler = quatToEuler(mahony_quaternion);

errorMah = mahony_euler' - attitude;

MahRMS = (w1*rms(errorMah(:,1)) + w2*rms(errorMah(:,2)) + w3*rms(errorMah(:,3)))/(w1 + w2 + w3);
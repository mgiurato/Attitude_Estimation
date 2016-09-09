function MadRMS = OptMadgwickfun(U,gx,gy,gz,ax,ay,az,mx,my,mz,optiR,optiP,optiY,w1,w2,w3,IMUsample)
beta = U(1);
zeta = U(2);

attitude = [optiR optiP optiY];

Gyroscope = [gx gy gz];
Accelerometer = [ax ay az];
Magnetometer = [mx my mz];

%Quaternion initialization
% quat = [0 0 0 1]';
quat = initQuat( Accelerometer(1,:)', Magnetometer(1,:)' );

madgwick_quaternion = zeros(4,length(Gyroscope)); 

AHRS = MadgwickAHRS('SamplePeriod', IMUsample, 'Quaternion', quat, ...
                    'Beta', beta, 'Zeta', zeta);
for t = 1:length(Gyroscope)
    AHRS.Update(Gyroscope(t,:)',Accelerometer(t,:)',Magnetometer(t,:)');
%     AHRS.UpdateIMU(Gyroscope(t,:)',Accelerometer(t,:)');
    madgwick_quaternion(:,t) = AHRS.Quaternion;
end

madgwick_euler = quatToEuler(madgwick_quaternion);

errorMad = madgwick_euler' - attitude;

MadRMS = sum([w1*rms(errorMad(:,1)) w2*rms(errorMad(:,2)) w3*rms(errorMad(:,3))])/sum([w1 w2 w3]);
function MadRMS = OptMadgwickfun(U,gx,gy,gz,ax,ay,az,mx,my,mz,optiR,optiP,optiY,w1,w2,w3,IMUsample)
beta = U(1);
zeta = U(2);

Gyroscope = [gx gy gz];
Accelerometer = [ax ay az];
Magnetometer = [mx my mz];

errorMad = zeros(size(Gyroscope));

Madgwick = MadgwickAHRS('SamplePeriod',IMUsample,...
                        'Beta',beta,'Zeta',zeta);
for t = 1:length(Gyroscope)
    Madgwick.Update(Gyroscope(t,:),Accelerometer(t,:),Magnetometer(t,:));
    MADquaternion = Madgwick.Quaternion;
    MADRPY = - quatern2euler(MADquaternion);
    errorMad(t,1) = MADRPY(1) - optiR(t);
    errorMad(t,2) = MADRPY(2) - optiP(t);
    errorMad(t,3) = MADRPY(3) - optiY(t);
end
MadRMS = sum([w1*rms(errorMad(:,1)) w2*rms(errorMad(:,2)) w3*rms(errorMad(:,3))])/sum([w1 w2 w3]);
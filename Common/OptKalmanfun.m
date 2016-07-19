function KalRMS = OptKalmanfun(U,gx,gy,gz,ax,ay,az,mx,my,mz,optiR,optiP,optiY,w1,w2,w3,ts)
sigma_acc = U(1);
sigma_mag = U(2);
sigma_v = U(3);
sigma_u = U(4);

Gyroscope = [gx gy gz];
Accelerometer = [ax ay az];
Magnetometer = [mx my mz];

errorKal = zeros(size(Accelerometer));

Kalman = KalmanAHRS('SamplePeriod',ts, ...
                    'sigma_acc',sigma_acc,'sigma_mag',sigma_mag, ...
                    'sigma_u',sigma_u,'sigma_v',sigma_v);
               
for t = 1:length(Accelerometer)
    Kalman.Update(Gyroscope(t,:)', Accelerometer(t,:)', Magnetometer(t,:)');
    errorKal(t,1) = Kalman.R_P_Y(1) - optiR(t);
    errorKal(t,2) = Kalman.R_P_Y(2) - optiP(t);
    errorKal(t,3) = Kalman.R_P_Y(3) - optiY(t);
end
KalRMS = sum([w1*rms(errorKal(:,1)) w2*rms(errorKal(:,2)) w3*rms(errorKal(:,3))])/sum([w1 w2 w3]);
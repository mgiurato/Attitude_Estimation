function MahRMS = OptMahonyfun(U,gx,gy,gz,ax,ay,az,mx,my,mz,optiR,optiP,optiY,w1,w2,w3,ts)
K_A = U(1);
K_M = U(2);
K_P = U(3);
K_I = U(4);

Gyroscope = [gx gy gz];
Accelerometer = [ax ay az];
Magnetometer = [mx my mz];

errorMah = zeros(size(Gyroscope));

Mahony = MahonyAHRS('SamplePeriod',ts,...
                    'Kacc',K_A,'Kmag',K_M,...
                    'Kp',K_P,'Ki',K_I);

for t = 1:length(Accelerometer)
    Mahony.Update(Gyroscope(t,:)', Accelerometer(t,:)', Magnetometer(t,:)');
    errorMah(t,1) = Mahony.R_P_Y(1) - optiR(t);
    errorMah(t,2) = Mahony.R_P_Y(2) - optiP(t);
    errorMah(t,3) = Mahony.R_P_Y(3) - optiY(t);
end
MahRMS = (w1*rms(errorMah(:,1)) + w2*rms(errorMah(:,2)) + w3*rms(errorMah(:,3)))/(w1 + w2 + w3);
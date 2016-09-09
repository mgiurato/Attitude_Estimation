function A = quatToAtt( quat )
% quatToAtt Converts a quaternion vector to the attitude matrix A
%
%   A = quat2A( quat )
%
%   The attitude matrix A represents the rotational matrix betwen the inertial
%   reference frame and the body frame of the vehicle.
%   The quaternion (quat) must be written as a 4-by-1 vector with the scalar
%   element as the fourth component.

qv = [quat(1) ;
      quat(2) ;
      quat(3)];
q4 = quat(4);

rox = [   0   -qv(3)  qv(2) ;
         qv(3)  0    -qv(1) ;
        -qv(2) qv(1)   0   ];
norm_ro_sq = qv(1)^2 + qv(2)^2 + qv(3)^2;

A = (q4^2 - norm_ro_sq) * eye(3) + 2 * (qv*qv') - 2 * q4 * rox;


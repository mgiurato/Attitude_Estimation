function qDot = quatDerivative( ome, quat )
%quatDerivative Calculates the quaternion derivative
%
%   qDot = quatDerivative( ome, quat )
%
%   The angular velocity (ome) must be written as a 3-by-1 vector and
%   expressed in radiants per seconds.
%   The quaternion (quat) must be written as a 4-by-1 vector with the scalar
%   element as the fourth component.

omex = [   0    -ome(3)  ome(2) ;
         ome(3)    0    -ome(1) ;
        -ome(2)  ome(1)    0   ];
Omega = [-omex ome ;
         -ome'  0 ];
qDot = 0.5*Omega*quat;



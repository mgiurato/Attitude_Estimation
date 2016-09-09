function quat = initQuat( acc, mag )
%initQuat Quaternion initialization
%
%   quat = initQuat( acc, mag )
%
%   Given the measurements of Accelerometer and Magnetometer (both
%   expressed as a 3-by-1 vector) this function return the quaternion
%   representing the rotation from inertial frame to IMU frame.

z = acc;
y = cross( z, mag );
x = cross( y, acc );

x = x/norm(x);
y = y/norm(y);
z = z/norm(z);

A = [x y z];

greatest  = max([trace(A) A(1,1) A(2,2) A(3,3)]);

switch greatest
    case A(1,1)
        q = [1 + 2*A(1,1) - trace(A) ;
                 A(1,2) + A(2,1)     ;
                 A(1,3) + A(3,1)     ;
                 A(2,3) - A(3,2)    ];
        quat = q/(4*q(1));
        
    case A(2,2)
        q = [    A(2,1) + A(1,2)     ;
             1 + 2*A(2,2) - trace(A) ;
                 A(2,3) + A(3,2)     ;
                 A(3,1) - A(1,3)    ];
        quat = q/(4*q(2));
        
    case A(3,3)
        q = [    A(3,1) + A(1,3)     ;
                 A(3,2) + A(2,3)     ;
             1 + 2*A(3,3) - trace(A) ;
                 A(1,2) - A(2,1)    ];
        quat = q/(4*q(3));
        
    case trace(A)
        q = [    A(2,3) - A(3,2)     ;
                 A(3,1) - A(1,3)     ;
                 A(1,2) - A(2,1)     ;
                  1 + trace(A)      ];
        quat = q/(4*q(4));
end
quat = quat/norm(quat);
end
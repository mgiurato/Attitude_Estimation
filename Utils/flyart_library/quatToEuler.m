function euler = quatToEuler( quat )
% quatToEuler Converts a quaternion vector to XYZ Euler angles
%
%   euler = quatToEuler( quat )
%
%   The quaternion (quat) must be written as a 4-by-N matrix with the scalar
%   element as the fourth component, instead, the output vector (euler)
%   is a 3-by-N matrix of angles in radiants.

A(2,3,:) = 2.*(quat(2,:).*quat(3,:) + quat(4,:).*quat(1,:));
A(3,3,:) = quat(4,:).^2 - quat(1,:).^2 - quat(2,:).^2 + quat(3,:).^2;
A(1,3,:) = 2 .*(quat(1,:).*quat(3,:) - quat(4,:).*quat(2,:));
A(1,2,:) = 2.*(quat(1,:).*quat(2,:) + quat(4,:).*quat(3,:));
A(1,1,:) = quat(4,:).^2 + quat(1,:).^2 - quat(2,:).^2 - quat(3,:).^2;

phi = atan2( A(2,3,:), A(3,3,:) );
theta = - asin( A(1,3,:) );
psi = atan2( A(1,2,:), A(1,1,:) );

euler = [ phi(1,:)' theta(1,:)' psi(1,:)' ]';


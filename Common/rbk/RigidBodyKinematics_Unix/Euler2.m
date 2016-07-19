function m = Euler2(x)

% EULER2 	Elementary rotation matrix
%	Returns the elementary rotation matrix about the
%	second body axis.

m = eye(3);
m(1,1) = cos(x);
m(1,3) = -sin(x);
m(3,1)= -m(1,3);
m(3,3) = m(1,1);

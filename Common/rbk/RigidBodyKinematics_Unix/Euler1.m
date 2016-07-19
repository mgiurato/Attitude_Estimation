function m = Euler1(x)

% EULER1 	Elementary rotation matrix
%	Returns the elementary rotation matrix about the
%	first body axis.

m = eye(3);
m(2,2) = cos(x);
m(2,3) = sin(x);
m(3,2)= -m(2,3);
m(3,3) = m(2,2);

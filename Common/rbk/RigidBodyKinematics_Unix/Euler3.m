function m = Euler3(x)

% EULER3 	Elementary rotation matrix
%	Returns the elementary rotation matrix about the
%	third body axis.

m = eye(3);
m(1,1) = cos(x);
m(1,2) = sin(x);
m(2,1)= -m(1,2);
m(2,2) = m(1,1);

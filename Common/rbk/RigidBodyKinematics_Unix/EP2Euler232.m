function e = EP2Euler232(q)

% EP2Euler232(Q)
%
%	E = EP2Euler232(Q) translates the Euler parameter
%	vector Q into the corresponding (2-3-2) Euler angle
%	vector E.
%

t1 = atan2(q(2),q(4));
t2 = atan2(q(3),q(1));

e(1) = t1+t2;
e(2) = 2*acos(sqrt(q(1)*q(1)+q(3)*q(3)));
e(3) = t2-t1;
e=e';

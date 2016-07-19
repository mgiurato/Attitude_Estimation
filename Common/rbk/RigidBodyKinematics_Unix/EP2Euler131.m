function e = EP2Euler131(q)

% EP2Euler131(Q)
%
%	E = EP2Euler131(Q) translates the Euler parameter
%	vector Q into the corresponding (1-3-1) Euler angle
%	vector E.
%

t1 = atan2(q(3),q(4));
t2 = atan2(q(2),q(1));

e(1) = t2-t1;
e(2) = 2*acos(sqrt(q(1)*q(1)+q(2)*q(2)));
e(3) = t2+t1;
e=e';

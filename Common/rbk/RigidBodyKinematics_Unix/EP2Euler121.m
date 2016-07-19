function e = EP2Euler121(q)

% EP2Euler121(Q)
%
%	E = EP2Euler121(Q) translates the Euler parameter
%	vector Q into the corresponding (1-2-1) Euler angle
%	vector E.
%

t1 = atan2(q(4),q(3));
t2 = atan2(q(2),q(1));

e(1) = t1+t2;
e(2) = 2*acos(sqrt(q(1)*q(1)+q(2)*q(2)));
e(3) = t2-t1;
e=e';

function e = EP2Euler323(q)

% EP2Euler323(Q)
%
%	E = EP2Euler323(Q) translates the Euler parameter
%	vector Q into the corresponding (3-2-3) Euler angle
%	vector E.
%

t1 = atan2(q(2),q(3));
t2 = atan2(q(4),q(1));

e(1) = t2-t1;
e(2) = 2*acos(sqrt(q(1)*q(1)+q(4)*q(4)));
e(3) = t2+t1;
e=e';

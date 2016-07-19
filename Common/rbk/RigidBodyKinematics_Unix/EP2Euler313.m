function e = EP2Euler313(q)

% EP2Euler313(Q)
%
%	E = EP2Euler313(Q) translates the Euler parameter
%	vector Q into the corresponding (3-1-3) Euler angle
%	vector E.
%

t1 = atan2(q(3),q(2));
t2 = atan2(q(4),q(1));

e(1) = t1+t2;
e(2) = 2*acos(sqrt(q(1)*q(1)+q(4)*q(4)));
e(3) = t2-t1;
e=e';

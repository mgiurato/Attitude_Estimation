function	q = EP2PRV(q1)

% EP2PRV(Q1)
%
%	Q = EP2PRV(Q1) translates the Euler parameter vector Q1
%	into the principal rotation vector Q.
%

p = 2*acos(q1(1));
sp = sin(p/2);
q(1) = q1(2)/sp*p;
q(2) = q1(3)/sp*p;
q(3) = q1(4)/sp*p;
q=q';

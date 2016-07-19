function q = Euler3232EP(e)

% Euler3232EP(E)
%
%	Q = Euler3232EP(E) translates the 323 Euler angle
%	vector E into the Euler parameter vector Q.
%

e1 = e(1)/2;
e2 = e(2)/2;
e3 = e(3)/2;

q(1) = cos(e2)*cos(e1+e3);
q(2) = sin(e2)*sin(-e1+e3);
q(3) = sin(e2)*cos(-e1+e3);
q(4) = cos(e2)*sin(e1+e3);
q=q';

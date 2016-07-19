function q = Euler3132EP(e)

% Euler3132EP(E)
%
%	Q = Euler3132EP(E) translates the 313 Euler angle
%	vector E into the Euler parameter vector Q.
%

e1 = e(1)/2;
e2 = e(2)/2;
e3 = e(3)/2;

q(1) = cos(e2)*cos(e1+e3);
q(2) = sin(e2)*cos(e1-e3);
q(3) = sin(e2)*sin(e1-e3);
q(4) = cos(e2)*sin(e1+e3);
q=q';

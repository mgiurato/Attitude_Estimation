function e2 = subEuler131(e,e1)

% subEuler131(E,E1)
%
%	E2 = subEuler131(E,E1) computes the relative
%	(1-3-1) Euler angle vector from E1 to E.
%

cp = cos(e(2));
cp1 = cos(e1(2));
sp = sin(e(2));
sp1 = sin(e1(2));
dum = e(1)-e1(1);

e2(2) = acos(cp1*cp+sp1*sp*cos(dum));
cp2 = cos(e2(2));
e2(1) = Picheck(-e1(3) + atan2(sp1*sp*sin(dum),cp2*cp1-cp));
e2(3) = Picheck(e(3) - atan2(sp1*sp*sin(dum),cp1-cp*cp2));
e2=e2';

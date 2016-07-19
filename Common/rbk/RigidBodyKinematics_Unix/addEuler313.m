function q = addEuler313(e1,e2)

% addEuler313(E1,E2)
%
%	Q = addEuler313(E1,E2) computes the overall (3-1-3) Euler
%	angle vector corresponding to two successive
%	(3-1-3) rotations E1 and E2.
%

cp1 = cos(e1(2));
cp2 = cos(e2(2));
sp1 = sin(e1(2));
sp2 = sin(e2(2));
dum = e1(3)+e2(1);

q(2) = acos(cp1*cp2-sp1*sp2*cos(dum));
cp3 = cos(q(2));
q(1) = Picheck(e1(1) + atan2(sp1*sp2*sin(dum),cp2-cp3*cp1));
q(3) = Picheck(e2(3) + atan2(sp1*sp2*sin(dum),cp1-cp3*cp2)); 
q=q';

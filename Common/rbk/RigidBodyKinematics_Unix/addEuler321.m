function q = addEuler321(e1,e2)

% addEuler321(E1,E2)
%
%	Q = addEuler321(E1,E2) computes the overall (3-2-1) Euler
%	angle vector corresponding to two successive
%	(3-2-1) rotations E1 and E2.
%

C1 = Euler3212C(e1);
C2 = Euler3212C(e2);
C = C2*C1;
q = C2Euler321(C);

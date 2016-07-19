function q = addEuler123(e1,e2)

% addEuler123(E1,E2)
%
%	Q = addEuler123(E1,E2) computes the overall (1-2-3) Euler
%	angle vector corresponding to two successive
%	(1-2-3) rotations E1 and E2.
%

C1 = Euler1232C(e1);
C2 = Euler1232C(e2);
C = C2*C1;
q = C2Euler123(C);

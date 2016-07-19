function q = addEuler231(e1,e2)

% addEuler231(E1,E2)
%
%	Q = addEuler231(E1,E2) computes the overall (2-3-1) Euler
%	angle vector corresponding to two successive
%	(2-3-1) rotations E1 and E2.
%

C1 = Euler2312C(e1);
C2 = Euler2312C(e2);
C = C2*C1;
q = C2Euler231(C);

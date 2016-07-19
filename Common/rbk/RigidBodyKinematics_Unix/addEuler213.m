function q = addEuler213(e1,e2)

% addEuler213(E1,E2)
%
%	Q = addEuler213(E1,E2) computes the overall (2-1-3) Euler
%	angle vector corresponding to two successive
%	(2-1-3) rotations E1 and E2.
%

C1 = Euler2132C(e1);
C2 = Euler2132C(e2);
C = C2*C1;
q = C2Euler213(C);

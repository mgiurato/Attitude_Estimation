function q = addEuler312(e1,e2)

% addEuler312(E1,E2)
%
%	Q = addEuler312(E1,E2) computes the overall (3-1-2) Euler
%	angle vector corresponding to two successive
%	(3-1-2) rotations E1 and E2.
%

C1 = Euler3122C(e1);
C2 = Euler3122C(e2);
C = C2*C1;
q = C2Euler312(C);

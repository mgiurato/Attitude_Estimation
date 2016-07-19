function q = addEuler132(e1,e2)

% addEuler132(E1,E2)
%
%	Q = addEuler132(E1,E2) computes the overall (1-3-2) Euler
%	angle vector corresponding to two successive
%	(1-3-2) rotations E1 and E2.
%

C1 = Euler1322C(e1);
C2 = Euler1322C(e2);
C = C2*C1;
q = C2Euler132(C);

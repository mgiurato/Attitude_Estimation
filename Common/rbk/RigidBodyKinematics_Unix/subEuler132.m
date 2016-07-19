function e2 = subEuler132(e,e1)

% subEuler132(E,E1)
%
%	E2 = subEuler132(E,E1) computes the relative
%	(1-3-2) Euler angle vector from E1 to E.
%

C = DirCosEuler132(e);
C1 = DirCosEuler132(e1);
C2 = C*C1';
e2 = C2Euler132(C2);

function e2 = subEuler123(e,e1)

% subEuler123(E,E1)
%
%	E2 = subEuler123(E,E1) computes the relative
%	(1-2-3) Euler angle vector from E1 to E.
%

C = DirCosEuler123(e);
C1 = DirCosEuler123(e1);
C2 = C*C1';
e2 = C2Euler123(C2);

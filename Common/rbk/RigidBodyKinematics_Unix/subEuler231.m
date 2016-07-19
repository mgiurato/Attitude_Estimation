function e2 = subEuler231(e,e1)

% subEuler231(E,E1)
%
%	E2 = subEuler231(E,E1) computes the relative
%	(2-3-1) Euler angle vector from E1 to E.
%

C = DirCosEuler231(e);
C1 = DirCosEuler231(e1);
C2 = C*C1';
e2 = C2Euler231(C2);

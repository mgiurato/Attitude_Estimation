function e2 = subEuler213(e,e1)

% subEuler213(E,E1)
%
%	E2 = subEuler213(E,E1) computes the relative
%	(2-1-3) Euler angle vector from E1 to E.
%

C = DirCosEuler213(e);
C1 = DirCosEuler213(e1);
C2 = C*C1';
e2 = C2Euler213(C2);

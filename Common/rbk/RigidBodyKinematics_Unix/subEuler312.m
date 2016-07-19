function e2 = subEuler312(e,e1)

% subEuler312(E,E1)
%
%	E2 = subEuler312(E,E1) computes the relative
%	(3-1-2) Euler angle vector from E1 to E.
%

C = DirCosEuler312(e);
C1 = DirCosEuler312(e1);
C2 = C*C1';
e2 = C2Euler312(C2);

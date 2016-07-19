function e2 = subEuler321(e,e1)

% subEuler321(E,E1)
%
%	E2 = subEuler321(E,E1) computes the relative
%	(3-2-1) Euler angle vector from E1 to E.
%

C = DirCosEuler321(e);
C1 = DirCosEuler321(e1);
C2 = C*C1';
e2 = C2Euler321(C2);

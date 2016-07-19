function	e = PRV2Euler231(q)

% PRV2Euler231(Q)
%
%	E = PRV2Euler231(Q) translates the principal rotation
%	vector Q into the (2-3-1) Euler angle vector E.
%

e = EP2Euler231(PRV2EP(q));

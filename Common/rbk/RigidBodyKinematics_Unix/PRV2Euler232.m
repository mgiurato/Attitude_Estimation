function	e = PRV2Euler232(q)

% PRV2Euler232(Q)
%
%	E = PRV2Euler232(Q) translates the principal rotation
%	vector Q into the (2-3-2) Euler angle vector E.
%

e = EP2Euler232(PRV2EP(q));

function	e = PRV2Euler131(q)

% PRV2Euler131(Q)
%
%	E = PRV2Euler131(Q) translates the principal rotation
%	vector Q into the (1-3-1) Euler angle vector E.
%

e = EP2Euler131(PRV2EP(q));

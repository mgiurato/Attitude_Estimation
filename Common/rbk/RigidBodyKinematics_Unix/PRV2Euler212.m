function	e = PRV2Euler212(q)

% PRV2Euler212(Q)
%
%	E = PRV2Euler212(Q) translates the principal rotation
%	vector Q into the (2-1-2) Euler angle vector E.
%

e = EP2Euler212(PRV2EP(q));

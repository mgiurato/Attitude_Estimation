function	e = PRV2Euler323(q)

% PRV2Euler323(Q)
%
%	E = PRV2Euler323(Q) translates the principal rotation
%	vector Q into the (3-2-3) Euler angle vector E.
%

e = EP2Euler323(PRV2EP(q));

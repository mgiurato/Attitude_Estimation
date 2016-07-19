function	e = PRV2Euler312(q)

% PRV2Euler312(Q)
%
%	E = PRV2Euler312(Q) translates the principal rotation
%	vector Q into the (3-1-2) Euler angle vector E.
%

e = EP2Euler312(PRV2EP(q));

function	e = PRV2Euler123(q)

% PRV2Euler123(Q)
%
%	E = PRV2Euler123(Q) translates the principal rotation
%	vector Q into the (1-2-3) Euler angle vector E.
%

e = EP2Euler123(PRV2EP(q));

function	e = PRV2Euler121(q)

% PRV2Euler121(Q)
%
%	E = PRV2Euler121(Q) translates the principal rotation
%	vector Q into the (1-2-1) Euler angle vector E.
%

e = EP2Euler121(PRV2EP(q));

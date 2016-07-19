function	e = PRV2Euler321(q)

% PRV2Euler321(Q)
%
%	E = PRV2Euler321(Q) translates the principal rotation
%	vector Q into the (3-2-1) Euler angle vector E.
%

e = EP2Euler321(PRV2EP(q));

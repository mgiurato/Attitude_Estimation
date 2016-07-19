function	e = PRV2Euler132(q)

% PRV2Euler132(Q)
%
%	E = PRV2Euler132(Q) translates the principal rotation
%	vector Q into the (1-3-2) Euler angle vector E.
%

e = EP2Euler132(PRV2EP(q));

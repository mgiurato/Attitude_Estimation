function	e = PRV2Euler213(q)

% PRV2Euler213(Q)
%
%	E = PRV2Euler213(Q) translates the principal rotation
%	vector Q into the (2-1-3) Euler angle vector E.
%

e = EP2Euler213(PRV2EP(q));

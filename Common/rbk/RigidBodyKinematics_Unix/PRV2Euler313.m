function	e = PRV2Euler313(q)

% PRV2Euler313(Q)
%
%	E = PRV2Euler313(Q) translates the principal rotation
%	vector Q into the (3-1-3) Euler angle vector E.
%

e = EP2Euler313(PRV2EP(q));

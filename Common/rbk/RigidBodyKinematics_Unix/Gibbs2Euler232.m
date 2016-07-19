function	e = Gibbs2Euler232(q)

% Gibbs2Euler232(Q)
%
%	E = Gibbs2Euler232(Q) translates the Gibbs
%	 vector Q into the (2-3-2) Euler angle vector E.
%

e = EP2Euler232(Gibbs2EP(q));

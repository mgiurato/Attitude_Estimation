function	e = Gibbs2Euler131(q)

% Gibbs2Euler131(Q)
%
%	E = Gibbs2Euler131(Q) translates the Gibbs
%	 vector Q into the (1-3-1) Euler angle vector E.
%

e = EP2Euler131(Gibbs2EP(q));

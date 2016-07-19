function	e = Gibbs2Euler212(q)

% Gibbs2Euler212(Q)
%
%	E = Gibbs2Euler212(Q) translates the Gibbs
%	 vector Q into the (2-1-2) Euler angle vector E.
%

e = EP2Euler212(Gibbs2EP(q));

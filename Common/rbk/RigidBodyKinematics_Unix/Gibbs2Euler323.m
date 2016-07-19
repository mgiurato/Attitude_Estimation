function	e = Gibbs2Euler323(q)

% Gibbs2Euler323(Q)
%
%	E = Gibbs2Euler323(Q) translates the Gibbs
%	 vector Q into the (3-2-3) Euler angle vector E.
%

e = EP2Euler323(Gibbs2EP(q));

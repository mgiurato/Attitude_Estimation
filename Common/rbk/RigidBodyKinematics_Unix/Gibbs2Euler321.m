function	e = Gibbs2Euler321(q)

% Gibbs2Euler321(Q)
%
%	E = Gibbs2Euler321(Q) translates the Gibbs
%	 vector Q into the (3-2-1) Euler angle vector E.
%

e = EP2Euler321(Gibbs2EP(q));

function	e = Gibbs2Euler132(q)

% Gibbs2Euler132(Q)
%
%	E = Gibbs2Euler132(Q) translates the Gibbs
%	 vector Q into the (1-3-2) Euler angle vector E.
%

e = EP2Euler132(Gibbs2EP(q));

function	e = Gibbs2Euler312(q)

% Gibbs2Euler312(Q)
%
%	E = Gibbs2Euler312(Q) translates the Gibbs
%	 vector Q into the (3-1-2) Euler angle vector E.
%

e = EP2Euler312(Gibbs2EP(q));

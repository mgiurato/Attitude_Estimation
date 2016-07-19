function	e = Gibbs2Euler313(q)

% Gibbs2Euler313(Q)
%
%	E = Gibbs2Euler313(Q) translates the Gibbs
%	 vector Q into the (3-1-3) Euler angle vector E.
%

e = EP2Euler313(Gibbs2EP(q));

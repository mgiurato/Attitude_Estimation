function	e = Gibbs2Euler123(q)

% Gibbs2Euler123(Q)
%
%	E = Gibbs2Euler123(Q) translates the Gibbs
%	 vector Q into the (1-2-3) Euler angle vector E.
%

e = EP2Euler123(Gibbs2EP(q));

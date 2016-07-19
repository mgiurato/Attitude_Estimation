function	e = Gibbs2Euler213(q)

% Gibbs2Euler213(Q)
%
%	E = Gibbs2Euler213(Q) translates the Gibbs
%	 vector Q into the (2-1-3) Euler angle vector E.
%

e = EP2Euler213(Gibbs2EP(q));

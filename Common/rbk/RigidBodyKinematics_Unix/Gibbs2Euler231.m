function	e = Gibbs2Euler231(q)

% Gibbs2Euler231(Q)
%
%	E = Gibbs2Euler231(Q) translates the Gibbs
%	 vector Q into the (2-3-1) Euler angle vector E.
%

e = EP2Euler231(Gibbs2EP(q));

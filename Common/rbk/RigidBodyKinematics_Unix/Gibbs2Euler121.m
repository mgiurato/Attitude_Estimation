function	e = Gibbs2Euler121(q)

% Gibbs2Euler121(Q)
%
%	E = Gibbs2Euler121(Q) translates the Gibbs
%	 vector Q into the (1-2-1) Euler angle vector E.
%

e = EP2Euler121(Gibbs2EP(q));

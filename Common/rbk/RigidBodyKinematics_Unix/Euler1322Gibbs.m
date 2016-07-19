function	q = Euler1322Gibbs(e)

% Euler1322Gibbs(E)
%
%	Q = Euler1322Gibbs(E) translates the (1-3-2) Euler
%	angle vector E into the Gibbs vector Q.
%

q = EP2Gibbs(Euler1322EP(e));

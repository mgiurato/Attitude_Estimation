function	q = Euler2322Gibbs(e)

% Euler2322Gibbs(E)
%
%	Q = Euler2322Gibbs(E) translates the (2-3-2) Euler
%	angle vector E into the Gibbs vector Q.
%

q = EP2Gibbs(Euler2322EP(e));

function	q = Euler2122Gibbs(e)

% Euler2122Gibbs(E)
%
%	Q = Euler2122Gibbs(E) translates the (2-1-2) Euler
%	angle vector E into the Gibbs vector Q.
%

q = EP2Gibbs(Euler2122EP(e));

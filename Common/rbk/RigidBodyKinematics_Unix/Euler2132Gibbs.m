function	q = Euler2132Gibbs(e)

% Euler2132Gibbs(E)
%
%	Q = Euler2132Gibbs(E) translates the (2-1-3) Euler
%	angle vector E into the Gibbs vector Q.
%

q = EP2Gibbs(Euler2132EP(e));

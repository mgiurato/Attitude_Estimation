function	q = Euler3132Gibbs(e)

% Euler3132Gibbs(E)
%
%	Q = Euler3132Gibbs(E) translates the (3-1-3) Euler
%	angle vector E into the Gibbs vector Q.
%

q = EP2Gibbs(Euler3132EP(e));

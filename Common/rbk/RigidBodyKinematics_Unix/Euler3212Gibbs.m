function	q = Euler3212Gibbs(e)

% Euler3212Gibbs(E)
%
%	Q = Euler3212Gibbs(E) translates the (3-2-1) Euler
%	angle vector E into the Gibbs vector Q.
%

q = EP2Gibbs(Euler3212EP(e));

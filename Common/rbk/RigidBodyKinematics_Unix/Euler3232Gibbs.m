function	q = Euler3232Gibbs(e)

% Euler3232Gibbs(E)
%
%	Q = Euler3232Gibbs(E) translates the (3-2-3) Euler
%	angle vector E into the Gibbs vector Q.
%

q = EP2Gibbs(Euler3232EP(e));

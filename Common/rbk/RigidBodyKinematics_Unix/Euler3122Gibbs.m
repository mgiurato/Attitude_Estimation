function	q = Euler3122Gibbs(e)

% Euler3122Gibbs(E)
%
%	Q = Euler3122Gibbs(E) translates the (3-1-2) Euler
%	angle vector E into the Gibbs vector Q.
%

q = EP2Gibbs(Euler3122EP(e));

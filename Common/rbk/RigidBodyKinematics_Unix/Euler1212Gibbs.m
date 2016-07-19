function	q = Euler1212Gibbs(e)

% Euler1212Gibbs(E)
%
%	Q = Euler1212Gibbs(E) translates the (1-2-1) Euler
%	angle vector E into the Gibbs vector Q.
%

q = EP2Gibbs(Euler1212EP(e));

function	q = Euler1232Gibbs(e)

% Euler1232Gibbs(E)
%
%	Q = Euler1232Gibbs(E) translates the (1-2-3) Euler
%	angle vector E into the Gibbs vector Q.
%

q = EP2Gibbs(Euler1232EP(e));

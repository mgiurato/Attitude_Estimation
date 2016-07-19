function	q = Euler1312Gibbs(e)

% Euler1312Gibbs(E)
%
%	Q = Euler1312Gibbs(E) translates the (1-3-1) Euler
%	angle vector E into the Gibbs vector Q.
%

q = EP2Gibbs(Euler1312EP(e));

function	q = Euler2312Gibbs(e)

% Euler2312Gibbs(E)
%
%	Q = Euler2312Gibbs(E) translates the (2-3-1) Euler
%	angle vector E into the Gibbs vector Q.
%

q = EP2Gibbs(Euler2312EP(e));

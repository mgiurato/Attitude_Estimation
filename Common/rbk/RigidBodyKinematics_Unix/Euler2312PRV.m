function	q = Euler2312PRV(e)

% Euler2312PRV(E)
%
%	Q = Euler2312MRP(E) translates the (2-3-1) Euler
%	angle vector E into the principal rotation vector Q.
%

q = EP2PRV(Euler2312EP(e));

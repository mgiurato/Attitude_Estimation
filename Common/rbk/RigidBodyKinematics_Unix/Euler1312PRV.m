function	q = Euler1312PRV(e)

% Euler1312PRV(E)
%
%	Q = Euler1312MRP(E) translates the (1-3-1) Euler
%	angle vector E into the principal rotation vector Q.
%

q = EP2PRV(Euler1312EP(e));

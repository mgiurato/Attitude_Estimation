function	q = Euler1312MRP(e)

% Euler1312MRP(E)
%
%	Q = Euler1312MRP(E) translates the (1-3-1) Euler
%	angle vector E into the MRP vector Q.
%

q = EP2MRP(Euler1312EP(e));

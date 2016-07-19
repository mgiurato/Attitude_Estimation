function	q = Euler2312MRP(e)

% Euler2312MRP(E)
%
%	Q = Euler2312MRP(E) translates the (2-3-1) Euler
%	angle vector E into the MRP vector Q.
%

q = EP2MRP(Euler2312EP(e));

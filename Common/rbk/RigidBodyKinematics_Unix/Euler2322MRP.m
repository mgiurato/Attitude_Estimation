function	q = Euler2322MRP(e)

% Euler2322MRP(E)
%
%	Q = Euler2322MRP(E) translates the (2-3-2) Euler
%	angle vector E into the MRP vector Q.
%

q = EP2MRP(Euler2322EP(e));

function	q = Euler2122MRP(e)

% Euler2122MRP(E)
%
%	Q = Euler2122MRP(E) translates the (2-1-2) Euler
%	angle vector E into the MRP vector Q.
%

q = EP2MRP(Euler2122EP(e));

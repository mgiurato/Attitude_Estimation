function	q = Euler2132MRP(e)

% Euler2132MRP(E)
%
%	Q = Euler2132MRP(E) translates the (2-1-3) Euler
%	angle vector E into the MRP vector Q.
%

q = EP2MRP(Euler2132EP(e));

function	q = Euler3132MRP(e)

% Euler3132MRP(E)
%
%	Q = Euler3132MRP(E) translates the (3-1-3) Euler
%	angle vector E into the MRP vector Q.
%

q = EP2MRP(Euler3132EP(e));

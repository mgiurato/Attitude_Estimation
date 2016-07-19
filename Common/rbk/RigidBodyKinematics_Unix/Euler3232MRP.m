function	q = Euler3232MRP(e)

% Euler3232MRP(E)
%
%	Q = Euler3232MRP(E) translates the (3-2-3) Euler
%	angle vector E into the MRP vector Q.
%

q = EP2MRP(Euler3232EP(e));

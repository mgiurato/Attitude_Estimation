function	q = Euler1232MRP(e)

% Euler1232MRP(E)
%
%	Q = Euler1232MRP(E) translates the (1-2-3) Euler
%	angle vector E into the MRP vector Q.
%

q = EP2MRP(Euler1232EP(e));

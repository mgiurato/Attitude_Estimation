function	q = Euler3212MRP(e)

% Euler3212MRP(E)
%
%	Q = Euler3212MRP(E) translates the (3-2-1) Euler
%	angle vector E into the MRP vector Q.
%

q = EP2MRP(Euler3212EP(e));

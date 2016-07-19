function	q = Euler3132PRV(e)

% Euler3132PRV(E)
%
%	Q = Euler3132MRP(E) translates the (3-1-3) Euler
%	angle vector E into the principal rotation vector Q.
%

q = EP2PRV(Euler3132EP(e));

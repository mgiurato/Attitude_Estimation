function	q = Euler3232PRV(e)

% Euler3232PRV(E)
%
%	Q = Euler3232MRP(E) translates the (3-2-3) Euler
%	angle vector Q1 into the principal rotation vector Q.
%

q = EP2PRV(Euler3232EP(e));

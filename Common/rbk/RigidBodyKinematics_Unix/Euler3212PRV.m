function	q = Euler3212PRV(e)

% Euler3212PRV(E)
%
%	Q = Euler3212MRP(E) translates the (3-2-1) Euler
%	angle vector E into the principal rotation vector Q.
%

q = EP2PRV(Euler3212EP(e));

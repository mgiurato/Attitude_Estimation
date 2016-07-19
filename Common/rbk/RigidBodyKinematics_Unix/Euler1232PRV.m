function	q = Euler1232PRV(e)

% Euler1232PRV(E)
%
%	Q = Euler1232MRP(E) translates the (1-2-3) Euler
%	angle vector E into the principal rotation vector Q.
%

q = EP2PRV(Euler1232EP(e));

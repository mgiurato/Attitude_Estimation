function	q = Euler1212PRV(e)

% Euler1212PRV(E)
%
%	Q = Euler1212MRP(E) translates the (1-2-1) Euler
%	angle vector E into the principal rotation vector Q.
%

q = EP2PRV(Euler1212EP(e));

function	q = Euler2322PRV(e)

% Euler2322PRV(E)
%
%	Q = Euler2322MRP(E) translates the (2-3-2) Euler
%	angle vector E into the principal rotation vector Q.
%

q = EP2PRV(Euler2322EP(e));

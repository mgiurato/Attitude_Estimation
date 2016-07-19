function	q = Euler2132PRV(e)

% Euler2132PRV(E)
%
%	Q = Euler2132MRP(E) translates the (2-1-3) Euler
%	angle vector E into the principal rotation vector Q.
%

q = EP2PRV(Euler2132EP(e));

function	q = Euler2122PRV(e)

% Euler2122PRV(E)
%
%	Q = Euler2122MRP(E) translates the (2-1-2) Euler
%	angle vector E into the principal rotation vector Q.
%

q = EP2PRV(Euler2122EP(e));

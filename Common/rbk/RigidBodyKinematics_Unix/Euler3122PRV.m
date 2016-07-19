function	q = Euler3122PRV(e)

% Euler3122PRV(E)
%
%	Q = Euler3122MRP(E) translates the (3-1-2) Euler
%	angle vector E into the principal rotation vector Q.
%

q = EP2PRV(Euler3122EP(e));

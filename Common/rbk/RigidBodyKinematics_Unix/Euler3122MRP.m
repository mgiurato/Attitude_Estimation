function	q = Euler3122MRP(e)

% Euler3122MRP(E)
%
%	Q = Euler3122MRP(E) translates the (3-1-2) Euler
%	angle vector E into the MRP vector Q.
%

q = EP2MRP(Euler3122EP(e));

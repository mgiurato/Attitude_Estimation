function	q = Euler1212MRP(e)

% Euler1212MRP(E)
%
%	Q = Euler1212MRP(E) translates the (1-2-1) Euler
%	angle vector E into the MRP vector Q.
%

q = EP2MRP(Euler1212EP(e));

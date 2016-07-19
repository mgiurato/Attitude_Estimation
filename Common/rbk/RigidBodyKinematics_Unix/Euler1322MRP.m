function	q = Euler1322MRP(e)

% Euler1322MRP(E)
%
%	Q = Euler1322MRP(E) translates the (1-3-2) Euler
%	angle vector E into the MRP vector Q.
%

q = EP2MRP(Euler1322EP(e));

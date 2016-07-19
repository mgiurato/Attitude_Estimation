function	e = MRP2Euler212(q)

% MRP2Euler212(Q)
%
%	E = MRP2Euler212(Q) translates the MRP
%	 vector Q into the (2-1-2) Euler angle vector E.
%

e = EP2Euler212(MRP2EP(q));

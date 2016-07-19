function	e = MRP2Euler321(q)

% MRP2Euler321(Q)
%
%	E = MRP2Euler321(Q) translates the MRP
%	 vector Q into the (3-2-1) Euler angle vector E.
%

e = EP2Euler321(MRP2EP(q));

function	e = MRP2Euler131(q)

% MRP2Euler131(Q)
%
%	E = MRP2Euler131(Q) translates the MRP
%	 vector Q into the (1-3-1) Euler angle vector E.
%

e = EP2Euler131(MRP2EP(q));

function	e = MRP2Euler232(q)

% MRP2Euler232(Q)
%
%	E = MRP2Euler232(Q) translates the MRP
%	 vector Q into the (2-3-2) Euler angle vector E.
%

e = EP2Euler232(MRP2EP(q));

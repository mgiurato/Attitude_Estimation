function	e = MRP2Euler231(q)

% MRP2Euler231(Q)
%
%	E = MRP2Euler231(Q) translates the MRP
%	 vector Q into the (2-3-1) Euler angle vector E.
%

e = EP2Euler231(MRP2EP(q));

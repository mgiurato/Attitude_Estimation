function	e = MRP2Euler123(q)

% MRP2Euler123(Q)
%
%	E = MRP2Euler123(Q) translates the MRP
%	 vector Q into the (1-2-3) Euler angle vector E.
%

e = EP2Euler123(MRP2EP(q));

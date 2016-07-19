function	e = MRP2Euler323(q)

% MRP2Euler323(Q)
%
%	E = MRP2Euler323(Q) translates the MRP
%	 vector Q into the (3-2-3) Euler angle vector E.
%

e = EP2Euler323(MRP2EP(q));

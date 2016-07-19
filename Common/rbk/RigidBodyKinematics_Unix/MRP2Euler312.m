function	e = MRP2Euler312(q)

% MRP2Euler312(Q)
%
%	E = MRP2Euler312(Q) translates the MRP
%	 vector Q into the (3-1-2) Euler angle vector E.
%

e = EP2Euler312(MRP2EP(q));

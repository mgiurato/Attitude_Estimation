function	e = MRP2Euler313(q)

% MRP2Euler313(Q)
%
%	E = MRP2Euler313(Q) translates the MRP
%	 vector Q into the (3-1-3) Euler angle vector E.
%

e = EP2Euler313(MRP2EP(q));

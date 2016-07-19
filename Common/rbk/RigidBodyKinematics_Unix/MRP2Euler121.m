function	e = MRP2Euler121(q)

% MRP2Euler121(Q)
%
%	E = MRP2Euler121(Q) translates the MRP
%	 vector Q into the (1-2-1) Euler angle vector E.
%

e = EP2Euler121(MRP2EP(q));

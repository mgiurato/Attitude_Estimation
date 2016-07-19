function	e = MRP2Euler132(q)

% MRP2Euler132(Q)
%
%	E = MRP2Euler132(Q) translates the MRP
%	 vector Q into the (1-3-2) Euler angle vector E.
%

e = EP2Euler132(MRP2EP(q));

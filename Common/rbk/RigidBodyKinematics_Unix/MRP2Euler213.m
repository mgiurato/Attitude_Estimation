function	e = MRP2Euler213(q)

% MRP2Euler213(Q)
%
%	E = MRP2Euler213(Q) translates the MRP
%	 vector Q into the (2-1-3) Euler angle vector E.
%

e = EP2Euler213(MRP2EP(q));

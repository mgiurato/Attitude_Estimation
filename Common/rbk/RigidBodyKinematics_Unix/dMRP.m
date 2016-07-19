function dq = dMRP(q,w)

% dMRP(Q,W)
%
%	dq = dMRP(Q,W) returns the MRP derivative
%	for a given MRP vector Q and body
%	angular velocity vector w.
%
%	dQ/dt = 1/4 [B(Q)] w
%

dq = .25*BmatMRP(q)*w;

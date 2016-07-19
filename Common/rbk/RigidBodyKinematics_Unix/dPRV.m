function dq = dPRV(q,w)

% dPRV(Q,W)
%
%	dq = dPRV(Q,W) returns the PRV derivative
%	for a given PRV vector Q and body
%	angular velocity vector w.
%
%	dQ/dt =  [B(Q)] w
%

dq = BmatPRV(q)*w;

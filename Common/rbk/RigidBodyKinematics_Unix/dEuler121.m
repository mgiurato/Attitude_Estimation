function dq = dEuler121(q,w)

% dEuler121(Q,W)
%
%	dq = dEuler121(Q,W) returns the (1-2-1) Euler angle derivative
%	vector for a given (1-2-1) Euler angle vector Q and body
%	angular velocity vector w.
%
%	dQ/dt =  [B(Q)] w
%

dq = BmatEuler121(q)*w;

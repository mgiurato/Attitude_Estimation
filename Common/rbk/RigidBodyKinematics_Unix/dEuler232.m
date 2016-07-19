function dq = dEuler232(q,w)

% dEuler232(Q,W)
%
%	dq = dEuler232(Q,W) returns the (2-3-2) Euler angle derivative
%	vector for a given (2-3-2) Euler angle vector Q and body
%	angular velocity vector w.
%
%	dQ/dt =  [B(Q)] w
%

dq = BmatEuler232(q)*w;

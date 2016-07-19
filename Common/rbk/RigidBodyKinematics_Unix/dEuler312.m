function dq = dEuler312(q,w)

% dEuler312(Q,W)
%
%	dq = dEuler312(Q,W) returns the (3-1-2) Euler angle derivative
%	vector for a given (3-1-2) Euler angle vector Q and body
%	angular velocity vector w.
%
%	dQ/dt =  [B(Q)] w
%

dq = BmatEuler312(q)*w;

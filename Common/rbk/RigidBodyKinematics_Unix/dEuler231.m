function dq = dEuler231(q,w)

% dEuler231(Q,W)
%
%	dq = dEuler231(Q,W) returns the (2-3-1) Euler angle derivative
%	vector for a given (2-3-1) Euler angle vector Q and body
%	angular velocity vector w.
%
%	dQ/dt =  [B(Q)] w
%

dq = BmatEuler231(q)*w;

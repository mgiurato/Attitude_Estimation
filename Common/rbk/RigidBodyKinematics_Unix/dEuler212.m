function dq = dEuler212(q,w)

% dEuler212(Q,W)
%
%	dq = dEuler212(Q,W) returns the (2-1-2) Euler angle derivative
%	vector for a given (2-1-2) Euler angle vector Q and body
%	angular velocity vector w.
%
%	dQ/dt =  [B(Q)] w
%

dq = BmatEuler212(q)*w;

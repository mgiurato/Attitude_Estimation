function dq = dEuler123(q,w)

% dEuler123(Q,W)
%
%	dq = dEuler123(Q,W) returns the (1-2-3) Euler angle derivative
%	vector for a given (1-2-3) Euler angle vector Q and body
%	angular velocity vector w.
%
%	dQ/dt =  [B(Q)] w
%

dq = BmatEuler123(q)*w;

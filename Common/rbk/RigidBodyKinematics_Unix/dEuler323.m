function dq = dEuler323(q,w)

% dEuler323(Q,W)
%
%	dq = dEuler323(Q,W) returns the (3-2-3) Euler angle derivative
%	vector for a given (3-2-3) Euler angle vector Q and body
%	angular velocity vector w.
%
%	dQ/dt =  [B(Q)] w
%

dq = BmatEuler323(q)*w;

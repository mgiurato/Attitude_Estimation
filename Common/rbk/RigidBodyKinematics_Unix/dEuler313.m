function dq = dEuler313(q,w)

% dEuler313(Q,W)
%
%	dq = dEuler313(Q,W) returns the (3-1-3) Euler angle derivative
%	vector for a given (3-1-3) Euler angle vector Q and body
%	angular velocity vector w.
%
%	dQ/dt =  [B(Q)] w
%

dq = BmatEuler313(q)*w;

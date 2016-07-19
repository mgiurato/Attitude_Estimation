function dq = dEuler132(q,w)

% dEuler132(Q,W)
%
%	dq = dEuler132(Q,W) returns the (1-3-2) Euler angle derivative
%	vector for a given (1-3-2) Euler angle vector Q and body
%	angular velocity vector w.
%
%	dQ/dt =  [B(Q)] w
%

dq = BmatEuler132(q)*w;

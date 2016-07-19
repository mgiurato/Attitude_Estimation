function dq = dEuler321(q,w)

% dEuler321(Q,W)
%
%	dq = dEuler321(Q,W) returns the (3-2-1) Euler angle derivative
%	vector for a given (3-2-1) Euler angle vector Q and body
%	angular velocity vector w.
%
%	dQ/dt =  [B(Q)] w
%

dq = BmatEuler321(q)*w;

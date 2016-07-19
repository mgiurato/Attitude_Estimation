function dq = dEuler213(q,w)

% dEuler213(Q,W)
%
%	dq = dEuler213(Q,W) returns the (2-1-3) Euler angle derivative
%	vector for a given (2-1-3) Euler angle vector Q and body
%	angular velocity vector w.
%
%	dQ/dt =  [B(Q)] w
%

dq = BmatEuler213(q)*w;

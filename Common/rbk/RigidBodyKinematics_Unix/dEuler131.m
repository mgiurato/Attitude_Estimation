function dq = dEuler131(q,w)

% dEuler131(Q,W)
%
%	dq = dEuler131(Q,W) returns the (1-3-1) Euler angle derivative
%	vector for a given (1-3-1) Euler angle vector Q and body
%	angular velocity vector w.
%
%	dQ/dt =  [B(Q)] w
%

dq = BmatEuler131(q)*w;

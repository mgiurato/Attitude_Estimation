function dq = dEP(q,w)

% dEP(Q,W)
%
%	dq = dEP(Q,W) returns the Euler parameter derivative
%	for a given Euler parameter vector Q and body
%	angular velocity vector w.
%
%	dQ/dt = 1/2 [B(Q)] w
%

dq = .5*BmatEP(q)*w;

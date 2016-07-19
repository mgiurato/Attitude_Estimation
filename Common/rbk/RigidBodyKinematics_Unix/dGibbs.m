function dq = dGibbs(q,w)

% dGibbs(Q,W)
%
%	dq = dGibbs(Q,W) returns the Gibbs derivative
%	for a given Gibbs vector Q and body
%	angular velocity vector w.
%
%	dQ/dt = 1/2 [B(Q)] w
%

dq = .5*BmatGibbs(q)*w;

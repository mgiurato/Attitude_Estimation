function	q = MRP2Gibbs(q1)

% MRP2Gibbs(Q1)
%
%	Q = MRP2Gibbs(Q1) translates the MRP vector Q1
%	into the Gibbs vector Q.
%

q = 2*q1/(1-q1'*q1);

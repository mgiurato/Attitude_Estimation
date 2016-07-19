function	q = Gibbs2MRP(q1)

% Gibbs2MRP(Q1)
%
%	Q = Gibbs2MRP(Q1) translates the Gibbs vector Q1
%	into the MRP vector Q.
%

q = q1/(1+sqrt(1+q1'*q1));

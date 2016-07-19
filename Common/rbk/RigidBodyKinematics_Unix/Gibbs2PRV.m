function	q = Gibbs2PRV(q1)

% Gibbs2PRV(Q1)
%
%	Q = Gibbs2PRV(Q1) translates the Gibbs vector Q1
%	into the principal rotation vector Q.
%

tp = sqrt(q1'*q1);
p = 2*atan(tp);
q(1) = q1(1)/tp*p;
q(2) = q1(2)/tp*p;
q(3) = q1(3)/tp*p;
q=q';

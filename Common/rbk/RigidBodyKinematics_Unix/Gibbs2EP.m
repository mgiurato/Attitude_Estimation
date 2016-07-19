function	q = Gibbs2EP(q1)

% Gibbs2EP(Q1)
%
%	Q = Gibbs2EP(Q1) translates the Gibbs vector Q1
%	into the Euler parameter vector Q.
%

q(1) = 1/sqrt(1+q1'*q1);
q(2) = q1(1)*q(1);
q(3) = q1(2)*q(1);
q(4) = q1(3)*q(1);
q=q';

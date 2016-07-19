function	q = EP2Gibbs(q1)

% EP2Gibbs(Q1)
%
%	Q = EP2Gibbs(Q1) translates the Euler parameter vector Q1
%	into the Gibbs vector Q.
%

q(1) = q1(2)/q1(1);
q(2) = q1(3)/q1(1);
q(3) = q1(4)/q1(1);
q=q';

function q = addGibbs(q1,q2)

% addGibbs(Q1,Q2)
%
%	Q = addGibbs(Q1,Q2) provides the Gibbs vector
%	which corresponds to performing to successive
%	rotations Q1 and Q2.
%

q = (q1+q2+cross(q1,q2))/(1-q1'*q2);

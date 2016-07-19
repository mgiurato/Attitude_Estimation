function q = subGibbs(q1,q2)

% subGibbs(Q1,Q2)
%
%	Q = subGibbs(Q1,Q2) provides the Gibbs vector
%	which corresponds to relative rotation from Q2
%	to Q1.
%

q = (q1-q2+cross(q1,q2))/(1+q1'*q2);

function q = addMRP(q1,q2)

% addMRP(Q1,Q2)
%
%	Q = addMRP(Q1,Q2) provides the MRP vector
%	which corresponds to performing to successive
%	rotations Q1 and Q2.
%

q = (1-q1'*q1)*q2+(1-q2'*q2)*q1+2*cross(q1,q2);
q = q/(1+q1'*q1*q2'*q2-2*q1'*q2);

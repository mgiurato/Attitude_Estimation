function q = subMRP(q1,q2)

% subMRP(Q1,Q2)
%
%	Q = subMRP(Q1,Q2) provides the MRP vector
%	which corresponds to relative rotation from Q2
%	to Q1.
%

q = (1-q2'*q2)*q1-(1-q1'*q1)*q2+2*cross(q1,q2);
q = q/(1+q1'*q1*q2'*q2+2*q1'*q2);

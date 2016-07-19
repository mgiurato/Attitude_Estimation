function C = PRV2C(q)

% PRV2C	
%
%	C = PRV2C(Q) returns the direction cosine 
%	matrix in terms of the 3x1 principal rotation vector
%	Q.  
%

q0 = sqrt(q'*q);
q1 = q(1)/q0;
q2 = q(2)/q0;
q3 = q(3)/q0;

cp= cos(q0);
sp= sin(q0);
d1 = 1-cp;
C(1,1) = q1*q1*d1+cp;
C(1,2) = q1*q2*d1+q3*sp;
C(1,3) = q1*q3*d1-q2*sp;
C(2,1) = q2*q1*d1-q3*sp;
C(2,2) = q2*q2*d1+cp;
C(2,3) = q2*q3*d1+q1*sp;
C(3,1) = q3*q1*d1+q2*sp;
C(3,2) = q3*q2*d1-q1*sp;
C(3,3) = q3*q3*d1+cp;

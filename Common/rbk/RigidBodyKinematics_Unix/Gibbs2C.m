function C = Gibbs2C(q)

% Gibbs2C	
%
%	C = Gibbs2C(Q) returns the direction cosine 
%	matrix in terms of the 3x1 Gibbs vector Q.  
%	

q1 = q(1);
q2 = q(2);
q3 = q(3);

d1 = q'*q;
C(1,1) = 1+2*q1*q1-d1;
C(1,2) = 2*(q1*q2+q3);
C(1,3) = 2*(q1*q3-q2);
C(2,1) = 2*(q2*q1-q3);
C(2,2) = 1+2*q2*q2-d1;
C(2,3) = 2*(q2*q3+q1);
C(3,1) = 2*(q3*q1+q2);
C(3,2) = 2*(q3*q2-q1);
C(3,3) = 1+2*q3*q3-d1;
C = C/(1+d1);

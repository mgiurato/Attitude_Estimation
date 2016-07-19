function C = Euler2132C(q)

% Euler2132C	
%
%	C = Euler2132C(Q) returns the direction cosine 
%	matrix in terms of the 2-1-3 Euler angles.  
%	Input Q must be a 3x1 vector of Euler angles.
%	

st1 = sin(q(1));
ct1 = cos(q(1));
st2 = sin(q(2));
ct2 = cos(q(2));
st3 = sin(q(3));
ct3 = cos(q(3));

C(1,1) = ct1*ct3+st1*st2*st3;
C(1,2) = ct2*st3;
C(1,3) = -ct3*st1+ct1*st2*st3;
C(2,1) = ct3*st1*st2-ct1*st3;
C(2,2) = ct2*ct3;
C(2,3) = ct1*ct3*st2 + st1*st3;
C(3,1) = ct2*st1;
C(3,2) = -st2;
C(3,3) = ct1*ct2;

function B = BmatEuler313(q)

% BmatEuler313(Q)
%
%	B = BmatEuler313(Q) returns the 3x3 matrix which relates the 
%	body angular velocity vector w to the derivative of
%	(3-1-3) Euler angle vector Q.  
%	
%		dQ/dt = [B(Q)] w
%	

s2 = sin(q(2));
c2 = cos(q(2));
s3 = sin(q(3));
c3 = cos(q(3));

B(1,1) = s3;
B(1,2) = c3;
B(1,3) = 0;
B(2,1) = c3*s2;
B(2,2) = -s3*s2;
B(2,3) = 0;
B(3,1) = -s3*c2;
B(3,2) = -c3*c2;
B(3,3) = s2;
B = B/s2;

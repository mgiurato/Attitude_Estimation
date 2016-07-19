function B = BmatEP(q)

% BmatEP(Q)
%
%	B = BmatEP(Q) returns the 4x3 matrix which relates the 
%	body angular velocity vector w to the derivative of
%	Euler parameter vector Q.  
%	
%		dQ/dt = 1/2 [B(Q)] w
%	

B(1,1) = -q(2);
B(1,2) = -q(3);
B(1,3) = -q(4);
B(2,1) = q(1);
B(2,2) = -q(4);
B(2,3) = q(3);
B(3,1) = q(4);
B(3,2) = q(1);
B(3,3) = -q(2);
B(4,1) = -q(3);
B(4,2) = q(2);
B(4,3) = q(1);

function B = BmatGibbs(q)

% BmatGibbs(Q)
%
%	B = BmatGibbs(Q) returns the 3x3 matrix which relates the 
%	body angular velocity vector w to the derivative of
%	Gibbs vector Q.  
%	
%		dQ/dt = 1/2 [B(Q)] w
%	

B(1,1) = 1+q(1)*q(1);
B(1,2) = q(1)*q(2)-q(3);
B(1,3) = q(1)*q(3)+q(2);
B(2,1) = q(2)*q(1)+q(3);
B(2,2) = 1+q(2)*q(2);
B(2,3) = q(2)*q(3)-q(1);
B(3,1) = q(3)*q(1)-q(2);
B(3,2) = q(3)*q(2)+q(1);
B(3,3) = 1+q(3)*q(3);

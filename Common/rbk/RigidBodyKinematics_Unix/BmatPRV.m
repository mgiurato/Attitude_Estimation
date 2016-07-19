function B = BmatPRV(q)

% BmatPRV(Q)
%
%	B = BmatPRV(Q) returns the 3x3 matrix which relates the 
%	body angular velocity vector w to the derivative of
%	principal rotation vector Q.  
%	
%		dQ/dt = [B(Q)] w
%	

p = sqrt(q'*q);
c = 1/p/p*(1-p/2*cot(p/2));
B(1,1) = 1- c*(q(2)*q(2)+q(3)*q(3));
B(1,2) = -q(3)/2 + c*(q(1)*q(2));
B(1,3) = q(2)/2 + c*(q(1)*q(3));
B(2,1) = q(3)/2 + c*(q(1)*q(2));
B(2,2) = 1 - c*(q(1)*q(1)+q(3)*q(3));
B(2,3) = -q(1)/2 + c*(q(2)*q(3));
B(3,1) = -q(2)/2 + c*(q(1)*q(3));
B(3,2) = q(1)/2 + c*(q(2)*q(3));
B(3,3) = 1-c*(q(1)*q(1)+q(2)*q(2));

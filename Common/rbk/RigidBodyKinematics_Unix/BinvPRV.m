function B = BinvPRV(q)

% BinvPRV(Q)
%
%	B = BinvPRV(Q) returns the 3x3 matrix which relates 
%	the derivative of principal rotation vector Q to the 
%	body angular velocity vector w.  
%	
%		w = [B(Q)]^(-1) dQ/dt
%	

p = sqrt(q'*q);
c1 = (1-cos(p))/p/p;
c2 = (p-sin(p))/p/p/p;

B(1,1) = 1-c2*(q(2)*q(2)+q(3)*q(3));
B(1,2) = c1*q(3) + c2*q(1)*q(2);
B(1,3) = -c1*q(2) + c2*q(1)*q(3);
B(2,1) = -c1*q(3) + c2*q(1)*q(2);
B(2,2) = 1 - c2*(q(1)*q(1)+ q(3)*q(3));
B(2,3) = c1*q(1) + c2*q(2)*q(3);
B(3,1) = c1*q(2) + c2*q(3)*q(1);
B(3,2) = -c1*q(1) + c2*q(3)*q(2);
B(3,3) = 1 - c2*(q(1)*q(1)+q(2)*q(2));

function B = BinvEP(q)

% BinvEP(Q)
%
%	B = BinvEP(Q) returns the 3x4 matrix which relates 
%	the derivative of Euler parameter vector Q to the 
%	body angular velocity vector w.  
%	
%		w = 2 [B(Q)]^(-1) dQ/dt
%	

B(1,1) = - q(2);
B(1,2) = q(1);
B(1,3) = q(4);
B(1,4) = -q(3);
B(2,1) = -q(3);
B(2,2) = -q(4);
B(2,3) = q(1);
B(2,4) = q(2);
B(3,1) = -q(4);
B(3,2) = q(3);
B(3,3) = -q(2);
B(3,4) = q(1);
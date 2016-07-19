function B = BinvGibbs(q)

% BinvGibbs(Q)
%
%	B = BinvGibbs(Q) returns the 3x3 matrix which relates 
%	the derivative of Gibbs vector Q to the 
%	body angular velocity vector w.  
%	
%		w = 2 [B(Q)]^(-1) dQ/dt
%	

B(1,1) = 1;
B(1,2) = q(3);
B(1,3) = -q(2);
B(2,1) = -q(3);
B(2,2) = 1;
B(2,3) = q(1);
B(3,1) = q(2);
B(3,2) = -q(1);
B(3,3) = 1;
B = B/(1+q'*q);

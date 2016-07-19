function q = C2Gibbs(C)

% C2Gibbs
%
%	Q = C2Gibbs(C) translates the 3x3 direction cosine matrix
%	C into the corresponding 3x1 Gibbs vector Q.
%	

b = C2EP(C);

q(1) = b(2)/b(1);
q(2) = b(3)/b(1);
q(3) = b(4)/b(1);
q=q';

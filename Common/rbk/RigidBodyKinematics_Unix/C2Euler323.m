function q = C2Euler323(C)

% C2Euler323
%
%	Q = C2Euler323(C) translates the 3x3 direction cosine matrix
%	C into the corresponding (3-2-3) Euler angle set.
%	

q(1) = atan2(C(3,2),C(3,1));
q(2) = acos(C(3,3));
q(3)= atan2(C(2,3),-C(1,3));
q=q';
